require "yaml"

module Operations
  class V0Readiness
    Result = Data.define(:passed, :checks, :blockers, :warnings)

    THESIS_SLUG = "operator-node-economics"
    THESIS_ROOT = Rails.root.join("..", "theses", THESIS_SLUG).expand_path
    THESIS_METADATA_PATH = THESIS_ROOT.join("thesis.yml")
    V0_ARTIFACT_PATH = THESIS_ROOT.join("publication", "v0.md")
    V0_TIMELINE_PATH = THESIS_ROOT.join("publication", "v0_timeline.yml")
    V0_CLAIM_SET_PATH = THESIS_ROOT.join("publication", "v0_claim_set.yml")
    V0_FORECAST_SET_PATH = THESIS_ROOT.join("publication", "v0_forecast_set.yml")
    V0_FROZEN_CLAIM_SET_REVIEW_PATH = THESIS_ROOT.join("publication", "v0_frozen_claim_set_review.yml")
    V0_FROZEN_FORECAST_SET_REVIEW_PATH = THESIS_ROOT.join("publication", "v0_frozen_forecast_set_review.yml")
    V0_INDICATOR_UNIVERSE_PATH = THESIS_ROOT.join("publication", "v0_indicator_universe.yml")
    V0_SOURCE_TRUTH_REVIEW_PATH = THESIS_ROOT.join("publication", "v0_source_truth_review.yml")
    V0_PROHIBITED_FOUNDATIONS_REVIEW_PATH = THESIS_ROOT.join("publication", "v0_prohibited_foundations_review.yml")
    V0_PROSE_REVIEW_PATH = THESIS_ROOT.join("publication", "v0_prose_review.yml")
    V0_PUBLIC_RELEASE_REVIEW_PATH = THESIS_ROOT.join("publication", "v0_public_release_review.yml")
    V0_APPROVAL_PACKET_PATH = THESIS_ROOT.join("publication", "v0_approval_packet.yml")

    REQUIRED_CHECKPOINTS = {
      v1: 12,
      v2: 20,
      v3: 40
    }.freeze

    REQUIRED_INDICATOR_CATEGORIES = %i[
      direct_operator_node_emergence
      diffusion_indicators
      substitution_indicators
      transaction_cost_indicators
      hr_management_coordination_indicators
      firm_boundary_indicators
      nonemployer_one_human_economics_indicators
      corporate_absorption_alternative_indicators
      remote_employment_unbundling_falsifier
      economic_class_preference_validation_indicators
      failure_adverse_indicators
    ].freeze

    REQUIRED_SCHEDULED_JOBS = %i[
      source_release_check
      quarterly_indicator_checkpoint
      annual_snapshot_candidate
      production_summary_check
      v0_readiness_check
    ].freeze

    def self.call(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
      new(policy: policy).call
    end

    def initialize(policy:)
      @policy = policy.deep_symbolize_keys
    end

    def call
      metadata = load_metadata
      timeline = load_timeline
      claim_set = load_claim_set
      forecast_set = load_forecast_set
      indicator_universe = load_indicator_universe
      approval_packet = load_approval_packet
      source_truth_review = Operations::V0SourceTruthReview.call
      prohibited_foundations_review = Operations::V0ProhibitedFoundationsReview.call
      frozen_claim_set_review = Operations::V0FrozenClaimSetReview.call
      frozen_forecast_set_review = Operations::V0FrozenForecastSetReview.call
      prose_review = Operations::V0ProseReview.call
      public_release_review = Operations::V0PublicReleaseReview.call
      checks = {
        thesis_metadata_present: metadata.present?,
        thesis_slug_correct: metadata.fetch(:slug, nil) == THESIS_SLUG,
        thesis_title_present: metadata.fetch(:title, nil).present?,
        thesis_status_ready_for_v0: metadata.fetch(:status, nil) == "v0_ready",
        draft_status_resolved: metadata.dig(:paper, :draft_status) != "held_back_initially",
        v0_publication_scaffold_present: V0_ARTIFACT_PATH.exist?,
        v0_timeline_scaffold_present: timeline.present?,
        v0_claim_set_present: claim_set.present?,
        v0_forecast_set_present: forecast_set.present?,
        v0_indicator_universe_present: indicator_universe.present?,
        v0_indicator_universe_categories_present: indicator_categories_present?(indicator_universe),
        v0_indicator_universe_unapproved: indicator_universe.fetch(:approval_status, nil) == "unapproved",
        v0_source_truth_review_scaffold_present: V0_SOURCE_TRUTH_REVIEW_PATH.exist?,
        v0_source_truth_review_scaffold_valid: source_truth_review.passed,
        v0_prohibited_foundations_review_scaffold_present: V0_PROHIBITED_FOUNDATIONS_REVIEW_PATH.exist?,
        v0_prohibited_foundations_review_scaffold_valid: prohibited_foundations_review.passed,
        v0_frozen_claim_set_review_scaffold_present: V0_FROZEN_CLAIM_SET_REVIEW_PATH.exist?,
        v0_frozen_claim_set_review_scaffold_valid: frozen_claim_set_review.passed,
        v0_frozen_forecast_set_review_scaffold_present: V0_FROZEN_FORECAST_SET_REVIEW_PATH.exist?,
        v0_frozen_forecast_set_review_scaffold_valid: frozen_forecast_set_review.passed,
        v0_prose_review_scaffold_present: V0_PROSE_REVIEW_PATH.exist?,
        v0_prose_review_scaffold_valid: prose_review.passed,
        v0_public_release_review_scaffold_present: V0_PUBLIC_RELEASE_REVIEW_PATH.exist?,
        v0_public_release_review_scaffold_valid: public_release_review.passed,
        v0_approval_packet_present: approval_packet.present?,
        v0_approval_packet_unapproved: approval_packet.fetch(:approval_status, nil) == "unapproved",
        v0_baseline_evidence_accepted: approval_gate_status(approval_packet, :baseline_evidence_review) == "accepted",
        v0_source_truth_review_accepted: approval_gate_status(approval_packet, :source_truth_review) == "accepted",
        v0_prohibited_foundations_review_accepted: approval_gate_status(approval_packet, :prohibited_foundations_review) == "accepted",
        v0_prose_review_accepted: approval_gate_status(approval_packet, :prose_review) == "accepted",
        v0_public_release_review_accepted: approval_gate_status(approval_packet, :public_release_review) == "accepted",
        v0_internal_target_date_set: timeline.dig(:publication, :target_internal_publication_date).present?,
        v0_first_measurement_period_set: timeline.dig(:forecast_clock, :first_measurement_period).present?,
        v0_publication_approved: timeline.dig(:publication, :approval_status) == "approved",
        v0_publication_date_set: timeline.dig(:publication, :publication_date).present?,
        v0_checkpoint_dates_set: checkpoint_dates_set?(timeline),
        v0_claim_set_approved: v0_set_approved?(timeline, claim_set, :claims_status),
        v0_forecast_set_approved: v0_set_approved?(timeline, forecast_set, :forecasts_status),
        forecast_clock_policy_present: forecast_clock_policy_present?,
        checkpoint_offsets_present: checkpoint_offsets_present?,
        sidekiq_schedule_present: sidekiq_schedule_present?,
        production_summary_healthy: production_summary.health_passed,
        evidence_counts_present: evidence_counts_present?,
        canonical_data_promotion_disabled: production_summary.canonical_data_promotion_disabled,
        claim_review_gate_disabled: claim_review_gate_disabled?,
        no_automatic_claim_promotion: no_automatic_claim_promotion?,
        public_path_target_configured: production_operations.fetch(:public_path_target, nil) == "sourcegridlabs.com/thesis"
      }

      blockers = checks.filter_map { |name, passed| name.to_s unless passed }
      Result.new(
        passed: blockers.empty?,
        checks: checks,
        blockers: blockers,
        warnings: warnings(metadata, timeline, claim_set, forecast_set, approval_packet)
      )
    end

    private

    attr_reader :policy

    def load_metadata
      return {} unless THESIS_METADATA_PATH.exist?

      YAML.safe_load_file(THESIS_METADATA_PATH).deep_symbolize_keys
    end

    def load_timeline
      return {} unless V0_TIMELINE_PATH.exist?

      YAML.safe_load_file(V0_TIMELINE_PATH).deep_symbolize_keys
    end

    def load_claim_set
      return {} unless V0_CLAIM_SET_PATH.exist?

      YAML.safe_load_file(V0_CLAIM_SET_PATH).deep_symbolize_keys
    end

    def load_forecast_set
      return {} unless V0_FORECAST_SET_PATH.exist?

      YAML.safe_load_file(V0_FORECAST_SET_PATH).deep_symbolize_keys
    end

    def load_approval_packet
      return {} unless V0_APPROVAL_PACKET_PATH.exist?

      YAML.safe_load_file(V0_APPROVAL_PACKET_PATH).deep_symbolize_keys
    end

    def load_indicator_universe
      return {} unless V0_INDICATOR_UNIVERSE_PATH.exist?

      YAML.safe_load_file(V0_INDICATOR_UNIVERSE_PATH).deep_symbolize_keys
    end

    def forecast_clock
      policy.fetch(:forecast_clock, {})
    end

    def production_operations
      policy.fetch(:production_operations_v1, {})
    end

    def claim_review_gate
      policy.fetch(:claim_review_gate_v1, {})
    end

    def forecast_clock_policy_present?
      forecast_clock.fetch(:measurement_atom, nil) == "calendar_quarter" &&
        forecast_clock.fetch(:first_measurement_period_rule, nil).present?
    end

    def checkpoint_offsets_present?
      configured_offsets = forecast_clock.fetch(:checkpoint_quarters_after_v0, {})
      REQUIRED_CHECKPOINTS.all? do |checkpoint, expected_offset|
        configured_offsets.fetch(checkpoint, nil) == expected_offset
      end
    end

    def indicator_categories_present?(indicator_universe)
      categories = indicator_universe.fetch(:indicator_categories, {})
      REQUIRED_INDICATOR_CATEGORIES.all? { |category| categories.key?(category) }
    end

    def checkpoint_dates_set?(timeline)
      checkpoints = timeline.fetch(:checkpoints, {})

      REQUIRED_CHECKPOINTS.all? do |checkpoint, expected_offset|
        configured_checkpoint = checkpoints.fetch(checkpoint, {})
        configured_checkpoint.fetch(:quarters_after_v0, nil) == expected_offset &&
          configured_checkpoint.fetch(:target_date, nil).present?
      end
    end

    def v0_set_approved?(timeline, set, timeline_status_key)
      timeline.dig(:publication, timeline_status_key) == "approved" &&
        set.fetch(:approval_status, nil) == "approved"
    end

    def approval_gate_status(approval_packet, gate)
      approval_packet.dig(:approval_gates, gate, :status)
    end

    def sidekiq_schedule_present?
      scheduler_jobs = policy.fetch(:scheduler).fetch(:jobs)
      REQUIRED_SCHEDULED_JOBS.all? { |job| scheduler_jobs.key?(job) }
    end

    def production_summary
      @production_summary ||= Operations::ProductionSummary.call
    end

    def evidence_counts_present?
      table_counts = production_summary.table_counts
      table_counts.fetch(:data_sources).positive? &&
        table_counts.fetch(:metric_definitions).positive? &&
        table_counts.fetch(:metric_observations).positive? &&
        table_counts.fetch(:metric_quality_reviews).positive?
    end

    def claim_review_gate_disabled?
      claim_review_gate.fetch(:status, nil) == "design_only_disabled" &&
        claim_review_gate.fetch(:claim_reviews_authorized, true) == false &&
        claim_review_gate.fetch(:prediction_links_authorized, true) == false
    end

    def no_automatic_claim_promotion?
      claim_review_gate.fetch(:automatic_claim_promotion_authorized, true) == false
    end

    def warnings(metadata, timeline, claim_set, forecast_set, approval_packet)
      [].tap do |warnings|
        warnings << "paper_draft_is_archive_only" if metadata.dig(:paper, :draft_status) == "held_back_initially"
        warnings << "v0_publication_scaffold_only" if %w[draft_scaffold internal_target_scaffold].include?(timeline.fetch(:status, nil))
        warnings << "v0_dates_are_provisional" if timeline.dig(:forecast_clock, :date_status) == "provisional_until_publication_approval"
        warnings << "v0_claim_set_candidate_only" if claim_set.fetch(:status, nil) == "candidate_inventory"
        warnings << "v0_forecast_set_candidate_only" if forecast_set.fetch(:status, nil) == "candidate_inventory"
        warnings << "v0_approval_packet_scaffold_only" if approval_packet.fetch(:status, nil) == "approval_packet_scaffold"
        warnings << "v0_indicator_universe_unapproved" if V0_INDICATOR_UNIVERSE_PATH.exist?
        warnings << "v0_source_truth_review_unapproved" if V0_SOURCE_TRUTH_REVIEW_PATH.exist? && approval_gate_status(approval_packet, :source_truth_review) != "accepted"
        warnings << "v0_prohibited_foundations_review_unapproved" if V0_PROHIBITED_FOUNDATIONS_REVIEW_PATH.exist? && approval_gate_status(approval_packet, :prohibited_foundations_review) != "accepted"
        warnings << "v0_frozen_claim_set_review_unapproved" if V0_FROZEN_CLAIM_SET_REVIEW_PATH.exist? && approval_gate_status(approval_packet, :frozen_claim_set_review) != "accepted"
        warnings << "v0_frozen_forecast_set_review_unapproved" if V0_FROZEN_FORECAST_SET_REVIEW_PATH.exist? && approval_gate_status(approval_packet, :frozen_forecast_set_review) != "accepted"
        warnings << "v0_prose_review_unapproved" if V0_PROSE_REVIEW_PATH.exist?
        warnings << "v0_public_release_review_unapproved" if V0_PUBLIC_RELEASE_REVIEW_PATH.exist?
        warnings << "operator_accounts_not_bootstrapped_intentionally" if production_summary.table_counts.fetch(:users).zero?
      end
    end
  end
end
