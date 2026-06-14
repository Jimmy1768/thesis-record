module PublicSources
  module Bds
    class MetricComputationDesignCheck
      Result = Data.define(:passed, :failures)

      REQUIRED_VALUES = {
        status: "source_native_observations_authorized",
        source_table: "bds_public_file_rows",
        source_row_status: "source_rows_loaded_context_only",
        grain: "source_native_year_sector_firm_age_firm_size_context",
        evidence_class: "employer_firm_dynamics_context_only",
        claim_status_effect: "unchanged",
        metric_definitions_authorized: false,
        metric_observations_authorized: true,
        quality_reviews_authorized: false,
        exports_authorized: false,
        prediction_links_authorized: false,
        analysis_authorized: false
      }.freeze

      REQUIRED_VALUE_RULES = {
        numeric_cell_value: "staged_context",
        publication_flag_D: "blocked_fewer_than_three_firms",
        publication_flag_S: "quality_review_required_before_use",
        publication_flag_X: "blocked_structural_missing_or_zero",
        publication_flag_N: "blocked_rate_cannot_be_calculated",
        null_numeric_value: "blocked_publication_flag_or_missing",
        missing_source_row: "blocked_missing_source_row"
      }.freeze

      REQUIRED_METRIC_KEYS = %w[
        bds_firms
        bds_establishments
        bds_employment
        bds_establishment_entries
        bds_establishment_exits
        bds_firm_deaths
        bds_job_creation
        bds_job_destruction
        bds_net_job_creation
        bds_reallocation_rate
      ].freeze

      REQUIRED_METADATA = %w[
        source_table
        source_row_id
        source_row_hash
        metric_key
        source_grain
        source_year
        source_sector_code
        source_firm_age_code
        source_firm_size_code
        source_cell_value_raw
        source_publication_flag
        metric_status_reason
        claim_status_effect
        ratios_computed
        trends_computed
        aggregation_computed
        exports_created
        prediction_links_created
        claim_support_authorized
        guardrail
      ].freeze

      REQUIRED_PROHIBITIONS = %w[
        ratios
        trends
        aggregation
        naics_crosswalk
        productivity_measures
        ai_or_node_interpretation
        nonemployer_conversion
        management_layer_inference
        transaction_cost_inference
        firm_boundary_conclusion
        claim_support
        exports
        prediction_links
      ].freeze

      def self.call(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys,
                    require_no_bds_observations: false)
        new(policy: policy, require_no_bds_observations: require_no_bds_observations).call
      end

      def initialize(policy:, require_no_bds_observations:)
        @policy = policy.deep_symbolize_keys
        @require_no_bds_observations = require_no_bds_observations
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

        missing_metrics = REQUIRED_METRIC_KEYS - design.fetch(:eligible_metric_keys)
        failures << "missing metric keys: #{missing_metrics.join(', ')}" if missing_metrics.any?

        missing_metadata = REQUIRED_METADATA - design.fetch(:required_quality_metadata)
        failures << "missing required quality metadata: #{missing_metadata.join(', ')}" if missing_metadata.any?

        missing_prohibitions = REQUIRED_PROHIBITIONS - design.fetch(:prohibited_computation)
        failures << "missing prohibited computations: #{missing_prohibitions.join(', ')}" if missing_prohibitions.any?
        failures << "BDS MetricObservation rows already exist" if require_no_bds_observations && bds_observations_exist?

        Result.new(passed: failures.empty?, failures: failures)
      end

      private

      attr_reader :policy, :require_no_bds_observations

      def design
        bds_policy.fetch(:parser_design_v1).fetch(:metric_computation_design_v1)
      end

      def bds_policy
        policy.fetch(:public_ingestion_v1).fetch(:bds_sector_age_size_public_file)
      end

      def bds_observations_exist?
        MetricObservation.joins(:data_source)
                         .where(data_sources: { source_kind: bds_policy.fetch(:source_kind) })
                         .exists?
      end
    end
  end
end
