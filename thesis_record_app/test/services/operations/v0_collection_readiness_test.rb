require "test_helper"

class Operations::V0CollectionReadinessTest < ActiveSupport::TestCase
  test "passes with the current dry-run-only v0 collection plan" do
    result = Operations::V0CollectionReadiness.call

    assert result.passed
    assert_empty result.blockers
    assert result.checks.fetch(:plan_present)
    assert result.checks.fetch(:default_mode_read_only)
    assert result.checks.fetch(:canonical_ingestion_not_authorized)
    assert result.checks.fetch(:row_ingestion_not_authorized)
    assert result.checks.fetch(:metric_computation_not_authorized)
    assert result.checks.fetch(:no_claim_or_publication_effects)
    assert result.checks.fetch(:production_policy_ingestion_disabled)
    assert result.checks.fetch(:claim_review_gate_disabled)
    assert_includes result.warnings, "first_live_collection_source_pending"
    assert_includes result.warnings, "first_live_collection_mode_pending"
  end

  test "fails when canonical collection env gate is enabled" do
    result = Operations::V0CollectionReadiness.call(
      env: {
        "THESIS_RECORD_ALLOW_V0_CANONICAL_COLLECTION" => "true"
      }
    )

    assert_not result.passed
    assert_includes result.blockers, "no_collection_env_gate_enabled"
    assert_includes result.warnings, "canonical_collection_env_gate_enabled"
  end

  test "fails when production policy enables public ingestion by default" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:production_operations_v1][:public_ingestion_enabled_default] = true

    result = Operations::V0CollectionReadiness.call(policy: policy)

    assert_not result.passed
    assert_includes result.blockers, "production_policy_ingestion_disabled"
  end

  test "fails when claim-review gate allows prediction links" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:claim_review_gate_v1][:prediction_links_authorized] = true

    result = Operations::V0CollectionReadiness.call(policy: policy)

    assert_not result.passed
    assert_includes result.blockers, "claim_review_gate_disabled"
  end
end
