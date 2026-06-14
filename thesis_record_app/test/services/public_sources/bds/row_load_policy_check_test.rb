require "test_helper"

class PublicSources::Bds::RowLoadPolicyCheckTest < ActiveSupport::TestCase
  test "current BDS row-load policy passes source-row-only guardrails" do
    result = PublicSources::Bds::RowLoadPolicyCheck.call

    assert result.passed
    assert_empty result.failures
  end

  test "fails if row load is disabled" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:public_ingestion_v1][:bds_sector_age_size_public_file][:parser_design_v1][:row_load_gate_v1][:row_load_authorized] = false

    result = PublicSources::Bds::RowLoadPolicyCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "row_load_authorized expected true, got false"
  end

  test "fails if row-load QA policy does not require the full dry-run row count" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:public_ingestion_v1][:bds_sector_age_size_public_file][:parser_design_v1][:row_load_qa_policy_v1][:expected_source_rows] = 1

    result = PublicSources::Bds::RowLoadPolicyCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "expected_source_rows expected 104880"
  end

  test "fails if row-load QA policy authorizes metric observations" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:public_ingestion_v1][:bds_sector_age_size_public_file][:parser_design_v1][:row_load_qa_policy_v1][:metric_observations_authorized] = true

    result = PublicSources::Bds::RowLoadPolicyCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "qa metric_observations_authorized expected false, got true"
  end

  test "fails loaded-table reconciliation when BDS row count does not match expected count" do
    operator = create_operator_user
    scaffold = PublicSources::Bds::PublicFileScaffold.call!(actor: operator)
    BdsPublicFileRow.create!(
      data_source: scaffold.fetch(:data_source),
      intake_manifest: scaffold.fetch(:intake_manifest),
      schema_version: scaffold.fetch(:schema_version),
      source_row_number: 1,
      year: 1978,
      sector_code: "11",
      firm_age_code: "a) 0",
      firm_size_code: "a) 1 to 4",
      raw_measure_values: { "firms" => "1" },
      numeric_measure_values: { "firms" => "1" },
      publication_flags: {},
      row_hash: SecureRandom.hex(32)
    )

    result = PublicSources::Bds::RowLoadPolicyCheck.call(require_loaded_table: true)

    assert_not result.passed
    assert_includes result.failures, "bds_public_file_rows row count expected 104880, got 1"
  end
end
