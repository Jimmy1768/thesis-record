require "test_helper"

class SourceHealthSummaryWorkflowTest < ActionDispatch::IntegrationTest
  test "requires authentication" do
    get source_health_path

    assert_redirected_to new_session_path
  end

  test "requires research operator access" do
    user = create_operator_user(role_name: "viewer")
    sign_in_as(user)

    get source_health_path

    assert_redirected_to root_path
  end

  test "research operator views read-only source health summary" do
    user = create_operator_user
    sign_in_as(user)

    assert_no_difference -> { AuditEvent.count } do
      assert_no_difference -> { MetricObservation.count } do
        assert_no_difference -> { MetricQualityReview.count } do
          get source_health_path
        end
      end
    end

    assert_response :success
    assert_select "h1", "Source Health Summary"
    assert_select "td", { text: "reviewed_context_only_not_claim_support", minimum: 1 }
    assert_select "dd", { text: "context_only_no_claim_links" }
  end
end
