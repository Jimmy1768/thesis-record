module PublicSources
  module Susb
    class MetricComputationDesignCheck
      Result = Data.define(:passed, :failures)

      REQUIRED_VALUES = {
        status: "design_only_disabled",
        eligible_enterprise_size_codes: [ "01" ],
        grain: "source_native_context",
        evidence_class: "employer_side_context_only",
        claim_status_effect: "unchanged"
      }.freeze

      REQUIRED_NOISE_RULES = {
        G: "staged_context",
        H: "staged_context",
        J: "quality_review_required",
        D: "blocked_noise_or_suppression",
        S: "blocked_noise_or_suppression"
      }.freeze

      REQUIRED_PROHIBITIONS = %w[
        ratios
        trends
        aggregation
        productivity_measures
        ai_or_node_interpretation
        claim_support
        exports
      ].freeze

      def self.call(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys,
                    require_no_observations: false)
        new(policy: policy, require_no_observations: require_no_observations).call
      end

      def initialize(policy:, require_no_observations:)
        @policy = policy.deep_symbolize_keys
        @require_no_observations = require_no_observations
      end

      def call
        failures = []
        REQUIRED_VALUES.each do |key, expected|
          actual = design.fetch(key)
          failures << "#{key} expected #{expected.inspect}, got #{actual.inspect}" unless actual == expected
        end

        REQUIRED_NOISE_RULES.each do |flag, expected|
          actual = design.fetch(:noise_flag_rules).fetch(flag)
          failures << "noise_flag_rules.#{flag} expected #{expected.inspect}, got #{actual.inspect}" unless actual == expected
        end

        missing_prohibitions = REQUIRED_PROHIBITIONS - design.fetch(:prohibited_computation)
        failures << "missing prohibited computations: #{missing_prohibitions.join(', ')}" if missing_prohibitions.any?
        failures << "MetricObservation rows already exist" if require_no_observations && MetricObservation.exists?

        Result.new(passed: failures.empty?, failures: failures)
      end

      private

      attr_reader :policy, :require_no_observations

      def design
        policy.fetch(:public_ingestion_v1)
              .fetch(:susb_us_state_annual)
              .fetch(:metric_computation_design_v1)
      end
    end
  end
end
