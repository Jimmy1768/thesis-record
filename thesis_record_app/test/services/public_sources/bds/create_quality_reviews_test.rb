require "test_helper"

class PublicSources::Bds::CreateQualityReviewsTest < ActiveSupport::TestCase
  setup do
    @source = create_source
    @definition = MetricDefinition.create!(
      key: "bds_firms",
      name: "BDS firms",
      formula_status: "draft_disabled"
    )
  end

  test "creates BDS review rows without mutating observations or claim flags" do
    observation = create_observation(metric_status: "staged_context")

    assert_difference -> { MetricQualityReview.count }, 1 do
      result = PublicSources::Bds::CreateQualityReviews.call!(actor: "test_reviewer")
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

  test "is idempotent for existing BDS review rows" do
    create_observation(metric_status: "staged_context")
    PublicSources::Bds::CreateQualityReviews.call!(actor: "test_reviewer")

    assert_no_difference -> { MetricQualityReview.count } do
      PublicSources::Bds::CreateQualityReviews.call!(actor: "test_reviewer")
    end
  end

  private

  def create_source
    DataSource.create!(
      name: "Census BDS sector by firm age by firm size public file",
      source_kind: "census_bds_public_file",
      source_status: "staging_rows_loaded",
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
      claim_status_allowed: "context_only"
    )
  end

  def create_observation(metric_status:)
    MetricObservation.create!(
      metric_definition: @definition,
      data_source: @source,
      period: "1978",
      metric_status: metric_status,
      numeric_value: 1,
      unit: "count",
      dimensions: {
        "year" => 1978,
        "sector_code" => "11",
        "firm_age_code" => "a) 0",
        "firm_size_code" => "a) 1 to 4",
        "evidence_class" => "employer_firm_dynamics_context_only",
        "grain" => "source_native_year_sector_firm_age_firm_size_context"
      },
      quality_metadata: quality_metadata(metric_status)
    )
  end

  def quality_metadata(metric_status)
    {
      "source_table" => "bds_public_file_rows",
      "source_row_id" => 1,
      "source_row_hash" => SecureRandom.hex(32),
      "metric_key" => "bds_firms",
      "source_grain" => "source_native_year_sector_firm_age_firm_size_context",
      "source_year" => 1978,
      "source_sector_code" => "11",
      "source_firm_age_code" => "a) 0",
      "source_firm_size_code" => "a) 1 to 4",
      "source_cell_value_raw" => "1",
      "source_publication_flag" => nil,
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
