require "test_helper"

class PublicSources::Susb::CreateQualityReviewsTest < ActiveSupport::TestCase
  setup do
    @source = DataSource.create!(
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
    @definition = MetricDefinition.create!(
      key: "susb_employment",
      name: "SUSB employer employment",
      formula_status: "draft_disabled"
    )
  end

  test "creates review rows without mutating observations or claim flags" do
    observation = create_observation(metric_status: "staged_context")

    assert_difference -> { MetricQualityReview.count }, 1 do
      result = PublicSources::Susb::CreateQualityReviews.call!(actor: "test_reviewer")
      assert_equal 1, result.observations_reviewed
      assert_equal 1, result.reviews_upserted
      assert_equal 1, result.status_counts.fetch("reviewed_context")
    end

    review = observation.reload.metric_quality_review
    assert_equal "reviewed_context", review.review_status
    assert_equal "staged_context", observation.metric_status
    assert_equal false, review.review_metadata.fetch("claim_support_authorized")
    assert_equal false, review.review_metadata.fetch("exports_created")
  end

  test "maps high-noise observations to reviewed with high noise" do
    observation = create_observation(metric_status: "quality_review_required")

    PublicSources::Susb::CreateQualityReviews.call!(actor: "test_reviewer")

    review = observation.metric_quality_review
    assert_equal "reviewed_with_high_noise", review.review_status
    assert_equal "high_noise_context_preserved", review.review_reason_code
  end

  test "is idempotent for existing review rows" do
    create_observation(metric_status: "staged_context")
    PublicSources::Susb::CreateQualityReviews.call!(actor: "test_reviewer")

    assert_no_difference -> { MetricQualityReview.count } do
      PublicSources::Susb::CreateQualityReviews.call!(actor: "test_reviewer")
    end
  end

  private

  def create_observation(metric_status:)
    MetricObservation.create!(
      metric_definition: @definition,
      data_source: @source,
      period: "2022",
      metric_status: metric_status,
      numeric_value: 1,
      unit: "employees",
      dimensions: {
        "year" => 2022,
        "state_code" => "00",
        "naics_code" => "111110",
        "enterprise_size_code" => "01",
        "evidence_class" => "employer_side_context_only",
        "grain" => "source_native_context"
      },
      quality_metadata: quality_metadata(metric_status)
    )
  end

  def quality_metadata(metric_status)
    {
      "source_table" => "susb_public_file_rows",
      "source_row_id" => 1,
      "source_row_hash" => SecureRandom.hex(32),
      "metric_key" => "susb_employment",
      "metric_status_reason" => metric_status,
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
