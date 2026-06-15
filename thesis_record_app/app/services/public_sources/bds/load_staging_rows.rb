require "bigdecimal"
require "csv"
require "digest"
require "securerandom"

module PublicSources
  module Bds
    class LoadStagingRows
      class LoadError < StandardError; end

      Result = Data.define(
        :data_source,
        :intake_manifest,
        :schema_version,
        :local_path,
        :load_id,
        :rows_read,
        :rows_inserted,
        :rows_deleted_before_load,
        :metric_definitions_created,
        :metric_observations_created,
        :quality_reviews_created,
        :prediction_links_created,
        :exports_created
      )

      BATCH_SIZE = 5_000

      def self.call!(actor:, local_path: nil, manifest_path: nil, load_id: nil, policy: nil, validator: nil)
        new(
          actor: actor,
          local_path: local_path,
          manifest_path: manifest_path,
          load_id: load_id,
          policy: policy,
          validator: validator
        ).call!
      end

      def initialize(actor:, local_path:, manifest_path:, load_id:, policy:, validator:)
        @actor = actor
        @policy = (policy || Rails.application.config_for(:thesis_record_policy)).deep_symbolize_keys
        @bds_policy = @policy.fetch(:public_ingestion_v1).fetch(:bds_sector_age_size_public_file)
        @parser_design = @bds_policy.fetch(:parser_design_v1)
        @qa_policy = @parser_design.fetch(:row_load_qa_policy_v1)
        @local_path = Pathname(local_path || Rails.root.parent.join(@bds_policy.fetch(:acquisition_design_v1).fetch(:local_raw_path)))
        @manifest_path = manifest_path
        @load_id = load_id || SecureRandom.uuid
        @validator = validator
      end

      def call!
        ensure_policy_allows_source_row_load!
        Operations::V0CanonicalCollectionPreflight.enforce_source_write_allowed!(
          source_kind: bds_policy.fetch(:source_kind)
        )
        validation = validate_source_file!
        ensure_validation_matches_qa_policy!(validation)

        rows_deleted = 0
        rows_inserted = 0
        BdsPublicFileRow.transaction do
          rows_deleted = BdsPublicFileRow.where(data_source: validation.data_source).delete_all
          rows_inserted = insert_source_rows!(validation)
          reconcile_post_load!(validation, rows_inserted)
          update_manifest_metadata!(validation, rows_inserted, rows_deleted)
        end

        Result.new(
          data_source: validation.data_source,
          intake_manifest: validation.intake_manifest,
          schema_version: validation.schema_version,
          local_path: validation.local_path,
          load_id: load_id,
          rows_read: rows_inserted,
          rows_inserted: rows_inserted,
          rows_deleted_before_load: rows_deleted,
          metric_definitions_created: 0,
          metric_observations_created: 0,
          quality_reviews_created: 0,
          prediction_links_created: 0,
          exports_created: 0
        )
      end

      private

      attr_reader :actor, :policy, :bds_policy, :parser_design, :qa_policy,
                  :local_path, :manifest_path, :load_id, :validator

      def ensure_policy_allows_source_row_load!
        parser_result = PublicSources::Bds::ParserDesignCheck.call(
          policy: policy,
          require_staging_table: true
        )
        row_load_result = PublicSources::Bds::RowLoadPolicyCheck.call(policy: policy)
        failures = parser_result.failures + row_load_result.failures
        raise LoadError, "BDS source-row load policy failed: #{failures.join('; ')}" if failures.any?
      end

      def validate_source_file!
        return validator.call if validator

        PublicSources::Bds::FetchAndValidatePublicFile.call!(
          actor: actor,
          local_path: local_path,
          manifest_path: manifest_path,
          strict: true
        )
      end

      def ensure_validation_matches_qa_policy!(validation)
        failures = []
        failures << "manifest_reconciled=false" unless validation.manifest_reconciled
        failures << "row_count_excluding_header=#{validation.row_count_excluding_header}" unless validation.row_count_excluding_header == qa_policy.fetch(:expected_source_rows)
        failures << "bad_width_rows=#{validation.bad_width_rows}" if qa_policy.fetch(:require_zero_bad_width_rows) && validation.bad_width_rows.positive?
        failures << "duplicate_key_count=#{validation.duplicate_key_count}" if qa_policy.fetch(:require_zero_duplicate_grain_keys) && validation.duplicate_key_count.positive?
        failures << "observed_year_range=#{validation.observed_year_range.inspect}" unless validation.observed_year_range == qa_policy.fetch(:require_observed_year_range)
        failures << "sector_count=#{validation.sector_count}" unless validation.sector_count == qa_policy.fetch(:require_sector_count)
        failures << "firm_age_count=#{validation.firm_age_count}" unless validation.firm_age_count == qa_policy.fetch(:require_firm_age_count)
        failures << "firm_size_count=#{validation.firm_size_count}" unless validation.firm_size_count == qa_policy.fetch(:require_firm_size_count)
        return if failures.empty?

        raise LoadError, "BDS source-row load QA failed: #{failures.join('; ')}"
      end

      def insert_source_rows!(validation)
        rows_read = 0
        batch = []
        timestamp = Time.current

        File.open(local_path, "r:UTF-8") do |file|
          CSV.new(file, headers: true, col_sep: delimiter).each.with_index(1) do |row, source_row_number|
            rows_read += 1
            batch << row_attributes(row, validation, source_row_number, timestamp)

            if batch.size >= BATCH_SIZE
              insert_batch!(batch)
              batch.clear
            end
          end
        end

        insert_batch!(batch) if batch.any?
        rows_read
      end

      def insert_batch!(batch)
        BdsPublicFileRow.insert_all(batch)
      end

      def row_attributes(row, validation, source_row_number, timestamp)
        raw_values = {}
        numeric_values = {}
        publication_flags = {}
        measure_columns.each do |field|
          raw_value = row.fetch(field)
          raw_values[field] = raw_value
          if allowed_publication_flags.include?(raw_value)
            numeric_values[field] = nil
            publication_flags[field] = raw_value
          else
            numeric_values[field] = decimal_string(raw_value, field, source_row_number)
          end
        end

        {
          data_source_id: validation.data_source.id,
          intake_manifest_id: validation.intake_manifest.id,
          schema_version_id: validation.schema_version.id,
          source_row_number: source_row_number,
          year: Integer(row.fetch("year"), 10),
          sector_code: row.fetch("sector"),
          firm_age_code: row.fetch("fage"),
          firm_size_code: row.fetch("fsize"),
          raw_measure_values: raw_values,
          numeric_measure_values: numeric_values,
          publication_flags: publication_flags,
          row_hash: row_hash(row),
          metadata: row_metadata(row),
          created_at: timestamp,
          updated_at: timestamp
        }
      end

      def decimal_string(value, field, source_row_number)
        BigDecimal(value).to_s("F")
      rescue ArgumentError
        raise LoadError, "unexpected BDS measure cell #{field}=#{value.inspect} at source row #{source_row_number}"
      end

      def row_hash(row)
        Digest::SHA256.hexdigest(expected_header.map { |field| row[field].to_s }.join("\u0000"))
      end

      def row_metadata(row)
        {
          load_id: load_id,
          source_grain: "year_sector_firm_age_firm_size",
          source_fields_preserved: true,
          flags_preserved_before_numeric_coercion: true,
          publication_flag_fields: publication_flag_fields(row),
          metric_definitions_authorized: false,
          metric_observations_authorized: false,
          quality_reviews_authorized: false,
          analysis_authorized: false,
          exports_authorized: false,
          prediction_links_authorized: false,
          claim_status_effect: "unchanged",
          guardrail: "BDS source row only; no metrics, reviews, exports, prediction links, analysis, or claim support."
        }
      end

      def publication_flag_fields(row)
        measure_columns.select { |field| allowed_publication_flags.include?(row.fetch(field)) }
      end

      def reconcile_post_load!(validation, rows_inserted)
        expected_rows = qa_policy.fetch(:expected_source_rows)
        actual_rows = BdsPublicFileRow.where(data_source: validation.data_source).count
        return if rows_inserted == expected_rows && actual_rows == expected_rows

        raise LoadError, "BDS post-load reconciliation failed: rows_inserted=#{rows_inserted}, actual_rows=#{actual_rows}, expected_rows=#{expected_rows}"
      end

      def update_manifest_metadata!(validation, rows_inserted, rows_deleted)
        validation.intake_manifest.update!(
          manifest_status: "staging_rows_loaded",
          metadata: validation.intake_manifest.metadata.merge(
            "staging_rows_loaded" => true,
            "staging_row_count" => rows_inserted,
            "staging_table" => "bds_public_file_rows",
            "load_id" => load_id,
            "rows_deleted_before_load" => rows_deleted,
            "cleanup_strategy" => "transactional_delete_existing_source_rows_before_insert",
            "rollback_strategy" => "single_transaction_rolls_back_delete_and_insert_on_error",
            "post_load_reconciliation" => "passed",
            "metric_definitions_created" => 0,
            "metric_observations_created" => 0,
            "quality_reviews_created" => 0,
            "exports_created" => 0,
            "prediction_links_created" => 0,
            "analysis_authorized" => false,
            "claim_status_effect" => "unchanged"
          )
        )

        validation.data_source.update!(
          source_status: "staging_rows_loaded",
          metadata: validation.data_source.metadata.merge(
            "bds_public_file_row_count" => rows_inserted,
            "staging_rows_loaded" => true,
            "claim_status_effect" => "unchanged"
          )
        )

        Audit::Recorder.record!(
          actor: actor,
          event_type: "validation_completed",
          entity: validation.intake_manifest,
          change_summary: "Loaded #{rows_inserted} BDS source-native rows into staging without metrics, reviews, analysis, exports, or claim support",
          reason_code: "bds_source_row_load",
          storage_zone: validation.data_source.storage_zone,
          privacy_classification: validation.data_source.privacy_classification,
          source_id: validation.data_source.id
        )
      end

      def expected_header
        bds_policy.fetch(:required_columns)
      end

      def measure_columns
        expected_header - bds_policy.fetch(:row_grain)
      end

      def allowed_publication_flags
        parser_design.fetch(:flag_handling).fetch(:allowed_flags)
      end

      def delimiter
        bds_policy.fetch(:acquisition_design_v1).fetch(:expected_delimiter)
      end
    end
  end
end
