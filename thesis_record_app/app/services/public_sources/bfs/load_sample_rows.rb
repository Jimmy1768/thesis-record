require "bigdecimal"
require "digest"
require "json"
require "net/http"
require "uri"

module PublicSources
  module Bfs
    class LoadSampleRows
      class LoadError < StandardError; end

      Result = Data.define(
        :data_source,
        :total_rows,
        :eligible_rows,
        :rows_upserted,
        :metric_definitions_created,
        :metric_observations_created,
        :prediction_links_created,
        :exports_created
      )

      def self.call!(actor:, api_key: nil, fetcher: nil, expected_eligible_rows: nil)
        new(actor: actor, api_key: api_key, fetcher: fetcher, expected_eligible_rows: expected_eligible_rows).call!
      end

      def initialize(actor:, api_key:, fetcher:, expected_eligible_rows:)
        @actor = actor
        @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
        @bfs_policy = @policy.fetch(:public_ingestion_v1).fetch(:bfs_monthly_api)
        @design = @bfs_policy.fetch(:ingestion_design_v1)
        @dry_run = @bfs_policy.fetch(:dry_run_v1)
        @sample_load = @bfs_policy.fetch(:sample_load_v1)
        @expected_eligible_rows = expected_eligible_rows
        @api_key = api_key.presence || env_api_key || local_env_api_key
        @fetcher = fetcher || method(:fetch_response)
      end

      def call!
        ensure_load_allowed!
        raise LoadError, "CENSUS_API_KEY missing" if api_key.blank?

        before_counts = guardrail_counts
        scaffold = PublicSources::Bfs::ApiScaffold.call!(actor: actor)
        response = fetcher.call(query_uri)
        parsed = parse_response!(response)
        rows = eligible_rows_from(parsed)
        validate_eligible_rows!(rows)
        rows_upserted = upsert_rows!(scaffold, rows)
        update_registry!(scaffold, rows_upserted)
        after_counts = guardrail_counts
        validate_guardrails!(before_counts, after_counts)

        Result.new(
          data_source: scaffold.fetch(:data_source),
          total_rows: parsed.fetch(:data_rows).size,
          eligible_rows: rows.size,
          rows_upserted: rows_upserted,
          metric_definitions_created: after_counts.fetch(:metric_definitions) - before_counts.fetch(:metric_definitions),
          metric_observations_created: after_counts.fetch(:metric_observations) - before_counts.fetch(:metric_observations),
          prediction_links_created: after_counts.fetch(:prediction_links) - before_counts.fetch(:prediction_links),
          exports_created: after_counts.fetch(:exports) - before_counts.fetch(:exports)
        )
      end

      private

      attr_reader :actor, :bfs_policy, :design, :dry_run, :sample_load, :expected_eligible_rows, :api_key, :fetcher

      def ensure_load_allowed!
        design_result = PublicSources::Bfs::IngestionDesignCheck.call(require_no_rows: false)
        raise LoadError, design_result.failures.join("; ") unless design_result.passed
        raise LoadError, "sample_load_v1 status is not authorized" unless sample_load.fetch(:status) == "sample_row_load_authorized"
        raise LoadError, "sample load API pull not authorized" unless sample_load.fetch(:api_pull_authorized) == true
        raise LoadError, "sample load data row storage not authorized" unless sample_load.fetch(:data_rows_authorized) == true

        %i[metric_computation_authorized analysis_authorized exports_authorized prediction_links_authorized].each do |flag|
          raise LoadError, "#{flag} must remain false" unless sample_load.fetch(flag) == false
        end
      end

      def parse_response!(response)
        unless response.code.to_i == 200
          raise LoadError, "BFS sample load HTTP #{response.code}: #{response.body.to_s[0, 120]}"
        end

        rows = JSON.parse(response.body)
        header = rows.first
        raise LoadError, "BFS sample load response is empty" if header.blank?
        raise LoadError, "BFS sample load header mismatch: #{header.inspect}" unless header == dry_run.fetch(:expected_response_header)

        { header: header, indexes: header.each_with_index.to_h, data_rows: rows.drop(1) }
      rescue JSON::ParserError => error
        raise LoadError, "BFS sample load returned invalid JSON: #{error.message}"
      end

      def eligible_rows_from(parsed)
        parsed.fetch(:data_rows).select { |row| eligible_row?(row, parsed.fetch(:indexes)) }
      end

      def eligible_row?(row, indexes)
        design.fetch(:first_pass_data_type_codes).include?(row.fetch(indexes.fetch("data_type_code"))) &&
          design.fetch(:first_pass_category_codes).include?(row.fetch(indexes.fetch("category_code"))) &&
          design.fetch(:seasonally_adj_allowed).include?(row.fetch(indexes.fetch("seasonally_adj"))) &&
          row.fetch(indexes.fetch("us")) == dry_run.fetch(:expected_us_code) &&
          dry_run.fetch(:expected_time_slot_ids).include?(row.fetch(indexes.fetch("time_slot_id"))) &&
          dry_run.fetch(:expected_error_data_values).include?(row.fetch(indexes.fetch("error_data")))
      end

      def validate_eligible_rows!(rows)
        expected_rows = expected_eligible_rows || sample_load.fetch(:expected_eligible_rows)
        raise LoadError, "BFS sample load expected #{expected_rows} eligible rows, found #{rows.size}" unless rows.size == expected_rows
      end

      def upsert_rows!(scaffold, rows)
        timestamp = Time.current
        indexes = dry_run.fetch(:expected_response_header).each_with_index.to_h
        attributes = rows.map do |row|
          row_attributes(scaffold, row, indexes, timestamp)
        end
        BfsApiRow.upsert_all(attributes, unique_by: "index_bfs_rows_on_source_month_series_category_geo")
        attributes.size
      end

      def row_attributes(scaffold, row, indexes, timestamp)
        period_month = row.fetch(indexes.fetch("time"))
        year, month = period_month.split("-").map(&:to_i)
        cell_value_raw = row.fetch(indexes.fetch("cell_value"))
        data_type_code = row.fetch(indexes.fetch("data_type_code"))
        category_code = row.fetch(indexes.fetch("category_code"))
        seasonally_adj = row.fetch(indexes.fetch("seasonally_adj"))
        geography_level = design.fetch(:geography_level)
        geography_code = row.fetch(indexes.fetch(geography_level))
        row_hash = row_hash_for(period_month, data_type_code, category_code, seasonally_adj, geography_level, geography_code, cell_value_raw)

        {
          data_source_id: scaffold.fetch(:data_source).id,
          intake_manifest_id: scaffold.fetch(:intake_manifest).id,
          schema_version_id: scaffold.fetch(:schema_version).id,
          period_month: period_month,
          year: year,
          month: month,
          data_type_code: data_type_code,
          time_slot_id: row.fetch(indexes.fetch("time_slot_id")),
          seasonally_adj: seasonally_adj,
          category_code: category_code,
          geography_level: geography_level,
          geography_code: geography_code,
          cell_value_raw: cell_value_raw,
          cell_value_numeric: numeric_cell_value(cell_value_raw),
          error_data: row.fetch(indexes.fetch("error_data")),
          row_hash: row_hash,
          metadata: row_metadata(row_hash, cell_value_raw),
          created_at: timestamp,
          updated_at: timestamp
        }
      end

      def row_metadata(row_hash, cell_value_raw)
        {
          source_endpoint: bfs_policy.fetch(:endpoint_url),
          redacted_query_url: redacted_query_url,
          query_shape: {
            get: dry_run.fetch(:query_get_fields),
            time: sample_load.fetch(:sample_time),
            for: "#{design.fetch(:geography_level)}:*"
          },
          row_hash: row_hash,
          value_code_mapping_version: sample_load.fetch(:value_code_mapping_version),
          row_status: sample_load.fetch(:row_status),
          raw_cell_value_non_numeric: numeric_cell_value(cell_value_raw).nil?,
          claim_status_effect: sample_load.fetch(:claim_status_effect),
          metrics_authorized: false,
          analysis_authorized: false,
          exports_authorized: false,
          prediction_links_authorized: false,
          guardrail: "BFS staged rows are indirect payroll-transition context only; no metrics, analysis, exports, prediction links, or claim support."
        }
      end

      def numeric_cell_value(cell_value_raw)
        BigDecimal(cell_value_raw)
      rescue ArgumentError
        nil
      end

      def update_registry!(scaffold, rows_upserted)
        source = scaffold.fetch(:data_source)
        manifest = scaffold.fetch(:intake_manifest)
        source.update!(
          source_status: sample_load.fetch(:source_status_after_load),
          metadata: source.metadata.merge(sample_load_metadata(rows_upserted))
        )
        manifest.update!(
          manifest_status: sample_load.fetch(:manifest_status_after_load),
          metadata: manifest.metadata.merge(sample_load_metadata(rows_upserted))
        )
        Audit::Recorder.record!(
          actor: actor,
          event_type: "collection_completed",
          entity: manifest,
          change_summary: "Loaded #{rows_upserted} BFS sample rows without metrics or analysis",
          reason_code: "bfs_sample_row_load",
          storage_zone: source.storage_zone,
          privacy_classification: source.privacy_classification,
          claim_status_effect: sample_load.fetch(:claim_status_effect),
          export_allowed: false,
          source_id: source.id
        )
      end

      def sample_load_metadata(rows_upserted)
        {
          sample_time: sample_load.fetch(:sample_time),
          sample_rows_loaded: true,
          sample_rows_upserted: rows_upserted,
          api_data_queried: true,
          data_rows_stored: true,
          metrics_authorized: false,
          analysis_authorized: false,
          exports_authorized: false,
          prediction_links_authorized: false,
          claim_status_effect: sample_load.fetch(:claim_status_effect)
        }.stringify_keys
      end

      def validate_guardrails!(before_counts, after_counts)
        %i[metric_definitions metric_observations prediction_links exports].each do |key|
          next if before_counts.fetch(key) == after_counts.fetch(key)

          raise LoadError, "BFS sample load changed #{key}"
        end
      end

      def guardrail_counts
        {
          metric_definitions: MetricDefinition.where("key LIKE ?", "bfs_%").count,
          metric_observations: MetricObservation.joins(:data_source).where(data_sources: { source_kind: bfs_policy.fetch(:source_kind) }).count,
          prediction_links: PredictionLink.joins(metric_observation: :data_source).where(data_sources: { source_kind: bfs_policy.fetch(:source_kind) }).count,
          exports: AuditEvent.where(event_type: "export_created").count
        }
      end

      def row_hash_for(*values)
        Digest::SHA256.hexdigest(values.join("\u0000"))
      end

      def query_uri
        @query_uri ||= begin
          uri = URI(bfs_policy.fetch(:endpoint_url))
          uri.query = URI.encode_www_form(
            key: api_key,
            get: dry_run.fetch(:query_get_fields).join(","),
            time: sample_load.fetch(:sample_time),
            for: "#{design.fetch(:geography_level)}:*"
          )
          uri
        end
      end

      def redacted_query_url
        query_uri.to_s.sub(api_key, "<redacted>")
      end

      def fetch_response(uri)
        Net::HTTP.get_response(uri)
      end

      def env_api_key
        ENV["CENSUS_API_KEY"]
      end

      def local_env_api_key
        env_path = Rails.root.parent.join(".env.local")
        return nil unless env_path.exist?

        env_path.each_line.find { |line| line.start_with?("CENSUS_API_KEY=") }&.split("=", 2)&.last&.strip
      end
    end
  end
end
