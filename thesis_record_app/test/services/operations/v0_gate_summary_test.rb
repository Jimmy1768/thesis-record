require "test_helper"

class Operations::V0GateSummaryTest < ActiveSupport::TestCase
  FakeValidatorResult = Data.define(:passed, :failures, :warnings)
  FakeReadiness = Data.define(:passed, :blockers)

  test "summarizes current v0 gates without approving readiness" do
    readiness = FakeReadiness.new(
      passed: false,
      blockers: %w[evidence_counts_present]
    )

    summary = Operations::V0GateSummary.call(v0_readiness: readiness)

    assert_equal "operator-node-economics", summary.thesis_slug
    assert_equal "approved", summary.approval_status
    assert_equal "not_public", summary.public_release_status
    assert summary.scaffolds_passed
    assert_not summary.v0_readiness_passed
    assert_includes summary.v0_readiness_blockers, "evidence_counts_present"
    assert_equal %i[
      source_truth_review
      prohibited_foundations_review
      baseline_evidence_review
      frozen_claim_set_review
      frozen_forecast_set_review
      prose_review
      public_release_review
    ], summary.gates.map(&:name)
    assert summary.gates.all?(&:validator_passed)
    assert_not_includes summary.warnings, "approval_packet_unapproved"
    assert_includes summary.warnings, "public_release_not_public"
    assert_includes summary.warnings, "v0_readiness_blocked"
    assert_not_includes summary.warnings, "source_truth_review_pending"
    assert_not_includes summary.warnings, "prohibited_foundations_review_pending"
  end

  test "surfaces validator failure for a gate" do
    readiness = FakeReadiness.new(passed: false, blockers: [])
    validators = {
      source_truth_review: FakeValidatorResult.new(
        passed: false,
        failures: [ "missing_source_truth_artifact" ],
        warnings: []
      )
    }

    summary = Operations::V0GateSummary.call(v0_readiness: readiness, validators: validators)
    source_truth_gate = summary.gates.find { |gate| gate.name == :source_truth_review }

    assert_not summary.scaffolds_passed
    assert_not source_truth_gate.validator_passed
    assert_includes source_truth_gate.failures, "missing_source_truth_artifact"
  end
end
