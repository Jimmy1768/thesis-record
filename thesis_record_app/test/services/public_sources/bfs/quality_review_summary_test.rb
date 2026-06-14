require "test_helper"

class PublicSources::Bfs::QualityReviewSummaryTest < ActiveSupport::TestCase
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

  test "summarizes BFS quality reviews without writing records" do
    observation = create_observation(metric_status: "staged_context")
    create_review(observation: observation, review_status: "reviewed_context")

    assert_no_difference -> { AuditEvent.count } do
      assert_no_difference -> { MetricQualityReview.count } do
        assert_no_difference -> { MetricObservation.count } do
          result = PublicSources::Bfs::QualityReviewSummary.call

          assert_equal 1, result.review_count
          assert_equal({ "reviewed_context" => 1 }, result.review_status_counts)
          assert_equal({ "staged_context" => 1 }, result.source_metric_status_counts)
          assert_equal({ "bfs_business_applications" => 1 }, result.metric_key_counts)
          assert_equal 0, result.unreviewed_observation_count
          assert_equal 0, result.prediction_link_count
          assert_equal 0, result.export_created_audit_event_count
          assert result.policy_check_passed
        end
      end
    end
  end

  test "reports unreviewed reviewable observations" do
    create_observation(metric_status: "staged_context")

    result = PublicSources::Bfs::QualityReviewSummary.call

    assert_equal 1, result.reviewable_observation_count
    assert_equal 1, result.unreviewed_observation_count
  end

  test "reports prohibited true guardrail flags" do
    observation = create_observation(metric_status: "staged_context")
    create_review(
      observation: observation,
      review_status: "reviewed_context",
      review_metadata: review_metadata("staged_context", "reviewed_context").merge("prediction_links_created" => true)
    )

    result = PublicSources::Bfs::QualityReviewSummary.call

    assert_equal 1, result.guardrail_flag_counts.fetch("prediction_links_created")
    assert result.policy_check_passed
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

  def create_review(observation:, review_status:, review_metadata: nil)
    MetricQualityReview.create!(
      metric_observation: observation,
      data_source: @source,
      policy_version: "bfs_quality_review_policy_v1",
      source_metric_status: observation.metric_status,
      review_status: review_status,
      review_reason_code: "source_native_context_verified",
      reviewed_by: "test_reviewer",
      reviewed_at: Time.current,
      review_metadata: review_metadata || self.review_metadata(observation.metric_status, review_status)
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

  def review_metadata(metric_status, review_status)
    quality_metadata(metric_status).merge(
      "policy_status" => "policy_and_review_state_authorized",
      "source_metric_status" => metric_status,
      "review_status" => review_status
    )
  end
end
