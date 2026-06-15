require "csv"
require "digest"

module PublicSources
  module Susb
    class LoadStagingRows
      class LoadError < StandardError; end

      Result = Data.define(
        :data_source,
        :intake_manifest,
        :schema_version,
        :local_path,
        :rows_read,
        :rows_upserted,
        :metric_observations_created,
        :quality_flags_created
      )

      BATCH_SIZE = 5_000

      def self.call!(actor:, year: nil, local_path: nil, manifest_path: nil)
        new(actor: actor, year: year, local_path: local_path, manifest_path: manifest_path).call!
      end

      def initialize(actor:, year:, local_path:, manifest_path:)
        @actor = actor
        @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
        @ingestion_policy = @policy.fetch(:public_ingestion_v1)
        @susb_policy = @ingestion_policy.fetch(:susb_us_state_annual)
        @year = year || @susb_policy.fetch(:default_year)
        @local_path = Pathname(local_path || repo_root.join(format(@susb_policy.fetch(:local_raw_path_template), year: @year)))
        @manifest_path = manifest_path
      end

      def call!
        Operations::V0CanonicalCollectionPreflight.enforce_source_write_allowed!(
          source_kind: susb_policy.fetch(:source_kind)
        )
        validation = PublicSources::Susb::FetchAndValidatePublicFile.call!(
          actor: actor,
          year: year,
          local_path: local_path,
          manifest_path: manifest_path,
          force_fetch: false
        )
        ensure_validation_ready!(validation)

        rows_read = load_rows!(validation)

        Audit::Recorder.record!(
          actor: actor,
          event_type: "validation_completed",
          entity: validation.intake_manifest,
          change_summary: "Loaded #{rows_read} SUSB #{year} source-native rows into staging without metric computation",
          reason_code: "susb_staging_load",
          storage_zone: validation.data_source.storage_zone,
          privacy_classification: validation.data_source.privacy_classification,
          source_id: validation.data_source.id
        )

        Result.new(
          data_source: validation.data_source,
          intake_manifest: validation.intake_manifest,
          schema_version: validation.schema_version,
          local_path: validation.local_path,
          rows_read: rows_read,
          rows_upserted: rows_read,
          metric_observations_created: 0,
          quality_flags_created: 0
        )
      end

      private

      attr_reader :actor, :susb_policy, :year, :local_path, :manifest_path

      def ensure_validation_ready!(validation)
        raise LoadError, "SUSB manifest is not reconciled" unless validation.manifest_reconciled
        raise LoadError, "SUSB validation found duplicate keys" unless validation.duplicate_key_count.zero?
        raise LoadError, "SUSB validation found bad-width rows" unless validation.bad_width_rows.zero?
      end

      def load_rows!(validation)
        rows_read = 0
        now = Time.current
        batch = []

        File.open(local_path, "r:ISO-8859-1:UTF-8") do |file|
          CSV.new(file, headers: true).each do |row|
            rows_read += 1
            batch << row_attributes(row, validation, now)

            if batch.size >= BATCH_SIZE
              upsert_batch!(batch)
              batch.clear
            end
          end
        end

        upsert_batch!(batch) if batch.any?
        update_manifest_metadata!(validation, rows_read)
        rows_read
      end

      def upsert_batch!(batch)
        SusbPublicFileRow.upsert_all(
          batch,
          unique_by: "index_susb_rows_on_source_year_state_naics_size"
        )
      end

      def row_attributes(row, validation, timestamp)
        {
          data_source_id: validation.data_source.id,
          intake_manifest_id: validation.intake_manifest.id,
          schema_version_id: validation.schema_version.id,
          year: year,
          state_code: row.fetch("STATE"),
          naics_code: row.fetch("NAICS"),
          enterprise_size_code: row.fetch("ENTRSIZE"),
          firm_count: integer_value(row.fetch("FIRM")),
          establishment_count: integer_value(row.fetch("ESTB")),
          employment: integer_value(row.fetch("EMPL")),
          employment_noise_flag: row.fetch("EMPLFL_N"),
          annual_payroll_thousand: integer_value(row.fetch("PAYR")),
          payroll_noise_flag: row.fetch("PAYRFL_N"),
          receipts_thousand: optional_integer_value(row["RCPT"]),
          receipts_noise_flag: row["RCPTFL_N"],
          state_name: row.fetch("STATEDSCR"),
          naics_description: row.fetch("NAICSDSCR"),
          enterprise_size_description: row.fetch("ENTRSIZEDSCR"),
          row_hash: row_hash(row),
          metadata: row_metadata(row),
          created_at: timestamp,
          updated_at: timestamp
        }
      end

      def integer_value(value)
        Integer(value, 10)
      end

      def optional_integer_value(value)
        return nil if value.blank?

        Integer(value, 10)
      end

      def row_hash(row)
        Digest::SHA256.hexdigest(susb_policy.fetch(:expected_header).map { |field| row[field].to_s }.join("\u0000"))
      end

      def row_metadata(row)
        {
          source_grain: "year_state_naics_enterprise_size",
          source_fields_preserved: true,
          flags_preserved_before_numeric_coercion: true,
          metrics_authorized: false,
          analysis_authorized: false,
          claim_status_effect: "unchanged",
          withheld_flag_present: %w[D S].intersect?([ row["EMPLFL_N"], row["PAYRFL_N"], row["RCPTFL_N"] ].compact)
        }
      end

      def update_manifest_metadata!(validation, rows_read)
        validation.intake_manifest.update!(
          manifest_status: "staging_rows_loaded",
          metadata: validation.intake_manifest.metadata.merge(
            "staging_rows_loaded" => true,
            "staging_row_count" => rows_read,
            "staging_table" => "susb_public_file_rows",
            "metric_observations_created" => 0,
            "analysis_authorized" => false,
            "metrics_authorized" => false
          )
        )
      end

      def repo_root
        Rails.root.parent
      end
    end
  end
end
