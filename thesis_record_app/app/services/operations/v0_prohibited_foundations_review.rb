require "yaml"

module Operations
  class V0ProhibitedFoundationsReview
    Result = Data.define(:passed, :checks, :failures, :warnings)

    THESIS_SLUG = "operator-node-economics"
    REPO_ROOT = Rails.root.join("..").expand_path
    THESIS_ROOT = REPO_ROOT.join("theses", THESIS_SLUG)
    V0_PROHIBITED_FOUNDATIONS_REVIEW_PATH = THESIS_ROOT.join("publication", "v0_prohibited_foundations_review.yml")
    V0_APPROVAL_PACKET_PATH = THESIS_ROOT.join("publication", "v0_approval_packet.yml")
    REVIEW_ARTIFACT_REF = "theses/operator-node-economics/publication/v0_prohibited_foundations_review.yml"

    REQUIRED_ALLOWED_FOUNDATIONS = %w[
      economics
      organizational_theory
      history
      technology
      empirical_evidence
    ].freeze

    REQUIRED_PROHIBITED_FOUNDATIONS = [
      "Buddhism",
      "Taoism",
      "Sunyata",
      "dependent origination"
    ].freeze

    REQUIRED_CRITERIA = %i[
      allowed_foundations_only
      prohibited_foundations_listed
      analogy_not_evidence
      no_manifesto_or_prestige_frame
      no_publication_without_human_review
    ].freeze

    REQUIRED_PROHIBITED_EFFECTS = %w[
      prohibited_foundations_review_acceptance
      source_truth_review_acceptance
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
      loaded_review = review || load_yaml(V0_PROHIBITED_FOUNDATIONS_REVIEW_PATH)
      loaded_approval_packet = approval_packet || load_yaml(V0_APPROVAL_PACKET_PATH)
      checks = {
        v0_prohibited_foundations_review_scaffold_present: loaded_review.present?,
        v0_prohibited_foundations_review_unapproved: loaded_review.fetch(:approval_status, nil) == "unapproved",
        v0_prohibited_foundations_review_no_approval_effect: loaded_review.fetch(:review_effect, nil) == "no_approval_no_publication_no_claim_support",
        v0_prohibited_foundations_allowed_foundations_present: allowed_foundations_present?(loaded_review),
        v0_prohibited_foundations_terms_listed: prohibited_terms_listed?(loaded_review),
        v0_prohibited_foundations_required_artifacts_present: required_artifacts_present?(loaded_review),
        v0_approval_packet_requires_prohibited_foundations_review: approval_packet_requires_review?(loaded_approval_packet),
        v0_prohibited_foundations_criteria_pending_human_review: review_criteria_pending?(loaded_review),
        v0_prohibited_foundations_prohibited_effects_present: prohibited_effects_present?(loaded_review),
        v0_scanned_artifacts_avoid_prohibited_foundation_terms: scanned_artifacts_avoid_terms?(loaded_review)
      }

      failures = checks.filter_map { |name, passed| name.to_s unless passed }
      Result.new(
        passed: failures.empty?,
        checks: checks,
        failures: failures,
        warnings: warnings(loaded_review)
      )
    end

    private

    attr_reader :review, :approval_packet

    def load_yaml(path)
      return {} unless path.exist?

      YAML.safe_load_file(path).deep_symbolize_keys
    end

    def allowed_foundations_present?(loaded_review)
      configured = loaded_review.fetch(:allowed_foundations, []).map(&:to_s)
      (REQUIRED_ALLOWED_FOUNDATIONS - configured).empty?
    end

    def prohibited_terms_listed?(loaded_review)
      configured = loaded_review.fetch(:prohibited_foundations, []).map(&:to_s)
      (REQUIRED_PROHIBITED_FOUNDATIONS - configured).empty?
    end

    def required_artifacts_present?(loaded_review)
      artifact_paths = loaded_review.fetch(:required_artifacts, [])
      return false if artifact_paths.empty?

      artifact_paths.all? { |artifact_path| REPO_ROOT.join(artifact_path).exist? }
    end

    def approval_packet_requires_review?(loaded_approval_packet)
      required_artifacts = loaded_approval_packet.dig(:approval_gates, :prohibited_foundations_review, :required_artifacts).to_a
      required_artifacts.include?(REVIEW_ARTIFACT_REF)
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

    def scanned_artifacts_avoid_terms?(loaded_review)
      scan_paths = loaded_review.fetch(:scan_paths, [])
      return false if scan_paths.empty?

      scan_paths.all? do |scan_path|
        path = REPO_ROOT.join(scan_path)
        next false unless path.exist?

        text = path.read
        REQUIRED_PROHIBITED_FOUNDATIONS.none? do |term|
          text.match?(/\b#{Regexp.escape(term)}\b/i)
        end
      end
    end

    def warnings(loaded_review)
      [].tap do |warnings|
        warnings << "v0_prohibited_foundations_review_unapproved" if loaded_review.fetch(:approval_status, nil) == "unapproved"
      end
    end
  end
end
