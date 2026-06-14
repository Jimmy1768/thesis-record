require "test_helper"

class PublicSources::Bds::ScaffoldPolicyCheckTest < ActiveSupport::TestCase
  test "current BDS scaffold policy passes metadata-only guardrails" do
    result = PublicSources::Bds::ScaffoldPolicyCheck.call(require_no_bds_rows: true)

    assert result.passed
    assert_empty result.failures
  end

  test "fails if analysis is authorized" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:public_ingestion_v1][:bds_sector_age_size_public_file][:analysis_authorized] = true

    result = PublicSources::Bds::ScaffoldPolicyCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "analysis_authorized expected false, got true"
  end

  test "fails if unresolved BDS paths are removed" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:public_ingestion_v1][:bds_sector_age_size_public_file][:unresolved_paths] = []

    result = PublicSources::Bds::ScaffoldPolicyCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "missing unresolved paths: six_digit_naics_firm_age_size, subnational_firm_age_size_multiyear, api_bdsfagefsize_multiyear, direct_employer_firm_startup_field"
  end
end
