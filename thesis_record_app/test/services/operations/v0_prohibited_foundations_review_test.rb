require "test_helper"

class Operations::V0ProhibitedFoundationsReviewTest < ActiveSupport::TestCase
  test "passes current unapproved prohibited-foundations review scaffold" do
    result = Operations::V0ProhibitedFoundationsReview.call

    assert result.passed
    assert result.checks.fetch(:v0_prohibited_foundations_review_scaffold_present)
    assert result.checks.fetch(:v0_prohibited_foundations_review_unapproved)
    assert result.checks.fetch(:v0_prohibited_foundations_review_no_approval_effect)
    assert result.checks.fetch(:v0_prohibited_foundations_allowed_foundations_present)
    assert result.checks.fetch(:v0_prohibited_foundations_terms_listed)
    assert result.checks.fetch(:v0_prohibited_foundations_required_artifacts_present)
    assert result.checks.fetch(:v0_approval_packet_requires_prohibited_foundations_review)
    assert result.checks.fetch(:v0_prohibited_foundations_criteria_pending_human_review)
    assert result.checks.fetch(:v0_prohibited_foundations_prohibited_effects_present)
    assert result.checks.fetch(:v0_scanned_artifacts_avoid_prohibited_foundation_terms)
    assert_includes result.warnings, "v0_prohibited_foundations_review_unapproved"
  end

  test "fails when a prohibited term appears in a scanned artifact" do
    review = YAML.safe_load_file(
      Rails.root.join("..", "theses", "operator-node-economics", "publication", "v0_prohibited_foundations_review.yml")
    ).deep_symbolize_keys
    review[:scan_paths] = [ "theses/operator-node-economics/source_truth/prohibited_foundations.md" ]

    result = Operations::V0ProhibitedFoundationsReview.call(review: review)

    assert_not result.passed
    assert_not result.checks.fetch(:v0_scanned_artifacts_avoid_prohibited_foundation_terms)
    assert_includes result.failures, "v0_scanned_artifacts_avoid_prohibited_foundation_terms"
  end

  test "fails when review criteria are treated as accepted without approval" do
    review = YAML.safe_load_file(
      Rails.root.join("..", "theses", "operator-node-economics", "publication", "v0_prohibited_foundations_review.yml")
    ).deep_symbolize_keys
    review[:review_criteria][:allowed_foundations_only][:status] = "accepted"

    result = Operations::V0ProhibitedFoundationsReview.call(review: review)

    assert_not result.passed
    assert_not result.checks.fetch(:v0_prohibited_foundations_criteria_pending_human_review)
    assert_includes result.failures, "v0_prohibited_foundations_criteria_pending_human_review"
  end
end
