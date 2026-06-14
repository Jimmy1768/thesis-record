require "test_helper"

class PublicSources::Bfs::IngestionDesignCheckTest < ActiveSupport::TestCase
  test "current BFS ingestion design passes staging-only guardrails" do
    result = PublicSources::Bfs::IngestionDesignCheck.call(require_no_rows: true)

    assert result.passed
    assert_empty result.failures
  end

  test "fails if API pull is authorized" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:public_ingestion_v1][:bfs_monthly_api][:ingestion_design_v1][:api_pull_authorized] = true

    result = PublicSources::Bfs::IngestionDesignCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "api_pull_authorized expected false, got true"
  end

  test "can enforce no rows when staging rows already exist" do
    operator = create_operator_user
    scaffold = PublicSources::Bfs::ApiScaffold.call!(actor: operator)
    BfsApiRow.create!(
      data_source: scaffold.fetch(:data_source),
      intake_manifest: scaffold.fetch(:intake_manifest),
      schema_version: scaffold.fetch(:schema_version),
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

    result = PublicSources::Bfs::IngestionDesignCheck.call(require_no_rows: true)

    assert_not result.passed
    assert_includes result.failures, "BfsApiRow rows already exist"
  end
end
