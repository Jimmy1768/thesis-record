require "test_helper"

class PublicSources::Bds::AcquisitionDesignCheckTest < ActiveSupport::TestCase
  test "current BDS acquisition design passes fetch-validation guardrails" do
    result = PublicSources::Bds::AcquisitionDesignCheck.call

    assert result.passed
    assert_empty result.failures
  end

  test "fails if raw file fetch is disabled" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:public_ingestion_v1][:bds_sector_age_size_public_file][:acquisition_design_v1][:raw_file_fetch_authorized] = false

    result = PublicSources::Bds::AcquisitionDesignCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "raw_file_fetch_authorized expected true"
  end

  test "fails if manifest reconciliation is disabled" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:public_ingestion_v1][:bds_sector_age_size_public_file][:acquisition_design_v1][:manifest_reconciliation_required] = false

    result = PublicSources::Bds::AcquisitionDesignCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "manifest_reconciliation_required expected true"
  end

  test "fails if parser is authorized during acquisition validation" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:public_ingestion_v1][:bds_sector_age_size_public_file][:acquisition_design_v1][:parser_authorized] = true

    result = PublicSources::Bds::AcquisitionDesignCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "parser_authorized expected false, got true"
  end
end
