module PublicSources
  module Susb
    class QualityReviewPolicyCheck
      Result = Data.define(:passed, :failures)

      REQUIRED_STATUS = "policy_only_no_review_state"

      REQUIRED_STATUS_MAPPING = {
        staged_context: "reviewed_context",
        quality_review_required: "reviewed_with_high_noise",
        blocked_noise_or_suppression: "excluded_noise_or_suppression"
      }.freeze

      REQUIRED_FINAL_STATUSES = %w[
        reviewed_context
        reviewed_with_high_noise
        excluded_noise_or_suppression
        excluded_policy_violation
        needs_manual_review
      ].freeze

      REQUIRED_METADATA_KEYS = %w[
        source_table
        source_row_id
        source_row_hash
        metric_key
        metric_status_reason
        claim_status_effect
        ratios_computed
        trends_computed
        aggregation_computed
        exports_created
        claim_support_authorized
        guardrail
      ].freeze

      HARD_FALSE_FLAGS = %w[
        ratios_computed
        trends_computed
        aggregation_computed
        exports_created
        claim_support_authorized
      ].freeze

      REQUIRED_MANUAL_REVIEW_REASONS = %w[
        missing_source_row
        missing_source_row_hash
        missing_required_dimensions
        unknown_metric_key
        unsupported_metric_status
        high_noise_status
      ].freeze

      REQUIRED_PROHIBITED_EFFECTS = %w[
        claim_support
        export_authorization
        thesis_interpretation
        ai_or_node_evidence
        aggregation_authorization
        trend_authorization
      ].freeze

      def self.call(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys,
                    inspect_observations: true)
        new(policy: policy, inspect_observations: inspect_observations).call
      end

      def initialize(policy:, inspect_observations:)
        @policy = policy.deep_symbolize_keys
        @inspect_observations = inspect_observations
      end

      def call
        failures = []
        failures.concat(policy_failures)
        failures.concat(observation_failures) if inspect_observations

        Result.new(passed: failures.empty?, failures: failures)
      end

      private

      attr_reader :policy, :inspect_observations

      def policy_failures
        failures = []
        failures << "status expected #{REQUIRED_STATUS.inspect}, got #{review_policy[:status].inspect}" unless review_policy[:status] == REQUIRED_STATUS

        REQUIRED_STATUS_MAPPING.each do |source_status, expected_review_status|
          actual = review_policy.fetch(:eligible_observation_statuses, {}).fetch(source_status, nil)
          next if actual == expected_review_status

          failures << "eligible_observation_statuses.#{source_status} expected #{expected_review_status.inspect}, got #{actual.inspect}"
        end

        failures.concat(missing_values_failures("final_review_statuses", REQUIRED_FINAL_STATUSES))
        failures.concat(missing_values_failures("required_quality_metadata", REQUIRED_METADATA_KEYS))
        failures.concat(missing_values_failures("manual_review_required_for", REQUIRED_MANUAL_REVIEW_REASONS))
        failures.concat(missing_values_failures("prohibited_review_effects", REQUIRED_PROHIBITED_EFFECTS))

        HARD_FALSE_FLAGS.each do |flag|
          actual = review_policy.fetch(:hard_false_flags, {}).fetch(flag.to_sym, nil)
          failures << "hard_false_flags.#{flag} expected false, got #{actual.inspect}" unless actual == false
        end

        failures << "review_storage_recommendation expected \"metric_quality_reviews\"" unless review_policy[:review_storage_recommendation] == "metric_quality_reviews"
        failures
      end

      def observation_failures
        failures = []
        unsupported_status_count = observation_scope.where.not(metric_status: REQUIRED_STATUS_MAPPING.keys.map(&:to_s)).count
        failures << "#{unsupported_status_count} metric observations have unsupported review-source statuses" if unsupported_status_count.positive?

        forbidden_flag_count = observation_scope.where(forbidden_flag_sql).count
        failures << "#{forbidden_flag_count} metric observations authorize prohibited computation/export/claim effects" if forbidden_flag_count.positive?

        missing_metadata_count = observation_scope.where(missing_metadata_sql).count
        failures << "#{missing_metadata_count} metric observations are missing required quality metadata" if missing_metadata_count.positive?

        failures
      end

      def observation_scope
        return MetricObservation.none if susb_source_ids.empty?

        MetricObservation.where(data_source_id: susb_source_ids)
                         .where("quality_metadata ->> 'source_table' = ?", "susb_public_file_rows")
      end

      def forbidden_flag_sql
        HARD_FALSE_FLAGS.map { |flag| "quality_metadata ->> '#{flag}' = 'true'" }.join(" OR ")
      end

      def missing_metadata_sql
        quoted_keys = REQUIRED_METADATA_KEYS.map { |key| ActiveRecord::Base.connection.quote(key) }.join(", ")
        "NOT (quality_metadata ?& array[#{quoted_keys}])"
      end

      def missing_values_failures(key, required_values)
        actual_values = Array(review_policy[key]).map(&:to_s)
        missing_values = required_values - actual_values
        return [] if missing_values.empty?

        [ "missing #{key}: #{missing_values.join(', ')}" ]
      end

      def review_policy
        @review_policy ||= policy.fetch(:public_ingestion_v1)
                                 .fetch(:susb_us_state_annual)
                                 .fetch(:quality_review_policy_v1)
      end

      def susb_source_ids
        @susb_source_ids ||= DataSource.where(source_kind: "census_susb_public_file").pluck(:id)
      end
    end
  end
end
