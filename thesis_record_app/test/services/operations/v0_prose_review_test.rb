require "test_helper"

class Operations::V0ProseReviewTest < ActiveSupport::TestCase
  test "passes accepted internal v0 prose record without public release" do
    result = Operations::V0ProseReview.call

    assert result.passed
    assert result.checks.fetch(:v0_prose_review_scaffold_present)
    assert result.checks.fetch(:v0_prose_review_unapproved)
    assert result.checks.fetch(:v0_prose_review_gate_accepted)
    assert result.checks.fetch(:v0_prose_review_no_approval_effect)
    assert result.checks.fetch(:v0_prose_required_artifacts_present)
    assert result.checks.fetch(:v0_prose_held_back_artifacts_absent)
    assert result.checks.fetch(:v0_approval_packet_requires_prose_review)
    assert result.checks.fetch(:v0_publication_artifact_internal_record)
    assert result.checks.fetch(:v0_prose_criteria_pending_human_review)
    assert result.checks.fetch(:v0_prose_prohibited_effects_present)
    assert_not_includes result.warnings, "v0_prose_review_unapproved"
  end

  test "fails when prose review criteria are treated as accepted without approval" do
    review = YAML.safe_load_file(
      Rails.root.join("..", "theses", "operator-node-economics", "publication", "v0_prose_review.yml")
    ).deep_symbolize_keys
    review[:review_criteria][:archived_draft_not_imported][:status] = "accepted"

    result = Operations::V0ProseReview.call(review: review)

    assert_not result.passed
    assert_not result.checks.fetch(:v0_prose_criteria_pending_human_review)
    assert_includes result.failures, "v0_prose_criteria_pending_human_review"
  end
end
