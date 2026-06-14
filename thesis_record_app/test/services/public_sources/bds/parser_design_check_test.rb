require "test_helper"

class PublicSources::Bds::ParserDesignCheckTest < ActiveSupport::TestCase
  test "current BDS parser design passes source-row-only guardrails" do
    result = PublicSources::Bds::ParserDesignCheck.call(
      require_staging_table: true
    )

    assert result.passed
    assert_empty result.failures
  end

  test "fails if row load is disabled" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:public_ingestion_v1][:bds_sector_age_size_public_file][:parser_design_v1][:row_load_authorized] = false

    result = PublicSources::Bds::ParserDesignCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "row_load_authorized expected true, got false"
  end

  test "fails if full-file dry run is disabled" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:public_ingestion_v1][:bds_sector_age_size_public_file][:parser_design_v1][:full_file_dry_run_authorized] = false

    result = PublicSources::Bds::ParserDesignCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "full_file_dry_run_authorized expected true"
  end

  test "fails if publication flags are not preserved" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:public_ingestion_v1][:bds_sector_age_size_public_file][:parser_design_v1][:flag_handling][:extract_publication_flags_before_numeric_coercion] = false

    result = PublicSources::Bds::ParserDesignCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "flag_handling.extract_publication_flags_before_numeric_coercion expected true"
  end

  test "fails if a source measure field is omitted" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    fields = policy[:public_ingestion_v1][:bds_sector_age_size_public_file][:parser_design_v1][:count_measure_fields]
    fields.delete("firmdeath_firms")

    result = PublicSources::Bds::ParserDesignCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "missing count measure fields: firmdeath_firms"
  end
end
