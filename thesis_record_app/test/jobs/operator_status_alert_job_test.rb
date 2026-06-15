require "test_helper"

class OperatorStatusAlertJobTest < ActiveJob::TestCase
  setup do
    @previous_recipient = ENV["THESIS_RECORD_ALERT_EMAIL_TO"]
    @previous_brevo_key = ENV["BREVO_API_KEY"]
    @previous_brevo_client_factory = Operations::OperatorStatusAlertJob.brevo_client_factory
  end

  teardown do
    if @previous_recipient.nil?
      ENV.delete("THESIS_RECORD_ALERT_EMAIL_TO")
    else
      ENV["THESIS_RECORD_ALERT_EMAIL_TO"] = @previous_recipient
    end
    if @previous_brevo_key.nil?
      ENV.delete("BREVO_API_KEY")
    else
      ENV["BREVO_API_KEY"] = @previous_brevo_key
    end
    Operations::OperatorStatusAlertJob.brevo_client_factory = @previous_brevo_client_factory
  end

  test "does not send email when operator status is healthy" do
    now = Time.utc(2026, 6, 15, 12, 0, 0)
    ENV["THESIS_RECORD_ALERT_EMAIL_TO"] = "dev@example.test"
    ENV["BREVO_API_KEY"] = "test-brevo-key"
    create_healthy_events!(now: now)
    brevo_client = FakeBrevoClient.new

    Operations::OperatorStatusAlertJob.brevo_client_factory = -> { brevo_client }

    assert_no_difference -> { AuditEvent.where(event_type: "operator_status_alert_sent").count } do
      Operations::OperatorStatusAlertJob.perform_now(now: now)
    end

    assert_empty brevo_client.deliveries
  end

  test "sends email and records audit event when operator status has warnings" do
    now = Time.utc(2026, 6, 15, 12, 0, 0)
    ENV["THESIS_RECORD_ALERT_EMAIL_TO"] = "dev@example.test"
    ENV["BREVO_API_KEY"] = "test-brevo-key"
    brevo_client = FakeBrevoClient.new

    Operations::OperatorStatusAlertJob.brevo_client_factory = -> { brevo_client }

    assert_difference -> { AuditEvent.where(event_type: "operator_status_alert_sent").count }, 1 do
      Operations::OperatorStatusAlertJob.perform_now(now: now)
    end

    assert_equal 1, brevo_client.deliveries.count
    delivery = brevo_client.deliveries.first
    assert_equal "dev@example.test", delivery.fetch(:to)
    assert_equal "[ThesisRecord] Operator status warning", delivery.fetch(:subject)
    assert_includes delivery.fetch(:html), "missing_source_release_check_event"

    event = AuditEvent.where(event_type: "operator_status_alert_sent").last
    assert_equal "operator_status_warning", event.reason_code
    assert_equal "OperationsAlert", event.entity_type
    assert_equal "operator_status", event.entity_id
    assert event.new_state_hash.present?
  end

  test "suppresses duplicate warning digest for same day" do
    now = Time.utc(2026, 6, 15, 12, 0, 0)
    ENV["THESIS_RECORD_ALERT_EMAIL_TO"] = "dev@example.test"
    ENV["BREVO_API_KEY"] = "test-brevo-key"
    brevo_client = FakeBrevoClient.new

    Operations::OperatorStatusAlertJob.brevo_client_factory = -> { brevo_client }

    Operations::OperatorStatusAlertJob.perform_now(now: now)

    assert_no_difference -> { AuditEvent.where(event_type: "operator_status_alert_sent").count } do
      Operations::OperatorStatusAlertJob.perform_now(now: now + 1.hour)
    end

    assert_equal 1, brevo_client.deliveries.count
  end

  test "does not send email without configured recipient" do
    now = Time.utc(2026, 6, 15, 12, 0, 0)
    ENV.delete("THESIS_RECORD_ALERT_EMAIL_TO")
    ENV["BREVO_API_KEY"] = "test-brevo-key"
    brevo_client = FakeBrevoClient.new

    Operations::OperatorStatusAlertJob.brevo_client_factory = -> { brevo_client }

    assert_no_difference -> { AuditEvent.where(event_type: "operator_status_alert_sent").count } do
      Operations::OperatorStatusAlertJob.perform_now(now: now)
    end

    assert_empty brevo_client.deliveries
  end

  test "does not send email without configured brevo api key" do
    now = Time.utc(2026, 6, 15, 12, 0, 0)
    ENV["THESIS_RECORD_ALERT_EMAIL_TO"] = "dev@example.test"
    ENV.delete("BREVO_API_KEY")
    brevo_client = FakeBrevoClient.new

    Operations::OperatorStatusAlertJob.brevo_client_factory = -> { brevo_client }

    assert_no_difference -> { AuditEvent.where(event_type: "operator_status_alert_sent").count } do
      Operations::OperatorStatusAlertJob.perform_now(now: now)
    end

    assert_empty brevo_client.deliveries
  end

  private

  class FakeBrevoClient
    attr_reader :deliveries

    def initialize
      @deliveries = []
    end

    def send_email(to:, subject:, html:, sender_name:, sender_email:)
      deliveries << {
        to: to,
        subject: subject,
        html: html,
        sender_name: sender_name,
        sender_email: sender_email
      }
      true
    end
  end

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
