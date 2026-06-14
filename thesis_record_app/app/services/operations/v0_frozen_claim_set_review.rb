require "yaml"

module Operations
  class V0FrozenClaimSetReview
    Result = Data.define(:passed, :checks, :failures, :warnings)

    THESIS_SLUG = "operator-node-economics"
    REPO_ROOT = Rails.root.join("..").expand_path
    THESIS_ROOT = REPO_ROOT.join("theses", THESIS_SLUG)
    V0_FROZEN_CLAIM_SET_REVIEW_PATH = THESIS_ROOT.join("publication", "v0_frozen_claim_set_review.yml")
    V0_CLAIM_SET_PATH = THESIS_ROOT.join("publication", "v0_claim_set.yml")
    V0_APPROVAL_PACKET_PATH = THESIS_ROOT.join("publication", "v0_approval_packet.yml")
    REVIEW_ARTIFACT_REF = "theses/operator-node-economics/publication/v0_frozen_claim_set_review.yml"

    REQUIRED_CRITERIA = %i[
      claim_inventory_complete
      all_claims_unapproved
      source_truth_refs_present
      review_notes_present
      no_automatic_promotion
    ].freeze

    REQUIRED_PROHIBITED_EFFECTS = %w[
      frozen_claim_set_review_acceptance
      claim_status_change
      forecast_status_change
      prediction_link_creation
      claim_review_creation
      public_publication
      paper_prose_publication
      canonical_ingestion
      thesis_verdict
    ].freeze

    def self.call(review: nil, claim_set: nil, approval_packet: nil)
      new(review: review, claim_set: claim_set, approval_packet: approval_packet).call
    end

    def initialize(review:, claim_set:, approval_packet:)
      @review = review
      @claim_set = claim_set
      @approval_packet = approval_packet
    end

    def call
      loaded_review = review || load_yaml(V0_FROZEN_CLAIM_SET_REVIEW_PATH)
      loaded_claim_set = claim_set || load_yaml(V0_CLAIM_SET_PATH)
      loaded_approval_packet = approval_packet || load_yaml(V0_APPROVAL_PACKET_PATH)
      checks = {
        v0_frozen_claim_set_review_scaffold_present: loaded_review.present?,
        v0_frozen_claim_set_review_unapproved: loaded_review.fetch(:approval_status, nil) == "unapproved",
        v0_frozen_claim_set_review_gate_accepted: approval_gate_accepted?(loaded_approval_packet),
        v0_frozen_claim_set_review_no_approval_effect: loaded_review.fetch(:review_effect, nil) == "no_approval_no_publication_no_claim_support",
        v0_frozen_claim_set_required_artifacts_present: required_artifacts_present?(loaded_review),
        v0_approval_packet_requires_frozen_claim_set_review: approval_packet_requires_review?(loaded_approval_packet),
        v0_claim_set_internal_inventory_approved: claim_set_internal_inventory_approved?(loaded_claim_set),
        v0_claim_inventory_complete: claim_inventory_complete?(loaded_review, loaded_claim_set),
        v0_claim_ids_unique: ids_unique?(loaded_claim_set.fetch(:claims, [])),
        v0_claim_items_reviewable: claim_items_reviewable?(loaded_claim_set),
        v0_claim_set_no_automatic_promotion: no_automatic_promotion?(loaded_claim_set),
        v0_frozen_claim_set_criteria_pending_human_review: review_criteria_pending?(loaded_review),
        v0_frozen_claim_set_prohibited_effects_present: prohibited_effects_present?(loaded_review)
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

    attr_reader :review, :claim_set, :approval_packet

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
      required_artifacts = loaded_approval_packet.dig(:approval_gates, :frozen_claim_set_review, :required_artifacts).to_a
      required_artifacts.include?(REVIEW_ARTIFACT_REF)
    end

    def approval_gate_accepted?(loaded_approval_packet)
      loaded_approval_packet.dig(:approval_gates, :frozen_claim_set_review, :status) == "accepted"
    end

    def claim_set_internal_inventory_approved?(loaded_claim_set)
      loaded_claim_set.fetch(:status, nil) == "internal_v0_inventory" &&
        loaded_claim_set.fetch(:approval_status, nil) == "approved"
    end

    def claim_inventory_complete?(loaded_review, loaded_claim_set)
      configured_ids = loaded_claim_set.fetch(:claims, []).map { |claim| claim.fetch(:id, nil) }.compact
      required_ids = loaded_review.fetch(:required_claim_ids, [])
      required_ids.present? && (required_ids - configured_ids).empty? && (configured_ids - required_ids).empty?
    end

    def ids_unique?(items)
      ids = items.map { |item| item.fetch(:id, nil) }.compact
      ids.size == ids.uniq.size
    end

    def claim_items_reviewable?(loaded_claim_set)
      claims = loaded_claim_set.fetch(:claims, [])
      claims.present? && claims.all? do |claim|
        claim.fetch(:v0_status, nil) == "candidate_unapproved" &&
          claim.fetch(:v0_role, nil).present? &&
          claim.fetch(:source_status, nil).present? &&
          claim.fetch(:source_truth_refs, []).present? &&
          claim.fetch(:review_note, nil).present?
      end
    end

    def no_automatic_promotion?(loaded_claim_set)
      loaded_claim_set.dig(:scope, :claim_status_effect) == "internal_inventory_approved_no_claim_support" &&
        loaded_claim_set.dig(:scope, :automatic_promotion_authorized) == false
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
        warnings << "v0_frozen_claim_set_review_unapproved" if loaded_review.fetch(:approval_status, nil) == "unapproved" && !approval_gate_accepted?(loaded_approval_packet)
      end
    end
  end
end
