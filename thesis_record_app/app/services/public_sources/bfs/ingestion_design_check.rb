module PublicSources
  module Bfs
    class IngestionDesignCheck
      Result = Data.define(:passed, :failures)

      REQUIRED_STATUS = "staging_schema_only_no_api_pull"
      REQUIRED_FALSE_FLAGS = %i[
        api_pull_authorized
        data_rows_authorized
        metric_computation_authorized
        analysis_authorized
        exports_authorized
        prediction_links_authorized
      ].freeze
      REQUIRED_ROW_GRAIN = %w[
        data_source_id
        period_month
        data_type_code
        category_code
        seasonally_adj
        geography_level
        geography_code
      ].freeze
      REQUIRED_TARGET_CODES = %w[
        BA_BA
        BA_HBA
        BF_BF4Q
        BF_BF8Q
        BF_PBF4Q
        BF_PBF8Q
      ].freeze
      REQUIRED_EXCLUDED_CATEGORIES = %w[TOTAL NONAICS].freeze

      def self.call(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys,
                    require_no_rows: false)
        new(policy: policy, require_no_rows: require_no_rows).call
      end

      def initialize(policy:, require_no_rows:)
        @policy = policy.deep_symbolize_keys
        @require_no_rows = require_no_rows
      end

      def call
        failures = []
        failures << "status expected #{REQUIRED_STATUS.inspect}, got #{design[:status].inspect}" unless design[:status] == REQUIRED_STATUS
        REQUIRED_FALSE_FLAGS.each do |flag|
          failures << "#{flag} expected false, got #{design[flag].inspect}" unless design[flag] == false
        end
        failures << "claim_status_effect expected \"unchanged\"" unless design[:claim_status_effect] == "unchanged"
        failures << "geography_scope expected \"us_only\"" unless design[:geography_scope] == "us_only"
        failures << "seasonally_adj_allowed expected [\"no\"]" unless design[:seasonally_adj_allowed] == [ "no" ]
        failures.concat(missing_values_failures(:first_pass_data_type_codes, REQUIRED_TARGET_CODES))
        failures.concat(missing_values_failures(:excluded_category_codes, REQUIRED_EXCLUDED_CATEGORIES))
        failures << "row_grain expected #{REQUIRED_ROW_GRAIN.inspect}, got #{design[:row_grain].inspect}" unless design[:row_grain] == REQUIRED_ROW_GRAIN
        failures << "staging_table expected \"bfs_api_rows\"" unless design[:staging_table] == "bfs_api_rows"
        failures << "evidence_class expected \"indirect_payroll_transition_proxy_only\"" unless design[:evidence_class] == "indirect_payroll_transition_proxy_only"
        failures << "BfsApiRow rows already exist" if require_no_rows && BfsApiRow.exists?

        Result.new(passed: failures.empty?, failures: failures)
      end

      private

      attr_reader :policy, :require_no_rows

      def missing_values_failures(key, required_values)
        actual_values = Array(design[key]).map(&:to_s)
        missing_values = required_values - actual_values
        return [] if missing_values.empty?

        [ "missing #{key}: #{missing_values.join(', ')}" ]
      end

      def design
        @design ||= policy.fetch(:public_ingestion_v1)
                          .fetch(:bfs_monthly_api)
                          .fetch(:ingestion_design_v1)
      end
    end
  end
end
