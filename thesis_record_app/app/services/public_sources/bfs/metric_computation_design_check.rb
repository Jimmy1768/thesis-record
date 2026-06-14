module PublicSources
  module Bfs
    class MetricComputationDesignCheck
      Result = Data.define(:passed, :failures)

      REQUIRED_VALUES = {
        status: "source_native_observations_authorized",
        source_table: "bfs_api_rows",
        source_row_status: "staged_context",
        grain: "source_native_monthly_sector_context",
        evidence_class: "indirect_payroll_transition_proxy_only",
        claim_status_effect: "unchanged",
        metric_definitions_authorized: false,
        metric_observations_authorized: true,
        quality_reviews_authorized: false,
        exports_authorized: false,
        prediction_links_authorized: false,
        eligible_geography_scope: "us_only",
        eligible_geography_level: "us",
        eligible_seasonally_adj: [ "no" ]
      }.freeze

      REQUIRED_VALUE_RULES = {
        numeric_cell_value: "staged_context",
        non_numeric_cell_value: "blocked_suppression_or_non_numeric",
        error_data_yes: "blocked_error_data",
        missing_cell_value: "blocked_missing_value"
      }.freeze

      REQUIRED_METRIC_KEYS = %w[
        bfs_business_applications
        bfs_high_propensity_business_applications
        bfs_business_formations_4q
        bfs_business_formations_8q
        bfs_projected_business_formations_4q
        bfs_projected_business_formations_8q
      ].freeze

      REQUIRED_PROHIBITIONS = %w[
        ratios
        trends
        aggregation
        seasonal_adjustment_mix
        category_harmonization
        naics_crosswalk
        productivity_measures
        ai_or_node_interpretation
        nonemployer_conversion
        claim_support
        exports
        prediction_links
      ].freeze

      def self.call(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys,
                    require_no_bfs_observations: false)
        new(policy: policy, require_no_bfs_observations: require_no_bfs_observations).call
      end

      def initialize(policy:, require_no_bfs_observations:)
        @policy = policy.deep_symbolize_keys
        @require_no_bfs_observations = require_no_bfs_observations
      end

      def call
        failures = []
        REQUIRED_VALUES.each do |key, expected|
          actual = design.fetch(key)
          failures << "#{key} expected #{expected.inspect}, got #{actual.inspect}" unless actual == expected
        end

        REQUIRED_VALUE_RULES.each do |key, expected|
          actual = design.fetch(:source_value_rules).fetch(key)
          failures << "source_value_rules.#{key} expected #{expected.inspect}, got #{actual.inspect}" unless actual == expected
        end

        missing_metrics = REQUIRED_METRIC_KEYS - design.fetch(:first_pass_metric_keys)
        failures << "missing metric keys: #{missing_metrics.join(', ')}" if missing_metrics.any?

        missing_data_codes = ingestion_design.fetch(:first_pass_data_type_codes) - design.fetch(:eligible_data_type_codes)
        failures << "missing eligible data_type_codes: #{missing_data_codes.join(', ')}" if missing_data_codes.any?

        missing_categories = ingestion_design.fetch(:first_pass_category_codes) - design.fetch(:eligible_category_codes)
        failures << "missing eligible category_codes: #{missing_categories.join(', ')}" if missing_categories.any?

        missing_prohibitions = REQUIRED_PROHIBITIONS - design.fetch(:prohibited_computation)
        failures << "missing prohibited computations: #{missing_prohibitions.join(', ')}" if missing_prohibitions.any?
        failures << "BFS MetricObservation rows already exist" if require_no_bfs_observations && bfs_observations_exist?

        Result.new(passed: failures.empty?, failures: failures)
      end

      private

      attr_reader :policy, :require_no_bfs_observations

      def design
        bfs_policy.fetch(:metric_computation_design_v1)
      end

      def ingestion_design
        bfs_policy.fetch(:ingestion_design_v1)
      end

      def bfs_policy
        policy.fetch(:public_ingestion_v1).fetch(:bfs_monthly_api)
      end

      def bfs_observations_exist?
        MetricObservation.joins(:data_source)
                         .where(data_sources: { source_kind: bfs_policy.fetch(:source_kind) })
                         .exists?
      end
    end
  end
end
