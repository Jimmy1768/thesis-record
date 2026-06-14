require "test_helper"

class PublicSources::Bfs::QualityReviewPolicyCheckTest < ActiveSupport::TestCase
  test "current BFS quality review policy passes conservative guardrails" do
    result = PublicSources::Bfs::QualityReviewPolicyCheck.call

    assert result.passed
    assert_empty result.failures
  end

  test "fails if prediction link prohibition is removed" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    review_policy = policy[:public_ingestion_v1][:bfs_monthly_api][:quality_review_policy_v1]
    review_policy[:prohibited_review_effects] -= [ "prediction_link_authorization" ]

    result = PublicSources::Bfs::QualityReviewPolicyCheck.call(policy: policy, inspect_observations: false)

    assert_not result.passed
    assert_includes result.failures, "missing prohibited_review_effects: prediction_link_authorization"
  end

  test "fails if BFS observations authorize claim support or exports" do
    source = create_bfs_source
    definition = MetricDefinition.create!(
      key: "bfs_business_applications",
      name: "BFS business applications",
      formula_status: "draft_disabled"
    )
    MetricObservation.create!(
      metric_definition: definition,
      data_source: source,
      period: "2012-01",
      metric_status: "staged_context",
      quality_metadata: required_metadata.merge(
        "claim_support_authorized" => true,
        "exports_created" => true
      )
    )

    result = PublicSources::Bfs::QualityReviewPolicyCheck.call

    assert_not result.passed
    assert_includes result.failures, "1 BFS metric observations authorize prohibited computation/export/link/claim effects"
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

  def required_metadata
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
