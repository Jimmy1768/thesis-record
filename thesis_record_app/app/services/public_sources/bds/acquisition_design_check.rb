module PublicSources
  module Bds
    class AcquisitionDesignCheck
      Result = Data.define(:passed, :failures)

      REQUIRED_STATUS = "fetch_validation_service_ready"
      REQUIRED_FALSE_FLAGS = %i[
        data_rows_authorized
        metric_definitions_authorized
        metric_observations_authorized
        quality_reviews_authorized
        parser_authorized
        analysis_authorized
        exports_authorized
        prediction_links_authorized
      ].freeze
      REQUIRED_AUDIT_EVENTS = %w[collection_started collection_completed validation_completed].freeze
      REQUIRED_PROHIBITED_EFFECTS = %w[
        metric_definition_creation
        metric_observation_creation
        quality_review_creation
        prediction_link_creation
        export_creation
        claim_status_change
        analysis
      ].freeze

      def self.call(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
        new(policy: policy).call
      end

      def initialize(policy:)
        @policy = policy.deep_symbolize_keys
      end

      def call
        failures = []
        failures << "status expected #{REQUIRED_STATUS.inspect}, got #{design[:status].inspect}" unless design[:status] == REQUIRED_STATUS
        failures << "raw_file_storage_zone expected \"private_file_storage\"" unless design[:raw_file_storage_zone] == "private_file_storage"
        failures << "local_raw_path should point under data/raw/bds/" unless design[:local_raw_path].to_s.start_with?("data/raw/bds/")
        failures << "manifest_path should point under data/manifests/" unless design[:manifest_path].to_s.start_with?("data/manifests/")
        failures << "checksum_required_before_parser expected true" unless design[:checksum_required_before_parser] == true
        failures << "manifest_reconciliation_required expected true" unless design[:manifest_reconciliation_required] == true
        failures << "expected_delimiter expected \",\"" unless design[:expected_delimiter] == ","
        failures << "expected_row_count_excluding_header expected #{bds_policy.fetch(:observed_row_count_excluding_header)}" unless design[:expected_row_count_excluding_header] == bds_policy.fetch(:observed_row_count_excluding_header)
        failures << "expected_year_range should match observed_year_range" unless design[:expected_year_range] == bds_policy.fetch(:observed_year_range)

        failures << "raw_file_fetch_authorized expected true" unless design[:raw_file_fetch_authorized] == true
        failures << "fetch_execution_default expected \"validate_existing_local_file\"" unless design[:fetch_execution_default] == "validate_existing_local_file"
        failures << "force_fetch_requires_operator_env expected \"BDS_FORCE_FETCH\"" unless design[:force_fetch_requires_operator_env] == "BDS_FORCE_FETCH"
        failures << "source_status_after_validation expected \"raw_file_validated\"" unless design[:source_status_after_validation] == "raw_file_validated"
        failures << "manifest_status_after_validation expected \"raw_file_validated\"" unless design[:manifest_status_after_validation] == "raw_file_validated"
        failures << "schema_status_required expected \"verified_public_file_metadata_scaffold\"" unless design[:schema_status_required] == "verified_public_file_metadata_scaffold"
        failures << "claim_status_effect expected \"unchanged\"" unless design[:claim_status_effect] == "unchanged"

        REQUIRED_FALSE_FLAGS.each do |flag|
          failures << "#{flag} expected false, got #{design[flag].inspect}" unless design[flag] == false
        end

        missing_events = REQUIRED_AUDIT_EVENTS - Array(design[:collection_audit_events_required])
        failures << "missing collection audit events: #{missing_events.join(', ')}" if missing_events.any?

        missing_effects = REQUIRED_PROHIBITED_EFFECTS - Array(design[:prohibited_effects])
        failures << "missing prohibited effects: #{missing_effects.join(', ')}" if missing_effects.any?

        Result.new(passed: failures.empty?, failures: failures)
      end

      private

      attr_reader :policy

      def bds_policy
        @bds_policy ||= policy.fetch(:public_ingestion_v1).fetch(:bds_sector_age_size_public_file)
      end

      def design
        @design ||= bds_policy.fetch(:acquisition_design_v1)
      end
    end
  end
end
