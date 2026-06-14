require "yaml"

module Operations
  class V0SourceTruthReview
    Result = Data.define(:passed, :checks, :failures, :warnings)

    THESIS_SLUG = "operator-node-economics"
    REPO_ROOT = Rails.root.join("..").expand_path
    THESIS_ROOT = REPO_ROOT.join("theses", THESIS_SLUG)
    V0_SOURCE_TRUTH_REVIEW_PATH = THESIS_ROOT.join("publication", "v0_source_truth_review.yml")
    V0_INDICATOR_UNIVERSE_PATH = THESIS_ROOT.join("publication", "v0_indicator_universe.yml")
    V0_APPROVAL_PACKET_PATH = THESIS_ROOT.join("publication", "v0_approval_packet.yml")
    REVIEW_ARTIFACT_REF = "theses/operator-node-economics/publication/v0_source_truth_review.yml"

    REQUIRED_CRITERIA = %i[
      direct_operator_node_evidence_boundary
      indirect_proxy_boundary
      falsifier_coverage
      definition_boundary
      forecast_ladder_boundary
      prohibited_foundations_boundary
    ].freeze

    REQUIRED_INDICATOR_CATEGORIES = Operations::V0Readiness::REQUIRED_INDICATOR_CATEGORIES

    REQUIRED_INDICATOR_FIELDS = %i[
      id
      target_value
      expected_direction_if_thesis_right
      checkpoint_relevance
      evidence_strength_class
      source_candidates
      linked_forecasts
      confounders
      falsification_or_adverse_condition
    ].freeze

    REQUIRED_PROHIBITED_EFFECTS = %w[
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

    def self.call(review: nil, indicator_universe: nil, approval_packet: nil)
      new(review: review, indicator_universe: indicator_universe, approval_packet: approval_packet).call
    end

    def initialize(review:, indicator_universe:, approval_packet:)
      @review = review
      @indicator_universe = indicator_universe
      @approval_packet = approval_packet
    end

    def call
      loaded_review = review || load_yaml(V0_SOURCE_TRUTH_REVIEW_PATH)
      loaded_indicator_universe = indicator_universe || load_yaml(V0_INDICATOR_UNIVERSE_PATH)
      loaded_approval_packet = approval_packet || load_yaml(V0_APPROVAL_PACKET_PATH)
      checks = {
        v0_source_truth_review_scaffold_present: loaded_review.present?,
        v0_source_truth_review_unapproved: loaded_review.fetch(:approval_status, nil) == "unapproved",
        v0_source_truth_review_gate_accepted: approval_gate_accepted?(loaded_approval_packet),
        v0_source_truth_review_no_approval_effect: loaded_review.fetch(:review_effect, nil) == "no_approval_no_publication_no_claim_support",
        v0_source_truth_required_artifacts_present: required_artifacts_present?(loaded_review),
        v0_approval_packet_requires_source_truth_review: approval_packet_requires_review?(loaded_approval_packet),
        v0_indicator_universe_present: loaded_indicator_universe.present?,
        v0_indicator_universe_boundary_declares_direct_absence: direct_absence_declared?(loaded_indicator_universe),
        v0_indicator_universe_context_only_at_baseline: context_only_boundary?(loaded_indicator_universe),
        v0_indicator_categories_complete: indicator_categories_complete?(loaded_indicator_universe),
        v0_indicator_items_reviewable: indicator_items_reviewable?(loaded_indicator_universe),
        v0_direct_future_evidence_required: direct_future_evidence_required?(loaded_indicator_universe),
        v0_source_truth_criteria_pending_human_review: review_criteria_pending?(loaded_review),
        v0_source_truth_prohibited_effects_present: prohibited_effects_present?(loaded_review)
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

    attr_reader :review, :indicator_universe, :approval_packet

    def load_yaml(path)
      return {} unless path.exist?

      YAML.safe_load_file(path).deep_symbolize_keys
    end

    def required_artifacts_present?(loaded_review)
      artifact_paths = loaded_review.dig(:required_artifacts, :source_truth_docs).to_a +
                       loaded_review.dig(:required_artifacts, :publication_artifacts).to_a
      return false if artifact_paths.empty?

      artifact_paths.all? { |artifact_path| REPO_ROOT.join(artifact_path).exist? }
    end

    def approval_packet_requires_review?(loaded_approval_packet)
      required_artifacts = loaded_approval_packet.dig(:approval_gates, :source_truth_review, :required_artifacts).to_a
      required_artifacts.include?(REVIEW_ARTIFACT_REF)
    end

    def approval_gate_accepted?(loaded_approval_packet)
      loaded_approval_packet.dig(:approval_gates, :source_truth_review, :status) == "accepted"
    end

    def direct_absence_declared?(loaded_indicator_universe)
      loaded_indicator_universe.dig(:current_baseline_boundary, :direct_operator_node_evidence_at_v0) == "absent"
    end

    def context_only_boundary?(loaded_indicator_universe)
      loaded_indicator_universe.dig(:current_baseline_boundary, :interpretation_effect) == "no_claim_support" &&
        loaded_indicator_universe.dig(:current_baseline_boundary, :production_coverage).to_s.include?("public-source context only")
    end

    def indicator_categories_complete?(loaded_indicator_universe)
      categories = loaded_indicator_universe.fetch(:indicator_categories, {})
      REQUIRED_INDICATOR_CATEGORIES.all? { |category| categories.key?(category) }
    end

    def indicator_items_reviewable?(loaded_indicator_universe)
      categories = loaded_indicator_universe.fetch(:indicator_categories, {})
      evidence_classes = loaded_indicator_universe.fetch(:evidence_strength_classes, {}).keys.map(&:to_s)
      return false if categories.empty? || evidence_classes.empty?

      categories.all? do |_category, category_config|
        indicators = category_config.fetch(:indicators, [])
        indicators.present? && indicators.all? do |indicator|
          required_indicator_fields_present?(indicator) &&
            evidence_classes.include?(indicator.fetch(:evidence_strength_class).to_s)
        end
      end
    end

    def required_indicator_fields_present?(indicator)
      REQUIRED_INDICATOR_FIELDS.all? do |field|
        value = indicator.fetch(field, nil)
        value.respond_to?(:empty?) ? value.present? : !value.nil?
      end
    end

    def direct_future_evidence_required?(loaded_indicator_universe)
      direct_indicators = loaded_indicator_universe
                          .dig(:indicator_categories, :direct_operator_node_emergence, :indicators)
                          .to_a
      direct_indicators.any? { |indicator| indicator.fetch(:evidence_strength_class, nil) == "direct_future" }
    end

    def review_criteria_pending?(loaded_review)
      criteria = loaded_review.fetch(:review_criteria, {})
      REQUIRED_CRITERIA.all? do |criterion|
        criteria.dig(criterion, :status) == "pending_human_review" &&
          criteria.dig(criterion, :requirement).present? &&
          criteria.dig(criterion, :artifact_refs).to_a.any?
      end
    end

    def prohibited_effects_present?(loaded_review)
      configured_effects = loaded_review.fetch(:prohibited_effects, []).map(&:to_s)
      (REQUIRED_PROHIBITED_EFFECTS - configured_effects).empty?
    end

    def warnings(loaded_review, loaded_approval_packet)
      [].tap do |warnings|
        warnings << "v0_source_truth_review_unapproved" if loaded_review.fetch(:approval_status, nil) == "unapproved" && !approval_gate_accepted?(loaded_approval_packet)
      end
    end
  end
end
