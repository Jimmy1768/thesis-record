require "test_helper"

class PublicSources::Susb::MetricComputationDesignCheckTest < ActiveSupport::TestCase
  test "current SUSB metric computation design passes conservative guardrails" do
    result = PublicSources::Susb::MetricComputationDesignCheck.call(require_no_observations: true)

    assert result.passed
    assert_empty result.failures
  end

  test "fails if ratios are not prohibited" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    design = policy[:public_ingestion_v1][:susb_us_state_annual][:metric_computation_design_v1]
    design[:prohibited_computation] -= [ "ratios" ]

    result = PublicSources::Susb::MetricComputationDesignCheck.call(policy: policy)

    assert_not result.passed
    assert_includes result.failures, "missing prohibited computations: ratios"
  end

  test "fails if metric observations already exist" do
    definition = MetricDefinition.create!(
      key: "test_metric",
      name: "Test metric",
      formula_status: "draft_disabled"
    )
    MetricObservation.create!(
      metric_definition: definition,
      period: "2022",
      metric_status: "staged_context"
    )

    result = PublicSources::Susb::MetricComputationDesignCheck.call(require_no_observations: true)

    assert_not result.passed
    assert_includes result.failures, "MetricObservation rows already exist"
  end
end
