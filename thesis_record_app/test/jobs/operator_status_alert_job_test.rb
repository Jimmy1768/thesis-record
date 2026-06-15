require "test_helper"

class OperatorStatusAlertJobTest < ActiveJob::TestCase
  setup do
    ActionMailer::Base.deliveries.clear
    @previous_recipient = ENV["THESIS_RECORD_ALERT_EMAIL_TO"]
  end

  teardown do
    if @previous_recipient.nil?
      ENV.delete("THESIS_RECORD_ALERT_EMAIL_TO")
    else
      ENV["THESIS_RECORD_ALERT_EMAIL_TO"] = @previous_recipient
    end
    ActionMailer::Base.deliveries.clear
  end

  test "does not send email when operator status is healthy" do
    now = Time.utc(2026, 6, 15, 12, 0, 0)
    ENV["THESIS_RECORD_ALERT_EMAIL_TO"] = "dev@example.test"
    create_healthy_events!(now: now)

    assert_no_difference -> { ActionMailer::Base.deliveries.count } do
      assert_no_difference -> { AuditEvent.where(event_type: "operator_status_alert_sent").count } do
        Operations::OperatorStatusAlertJob.perform_now(now: now)
      end
    end
  end

  test "sends email and records audit event when operator status has warnings" do
    now = Time.utc(2026, 6, 15, 12, 0, 0)
    ENV["THESIS_RECORD_ALERT_EMAIL_TO"] = "dev@example.test"

    assert_difference -> { ActionMailer::Base.deliveries.count }, 1 do
      assert_difference -> { AuditEvent.where(event_type: "operator_status_alert_sent").count }, 1 do
        Operations::OperatorStatusAlertJob.perform_now(now: now)
      end
    end

    email = ActionMailer::Base.deliveries.last
    assert_equal [ "dev@example.test" ], email.to
    assert_equal "[ThesisRecord] Operator status warning", email.subject
    assert_includes email.text_part&.body.to_s.presence || email.body.to_s, "missing_source_release_check_event"

    event = AuditEvent.where(event_type: "operator_status_alert_sent").last
    assert_equal "operator_status_warning", event.reason_code
    assert_equal "OperationsAlert", event.entity_type
    assert_equal "operator_status", event.entity_id
    assert event.new_state_hash.present?
  end

  test "suppresses duplicate warning digest for same day" do
    now = Time.utc(2026, 6, 15, 12, 0, 0)
    ENV["THESIS_RECORD_ALERT_EMAIL_TO"] = "dev@example.test"

    Operations::OperatorStatusAlertJob.perform_now(now: now)

    assert_no_difference -> { ActionMailer::Base.deliveries.count } do
      assert_no_difference -> { AuditEvent.where(event_type: "operator_status_alert_sent").count } do
        Operations::OperatorStatusAlertJob.perform_now(now: now + 1.hour)
      end
    end
  end

  test "does not send email without configured recipient" do
    now = Time.utc(2026, 6, 15, 12, 0, 0)
    ENV.delete("THESIS_RECORD_ALERT_EMAIL_TO")

    assert_no_difference -> { ActionMailer::Base.deliveries.count } do
      assert_no_difference -> { AuditEvent.where(event_type: "operator_status_alert_sent").count } do
        Operations::OperatorStatusAlertJob.perform_now(now: now)
      end
    end
  end

  private

  def create_healthy_events!(now:)
    {
      source_release_check_completed: "source_release_check",
      quarterly_checkpoint_requested: "quarterly_indicator_checkpoint:2026-Q3",
      annual_snapshot_candidate_requested: "annual_snapshot_candidate:2027-Q2",
      production_summary_checked: "production_summary",
      v0_readiness_checked: "operator_nodes_v0"
    }.each do |event_type, entity_id|
      AuditEvent.create!(
        occurred_at: now,
        actor_type: "Test",
        event_type: event_type.to_s,
        entity_type: "SchedulerCheckpoint",
        entity_id: entity_id,
        change_summary: "#{event_type} summary",
        reason_code: "test_reason",
        storage_zone: "production_postgresql",
        privacy_classification: "internal",
        claim_status_effect: "unchanged",
        export_allowed: false
      )
    end
  end
end
