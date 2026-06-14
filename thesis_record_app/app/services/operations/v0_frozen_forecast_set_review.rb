require "yaml"

module Operations
  class V0FrozenForecastSetReview
    Result = Data.define(:passed, :checks, :failures, :warnings)

    THESIS_SLUG = "operator-node-economics"
    REPO_ROOT = Rails.root.join("..").expand_path
    THESIS_ROOT = REPO_ROOT.join("theses", THESIS_SLUG)
    V0_FROZEN_FORECAST_SET_REVIEW_PATH = THESIS_ROOT.join("publication", "v0_frozen_forecast_set_review.yml")
    V0_FORECAST_SET_PATH = THESIS_ROOT.join("publication", "v0_forecast_set.yml")
    V0_TIMELINE_PATH = THESIS_ROOT.join("publication", "v0_timeline.yml")
    V0_APPROVAL_PACKET_PATH = THESIS_ROOT.join("publication", "v0_approval_packet.yml")
    REVIEW_ARTIFACT_REF = "theses/operator-node-economics/publication/v0_frozen_forecast_set_review.yml"

    REQUIRED_CRITERIA = %i[
      forecast_inventory_complete
      all_forecasts_unapproved
      failure_conditions_present
      measurement_readiness_present
      checkpoint_refs_match_timeline
      no_automatic_verdicts
    ].freeze

    REQUIRED_PROHIBITED_EFFECTS = %w[
      frozen_forecast_set_review_acceptance
      forecast_status_change
      claim_status_change
      prediction_link_creation
      claim_review_creation
      public_publication
      paper_prose_publication
      canonical_ingestion
      thesis_verdict
    ].freeze

    def self.call(review: nil, forecast_set: nil, timeline: nil, approval_packet: nil)
      new(review: review, forecast_set: forecast_set, timeline: timeline, approval_packet: approval_packet).call
    end

    def initialize(review:, forecast_set:, timeline:, approval_packet:)
      @review = review
      @forecast_set = forecast_set
      @timeline = timeline
      @approval_packet = approval_packet
    end

    def call
      loaded_review = review || load_yaml(V0_FROZEN_FORECAST_SET_REVIEW_PATH)
      loaded_forecast_set = forecast_set || load_yaml(V0_FORECAST_SET_PATH)
      loaded_timeline = timeline || load_yaml(V0_TIMELINE_PATH)
      loaded_approval_packet = approval_packet || load_yaml(V0_APPROVAL_PACKET_PATH)
      checks = {
        v0_frozen_forecast_set_review_scaffold_present: loaded_review.present?,
        v0_frozen_forecast_set_review_unapproved: loaded_review.fetch(:approval_status, nil) == "unapproved",
        v0_frozen_forecast_set_review_gate_accepted: approval_gate_accepted?(loaded_approval_packet),
        v0_frozen_forecast_set_review_no_approval_effect: loaded_review.fetch(:review_effect, nil) == "no_approval_no_publication_no_claim_support",
        v0_frozen_forecast_set_required_artifacts_present: required_artifacts_present?(loaded_review),
        v0_approval_packet_requires_frozen_forecast_set_review: approval_packet_requires_review?(loaded_approval_packet),
        v0_forecast_set_unapproved_candidate_inventory: forecast_set_unapproved_candidate_inventory?(loaded_forecast_set),
        v0_forecast_inventory_complete: forecast_inventory_complete?(loaded_review, loaded_forecast_set),
        v0_forecast_ids_unique: ids_unique?(loaded_forecast_set.fetch(:forecasts, [])),
        v0_forecast_items_reviewable: forecast_items_reviewable?(loaded_forecast_set),
        v0_forecast_clock_matches_timeline: forecast_clock_matches_timeline?(loaded_review, loaded_forecast_set, loaded_timeline),
        v0_forecast_set_no_automatic_verdicts: no_automatic_verdicts?(loaded_forecast_set),
        v0_frozen_forecast_set_criteria_pending_human_review: review_criteria_pending?(loaded_review),
        v0_frozen_forecast_set_prohibited_effects_present: prohibited_effects_present?(loaded_review)
      }

      failures = checks.filter_map { |name, passed| name.to_s unless passed }
      Result.new(
        passed: failures.empty?,
        checks: checks,
        failures: failures,
        warnings: warnings(loaded_review, loaded_approval_packet)
      )
    end

    private

    attr_reader :review, :forecast_set, :timeline, :approval_packet

    def load_yaml(path)
      return {} unless path.exist?

      YAML.safe_load_file(path).deep_symbolize_keys
    end

    def required_artifacts_present?(loaded_review)
      artifact_paths = loaded_review.fetch(:required_artifacts, [])
      return false if artifact_paths.empty?

      artifact_paths.all? { |artifact_path| REPO_ROOT.join(artifact_path).exist? }
    end

    def approval_packet_requires_review?(loaded_approval_packet)
      required_artifacts = loaded_approval_packet.dig(:approval_gates, :frozen_forecast_set_review, :required_artifacts).to_a
      required_artifacts.include?(REVIEW_ARTIFACT_REF)
    end

    def approval_gate_accepted?(loaded_approval_packet)
      loaded_approval_packet.dig(:approval_gates, :frozen_forecast_set_review, :status) == "accepted"
    end

    def forecast_set_unapproved_candidate_inventory?(loaded_forecast_set)
      loaded_forecast_set.fetch(:status, nil) == "candidate_inventory" &&
        loaded_forecast_set.fetch(:approval_status, nil) == "unapproved"
    end

    def forecast_inventory_complete?(loaded_review, loaded_forecast_set)
      configured_ids = loaded_forecast_set.fetch(:forecasts, []).map { |forecast| forecast.fetch(:id, nil) }.compact
      required_ids = loaded_review.fetch(:required_forecast_ids, [])
      required_ids.present? && (required_ids - configured_ids).empty? && (configured_ids - required_ids).empty?
    end

    def ids_unique?(items)
      ids = items.map { |item| item.fetch(:id, nil) }.compact
      ids.size == ids.uniq.size
    end

    def forecast_items_reviewable?(loaded_forecast_set)
      forecasts = loaded_forecast_set.fetch(:forecasts, [])
      forecasts.present? && forecasts.all? do |forecast|
        forecast.fetch(:v0_status, nil) == "candidate_unapproved" &&
          forecast.fetch(:v0_role, nil).present? &&
          forecast.fetch(:source_status, nil).present? &&
          forecast.fetch(:measurement_readiness, nil).present? &&
          forecast.fetch(:failure_condition_status, nil) == "present"
      end
    end

    def forecast_clock_matches_timeline?(loaded_review, loaded_forecast_set, loaded_timeline)
      review_refs = loaded_review.fetch(:required_checkpoint_refs, {})
      forecast_refs = loaded_forecast_set.dig(:forecast_clock, :checkpoint_refs).to_h
      timeline_refs = loaded_timeline.fetch(:checkpoints, {}).transform_values { |checkpoint| checkpoint.fetch(:target_period, nil) }
      review_refs == forecast_refs && review_refs == timeline_refs.slice(:v1, :v2, :v3)
    end

    def no_automatic_verdicts?(loaded_forecast_set)
      loaded_forecast_set.dig(:scope, :forecast_status_effect) == "unchanged" &&
        loaded_forecast_set.dig(:scope, :quarterly_updates_are_verdicts) == false &&
        loaded_forecast_set.dig(:scope, :automatic_verdicts_authorized) == false
    end

    def review_criteria_pending?(loaded_review)
      criteria = loaded_review.fetch(:review_criteria, {})
      REQUIRED_CRITERIA.all? do |criterion|
        criteria.dig(criterion, :status) == "pending_human_review" &&
          criteria.dig(criterion, :requirement).present?
      end
    end

    def prohibited_effects_present?(loaded_review)
      configured_effects = loaded_review.fetch(:prohibited_effects, []).map(&:to_s)
      (REQUIRED_PROHIBITED_EFFECTS - configured_effects).empty?
    end

    def warnings(loaded_review, loaded_approval_packet)
      [].tap do |warnings|
        warnings << "v0_frozen_forecast_set_review_unapproved" if loaded_review.fetch(:approval_status, nil) == "unapproved" && !approval_gate_accepted?(loaded_approval_packet)
      end
    end
  end
end
