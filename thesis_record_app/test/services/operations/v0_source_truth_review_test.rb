require "test_helper"

class Operations::V0SourceTruthReviewTest < ActiveSupport::TestCase
  test "passes current unapproved source-truth review scaffold" do
    result = Operations::V0SourceTruthReview.call

    assert result.passed
    assert result.checks.fetch(:v0_source_truth_review_scaffold_present)
    assert result.checks.fetch(:v0_source_truth_review_unapproved)
    assert result.checks.fetch(:v0_source_truth_review_no_approval_effect)
    assert result.checks.fetch(:v0_source_truth_required_artifacts_present)
    assert result.checks.fetch(:v0_approval_packet_requires_source_truth_review)
    assert result.checks.fetch(:v0_indicator_universe_boundary_declares_direct_absence)
    assert result.checks.fetch(:v0_indicator_universe_context_only_at_baseline)
    assert result.checks.fetch(:v0_indicator_items_reviewable)
    assert result.checks.fetch(:v0_direct_future_evidence_required)
    assert result.checks.fetch(:v0_source_truth_criteria_pending_human_review)
    assert result.checks.fetch(:v0_source_truth_prohibited_effects_present)
    assert_includes result.warnings, "v0_source_truth_review_unapproved"
  end

  test "fails when an indicator loses its falsification condition" do
    indicator_universe = YAML.safe_load_file(
      Rails.root.join("..", "theses", "operator-node-economics", "publication", "v0_indicator_universe.yml")
    ).deep_symbolize_keys
    first_indicator = indicator_universe
                      .dig(:indicator_categories, :direct_operator_node_emergence, :indicators)
                      .first
    first_indicator.delete(:falsification_or_adverse_condition)

    result = Operations::V0SourceTruthReview.call(indicator_universe: indicator_universe)

    assert_not result.passed
    assert_not result.checks.fetch(:v0_indicator_items_reviewable)
    assert_includes result.failures, "v0_indicator_items_reviewable"
  end

  test "fails when review criteria are treated as accepted without approval" do
    review = YAML.safe_load_file(
      Rails.root.join("..", "theses", "operator-node-economics", "publication", "v0_source_truth_review.yml")
    ).deep_symbolize_keys
    review[:review_criteria][:direct_operator_node_evidence_boundary][:status] = "accepted"

    result = Operations::V0SourceTruthReview.call(review: review)

    assert_not result.passed
    assert_not result.checks.fetch(:v0_source_truth_criteria_pending_human_review)
    assert_includes result.failures, "v0_source_truth_criteria_pending_human_review"
  end
end
