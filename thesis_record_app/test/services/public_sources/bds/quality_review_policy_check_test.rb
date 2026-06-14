require "test_helper"

class PublicSources::Bds::QualityReviewPolicyCheckTest < ActiveSupport::TestCase
  test "current BDS quality-review policy passes guardrails without observations" do
    result = PublicSources::Bds::QualityReviewPolicyCheck.call

    assert result.passed
    assert_empty result.failures
  end

  test "fails if claim support is not prohibited" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    review_policy = policy[:public_ingestion_v1][:bds_sector_age_size_public_file][:parser_design_v1][:quality_review_policy_v1]
    review_policy[:prohibited_review_effects] -= [ "claim_support" ]

    result = PublicSources::Bds::QualityReviewPolicyCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "missing prohibited_review_effects: claim_support"
  end

  test "fails when BDS observations authorize claim support" do
    source = create_source
    definition = MetricDefinition.create!(key: "bds_firms", name: "BDS firms", formula_status: "draft_disabled")
    MetricObservation.create!(
      metric_definition: definition,
      data_source: source,
      period: "1978",
      metric_status: "staged_context",
      quality_metadata: quality_metadata.merge("claim_support_authorized" => true)
    )

    result = PublicSources::Bds::QualityReviewPolicyCheck.call

    assert_not result.passed
    assert_includes result.failures, "1 BDS metric observations authorize prohibited computation/export/link/claim effects"
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

  def quality_metadata
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
