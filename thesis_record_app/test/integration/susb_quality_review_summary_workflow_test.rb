require "test_helper"

class SusbQualityReviewSummaryWorkflowTest < ActionDispatch::IntegrationTest
  test "requires authentication" do
    get susb_quality_review_path

    assert_redirected_to new_session_path
  end

  test "requires research operator access" do
    user = create_operator_user(role_name: "viewer")
    sign_in_as(user)

    get susb_quality_review_path

    assert_redirected_to root_path
  end

  test "research operator views read-only SUSB quality summary" do
    user = create_operator_user
    sign_in_as(user)
    source = create_susb_source
    definition = MetricDefinition.create!(
      key: "susb_employment",
      name: "SUSB employer employment",
      formula_status: "draft_disabled"
    )
    observation = MetricObservation.create!(
      metric_definition: definition,
      data_source: source,
      period: "2022",
      metric_status: "staged_context",
      numeric_value: 1,
      unit: "employees",
      quality_metadata: quality_metadata
    )
    MetricQualityReview.create!(
      metric_observation: observation,
      data_source: source,
      policy_version: "quality_review_policy_v1",
      source_metric_status: "staged_context",
      review_status: "reviewed_context",
      review_reason_code: "source_context_verified",
      reviewed_by: "test_reviewer",
      reviewed_at: Time.current,
      review_metadata: quality_metadata.merge(
        "policy_status" => "policy_only_no_review_state",
        "source_metric_status" => "staged_context",
        "review_status" => "reviewed_context"
      )
    )

    assert_no_difference -> { AuditEvent.count } do
      assert_no_difference -> { MetricObservation.count } do
        assert_no_difference -> { MetricQualityReview.count } do
          get susb_quality_review_path
        end
      end
    end

    assert_response :success
    assert_select "h1", "SUSB Quality Review Summary"
    assert_select "td", "reviewed_context"
    assert_select "td", "susb_employment"
    assert_select "dd", { text: "0", minimum: 2 }
  end

  private

  def create_susb_source
    DataSource.create!(
      name: "Census SUSB U.S./state annual public file 2022",
      source_kind: "census_susb_public_file",
      source_status: "raw_file_validated",
      storage_zone: "production_postgresql",
      privacy_classification: "public",
      public_repo_allowed: true,
      structured_private_allowed: false,
      private_file_storage_allowed: false,
      secret_material_present: false,
      redaction_required: false,
      minimum_cell_rule_required: true,
      human_review_required: true,
      retention_rule: "public_source_metadata_retained",
      claim_status_allowed: "context_only"
    )
  end

  def quality_metadata
    {
      "source_table" => "susb_public_file_rows",
      "source_row_id" => 1,
      "source_row_hash" => SecureRandom.hex(32),
      "metric_key" => "susb_employment",
      "metric_status_reason" => "staged_context",
      "claim_status_effect" => "unchanged",
      "ratios_computed" => false,
      "trends_computed" => false,
      "aggregation_computed" => false,
      "exports_created" => false,
      "claim_support_authorized" => false,
      "guardrail" => "test guardrail"
    }
  end
end
