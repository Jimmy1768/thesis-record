require "test_helper"

class Operations::OperatorStatusSummaryTest < ActiveSupport::TestCase
  test "reports latest scheduler and readiness audit events without writes" do
    older = create_audit_event!(
      event_type: "quarterly_checkpoint_requested",
      entity_id: "quarterly_indicator_checkpoint:2026-Q3",
      occurred_at: 2.days.ago
    )
    newer = create_audit_event!(
      event_type: "quarterly_checkpoint_requested",
      entity_id: "quarterly_indicator_checkpoint:2026-Q4",
      occurred_at: 1.day.ago
    )
    source = create_audit_event!(
      event_type: "source_release_check_completed",
      entity_id: "source_release_check",
      reason_code: "scheduled_source_release_check"
    )
    annual = create_audit_event!(
      event_type: "annual_snapshot_candidate_requested",
      entity_id: "annual_snapshot_candidate:2027-Q2",
      reason_code: "scheduled_annual_snapshot_candidate"
    )
    production = create_audit_event!(
      event_type: "production_summary_checked",
      entity_id: "production_summary",
      reason_code: "scheduled_production_summary_check"
    )
    readiness = create_audit_event!(
      event_type: "v0_readiness_checked",
      entity_id: "v0_readiness",
      reason_code: "scheduled_v0_readiness_check"
    )

    assert_no_difference -> { AuditEvent.count } do
      @summary = Operations::OperatorStatusSummary.call
    end

    assert_equal source.id, @summary.latest_events.fetch(:source_release_check).event_id
    assert_equal newer.id, @summary.latest_events.fetch(:quarterly_checkpoint).event_id
    assert_not_equal older.id, @summary.latest_events.fetch(:quarterly_checkpoint).event_id
    assert_equal annual.id, @summary.latest_events.fetch(:annual_snapshot).event_id
    assert_equal production.id, @summary.latest_events.fetch(:production_summary).event_id
    assert_equal readiness.id, @summary.latest_events.fetch(:v0_readiness).event_id
    assert_equal AuditEvent.count, @summary.table_counts.fetch(:audit_events)
    assert_equal PredictionLink.count, @summary.table_counts.fetch(:prediction_links)
    assert_empty @summary.warnings
  end

  test "warns when expected event family is missing" do
    summary = Operations::OperatorStatusSummary.call

    assert_includes summary.warnings, "missing_source_release_check_event"
    assert_includes summary.warnings, "missing_quarterly_checkpoint_event"
    assert_includes summary.warnings, "missing_annual_snapshot_event"
    assert_includes summary.warnings, "missing_production_summary_event"
    assert_includes summary.warnings, "missing_v0_readiness_event"
  end

  test "warns when expected event family is stale" do
    now = Time.utc(2026, 6, 15, 12, 0, 0)

    create_audit_event!(
      event_type: "source_release_check_completed",
      entity_id: "source_release_check",
      occurred_at: now - 9.days
    )
    create_audit_event!(
      event_type: "quarterly_checkpoint_requested",
      entity_id: "quarterly_indicator_checkpoint:2026-Q3",
      occurred_at: now - 101.days
    )
    create_audit_event!(
      event_type: "annual_snapshot_candidate_requested",
      entity_id: "annual_snapshot_candidate:2027-Q2",
      occurred_at: now - 401.days
    )
    create_audit_event!(
      event_type: "production_summary_checked",
      entity_id: "production_summary",
      occurred_at: now - 27.hours
    )
    create_audit_event!(
      event_type: "v0_readiness_checked",
      entity_id: "operator_nodes_v0",
      occurred_at: now - 27.hours
    )

    summary = Operations::OperatorStatusSummary.call(now: now)

    assert_includes summary.warnings, "stale_source_release_check_event"
    assert_includes summary.warnings, "stale_quarterly_checkpoint_event"
    assert_includes summary.warnings, "stale_annual_snapshot_event"
    assert_includes summary.warnings, "stale_production_summary_event"
    assert_includes summary.warnings, "stale_v0_readiness_event"
  end

  private

  def create_audit_event!(event_type:, entity_id:, reason_code: "test_reason", occurred_at: Time.current)
    AuditEvent.create!(
      occurred_at: occurred_at,
      actor_type: "Test",
      event_type: event_type,
      entity_type: "SchedulerCheckpoint",
      entity_id: entity_id,
      change_summary: "#{event_type} summary",
      reason_code: reason_code,
      storage_zone: "production_postgresql",
      privacy_classification: "internal",
      claim_status_effect: "unchanged",
      export_allowed: false
    )
  end
end
