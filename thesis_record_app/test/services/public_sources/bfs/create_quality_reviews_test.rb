require "test_helper"

class PublicSources::Bfs::CreateQualityReviewsTest < ActiveSupport::TestCase
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

  test "creates review rows without mutating observations or claim flags" do
    observation = create_observation(metric_status: "staged_context")

    assert_difference -> { MetricQualityReview.count }, 1 do
      result = PublicSources::Bfs::CreateQualityReviews.call!(actor: "test_reviewer")
      assert_equal 1, result.observations_reviewed
      assert_equal 1, result.reviews_upserted
      assert_equal 1, result.status_counts.fetch("reviewed_context")
      assert_equal 0, result.prediction_links_created
      assert_equal 0, result.exports_created
    end

    review = observation.reload.metric_quality_review
    assert_equal "reviewed_context", review.review_status
    assert_equal "staged_context", observation.metric_status
    assert_equal false, review.review_metadata.fetch("claim_support_authorized")
    assert_equal false, review.review_metadata.fetch("exports_created")
    assert_equal false, review.review_metadata.fetch("prediction_links_created")
  end

  test "is idempotent for existing review rows" do
    create_observation(metric_status: "staged_context")
    PublicSources::Bfs::CreateQualityReviews.call!(actor: "test_reviewer")

    assert_no_difference -> { MetricQualityReview.count } do
      PublicSources::Bfs::CreateQualityReviews.call!(actor: "test_reviewer")
    end
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
