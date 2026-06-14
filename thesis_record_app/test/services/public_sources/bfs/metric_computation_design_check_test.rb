require "test_helper"

class PublicSources::Bfs::MetricComputationDesignCheckTest < ActiveSupport::TestCase
  test "current BFS metric computation design passes source-native observation guardrails" do
    result = PublicSources::Bfs::MetricComputationDesignCheck.call

    assert result.passed
    assert_empty result.failures
  end

  test "fails if aggregation is not prohibited" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    design = policy[:public_ingestion_v1][:bfs_monthly_api][:metric_computation_design_v1]
    design[:prohibited_computation] -= [ "aggregation" ]

    result = PublicSources::Bfs::MetricComputationDesignCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "missing prohibited computations: aggregation"
  end

  test "fails if target data type codes drift from ingestion design" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    design = policy[:public_ingestion_v1][:bfs_monthly_api][:metric_computation_design_v1]
    design[:eligible_data_type_codes] -= [ "BA_HBA" ]

    result = PublicSources::Bfs::MetricComputationDesignCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "missing eligible data_type_codes: BA_HBA"
  end

  test "fails if BFS metric observations already exist" do
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
      metric_status: "staged_context"
    )

    result = PublicSources::Bfs::MetricComputationDesignCheck.call(require_no_bfs_observations: true)

    assert_not result.passed
    assert_includes result.failures, "BFS MetricObservation rows already exist"
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
end
