require "yaml"

module Operations
  class V0Readiness
    Result = Data.define(:passed, :checks, :blockers, :warnings)

    THESIS_SLUG = "operator-node-economics"
    THESIS_ROOT = Rails.root.join("..", "theses", THESIS_SLUG).expand_path
    THESIS_METADATA_PATH = THESIS_ROOT.join("thesis.yml")
    V0_ARTIFACT_PATH = THESIS_ROOT.join("publication", "v0.md")
    V0_TIMELINE_PATH = THESIS_ROOT.join("publication", "v0_timeline.yml")

    REQUIRED_CHECKPOINTS = {
      v2: 12,
      v3: 20,
      v4: 40
    }.freeze

    REQUIRED_SCHEDULED_JOBS = %i[
      source_release_check
      quarterly_indicator_checkpoint
      annual_snapshot_candidate
    ].freeze

    def self.call(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
      new(policy: policy).call
    end

    def initialize(policy:)
      @policy = policy.deep_symbolize_keys
    end

    def call
      metadata = load_metadata
      checks = {
        thesis_metadata_present: metadata.present?,
        thesis_slug_correct: metadata.fetch(:slug, nil) == THESIS_SLUG,
        thesis_title_present: metadata.fetch(:title, nil).present?,
        thesis_status_ready_for_v0: metadata.fetch(:status, nil) == "v0_ready",
        draft_status_resolved: metadata.dig(:paper, :draft_status) != "held_back_initially",
        v0_publication_artifact_present: V0_ARTIFACT_PATH.exist?,
        v0_timeline_present: V0_TIMELINE_PATH.exist?,
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
        warnings: warnings(metadata)
      )
    end

    private

    attr_reader :policy

    def load_metadata
      return {} unless THESIS_METADATA_PATH.exist?

      YAML.safe_load_file(THESIS_METADATA_PATH).deep_symbolize_keys
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
      configured_offsets = forecast_clock.fetch(:checkpoint_quarters_after_v1, {})
      REQUIRED_CHECKPOINTS.all? do |checkpoint, expected_offset|
        configured_offsets.fetch(checkpoint, nil) == expected_offset
      end
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

    def warnings(metadata)
      [].tap do |warnings|
        warnings << "paper_draft_is_archive_only" if metadata.dig(:paper, :draft_status) == "held_back_initially"
        warnings << "operator_accounts_not_bootstrapped_intentionally" if production_summary.table_counts.fetch(:users).zero?
      end
    end
  end
end
