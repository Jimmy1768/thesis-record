require "test_helper"

class PublicSources::Bfs::ComputeSourceNativeObservationsTest < ActiveSupport::TestCase
  setup do
    @operator = create_operator_user
    @source = DataSources::Create.call!(
      attributes: source_attributes,
      actor: @operator
    )
    @manifest = IntakeManifests::Create.call!(
      data_source: @source,
      attributes: manifest_attributes,
      actor: @operator
    )
    @schema_version = SchemaVersion.create!(
      data_source: @source,
      intake_manifest: @manifest,
      version: "bfs_timeseries_eits_v1",
      schema_status: "verified_api_metadata_scaffold"
    )
    PublicSources::Bfs::MetricDefinitionScaffold.call!(actor: @operator)
  end

  test "computes source-native observations from numeric eligible rows only" do
    create_bfs_row(data_type_code: "BA_BA", category_code: "NAICS11", raw_value: "3290", numeric_value: 3290)
    create_bfs_row(data_type_code: "BA_HBA", category_code: "NAICS21", raw_value: "D", numeric_value: nil)
    create_bfs_row(data_type_code: "BA_CBA", category_code: "NAICS11", raw_value: "99", numeric_value: 99)

    assert_difference -> { MetricObservation.count }, 1 do
      @result = PublicSources::Bfs::ComputeSourceNativeObservations.call!(actor: @operator)
    end

    assert_equal 2, @result.eligible_rows
    assert_equal 1, @result.observations_created
    assert_equal 1, @result.status_counts.fetch("staged_context")
    assert_equal 1, @result.metric_counts.fetch("bfs_business_applications")
    assert_equal 1, @result.blocked_cells.fetch("bfs_high_propensity_business_applications")
    observation = MetricObservation.find_by!(metric_definition: MetricDefinition.find_by!(key: "bfs_business_applications"))
    assert_equal "2012-01", observation.period
    assert_equal "count", observation.unit
    assert_equal "NAICS11", observation.dimensions.fetch("category_code")
    assert_equal false, observation.quality_metadata.fetch("exports_created")
    assert_equal false, observation.quality_metadata.fetch("prediction_links_created")
    assert_equal false, observation.quality_metadata.fetch("claim_support_authorized")
  end

  test "is idempotent by deleting and recreating scoped BFS observations" do
    create_bfs_row(data_type_code: "BF_BF4Q", category_code: "NAICS23", raw_value: "12", numeric_value: 12)
    PublicSources::Bfs::ComputeSourceNativeObservations.call!(actor: @operator)

    assert_no_difference -> { MetricObservation.count } do
      result = PublicSources::Bfs::ComputeSourceNativeObservations.call!(actor: @operator)
      assert_equal 1, result.observations_deleted
      assert_equal 1, result.observations_created
    end
  end

  private

  def create_bfs_row(data_type_code:, category_code:, raw_value:, numeric_value:)
    BfsApiRow.create!(
      data_source: @source,
      intake_manifest: @manifest,
      schema_version: @schema_version,
      period_month: "2012-01",
      year: 2012,
      month: 1,
      data_type_code: data_type_code,
      time_slot_id: "0",
      seasonally_adj: "no",
      category_code: category_code,
      geography_level: "us",
      geography_code: "1",
      cell_value_raw: raw_value,
      cell_value_numeric: numeric_value,
      error_data: "no",
      row_hash: SecureRandom.hex(32)
    )
  end

  def source_attributes
    {
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
    }
  end

  def manifest_attributes
    {
      name: "BFS monthly API metadata scaffold",
      manifest_status: "sample_rows_loaded",
      storage_zone: "production_postgresql",
      privacy_classification: "public",
      public_repo_allowed: false,
      structured_private_allowed: true,
      private_file_storage_allowed: false,
      secret_material_present: false,
      redaction_required: true,
      minimum_cell_rule_required: true,
      human_review_required: true,
      retention_rule: "public_source_metadata_retained"
    }
  end
end
