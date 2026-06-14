require "csv"
require "digest"
require "fileutils"
require "net/http"
require "set"
require "tempfile"
require "uri"

module PublicSources
  module Bds
    class FetchAndValidatePublicFile
      class ValidationError < StandardError; end

      Result = Data.define(
        :data_source,
        :source_access_path,
        :intake_manifest,
        :schema_version,
        :local_path,
        :fetched_this_run,
        :sha256,
        :byte_size,
        :row_count_including_header,
        :row_count_excluding_header,
        :bad_width_rows,
        :blank_lines,
        :duplicate_key_count,
        :observed_year_range,
        :sector_count,
        :firm_age_count,
        :firm_size_count,
        :publication_flag_counts,
        :manifest_reconciled,
        :metric_definitions_created,
        :metric_observations_created,
        :quality_reviews_created,
        :prediction_links_created,
        :exports_created
      )

      def self.call!(actor:, force_fetch: false, fetcher: nil, local_path: nil, manifest_path: nil, strict: true)
        new(
          actor: actor,
          force_fetch: force_fetch,
          fetcher: fetcher,
          local_path: local_path,
          manifest_path: manifest_path,
          strict: strict
        ).call!
      end

      def initialize(actor:, force_fetch:, fetcher:, local_path:, manifest_path:, strict:)
        @actor = actor
        @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
        @ingestion_policy = @policy.fetch(:public_ingestion_v1)
        @bds_policy = @ingestion_policy.fetch(:bds_sector_age_size_public_file)
        @acquisition_design = @bds_policy.fetch(:acquisition_design_v1)
        @parser_design = @bds_policy.fetch(:parser_design_v1)
        @force_fetch = force_fetch
        @fetcher = fetcher || method(:download_public_file)
        @local_path = Pathname(local_path || repo_root.join(@acquisition_design.fetch(:local_raw_path)))
        @manifest_path = Pathname(manifest_path || repo_root.join(@acquisition_design.fetch(:manifest_path)))
        @strict = strict
      end

      def call!
        ensure_policy_allows_fetch_validation!

        scaffold = find_or_create_scaffold
        fetched_this_run = fetch_raw_file_if_needed
        validation = validate_raw_file!
        manifest_reconciled = reconcile_manifest!(validation)

        update_registry!(scaffold, validation, fetched_this_run, manifest_reconciled)

        Result.new(
          data_source: scaffold.fetch(:data_source),
          source_access_path: scaffold.fetch(:source_access_path),
          intake_manifest: scaffold.fetch(:intake_manifest),
          schema_version: scaffold.fetch(:schema_version),
          local_path: local_path.to_s,
          fetched_this_run: fetched_this_run,
          sha256: validation.fetch(:sha256),
          byte_size: validation.fetch(:byte_size),
          row_count_including_header: validation.fetch(:row_count_including_header),
          row_count_excluding_header: validation.fetch(:row_count_excluding_header),
          bad_width_rows: validation.fetch(:bad_width_rows),
          blank_lines: validation.fetch(:blank_lines),
          duplicate_key_count: validation.fetch(:duplicate_key_count),
          observed_year_range: validation.fetch(:observed_year_range),
          sector_count: validation.fetch(:sector_count),
          firm_age_count: validation.fetch(:firm_age_count),
          firm_size_count: validation.fetch(:firm_size_count),
          publication_flag_counts: validation.fetch(:publication_flag_counts),
          manifest_reconciled: manifest_reconciled,
          metric_definitions_created: 0,
          metric_observations_created: 0,
          quality_reviews_created: 0,
          prediction_links_created: 0,
          exports_created: 0
        )
      end

      private

      attr_reader :actor, :bds_policy, :acquisition_design, :parser_design,
                  :force_fetch, :fetcher, :local_path, :manifest_path, :strict

      def ensure_policy_allows_fetch_validation!
        acquisition_result = PublicSources::Bds::AcquisitionDesignCheck.call(policy: @policy)
        parser_result = PublicSources::Bds::ParserDesignCheck.call(
          policy: @policy,
          require_staging_table: true,
          require_empty_staging_table: false
        )
        failures = acquisition_result.failures + parser_result.failures
        raise ValidationError, "BDS fetch/validation policy failed: #{failures.join('; ')}" if failures.any?
      end

      def find_or_create_scaffold
        source = DataSource.find_by(name: bds_policy.fetch(:source_name), source_kind: bds_policy.fetch(:source_kind))
        return existing_scaffold(source) if source

        PublicSources::Bds::PublicFileScaffold.call!(actor: actor)
      end

      def existing_scaffold(source)
        {
          data_source: source,
          source_access_path: source.source_access_paths.find_by!(access_type: "official_public_file_metadata"),
          intake_manifest: source.intake_manifests.find_by!(name: bds_policy.fetch(:manifest_name)),
          schema_version: source.schema_versions.find_by!(version: bds_policy.fetch(:schema_version))
        }
      end

      def fetch_raw_file_if_needed
        return false if local_path.exist? && !force_fetch

        FileUtils.mkdir_p(local_path.dirname)
        Audit::Recorder.record_system!(
          actor: actor,
          event_type: "collection_started",
          entity_type: "PublicSourceFile",
          entity_id: "bds_2023_sector_age_size",
          change_summary: "BDS public file fetch started",
          reason_code: "bds_public_file_fetch"
        )

        fetcher.call(bds_policy.fetch(:source_url), local_path)

        Audit::Recorder.record_system!(
          actor: actor,
          event_type: "collection_completed",
          entity_type: "PublicSourceFile",
          entity_id: "bds_2023_sector_age_size",
          change_summary: "BDS public file fetch completed",
          reason_code: "bds_public_file_fetch"
        )

        true
      end

      def download_public_file(url, destination)
        uri = URI(url)
        Tempfile.create([ "bds-sector-age-size", ".csv" ], destination.dirname) do |tempfile|
          Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
            request = Net::HTTP::Get.new(uri)
            http.request(request) do |response|
              raise ValidationError, "BDS fetch failed with HTTP #{response.code}" unless response.is_a?(Net::HTTPSuccess)

              response.read_body { |chunk| tempfile.write(chunk) }
            end
          end
          tempfile.close
          FileUtils.mv(tempfile.path, destination)
        end
      end

      def validate_raw_file!
        raise ValidationError, "BDS raw file missing at #{local_path}" unless local_path.exist?

        sha256 = Digest::SHA256.file(local_path).hexdigest
        byte_size = local_path.size
        header = nil
        row_count_excluding_header = 0
        bad_width_rows = 0
        blank_lines = 0
        duplicate_key_count = 0
        keys = Set.new
        years = Set.new
        sectors = Set.new
        firm_ages = Set.new
        firm_sizes = Set.new
        publication_flag_counts = measure_columns.index_with { {} }

        File.open(local_path, "r:UTF-8") do |file|
          CSV.new(file, headers: true, col_sep: acquisition_design.fetch(:expected_delimiter)).each.with_index(2) do |row, line_number|
            header ||= row.headers
            if row.fields.all?(&:blank?)
              blank_lines += 1
              next
            end

            row_count_excluding_header += 1
            bad_width_rows += 1 unless row.fields.length == expected_header.length
            key = row_grain.map { |field| row.fetch(field) }.join("\u0000")
            duplicate_key_count += 1 unless keys.add?(key)

            years.add(Integer(row.fetch("year"), 10))
            sectors.add(row.fetch("sector"))
            firm_ages.add(row.fetch("fage"))
            firm_sizes.add(row.fetch("fsize"))

            validate_dimensions!(row, line_number)
            collect_and_validate_measure_cells!(row, line_number, publication_flag_counts)
          end
        end

        header ||= CSV.open(local_path, "r:UTF-8", col_sep: acquisition_design.fetch(:expected_delimiter), &:first)
        validate_header!(header)
        validate_zero_structure_issues!(bad_width_rows, blank_lines, duplicate_key_count)
        validate_strict_shape!(row_count_excluding_header, years, sectors, firm_ages, firm_sizes) if strict

        {
          sha256: sha256,
          byte_size: byte_size,
          row_count_including_header: row_count_excluding_header + 1,
          row_count_excluding_header: row_count_excluding_header,
          bad_width_rows: bad_width_rows,
          blank_lines: blank_lines,
          duplicate_key_count: duplicate_key_count,
          observed_year_range: { start: years.min, end: years.max },
          sector_count: sectors.length,
          firm_age_count: firm_ages.length,
          firm_size_count: firm_sizes.length,
          publication_flag_counts: publication_flag_counts
        }
      end

      def validate_header!(header)
        raise ValidationError, "BDS header mismatch: #{header.inspect}" unless header == expected_header
      end

      def validate_zero_structure_issues!(bad_width_rows, blank_lines, duplicate_key_count)
        failures = []
        failures << "bad_width_rows=#{bad_width_rows}" if bad_width_rows.positive?
        failures << "blank_lines=#{blank_lines}" if blank_lines.positive?
        failures << "duplicate_key_count=#{duplicate_key_count}" if duplicate_key_count.positive?
        return if failures.empty?

        raise ValidationError, "BDS structural validation failed: #{failures.join(', ')}"
      end

      def validate_strict_shape!(row_count_excluding_header, years, sectors, firm_ages, firm_sizes)
        failures = []
        failures << "row_count_excluding_header=#{row_count_excluding_header}" unless row_count_excluding_header == acquisition_design.fetch(:expected_row_count_excluding_header)
        failures << "year_range=#{years.min}-#{years.max}" unless { start: years.min, end: years.max } == acquisition_design.fetch(:expected_year_range)
        failures << "sector_values_mismatch" unless sectors == Set.new(bds_policy.fetch(:allowed_sector_values))
        failures << "fage_values_mismatch" unless firm_ages == Set.new(bds_policy.fetch(:allowed_fage_values))
        failures << "fsize_values_mismatch" unless firm_sizes == Set.new(bds_policy.fetch(:allowed_fsize_values))
        return if failures.empty?

        raise ValidationError, "BDS strict validation failed: #{failures.join(', ')}"
      end

      def validate_dimensions!(row, line_number)
        failures = []
        failures << "sector=#{row.fetch('sector')}" unless bds_policy.fetch(:allowed_sector_values).include?(row.fetch("sector"))
        failures << "fage=#{row.fetch('fage')}" unless bds_policy.fetch(:allowed_fage_values).include?(row.fetch("fage"))
        failures << "fsize=#{row.fetch('fsize')}" unless bds_policy.fetch(:allowed_fsize_values).include?(row.fetch("fsize"))
        return if failures.empty?

        raise ValidationError, "unexpected BDS dimension values at line #{line_number}: #{failures.join(', ')}"
      end

      def collect_and_validate_measure_cells!(row, line_number, publication_flag_counts)
        measure_columns.each do |field|
          value = row.fetch(field)
          if allowed_publication_flags.include?(value)
            publication_flag_counts.fetch(field)[value] = publication_flag_counts.fetch(field).fetch(value, 0) + 1
          elsif numeric_cell?(value)
            publication_flag_counts.fetch(field)["numeric"] = publication_flag_counts.fetch(field).fetch("numeric", 0) + 1
          else
            raise ValidationError, "unexpected BDS measure cell #{field}=#{value.inspect} at line #{line_number}"
          end
        end
      end

      def numeric_cell?(value)
        Float(value)
        true
      rescue ArgumentError, TypeError
        false
      end

      def reconcile_manifest!(validation)
        return false unless manifest_path.exist?

        manifest_row = CSV.read(manifest_path, headers: true).find do |row|
          row.fetch("dataset").include?("BDS 2023 sector")
        end
        raise ValidationError, "BDS manifest row missing" unless manifest_row

        expected = {
          "content_length" => validation.fetch(:byte_size).to_s,
          "local_path" => local_path.relative_path_from(repo_root).to_s,
          "sha256" => validation.fetch(:sha256),
          "row_count" => validation.fetch(:row_count_including_header).to_s,
          "field_list" => expected_header.join(";")
        }
        mismatches = expected.filter_map do |field, value|
          "#{field}: expected #{value}, found #{manifest_row[field]}" unless manifest_row[field] == value
        end
        raise ValidationError, "BDS manifest mismatch: #{mismatches.join('; ')}" if mismatches.any?

        true
      end

      def update_registry!(scaffold, validation, fetched_this_run, manifest_reconciled)
        DataSource.transaction do
          source = scaffold.fetch(:data_source)
          access_path = scaffold.fetch(:source_access_path)
          manifest = scaffold.fetch(:intake_manifest)

          metadata = validation_metadata(validation, fetched_this_run, manifest_reconciled)
          source.update!(
            source_status: acquisition_design.fetch(:source_status_after_validation),
            metadata: source.metadata.merge(metadata)
          )
          access_path.update!(
            status: "fetched_and_validated",
            last_checked_at: Time.current,
            metadata: access_path.metadata.merge(metadata)
          )
          manifest.update!(
            manifest_status: acquisition_design.fetch(:manifest_status_after_validation),
            metadata: manifest.metadata.merge(metadata)
          )

          Audit::Recorder.record!(
            actor: actor,
            event_type: "validation_completed",
            entity: manifest,
            change_summary: "Validated BDS public-file structure without staging rows, metrics, analysis, exports, or claim support",
            reason_code: "bds_public_file_validation",
            storage_zone: source.storage_zone,
            privacy_classification: source.privacy_classification,
            source_id: source.id
          )
        end
      end

      def validation_metadata(validation, fetched_this_run, manifest_reconciled)
        validation.merge(
          local_path: local_path.relative_path_from(repo_root).to_s,
          source_url: bds_policy.fetch(:source_url),
          fetched_this_run: fetched_this_run,
          manifest_reconciled: manifest_reconciled,
          parser_authorized: parser_design.fetch(:parser_authorized),
          staging_table_creation_authorized: parser_design.fetch(:staging_table_creation_authorized),
          row_load_authorized: parser_design.fetch(:row_load_authorized),
          metric_definitions_authorized: acquisition_design.fetch(:metric_definitions_authorized),
          metric_observations_authorized: acquisition_design.fetch(:metric_observations_authorized),
          quality_reviews_authorized: acquisition_design.fetch(:quality_reviews_authorized),
          analysis_authorized: acquisition_design.fetch(:analysis_authorized),
          exports_authorized: acquisition_design.fetch(:exports_authorized),
          prediction_links_authorized: acquisition_design.fetch(:prediction_links_authorized),
          claim_status_effect: acquisition_design.fetch(:claim_status_effect),
          guardrail: "BDS raw file validated as employer-side context only; no parser rows, metrics, exports, prediction links, analysis, or claim support."
        ).deep_stringify_keys
      end

      def expected_header
        bds_policy.fetch(:required_columns)
      end

      def row_grain
        bds_policy.fetch(:row_grain)
      end

      def measure_columns
        expected_header - row_grain
      end

      def allowed_publication_flags
        parser_design.fetch(:flag_handling).fetch(:allowed_flags)
      end

      def repo_root
        Rails.root.parent
      end
    end
  end
end
