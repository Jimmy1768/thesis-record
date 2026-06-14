require "test_helper"

class Evidence::ClaimReviewGateDesignCheckTest < ActiveSupport::TestCase
  test "passes default disabled claim-review gate without writing records" do
    assert_no_difference -> { PredictionLink.count } do
      assert_no_difference -> { ClaimReview.count } do
        assert_no_difference -> { AuditEvent.count } do
          result = Evidence::ClaimReviewGateDesignCheck.call

          assert result.passed
          assert_empty result.failures
        end
      end
    end
  end

  test "fails if automatic claim promotion is enabled" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:claim_review_gate_v1][:automatic_claim_promotion_authorized] = true

    result = Evidence::ClaimReviewGateDesignCheck.call(policy: policy, inspect_database: false)

    assert_not result.passed
    assert_includes result.failures, "automatic_claim_promotion_authorized expected false, got true"
  end

  test "fails if a blocked prediction id is missing" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:claim_review_gate_v1][:blocked_prediction_ids].delete("TCE-P012")

    result = Evidence::ClaimReviewGateDesignCheck.call(policy: policy, inspect_database: false)

    assert_not result.passed
    assert_includes result.failures, "missing blocked_prediction_ids: TCE-P012"
  end

  test "fails if prediction links exist while gate is disabled" do
    PredictionLink.create!(
      prediction_id: "TCE-P001",
      evidence_classification: "context_only",
      review_status: "review_pending",
      notes: "test record"
    )

    result = Evidence::ClaimReviewGateDesignCheck.call

    assert_not result.passed
    assert_includes result.failures, "1 prediction links exist while claim-review gate is disabled"
  end
end
