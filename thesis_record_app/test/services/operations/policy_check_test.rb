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
end
