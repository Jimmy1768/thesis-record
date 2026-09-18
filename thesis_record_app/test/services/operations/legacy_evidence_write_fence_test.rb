require "test_helper"

class LegacyEvidenceWriteFenceTest < ActiveSupport::TestCase
  test "allows local rehearsal" do
    assert Operations::LegacyEvidenceWriteFence.enforce!(operation: "test")
  end

  test "production denies legacy mutation" do
    error = assert_raises(Operations::LegacyEvidenceWriteFence::MutationDenied) do
      Operations::LegacyEvidenceWriteFence.enforce!(
        operation: "source row replacement",
        environment: "production"
      )
    end
    assert_includes error.message, "source row replacement"
  end

  test "production has no environment override" do
    previous = ENV["THESIS_RECORD_ALLOW_LEGACY_EVIDENCE_MUTATION"]
    ENV["THESIS_RECORD_ALLOW_LEGACY_EVIDENCE_MUTATION"] = "true"
    assert_raises(Operations::LegacyEvidenceWriteFence::MutationDenied) do
      Operations::LegacyEvidenceWriteFence.enforce!(operation: "controlled rehearsal", environment: "production")
    end
  ensure
    ENV["THESIS_RECORD_ALLOW_LEGACY_EVIDENCE_MUTATION"] = previous
  end
end
