require "yaml"

module Operations
  class V0ProseReview
    Result = Data.define(:passed, :checks, :failures, :warnings)

    THESIS_SLUG = "operator-node-economics"
    REPO_ROOT = Rails.root.join("..").expand_path
    THESIS_ROOT = REPO_ROOT.join("theses", THESIS_SLUG)
    V0_PROSE_REVIEW_PATH = THESIS_ROOT.join("publication", "v0_prose_review.yml")
    V0_ARTIFACT_PATH = THESIS_ROOT.join("publication", "v0.md")
    V0_APPROVAL_PACKET_PATH = THESIS_ROOT.join("publication", "v0_approval_packet.yml")
    REVIEW_ARTIFACT_REF = "theses/operator-node-economics/publication/v0_prose_review.yml"

    REQUIRED_CRITERIA = %i[
      archived_draft_not_imported
      internal_record_not_public_prose
      no_claim_or_forecast_approval
      source_truth_boundaries_visible
      no_baseline_as_proof
      no_public_release_effect
    ].freeze

    REQUIRED_PROHIBITED_EFFECTS = %w[
      prose_review_acceptance
      source_truth_review_acceptance
      prohibited_foundations_review_acceptance
      claim_status_change
      forecast_status_change
      prediction_link_creation
      claim_review_creation
      public_publication
      paper_prose_publication
      canonical_ingestion
      thesis_verdict
    ].freeze

    def self.call(review: nil, approval_packet: nil)
      new(review: review, approval_packet: approval_packet).call
    end

    def initialize(review:, approval_packet:)
      @review = review
      @approval_packet = approval_packet
    end

    def call
      loaded_review = review || load_yaml(V0_PROSE_REVIEW_PATH)
      loaded_approval_packet = approval_packet || load_yaml(V0_APPROVAL_PACKET_PATH)
      checks = {
        v0_prose_review_scaffold_present: loaded_review.present?,
        v0_prose_review_unapproved: loaded_review.fetch(:approval_status, nil) == "unapproved",
        v0_prose_review_gate_accepted: approval_gate_accepted?(loaded_approval_packet),
        v0_prose_review_no_approval_effect: loaded_review.fetch(:review_effect, nil) == "no_approval_no_publication_no_claim_support",
        v0_prose_required_artifacts_present: required_artifacts_present?(loaded_review),
        v0_prose_held_back_artifacts_absent: held_back_artifacts_absent?(loaded_review),
        v0_approval_packet_requires_prose_review: approval_packet_requires_review?(loaded_approval_packet),
        v0_publication_artifact_internal_record: publication_artifact_internal_record?,
        v0_prose_criteria_pending_human_review: review_criteria_pending?(loaded_review),
        v0_prose_prohibited_effects_present: prohibited_effects_present?(loaded_review)
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

    attr_reader :review, :approval_packet

    def load_yaml(path)
      return {} unless path.exist?

      YAML.safe_load_file(path).deep_symbolize_keys
    end

    def required_artifacts_present?(loaded_review)
      artifact_paths = loaded_review.fetch(:required_artifacts, [])
      return false if artifact_paths.empty?

      artifact_paths.all? { |artifact_path| REPO_ROOT.join(artifact_path).exist? }
    end

    def held_back_artifacts_absent?(loaded_review)
      loaded_review.fetch(:held_back_artifacts, []).all? do |artifact_path|
        !REPO_ROOT.join(artifact_path).exist?
      end
    end

    def approval_packet_requires_review?(loaded_approval_packet)
      required_artifacts = loaded_approval_packet.dig(:approval_gates, :prose_review, :required_artifacts).to_a
      required_artifacts.include?(REVIEW_ARTIFACT_REF)
    end

    def approval_gate_accepted?(loaded_approval_packet)
      loaded_approval_packet.dig(:approval_gates, :prose_review, :status) == "accepted"
    end

    def publication_artifact_internal_record?
      return false unless V0_ARTIFACT_PATH.exist?

      text = V0_ARTIFACT_PATH.read
      text.include?("Status: internal v0 control record.") &&
        text.include?("does not import the archived `paper/draft.md`") &&
        text.include?("Public release status: not public") &&
        text.include?("Direct Operator Node evidence is absent at v0") &&
        text.include?("The claim and forecast sets are approved as internal v0 inventories") &&
        text.include?("individual claim and forecast items") &&
        text.include?("remain `candidate_unapproved`")
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
        warnings << "v0_prose_review_unapproved" if loaded_review.fetch(:approval_status, nil) == "unapproved" && !approval_gate_accepted?(loaded_approval_packet)
      end
    end
  end
end
