require "test_helper"

class PublicSources::Susb::QualityReviewPolicyCheckTest < ActiveSupport::TestCase
  test "current SUSB quality review policy passes conservative guardrails" do
    result = PublicSources::Susb::QualityReviewPolicyCheck.call

    assert result.passed
    assert_empty result.failures
  end

  test "fails if high-noise review status is removed" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    review_policy = policy[:public_ingestion_v1][:susb_us_state_annual][:quality_review_policy_v1]
    review_policy[:final_review_statuses] -= [ "reviewed_with_high_noise" ]

    result = PublicSources::Susb::QualityReviewPolicyCheck.call(policy: policy, inspect_observations: false)

    assert_not result.passed
    assert_includes result.failures, "missing final_review_statuses: reviewed_with_high_noise"
  end

  test "fails if observations authorize claim support or exports" do
    source = DataSource.create!(
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
    definition = MetricDefinition.create!(
      key: "test_metric",
      name: "Test metric",
      formula_status: "draft_disabled"
    )
    MetricObservation.create!(
      metric_definition: definition,
      data_source: source,
      period: "2022",
      metric_status: "staged_context",
      quality_metadata: required_metadata.merge(
        "claim_support_authorized" => true,
        "exports_created" => true
      )
    )

    result = PublicSources::Susb::QualityReviewPolicyCheck.call

    assert_not result.passed
    assert_includes result.failures, "1 metric observations authorize prohibited computation/export/claim effects"
  end

  private

  def required_metadata
    {
      "source_table" => "susb_public_file_rows",
      "source_row_id" => 1,
      "source_row_hash" => SecureRandom.hex(32),
      "metric_key" => "test_metric",
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
