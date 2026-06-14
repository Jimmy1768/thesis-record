require "json"
require "net/http"
require "uri"

module PublicSources
  module Bfs
    class DryRunQueryValidator
      class ValidationError < StandardError; end

      Result = Data.define(
        :redacted_query_url,
        :total_rows,
        :eligible_rows,
        :eligible_data_type_codes,
        :eligible_category_codes,
        :eligible_seasonally_adj_values,
        :eligible_time_slot_ids,
        :eligible_error_data_values,
        :database_counts_unchanged
      )

      DATABASE_COUNT_KEYS = %i[
        bfs_api_rows
        bfs_metric_definitions
        bfs_observations
        bfs_prediction_links
        export_created_audit_events
      ].freeze

      def self.call!(api_key: nil, fetcher: nil)
        new(api_key: api_key, fetcher: fetcher).call!
      end

      def initialize(api_key:, fetcher:)
        @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
        @bfs_policy = @policy.fetch(:public_ingestion_v1).fetch(:bfs_monthly_api)
        @design = @bfs_policy.fetch(:ingestion_design_v1)
        @dry_run = @bfs_policy.fetch(:dry_run_v1)
        @api_key = api_key.presence || env_api_key || local_env_api_key
        @fetcher = fetcher || method(:fetch_response)
      end

      def call!
        ensure_design_allowed!
        raise ValidationError, "CENSUS_API_KEY missing" if api_key.blank?

        before_counts = database_counts
        response = fetcher.call(query_uri)
        rows = parse_response!(response)
        result = validate_rows!(rows)
        after_counts = database_counts
        raise ValidationError, "dry run changed database counts" unless before_counts == after_counts

        result.with(database_counts_unchanged: true)
      end

      private

      attr_reader :policy, :bfs_policy, :design, :dry_run, :api_key, :fetcher

      def ensure_design_allowed!
        result = PublicSources::Bfs::IngestionDesignCheck.call(require_no_rows: false)
        raise ValidationError, result.failures.join("; ") unless result.passed
      end

      def parse_response!(response)
        unless response.code.to_i == 200
          raise ValidationError, "BFS dry run HTTP #{response.code}: #{response.body.to_s[0, 120]}"
        end

        JSON.parse(response.body)
      rescue JSON::ParserError => error
        raise ValidationError, "BFS dry run returned invalid JSON: #{error.message}"
      end

      def validate_rows!(rows)
        header = rows.first
        raise ValidationError, "BFS dry run response is empty" if header.blank?
        raise ValidationError, "BFS dry run header mismatch: #{header.inspect}" unless header == dry_run.fetch(:expected_response_header)

        data_rows = rows.drop(1)
        indexes = header.each_with_index.to_h
        eligible_rows = data_rows.select { |row| eligible_row?(row, indexes) }
        raise ValidationError, "BFS dry run found no eligible rows" if eligible_rows.size < dry_run.fetch(:minimum_eligible_rows)

        result = result_for(data_rows, eligible_rows, indexes)
        validate_result!(result)
        result
      end

      def eligible_row?(row, indexes)
        design.fetch(:first_pass_data_type_codes).include?(row.fetch(indexes.fetch("data_type_code"))) &&
          design.fetch(:first_pass_category_codes).include?(row.fetch(indexes.fetch("category_code"))) &&
          design.fetch(:seasonally_adj_allowed).include?(row.fetch(indexes.fetch("seasonally_adj"))) &&
          row.fetch(indexes.fetch("us")) == dry_run.fetch(:expected_us_code)
      end

      def result_for(data_rows, eligible_rows, indexes)
        Result.new(
          redacted_query_url: redacted_query_url,
          total_rows: data_rows.size,
          eligible_rows: eligible_rows.size,
          eligible_data_type_codes: unique_values(eligible_rows, indexes.fetch("data_type_code")),
          eligible_category_codes: unique_values(eligible_rows, indexes.fetch("category_code")),
          eligible_seasonally_adj_values: unique_values(eligible_rows, indexes.fetch("seasonally_adj")),
          eligible_time_slot_ids: unique_values(eligible_rows, indexes.fetch("time_slot_id")),
          eligible_error_data_values: unique_values(eligible_rows, indexes.fetch("error_data")),
          database_counts_unchanged: false
        )
      end

      def validate_result!(result)
        missing_target_codes = design.fetch(:first_pass_data_type_codes) - result.eligible_data_type_codes
        if dry_run.fetch(:target_codes_must_all_appear) && missing_target_codes.any?
          raise ValidationError, "BFS dry run missing target data_type_code values: #{missing_target_codes.join(', ')}"
        end

        unless result.eligible_seasonally_adj_values == design.fetch(:seasonally_adj_allowed)
          raise ValidationError, "BFS dry run unexpected seasonally_adj values: #{result.eligible_seasonally_adj_values.inspect}"
        end

        unless result.eligible_time_slot_ids == dry_run.fetch(:expected_time_slot_ids)
          raise ValidationError, "BFS dry run unexpected time_slot_id values: #{result.eligible_time_slot_ids.inspect}"
        end

        return if result.eligible_error_data_values == dry_run.fetch(:expected_error_data_values)

        raise ValidationError, "BFS dry run unexpected error_data values: #{result.eligible_error_data_values.inspect}"
      end

      def unique_values(rows, index)
        rows.map { |row| row.fetch(index) }.uniq.sort
      end

      def database_counts
        {
          bfs_api_rows: BfsApiRow.count,
          bfs_metric_definitions: MetricDefinition.where("key LIKE ?", "bfs_%").count,
          bfs_observations: MetricObservation.joins(:data_source).where(data_sources: { source_kind: bfs_policy.fetch(:source_kind) }).count,
          bfs_prediction_links: PredictionLink.joins(metric_observation: :data_source).where(data_sources: { source_kind: bfs_policy.fetch(:source_kind) }).count,
          export_created_audit_events: AuditEvent.where(event_type: "export_created").count
        }.slice(*DATABASE_COUNT_KEYS)
      end

      def query_uri
        @query_uri ||= begin
          uri = URI(bfs_policy.fetch(:endpoint_url))
          uri.query = URI.encode_www_form(
            key: api_key,
            get: dry_run.fetch(:query_get_fields).join(","),
            time: dry_run.fetch(:sample_time),
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
