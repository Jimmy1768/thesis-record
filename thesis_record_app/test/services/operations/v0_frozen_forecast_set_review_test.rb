require "test_helper"

class Operations::V0FrozenForecastSetReviewTest < ActiveSupport::TestCase
  test "passes current accepted frozen forecast-set gate while preserving candidate forecasts" do
    result = Operations::V0FrozenForecastSetReview.call

    assert result.passed
    assert result.checks.fetch(:v0_frozen_forecast_set_review_scaffold_present)
    assert result.checks.fetch(:v0_frozen_forecast_set_review_unapproved)
    assert result.checks.fetch(:v0_frozen_forecast_set_review_gate_accepted)
    assert result.checks.fetch(:v0_frozen_forecast_set_review_no_approval_effect)
    assert result.checks.fetch(:v0_frozen_forecast_set_required_artifacts_present)
    assert result.checks.fetch(:v0_approval_packet_requires_frozen_forecast_set_review)
    assert result.checks.fetch(:v0_forecast_set_unapproved_candidate_inventory)
    assert result.checks.fetch(:v0_forecast_inventory_complete)
    assert result.checks.fetch(:v0_forecast_ids_unique)
    assert result.checks.fetch(:v0_forecast_items_reviewable)
    assert result.checks.fetch(:v0_forecast_clock_matches_timeline)
    assert result.checks.fetch(:v0_forecast_set_no_automatic_verdicts)
    assert result.checks.fetch(:v0_frozen_forecast_set_criteria_pending_human_review)
    assert result.checks.fetch(:v0_frozen_forecast_set_prohibited_effects_present)
    assert_not_includes result.warnings, "v0_frozen_forecast_set_review_unapproved"
  end

  test "fails when a forecast loses its failure condition" do
    forecast_set = YAML.safe_load_file(
      Rails.root.join("..", "theses", "operator-node-economics", "publication", "v0_forecast_set.yml")
    ).deep_symbolize_keys
    forecast_set[:forecasts].first[:failure_condition_status] = "missing"

    result = Operations::V0FrozenForecastSetReview.call(forecast_set: forecast_set)

    assert_not result.passed
    assert_not result.checks.fetch(:v0_forecast_items_reviewable)
    assert_includes result.failures, "v0_forecast_items_reviewable"
  end

  test "fails when forecast checkpoint refs drift from timeline" do
    forecast_set = YAML.safe_load_file(
      Rails.root.join("..", "theses", "operator-node-economics", "publication", "v0_forecast_set.yml")
    ).deep_symbolize_keys
    forecast_set[:forecast_clock][:checkpoint_refs][:v1] = "2029-Q3"

    result = Operations::V0FrozenForecastSetReview.call(forecast_set: forecast_set)

    assert_not result.passed
    assert_not result.checks.fetch(:v0_forecast_clock_matches_timeline)
    assert_includes result.failures, "v0_forecast_clock_matches_timeline"
  end
end
