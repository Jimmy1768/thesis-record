module PublicSources
  module Bds
    class RowLoadPolicyCheck
      Result = Data.define(:passed, :failures)

      REQUIRED_FALSE_FLAGS = %i[
        metric_observations_authorized
        quality_reviews_authorized
        exports_authorized
        prediction_links_authorized
      ].freeze
      REQUIRED_TRUE_FLAGS = %i[
        full_file_parser_authorized
        row_load_authorized
      ].freeze

      REQUIRED_QA_FALSE_FLAGS = %i[
        metric_definitions_authorized
        metric_observations_authorized
        quality_reviews_authorized
        exports_authorized
        prediction_links_authorized
        analysis_authorized
      ].freeze

      def self.call(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys,
                    require_loaded_table: false)
        new(policy: policy, require_loaded_table: require_loaded_table).call
      end

      def initialize(policy:, require_loaded_table:)
        @policy = policy.deep_symbolize_keys
        @require_loaded_table = require_loaded_table
      end

      def call
        failures = []
        failures << "status expected \"source_row_load_authorized\"" unless gate[:status] == "source_row_load_authorized"
        failures << "table_must_exist expected true" unless gate[:table_must_exist] == true
        failures << "table_must_remain_empty expected false" unless gate[:table_must_remain_empty] == false
        failures << "parser_fixture_only expected true" unless gate[:parser_fixture_only] == true
        failures << "full_file_dry_run_authorized expected true" unless gate[:full_file_dry_run_authorized] == true
        failures << "claim_status_effect expected \"unchanged\"" unless gate[:claim_status_effect] == "unchanged"

        REQUIRED_FALSE_FLAGS.each do |flag|
          failures << "#{flag} expected false, got #{gate[flag].inspect}" unless gate[flag] == false
        end

        REQUIRED_TRUE_FLAGS.each do |flag|
          failures << "#{flag} expected true, got #{gate[flag].inspect}" unless gate[flag] == true
        end

        validate_qa_policy!(failures)

        table_name = parser_design.fetch(:staging_table)
        table_exists = ActiveRecord::Base.connection.data_source_exists?(table_name)
        failures << "#{table_name} table is missing" if gate[:table_must_exist] && !table_exists
        if require_loaded_table && table_exists && BdsPublicFileRow.count != qa_policy.fetch(:expected_source_rows)
          failures << "#{table_name} row count expected #{qa_policy.fetch(:expected_source_rows)}, got #{BdsPublicFileRow.count}"
        end

        Result.new(passed: failures.empty?, failures: failures)
      end

      private

      attr_reader :policy, :require_loaded_table

      def bds_policy
        @bds_policy ||= policy.fetch(:public_ingestion_v1).fetch(:bds_sector_age_size_public_file)
      end

      def parser_design
        @parser_design ||= bds_policy.fetch(:parser_design_v1)
      end

      def gate
        @gate ||= parser_design.fetch(:row_load_gate_v1)
      end

      def qa_policy
        @qa_policy ||= parser_design.fetch(:row_load_qa_policy_v1)
      end

      def validate_qa_policy!(failures)
        failures << "qa status expected \"policy_defined_row_load_disabled\"" unless qa_policy[:status] == "policy_defined_row_load_disabled"
        failures << "dry_run_required_before_load expected true" unless qa_policy[:dry_run_required_before_load] == true
        failures << "expected_source_rows expected #{expected_source_rows}" unless qa_policy[:expected_source_rows] == expected_source_rows
        failures << "require_zero_bad_width_rows expected true" unless qa_policy[:require_zero_bad_width_rows] == true
        failures << "require_zero_duplicate_grain_keys expected true" unless qa_policy[:require_zero_duplicate_grain_keys] == true
        failures << "require_observed_year_range expected #{expected_year_range.inspect}" unless qa_policy[:require_observed_year_range] == expected_year_range
        failures << "require_sector_count expected #{expected_sector_count}" unless qa_policy[:require_sector_count] == expected_sector_count
        failures << "require_firm_age_count expected #{expected_firm_age_count}" unless qa_policy[:require_firm_age_count] == expected_firm_age_count
        failures << "require_firm_size_count expected #{expected_firm_size_count}" unless qa_policy[:require_firm_size_count] == expected_firm_size_count
        failures << "require_publication_flag_preservation expected true" unless qa_policy[:require_publication_flag_preservation] == true
        failures << "required_publication_flags expected D/S/X/N" unless qa_policy[:required_publication_flags] == %w[D S X N]
        failures << "require_source_row_hash expected true" unless qa_policy[:require_source_row_hash] == true
        failures << "require_load_id expected true" unless qa_policy[:require_load_id] == true
        failures << "cleanup_strategy_required expected true" unless qa_policy[:cleanup_strategy_required] == true
        failures << "rollback_strategy_required expected true" unless qa_policy[:rollback_strategy_required] == true
        failures << "load_idempotency_required expected true" unless qa_policy[:load_idempotency_required] == true
        failures << "post_load_reconciliation_required expected true" unless qa_policy[:post_load_reconciliation_required] == true
        failures << "qa claim_status_effect expected \"unchanged\"" unless qa_policy[:claim_status_effect] == "unchanged"

        REQUIRED_QA_FALSE_FLAGS.each do |flag|
          failures << "qa #{flag} expected false, got #{qa_policy[flag].inspect}" unless qa_policy[flag] == false
        end
      end

      def expected_source_rows
        bds_policy.fetch(:observed_row_count_excluding_header)
      end

      def expected_year_range
        bds_policy.fetch(:observed_year_range)
      end

      def expected_sector_count
        bds_policy.fetch(:allowed_sector_values).length
      end

      def expected_firm_age_count
        bds_policy.fetch(:allowed_fage_values).length
      end

      def expected_firm_size_count
        bds_policy.fetch(:allowed_fsize_values).length
      end
    end
  end
end
