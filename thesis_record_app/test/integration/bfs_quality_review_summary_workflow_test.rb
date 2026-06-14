require "test_helper"

class BfsQualityReviewSummaryWorkflowTest < ActionDispatch::IntegrationTest
  test "requires authentication" do
    get bfs_quality_review_path

    assert_redirected_to new_session_path
  end

  test "requires research operator access" do
    user = create_operator_user(role_name: "viewer")
    sign_in_as(user)

    get bfs_quality_review_path

    assert_redirected_to root_path
  end

  test "research operator views read-only BFS quality summary" do
    user = create_operator_user
    sign_in_as(user)
    source = create_bfs_source
    definition = MetricDefinition.create!(
      key: "bfs_business_applications",
      name: "BFS business applications",
      formula_status: "draft_disabled"
    )
    observation = MetricObservation.create!(
      metric_definition: definition,
      data_source: source,
      period: "2012-01",
      metric_status: "staged_context",
      numeric_value: 3290,
      unit: "count",
      quality_metadata: quality_metadata
    )
    MetricQualityReview.create!(
      metric_observation: observation,
      data_source: source,
      policy_version: "bfs_quality_review_policy_v1",
      source_metric_status: "staged_context",
      review_status: "reviewed_context",
      review_reason_code: "source_native_context_verified",
      reviewed_by: "test_reviewer",
      reviewed_at: Time.current,
      review_metadata: quality_metadata.merge(
        "policy_status" => "policy_and_review_state_authorized",
        "source_metric_status" => "staged_context",
        "review_status" => "reviewed_context"
      )
    )

    assert_no_difference -> { AuditEvent.count } do
      assert_no_difference -> { MetricObservation.count } do
        assert_no_difference -> { MetricQualityReview.count } do
          get bfs_quality_review_path
        end
      end
    end

    assert_response :success
    assert_select "h1", "BFS Quality Review Summary"
    assert_select "td", "reviewed_context"
    assert_select "td", "bfs_business_applications"
    assert_select "dd", { text: "0", minimum: 2 }
  end

  private

  def create_bfs_source
    DataSource.create!(
      name: "Census BFS monthly API",
      source_kind: "census_bfs_api",
      source_status: "sample_rows_loaded",
      storage_zone: "production_postgresql",
      privacy_classification: "public",
      public_repo_allowed: false,
      structured_private_allowed: true,
      private_file_storage_allowed: false,
      secret_material_present: false,
      redaction_required: true,
      minimum_cell_rule_required: true,
      human_review_required: true,
      retention_rule: "public_source_metadata_retained",
      claim_status_allowed: "not_evidence"
    )
  end

  def quality_metadata
    {
      "source_table" => "bfs_api_rows",
      "source_row_id" => 1,
      "source_row_hash" => SecureRandom.hex(32),
      "metric_key" => "bfs_business_applications",
      "source_cell_value_raw" => "3290",
      "source_error_data" => "no",
      "metric_status_reason" => "staged_context",
      "claim_status_effect" => "unchanged",
      "ratios_computed" => false,
      "trends_computed" => false,
      "aggregation_computed" => false,
      "exports_created" => false,
      "prediction_links_created" => false,
      "claim_support_authorized" => false,
      "guardrail" => "test guardrail"
    }
  end
end
