require "test_helper"

class PublicSources::SourceHealthSummaryTest < ActiveSupport::TestCase
  test "summarizes BFS, SUSB, and BDS health without writing records" do
    bfs_source = create_source(name: "Census BFS monthly API", source_kind: "census_bfs_api", claim_status_allowed: "not_evidence")
    susb_source = create_source(name: "Census SUSB U.S./state annual public file 2022", source_kind: "census_susb_public_file", claim_status_allowed: "context_only")
    bds_source = create_source(name: "Census BDS sector age size public file 2023", source_kind: "census_bds_public_file", claim_status_allowed: "context_only")
    create_bfs_row(bfs_source)
    create_susb_row(susb_source)
    create_bds_row(bds_source)
    create_reviewed_observation(
      source: bfs_source,
      metric_key: "bfs_business_applications",
      source_table: "bfs_api_rows",
      review_policy: "bfs_quality_review_policy_v1",
      quality_metadata: bfs_quality_metadata
    )
    create_reviewed_observation(
      source: susb_source,
      metric_key: "susb_employment",
      source_table: "susb_public_file_rows",
      review_policy: "quality_review_policy_v1",
      quality_metadata: susb_quality_metadata
    )

    assert_no_difference -> { AuditEvent.count } do
      assert_no_difference -> { MetricObservation.count } do
        assert_no_difference -> { MetricQualityReview.count } do
          @result = PublicSources::SourceHealthSummary.call
        end
      end
    end

    assert_equal 3, @result.sources.size
    assert_equal 3, @result.total_source_rows
    assert_equal 3, @result.total_metric_observations
    assert_equal 2, @result.total_quality_reviews
    assert_equal 0, @result.total_prediction_links
    assert @result.all_policy_checks_passed
    assert_equal "context_only_no_claim_links", @result.overall_evidence_status
    assert_equal "reviewed_context_only_not_claim_support", @result.sources.first.evidence_status
    bds_result = @result.sources.find { |source| source.key == "bds" }
    assert_equal 1, bds_result.metric_observation_count
    assert_equal 1, bds_result.unreviewed_observation_count
    assert_equal "source_native_observations_unreviewed_context_only", bds_result.evidence_status
  end

  private

  def create_source(name:, source_kind:, claim_status_allowed:)
    DataSource.create!(
      name: name,
      source_kind: source_kind,
      source_status: "source_registered",
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
      claim_status_allowed: claim_status_allowed
    )
  end

  def create_bfs_row(source)
    manifest = IntakeManifest.create!(manifest_attributes(source, "BFS monthly API metadata scaffold"))
    schema = SchemaVersion.create!(data_source: source, intake_manifest: manifest, version: "bfs_timeseries_eits_v1", schema_status: "verified_api_metadata_scaffold")
    BfsApiRow.create!(
      data_source: source,
      intake_manifest: manifest,
      schema_version: schema,
      period_month: "2012-01",
      year: 2012,
      month: 1,
      data_type_code: "BA_BA",
      time_slot_id: "0",
      seasonally_adj: "no",
      category_code: "NAICS11",
      geography_level: "us",
      geography_code: "1",
      cell_value_raw: "3290",
      cell_value_numeric: 3290,
      error_data: "no",
      row_hash: SecureRandom.hex(32)
    )
  end

  def create_susb_row(source)
    manifest = IntakeManifest.create!(manifest_attributes(source, "SUSB U.S./state annual 2022 public-file manifest"))
    schema = SchemaVersion.create!(data_source: source, intake_manifest: manifest, version: "susb_us_state_annual_2007_present_v1", schema_status: "verified_record_layout_scaffold")
    SusbPublicFileRow.create!(
      data_source: source,
      intake_manifest: manifest,
      schema_version: schema,
      year: 2022,
      state_code: "00",
      naics_code: "111110",
      enterprise_size_code: "01",
      firm_count: 1,
      establishment_count: 1,
      employment: 1,
      employment_noise_flag: "G",
      annual_payroll_thousand: 1,
      payroll_noise_flag: "G",
      receipts_thousand: 1,
      receipts_noise_flag: "G",
      state_name: "United States",
      naics_description: "Soybean Farming",
      enterprise_size_description: "01: Total",
      row_hash: SecureRandom.hex(32)
    )
  end

  def create_bds_row(source)
    manifest = IntakeManifest.create!(manifest_attributes(source, "BDS 2023 sector by firm age by firm size manifest"))
    schema = SchemaVersion.create!(data_source: source, intake_manifest: manifest, version: "bds_2023_sector_firm_age_firm_size_v1", schema_status: "verified_public_file_metadata_scaffold")
    BdsPublicFileRow.create!(
      data_source: source,
      intake_manifest: manifest,
      schema_version: schema,
      source_row_number: 1,
      year: 1978,
      sector_code: "11",
      firm_age_code: "a) 0",
      firm_size_code: "a) 1 to 4",
      raw_measure_values: { "firms" => "1" },
      numeric_measure_values: { "firms" => "1.0" },
      publication_flags: {},
      row_hash: SecureRandom.hex(32)
    )
    definition = MetricDefinition.create!(key: "bds_firms", name: "BDS firms", formula_status: "draft_disabled")
    MetricObservation.create!(
      metric_definition: definition,
      data_source: source,
      period: "1978",
      metric_status: "staged_context",
      numeric_value: 1,
      unit: "count",
      quality_metadata: {
        source_table: "bds_public_file_rows",
        source_row_id: 1,
        source_row_hash: SecureRandom.hex(32),
        metric_key: "bds_firms"
      }
    )
  end

  def create_reviewed_observation(source:, metric_key:, source_table:, review_policy:, quality_metadata:)
    definition = MetricDefinition.create!(key: metric_key, name: metric_key.humanize, formula_status: "draft_disabled")
    observation = MetricObservation.create!(
      metric_definition: definition,
      data_source: source,
      period: "2022",
      metric_status: "staged_context",
      numeric_value: 1,
      unit: "count",
      quality_metadata: quality_metadata
    )
    MetricQualityReview.create!(
      metric_observation: observation,
      data_source: source,
      policy_version: review_policy,
      source_metric_status: "staged_context",
      review_status: "reviewed_context",
      review_reason_code: "source_context_verified",
      reviewed_by: "test_reviewer",
      reviewed_at: Time.current,
      review_metadata: quality_metadata.merge(
        "policy_status" => "test_policy",
        "source_table" => source_table,
        "source_metric_status" => "staged_context",
        "review_status" => "reviewed_context"
      )
    )
  end

  def manifest_attributes(source, name)
    {
      data_source: source,
      name: name,
      manifest_status: "staging_rows_loaded",
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

  def bfs_quality_metadata
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

  def susb_quality_metadata
    {
      "source_table" => "susb_public_file_rows",
      "source_row_id" => 1,
      "source_row_hash" => SecureRandom.hex(32),
      "metric_key" => "susb_employment",
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
