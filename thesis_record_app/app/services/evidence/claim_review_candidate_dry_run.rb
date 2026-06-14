module Evidence
  class ClaimReviewCandidateDryRun
    Result = Data.define(
      :policy_check_passed,
      :policy_check_failures,
      :candidate_groups,
      :total_reviewed_observations,
      :total_unreviewed_observations,
      :prediction_link_count,
      :claim_review_count,
      :export_created_audit_event_count
    )

    CandidateGroup = Data.define(
      :id,
      :source_kind,
      :source_table,
      :metric_keys,
      :related_prediction_ids,
      :related_claim_ids,
      :candidate_status,
      :evidence_classification,
      :proposed_claim_status,
      :reviewed_observation_count,
      :unreviewed_observation_count,
      :limitation
    )

    REQUIRED_VALUES = {
      status: "dry_run_only_no_records",
      candidate_records_authorized: false,
      database_writes_allowed: false,
      claim_reviews_authorized: false,
      prediction_links_authorized: false,
      exports_authorized: false,
      claim_status_effect: "unchanged",
      required_candidate_status: "dry_run_candidate_only",
      required_evidence_classification: "context_only_not_claim_support"
    }.freeze

    REQUIRED_PROHIBITED_OUTPUTS = %w[
      prediction_link_creation
      claim_review_creation
      claim_status_change
      export_creation
      paper_prose_change
      thesis_verdict
    ].freeze

    REQUIRED_GROUP_KEYS = %i[
      id
      source_kind
      source_table
      metric_keys
      related_prediction_ids
      related_claim_ids
      candidate_status
      evidence_classification
      proposed_claim_status
      limitation
    ].freeze

    def self.call(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
      new(policy: policy).call
    end

    def initialize(policy:)
      @policy = policy.deep_symbolize_keys
    end

    def call
      failures = policy_failures
      groups = failures.empty? ? candidate_groups : []

      Result.new(
        policy_check_passed: failures.empty?,
        policy_check_failures: failures,
        candidate_groups: groups,
        total_reviewed_observations: groups.sum(&:reviewed_observation_count),
        total_unreviewed_observations: groups.sum(&:unreviewed_observation_count),
        prediction_link_count: PredictionLink.count,
        claim_review_count: ClaimReview.count,
        export_created_audit_event_count: AuditEvent.where(event_type: "export_created").count
      )
    end

    private

    attr_reader :policy

    def policy_failures
      failures = []
      gate_check = Evidence::ClaimReviewGateDesignCheck.call(policy: policy)
      failures.concat(gate_check.failures.map { |failure| "claim_review_gate_v1: #{failure}" }) unless gate_check.passed

      REQUIRED_VALUES.each do |key, expected|
        actual = dry_run_policy.fetch(key)
        failures << "#{key} expected #{expected.inspect}, got #{actual.inspect}" unless actual == expected
      end

      missing_outputs = REQUIRED_PROHIBITED_OUTPUTS - dry_run_policy.fetch(:prohibited_outputs)
      failures << "missing prohibited outputs: #{missing_outputs.join(', ')}" if missing_outputs.any?

      dry_run_policy.fetch(:candidate_groups).each do |group|
        failures.concat(group_failures(group))
      end

      failures
    end

    def group_failures(group)
      failures = []
      missing_keys = REQUIRED_GROUP_KEYS - group.keys
      failures << "candidate group missing keys: #{missing_keys.join(', ')}" if missing_keys.any?
      return failures if missing_keys.any?

      failures << "#{group.fetch(:id)} candidate_status must be dry_run_candidate_only" unless group.fetch(:candidate_status) == "dry_run_candidate_only"
      failures << "#{group.fetch(:id)} evidence_classification must be context_only_not_claim_support" unless group.fetch(:evidence_classification) == "context_only_not_claim_support"
      failures << "#{group.fetch(:id)} proposed_claim_status must be unchanged" unless group.fetch(:proposed_claim_status) == "unchanged"

      prediction_ids = group.fetch(:related_prediction_ids).map(&:to_s)
      unknown_prediction_ids = prediction_ids - gate_policy.fetch(:blocked_prediction_ids)
      failures << "#{group.fetch(:id)} has prediction IDs outside blocked gate: #{unknown_prediction_ids.join(', ')}" if unknown_prediction_ids.any?

      claim_ids = group.fetch(:related_claim_ids).map(&:to_s)
      unknown_claim_ids = claim_ids - gate_policy.fetch(:blocked_claim_ids)
      failures << "#{group.fetch(:id)} has claim IDs outside blocked gate: #{unknown_claim_ids.join(', ')}" if unknown_claim_ids.any?

      failures
    end

    def candidate_groups
      dry_run_policy.fetch(:candidate_groups).map do |group|
        CandidateGroup.new(
          id: group.fetch(:id),
          source_kind: group.fetch(:source_kind),
          source_table: group.fetch(:source_table),
          metric_keys: group.fetch(:metric_keys),
          related_prediction_ids: group.fetch(:related_prediction_ids),
          related_claim_ids: group.fetch(:related_claim_ids),
          candidate_status: group.fetch(:candidate_status),
          evidence_classification: group.fetch(:evidence_classification),
          proposed_claim_status: group.fetch(:proposed_claim_status),
          reviewed_observation_count: reviewed_observation_count(group),
          unreviewed_observation_count: unreviewed_observation_count(group),
          limitation: group.fetch(:limitation)
        )
      end
    end

    def reviewed_observation_count(group)
      MetricQualityReview
        .joins(:data_source)
        .where(data_sources: { source_kind: group.fetch(:source_kind) })
        .where(review_status: dry_run_policy.fetch(:allowed_review_statuses))
        .where("metric_quality_reviews.review_metadata ->> 'source_table' = ?", group.fetch(:source_table))
        .where("metric_quality_reviews.review_metadata ->> 'metric_key' IN (?)", group.fetch(:metric_keys))
        .count
    end

    def unreviewed_observation_count(group)
      MetricObservation
        .joins(:data_source)
        .left_joins(:metric_quality_review)
        .where(data_sources: { source_kind: group.fetch(:source_kind) })
        .where("metric_observations.quality_metadata ->> 'source_table' = ?", group.fetch(:source_table))
        .where("metric_observations.quality_metadata ->> 'metric_key' IN (?)", group.fetch(:metric_keys))
        .where(metric_quality_reviews: { id: nil })
        .count
    end

    def dry_run_policy
      @dry_run_policy ||= policy.fetch(:claim_review_candidate_dry_run_v1)
    end

    def gate_policy
      @gate_policy ||= policy.fetch(:claim_review_gate_v1)
    end
  end
end
