require "test_helper"

class FailureRecordTest < ActiveSupport::TestCase
  test "failure records require prediction and review status metadata" do
    record = FailureRecord.new(
      prediction_id: "TCE-P011",
      horizon: "3-year",
      failure_type: "null_result",
      metric_status: "metric_computed",
      observed_direction: "null",
      expected_direction: "remote_salaried_decline",
      human_review_status: "pending",
      publication_status: "not_public",
      revision_action: "none"
    )

    assert record.valid?
  end
end
