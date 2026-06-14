module Evidence
  class ClaimReviewGateDesignCheck
    Result = Data.define(:passed, :failures)

    REQUIRED_VALUES = {
      status: "design_only_disabled",
      claim_reviews_authorized: false,
      prediction_links_authorized: false,
      automatic_claim_promotion_authorized: false,
      evidence_status_change_authorized: false,
      exports_authorized: false
    }.freeze

    REQUIRED_SOURCE_KINDS = %w[
      census_bfs_api
      census_susb_public_file
      census_bds_public_file
    ].freeze

    REQUIRED_REVIEW_STATUSES = %w[
      reviewed_context
    ].freeze

    REQUIRED_SOURCE_STATUSES = %w[
      staged_context
      reviewed_with_high_noise
    ].freeze

    REQUIRED_EXCLUDED_EVIDENCE_CLASSES = %w[
      indirect_payroll_transition_proxy_only
      employer_side_context_only
      employer_firm_dynamics_context_only
    ].freeze

    REQUIRED_BLOCKED_PREDICTION_IDS = (1..12).map { |index| "TCE-P%03d" % index }.freeze
    REQUIRED_BLOCKED_CLAIM_IDS = (1..15).map { |index| "TCE-CLAIM-%03d" % index }.freeze

    REQUIRED_METADATA = %w[
      metric_observation_id
      metric_quality_review_id
      data_source_id
      source_kind
      source_status
      metric_key
      source_metric_status
      quality_review_status
      evidence_classification
      prediction_id
      claim_id
      prior_claim_status
      proposed_claim_status
      source_limitations
      disconfirming_alternatives
      human_reviewer
      authorization_record
      paper_scope_effect
    ].freeze

    REQUIRED_PROHIBITED_EFFECTS = %w[
      claim_status_change
      prediction_link_creation
      claim_review_creation
      export_creation
      paper_prose_change
      thesis_verdict
      ai_or_node_interpretation
      nonemployer_conversion_interpretation
      management_layer_interpretation
      transaction_cost_interpretation
      firm_boundary_conclusion
    ].freeze

    def self.call(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys,
                  inspect_database: true)
      new(policy: policy, inspect_database: inspect_database).call
    end

    def initialize(policy:, inspect_database:)
      @policy = policy.deep_symbolize_keys
      @inspect_database = inspect_database
    end

    def call
      failures = []
      failures.concat(value_failures)
      failures.concat(missing_values_failures(:eligible_source_kinds_for_future_review, REQUIRED_SOURCE_KINDS))
      failures.concat(missing_values_failures(:eligible_metric_review_statuses_for_future_review, REQUIRED_REVIEW_STATUSES))
      failures.concat(missing_values_failures(:eligible_metric_source_statuses_for_future_review, REQUIRED_SOURCE_STATUSES))
      failures.concat(missing_values_failures(:context_evidence_classes_excluded_from_automatic_claim_support, REQUIRED_EXCLUDED_EVIDENCE_CLASSES))
      failures.concat(missing_values_failures(:blocked_prediction_ids, REQUIRED_BLOCKED_PREDICTION_IDS))
      failures.concat(missing_values_failures(:blocked_claim_ids, REQUIRED_BLOCKED_CLAIM_IDS))
      failures.concat(missing_values_failures(:required_metadata_before_future_claim_review, REQUIRED_METADATA))
      failures.concat(missing_values_failures(:prohibited_automatic_effects, REQUIRED_PROHIBITED_EFFECTS))
      failures.concat(database_failures) if inspect_database

      Result.new(passed: failures.empty?, failures: failures)
    end

    private

    attr_reader :policy, :inspect_database

    def value_failures
      REQUIRED_VALUES.each_with_object([]) do |(key, expected), failures|
        actual = gate.fetch(key)
        failures << "#{key} expected #{expected.inspect}, got #{actual.inspect}" unless actual == expected
      end
    end

    def missing_values_failures(key, required_values)
      actual_values = Array(gate.fetch(key)).map(&:to_s)
      missing_values = required_values - actual_values
      return [] if missing_values.empty?

      [ "missing #{key}: #{missing_values.join(', ')}" ]
    end

    def database_failures
      failures = []
      prediction_link_count = PredictionLink.count
      claim_review_count = ClaimReview.count
      export_count = AuditEvent.where(event_type: "export_created").count

      failures << "#{prediction_link_count} prediction links exist while claim-review gate is disabled" if prediction_link_count.positive?
      failures << "#{claim_review_count} claim reviews exist while claim-review gate is disabled" if claim_review_count.positive?
      failures << "#{export_count} export-created audit events exist while claim-review gate is disabled" if export_count.positive?

      failures
    end

    def gate
      @gate ||= policy.fetch(:claim_review_gate_v1)
    end
  end
end
