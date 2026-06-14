require "test_helper"

class Evidence::ClaimReviewCandidateDryRunTest < ActiveSupport::TestCase
  setup do
    @source = DataSource.create!(
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
    @definition = MetricDefinition.create!(
      key: "bfs_business_applications",
      name: "BFS business applications",
      formula_status: "draft_disabled"
    )
  end

  test "summarizes dry-run candidate groups without writing records" do
    observation = create_observation(metric_status: "staged_context")
    create_review(observation: observation, review_status: "reviewed_context")

    assert_no_difference -> { PredictionLink.count } do
      assert_no_difference -> { ClaimReview.count } do
        assert_no_difference -> { MetricQualityReview.count } do
          assert_no_difference -> { MetricObservation.count } do
            result = Evidence::ClaimReviewCandidateDryRun.call

            assert result.policy_check_passed
            assert_empty result.policy_check_failures
            assert_equal 1, result.candidate_groups.find { |group| group.id == "bfs_business_formation_context" }.reviewed_observation_count
            assert_equal 0, result.prediction_link_count
            assert_equal 0, result.claim_review_count
            assert_equal 0, result.export_created_audit_event_count
          end
        end
      end
    end
  end

  test "fails if candidate group proposes a claim status change" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:claim_review_candidate_dry_run_v1][:candidate_groups].first[:proposed_claim_status] = "weak_support"

    result = Evidence::ClaimReviewCandidateDryRun.call(policy: policy)

    assert_not result.policy_check_passed
    assert_includes result.policy_check_failures, "bfs_business_formation_context proposed_claim_status must be unchanged"
  end

  test "fails if candidate group uses a prediction outside the disabled gate" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:claim_review_candidate_dry_run_v1][:candidate_groups].first[:related_prediction_ids] << "TCE-P999"

    result = Evidence::ClaimReviewCandidateDryRun.call(policy: policy)

    assert_not result.policy_check_passed
    assert_includes result.policy_check_failures, "bfs_business_formation_context has prediction IDs outside blocked gate: TCE-P999"
  end

  private

  def create_observation(metric_status:)
    MetricObservation.create!(
      metric_definition: @definition,
      data_source: @source,
      period: "2012-01",
      metric_status: metric_status,
      numeric_value: 3290,
      unit: "count",
      dimensions: {
        "year" => 2012,
        "month" => 1,
        "period_month" => "2012-01",
        "data_type_code" => "BA_BA",
        "category_code" => "NAICS11",
        "seasonally_adj" => "no",
        "geography_level" => "us",
        "geography_code" => "1",
        "evidence_class" => "indirect_payroll_transition_proxy_only",
        "grain" => "source_native_monthly_sector_context"
      },
      quality_metadata: quality_metadata(metric_status)
    )
  end

  def create_review(observation:, review_status:)
    MetricQualityReview.create!(
      metric_observation: observation,
      data_source: @source,
      policy_version: "bfs_quality_review_policy_v1",
      source_metric_status: observation.metric_status,
      review_status: review_status,
      review_reason_code: "source_native_context_verified",
      reviewed_by: "test_reviewer",
      reviewed_at: Time.current,
      review_metadata: quality_metadata(observation.metric_status).merge(
        "policy_status" => "policy_and_review_state_authorized",
        "source_metric_status" => observation.metric_status,
        "review_status" => review_status
      )
    )
  end

  def quality_metadata(metric_status)
    {
      "source_table" => "bfs_api_rows",
      "source_row_id" => 1,
      "source_row_hash" => SecureRandom.hex(32),
      "metric_key" => "bfs_business_applications",
      "source_cell_value_raw" => "3290",
      "source_error_data" => "no",
      "metric_status_reason" => metric_status,
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
