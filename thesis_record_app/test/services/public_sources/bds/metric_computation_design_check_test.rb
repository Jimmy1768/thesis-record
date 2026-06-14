require "test_helper"

class PublicSources::Bds::MetricComputationDesignCheckTest < ActiveSupport::TestCase
  test "current BDS metric computation design passes source-native guardrails" do
    result = PublicSources::Bds::MetricComputationDesignCheck.call(require_no_bds_observations: true)

    assert result.passed
    assert_empty result.failures
  end

  test "fails if observations are disabled" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    design = policy[:public_ingestion_v1][:bds_sector_age_size_public_file][:parser_design_v1][:metric_computation_design_v1]
    design[:metric_observations_authorized] = false

    result = PublicSources::Bds::MetricComputationDesignCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "metric_observations_authorized expected true, got false"
  end

  test "fails if firm-boundary conclusions are not prohibited" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    design = policy[:public_ingestion_v1][:bds_sector_age_size_public_file][:parser_design_v1][:metric_computation_design_v1]
    design[:prohibited_computation] -= [ "firm_boundary_conclusion" ]

    result = PublicSources::Bds::MetricComputationDesignCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "missing prohibited computations: firm_boundary_conclusion"
  end

  test "fails if BDS observations already exist" do
    source = create_source
    definition = MetricDefinition.create!(key: "bds_test_metric", name: "BDS test metric", formula_status: "draft_disabled")
    MetricObservation.create!(
      metric_definition: definition,
      data_source: source,
      period: "1978",
      metric_status: "staged_context"
    )

    result = PublicSources::Bds::MetricComputationDesignCheck.call(require_no_bds_observations: true)

    assert_not result.passed
    assert_includes result.failures, "BDS MetricObservation rows already exist"
  end

  private

  def create_source
    DataSource.create!(
      name: "Census BDS sector age size public file 2023",
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
end
