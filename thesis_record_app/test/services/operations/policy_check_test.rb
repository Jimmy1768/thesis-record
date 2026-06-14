require "test_helper"

class Operations::PolicyCheckTest < ActiveSupport::TestCase
  test "current v1 operations policy passes guardrail check" do
    result = Operations::PolicyCheck.call

    assert result.passed
    assert_empty result.failures
  end

  test "policy check fails when private ingestion is enabled by default" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:production_operations_v1][:private_ingestion_enabled_default] = true

    result = Operations::PolicyCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures,
                    "production_operations_v1.private_ingestion_enabled_default expected false, got true"
  end

  test "policy check fails when deployment port drifts from production target" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:production_operations_v1][:puma_port] = 3000

    result = Operations::PolicyCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures,
                    "production_operations_v1.puma_port expected 3400, got 3000"
  end

  test "policy check fails when canonical promotion gates are incomplete" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:production_operations_v1][:canonical_data_promotion_requires] = [
      "production_postgresql_target"
    ]

    result = Operations::PolicyCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures,
                    'production_operations_v1.canonical_data_promotion_requires missing ["pre_promotion_backup", "migration_manifest", "row_count_reconciliation", "post_promotion_health_check"]'
  end
end
