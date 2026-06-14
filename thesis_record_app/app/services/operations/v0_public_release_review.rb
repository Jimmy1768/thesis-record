require "yaml"

module Operations
  class V0PublicReleaseReview
    Result = Data.define(:passed, :checks, :failures, :warnings)

    THESIS_SLUG = "operator-node-economics"
    REPO_ROOT = Rails.root.join("..").expand_path
    THESIS_ROOT = REPO_ROOT.join("theses", THESIS_SLUG)
    V0_PUBLIC_RELEASE_REVIEW_PATH = THESIS_ROOT.join("publication", "v0_public_release_review.yml")
    V0_TIMELINE_PATH = THESIS_ROOT.join("publication", "v0_timeline.yml")
    V0_APPROVAL_PACKET_PATH = THESIS_ROOT.join("publication", "v0_approval_packet.yml")
    REVIEW_ARTIFACT_REF = "theses/operator-node-economics/publication/v0_public_release_review.yml"

    REQUIRED_CRITERIA = %i[
      release_status_not_public
      public_path_declared
      approval_packet_controls_release
      no_nginx_or_web_surface_assumption
      no_claim_or_forecast_approval
    ].freeze

    REQUIRED_PREREQUISITES = %w[
      source_truth_review_accepted
      prohibited_foundations_review_accepted
      prose_review_accepted
      frozen_claim_set_review_accepted
      frozen_forecast_set_review_accepted
      public_path_verified
      no_claim_or_forecast_auto_promotion
    ].freeze

    REQUIRED_PROHIBITED_EFFECTS = %w[
      public_release_review_acceptance
      prose_review_acceptance
      claim_status_change
      forecast_status_change
      prediction_link_creation
      claim_review_creation
      public_publication
      paper_prose_publication
      canonical_ingestion
      thesis_verdict
    ].freeze

    def self.call(review: nil, approval_packet: nil, timeline: nil)
      new(review: review, approval_packet: approval_packet, timeline: timeline).call
    end

    def initialize(review:, approval_packet:, timeline:)
      @review = review
      @approval_packet = approval_packet
      @timeline = timeline
    end

    def call
      loaded_review = review || load_yaml(V0_PUBLIC_RELEASE_REVIEW_PATH)
      loaded_approval_packet = approval_packet || load_yaml(V0_APPROVAL_PACKET_PATH)
      loaded_timeline = timeline || load_yaml(V0_TIMELINE_PATH)
      checks = {
        v0_public_release_review_scaffold_present: loaded_review.present?,
        v0_public_release_review_unapproved: loaded_review.fetch(:approval_status, nil) == "unapproved",
        v0_public_release_review_gate_accepted: approval_gate_accepted?(loaded_approval_packet),
        v0_public_release_review_no_approval_effect: loaded_review.fetch(:review_effect, nil) == "no_approval_no_publication_no_claim_support",
        v0_public_release_required_artifacts_present: required_artifacts_present?(loaded_review),
        v0_public_release_prerequisites_listed: release_prerequisites_listed?(loaded_review),
        v0_approval_packet_requires_public_release_review: approval_packet_requires_review?(loaded_approval_packet),
        v0_public_release_status_not_public: release_status_not_public?(loaded_approval_packet, loaded_timeline),
        v0_public_path_declared: public_path_declared?(loaded_timeline),
        v0_public_release_criteria_pending_human_review: review_criteria_pending?(loaded_review),
        v0_public_release_prohibited_effects_present: prohibited_effects_present?(loaded_review)
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

    attr_reader :review, :approval_packet, :timeline

    def load_yaml(path)
      return {} unless path.exist?

      YAML.safe_load_file(path).deep_symbolize_keys
    end

    def required_artifacts_present?(loaded_review)
      artifact_paths = loaded_review.fetch(:required_artifacts, [])
      return false if artifact_paths.empty?

      artifact_paths.all? { |artifact_path| REPO_ROOT.join(artifact_path).exist? }
    end

    def release_prerequisites_listed?(loaded_review)
      configured = loaded_review.fetch(:release_prerequisites, []).map(&:to_s)
      (REQUIRED_PREREQUISITES - configured).empty?
    end

    def approval_packet_requires_review?(loaded_approval_packet)
      required_artifacts = loaded_approval_packet.dig(:approval_gates, :public_release_review, :required_artifacts).to_a
      required_artifacts.include?(REVIEW_ARTIFACT_REF)
    end

    def approval_gate_accepted?(loaded_approval_packet)
      loaded_approval_packet.dig(:approval_gates, :public_release_review, :status) == "accepted"
    end

    def release_status_not_public?(loaded_approval_packet, loaded_timeline)
      loaded_approval_packet.fetch(:public_release_status, nil) == "not_public" &&
        loaded_timeline.dig(:publication, :public_release_status) == "not_public"
    end

    def public_path_declared?(loaded_timeline)
      loaded_timeline.dig(:publication, :public_path) == "/thesis/operator-node-economics"
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
        warnings << "v0_public_release_review_unapproved" if loaded_review.fetch(:approval_status, nil) == "unapproved" && !approval_gate_accepted?(loaded_approval_packet)
      end
    end
  end
end
