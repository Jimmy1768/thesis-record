require "test_helper"

class Operations::V0ReadinessTest < ActiveSupport::TestCase
  test "reports expected current v0 blockers" do
    result = Operations::V0Readiness.call

    assert_not result.passed
    assert_includes result.blockers, "thesis_status_ready_for_v0"
    assert_includes result.blockers, "draft_status_resolved"
    assert result.checks.fetch(:v0_publication_scaffold_present)
    assert result.checks.fetch(:v0_timeline_scaffold_present)
    assert result.checks.fetch(:v0_claim_set_present)
    assert result.checks.fetch(:v0_forecast_set_present)
    assert result.checks.fetch(:v0_indicator_universe_present)
    assert result.checks.fetch(:v0_indicator_universe_categories_present)
    assert result.checks.fetch(:v0_indicator_universe_unapproved)
    assert result.checks.fetch(:v0_source_truth_review_scaffold_present)
    assert result.checks.fetch(:v0_source_truth_review_scaffold_valid)
    assert result.checks.fetch(:v0_prohibited_foundations_review_scaffold_present)
    assert result.checks.fetch(:v0_prohibited_foundations_review_scaffold_valid)
    assert result.checks.fetch(:v0_frozen_claim_set_review_scaffold_present)
    assert result.checks.fetch(:v0_frozen_claim_set_review_scaffold_valid)
    assert result.checks.fetch(:v0_frozen_forecast_set_review_scaffold_present)
    assert result.checks.fetch(:v0_frozen_forecast_set_review_scaffold_valid)
    assert result.checks.fetch(:v0_prose_review_scaffold_present)
    assert result.checks.fetch(:v0_prose_review_scaffold_valid)
    assert result.checks.fetch(:v0_public_release_review_scaffold_present)
    assert result.checks.fetch(:v0_public_release_review_scaffold_valid)
    assert result.checks.fetch(:v0_approval_packet_present)
    assert result.checks.fetch(:v0_approval_packet_unapproved)
    assert result.checks.fetch(:v0_baseline_evidence_accepted)
    assert result.checks.fetch(:v0_source_truth_review_accepted)
    assert_not_includes result.blockers, "v0_source_truth_review_accepted"
    assert result.checks.fetch(:v0_prohibited_foundations_review_accepted)
    assert_not_includes result.blockers, "v0_prohibited_foundations_review_accepted"
    assert_includes result.blockers, "v0_prose_review_accepted"
    assert_includes result.blockers, "v0_public_release_review_accepted"
    assert result.checks.fetch(:v0_internal_target_date_set)
    assert result.checks.fetch(:v0_first_measurement_period_set)
    assert result.checks.fetch(:v0_checkpoint_dates_set)
    assert_includes result.blockers, "v0_publication_approved"
    assert result.checks.fetch(:v0_publication_date_set)
    assert_not_includes result.blockers, "v0_publication_date_set"
    assert_includes result.blockers, "v0_claim_set_approved"
    assert_includes result.blockers, "v0_forecast_set_approved"
    assert_includes result.warnings, "paper_draft_is_archive_only"
    assert_includes result.warnings, "v0_claim_set_candidate_only"
    assert_includes result.warnings, "v0_forecast_set_candidate_only"
    assert_includes result.warnings, "v0_indicator_universe_unapproved"
    assert_not_includes result.warnings, "v0_source_truth_review_unapproved"
    assert_not_includes result.warnings, "v0_prohibited_foundations_review_unapproved"
    assert_not_includes result.warnings, "v0_frozen_claim_set_review_unapproved"
    assert_includes result.warnings, "v0_frozen_forecast_set_review_unapproved"
    assert_includes result.warnings, "v0_prose_review_unapproved"
    assert_includes result.warnings, "v0_public_release_review_unapproved"
    assert_includes result.warnings, "v0_approval_packet_scaffold_only"
  end

  test "keeps safety checks green under current policy" do
    result = Operations::V0Readiness.call

    assert result.checks.fetch(:forecast_clock_policy_present)
    assert result.checks.fetch(:checkpoint_offsets_present)
    assert result.checks.fetch(:sidekiq_schedule_present)
    assert result.checks.fetch(:canonical_data_promotion_disabled)
    assert result.checks.fetch(:claim_review_gate_disabled)
    assert result.checks.fetch(:no_automatic_claim_promotion)
    assert result.checks.fetch(:public_path_target_configured)
  end

  test "accepts provisional v0 checkpoint dates before publication approval" do
    result = Operations::V0Readiness.call

    assert result.checks.fetch(:v0_checkpoint_dates_set)
    assert_not_includes result.blockers, "v0_checkpoint_dates_set"
    assert result.checks.fetch(:v0_publication_date_set)
    assert_not_includes result.blockers, "v0_publication_date_set"
  end

  test "requires timeline and set files to approve claim and forecast sets" do
    result = Operations::V0Readiness.call

    assert result.checks.fetch(:v0_claim_set_present)
    assert result.checks.fetch(:v0_forecast_set_present)
    assert_not result.checks.fetch(:v0_claim_set_approved)
    assert_not result.checks.fetch(:v0_forecast_set_approved)
  end

  test "fails when checkpoint offsets drift" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:forecast_clock][:checkpoint_quarters_after_v0][:v1] = 10

    result = Operations::V0Readiness.call(policy: policy)

    assert_not result.checks.fetch(:checkpoint_offsets_present)
    assert_includes result.blockers, "checkpoint_offsets_present"
  end
end
