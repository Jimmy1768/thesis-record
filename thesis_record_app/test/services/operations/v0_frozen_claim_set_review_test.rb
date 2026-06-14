require "test_helper"

class Operations::V0FrozenClaimSetReviewTest < ActiveSupport::TestCase
  test "passes current unapproved frozen claim-set review scaffold" do
    result = Operations::V0FrozenClaimSetReview.call

    assert result.passed
    assert result.checks.fetch(:v0_frozen_claim_set_review_scaffold_present)
    assert result.checks.fetch(:v0_frozen_claim_set_review_unapproved)
    assert result.checks.fetch(:v0_frozen_claim_set_review_no_approval_effect)
    assert result.checks.fetch(:v0_frozen_claim_set_required_artifacts_present)
    assert result.checks.fetch(:v0_approval_packet_requires_frozen_claim_set_review)
    assert result.checks.fetch(:v0_claim_set_unapproved_candidate_inventory)
    assert result.checks.fetch(:v0_claim_inventory_complete)
    assert result.checks.fetch(:v0_claim_ids_unique)
    assert result.checks.fetch(:v0_claim_items_reviewable)
    assert result.checks.fetch(:v0_claim_set_no_automatic_promotion)
    assert result.checks.fetch(:v0_frozen_claim_set_criteria_pending_human_review)
    assert result.checks.fetch(:v0_frozen_claim_set_prohibited_effects_present)
    assert_includes result.warnings, "v0_frozen_claim_set_review_unapproved"
  end

  test "fails when a claim is approved early" do
    claim_set = YAML.safe_load_file(
      Rails.root.join("..", "theses", "operator-node-economics", "publication", "v0_claim_set.yml")
    ).deep_symbolize_keys
    claim_set[:claims].first[:v0_status] = "approved"

    result = Operations::V0FrozenClaimSetReview.call(claim_set: claim_set)

    assert_not result.passed
    assert_not result.checks.fetch(:v0_claim_items_reviewable)
    assert_includes result.failures, "v0_claim_items_reviewable"
  end

  test "fails when a required claim is missing" do
    claim_set = YAML.safe_load_file(
      Rails.root.join("..", "theses", "operator-node-economics", "publication", "v0_claim_set.yml")
    ).deep_symbolize_keys
    claim_set[:claims].pop

    result = Operations::V0FrozenClaimSetReview.call(claim_set: claim_set)

    assert_not result.passed
    assert_not result.checks.fetch(:v0_claim_inventory_complete)
    assert_includes result.failures, "v0_claim_inventory_complete"
  end
end
