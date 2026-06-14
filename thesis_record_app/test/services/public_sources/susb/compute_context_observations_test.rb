require "test_helper"

class PublicSources::Susb::ComputeContextObservationsTest < ActiveSupport::TestCase
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
      version: "susb_us_state_annual_2007_present_v1",
      schema_status: "verified_record_layout_scaffold"
    )
    PublicSources::Susb::MetricDefinitionScaffold.call!(actor: @operator)
  end

  test "computes context observations for ENTRSIZE 01 rows only" do
    create_susb_row(state_code: "00", enterprise_size_code: "01", employment_noise_flag: "G", payroll_noise_flag: "H", receipts_noise_flag: "J")
    create_susb_row(state_code: "00", enterprise_size_code: "02", employment_noise_flag: "G", payroll_noise_flag: "G", receipts_noise_flag: "G")

    assert_difference -> { MetricObservation.count }, 5 do
      @result = PublicSources::Susb::ComputeContextObservations.call!(actor: @operator)
    end

    assert_equal 1, @result.eligible_rows
    assert_equal 5, @result.observations_created
    assert_equal 4, @result.status_counts.fetch("staged_context")
    assert_equal 1, @result.status_counts.fetch("quality_review_required")
    assert_equal 0, MetricObservation.where("dimensions ->> 'enterprise_size_code' = ?", "02").count
  end

  test "blocks D and S flagged metric cells" do
    create_susb_row(state_code: "00", employment_noise_flag: "D", payroll_noise_flag: "S", receipts_noise_flag: "G")

    result = PublicSources::Susb::ComputeContextObservations.call!(actor: @operator)

    assert_equal 3, result.observations_created
    assert_equal 1, result.blocked_cells.fetch("susb_employment")
    assert_equal 1, result.blocked_cells.fetch("susb_annual_payroll_thousand")
  end

  test "is idempotent by deleting and recreating scoped observations" do
    create_susb_row(state_code: "00")
    PublicSources::Susb::ComputeContextObservations.call!(actor: @operator)

    assert_no_difference -> { MetricObservation.count } do
      result = PublicSources::Susb::ComputeContextObservations.call!(actor: @operator)
      assert_equal 5, result.observations_deleted
      assert_equal 5, result.observations_created
    end
  end

  private

  def create_susb_row(state_code:, enterprise_size_code: "01", employment_noise_flag: "G", payroll_noise_flag: "G", receipts_noise_flag: "G")
    SusbPublicFileRow.create!(
      data_source: @source,
      intake_manifest: @manifest,
      schema_version: @schema_version,
      year: 2022,
      state_code: state_code,
      naics_code: "111110",
      enterprise_size_code: enterprise_size_code,
      firm_count: 1,
      establishment_count: 1,
      employment: 1,
      employment_noise_flag: employment_noise_flag,
      annual_payroll_thousand: 1,
      payroll_noise_flag: payroll_noise_flag,
      receipts_thousand: 1,
      receipts_noise_flag: receipts_noise_flag,
      state_name: "United States",
      naics_description: "Soybean Farming",
      enterprise_size_description: "01: Total",
      row_hash: SecureRandom.hex(32)
    )
  end

  def source_attributes
    {
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
    }
  end

  def manifest_attributes
    {
      name: "SUSB U.S./state annual 2022 public-file manifest",
      manifest_status: "staging_rows_loaded",
      storage_zone: "production_postgresql",
      privacy_classification: "public",
      public_repo_allowed: true,
      structured_private_allowed: false,
      private_file_storage_allowed: false,
      secret_material_present: false,
      redaction_required: false,
      minimum_cell_rule_required: true,
      human_review_required: true,
      retention_rule: "public_source_metadata_retained"
    }
  end
end
