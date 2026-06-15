require "digest"

module Operations
  class OperatorStatusAlertJob < ApplicationJob
    queue_as :maintenance

    ALERT_EVENT_TYPE = "operator_status_alert_sent"

    class << self
      attr_writer :brevo_client_factory

      def brevo_client_factory
        @brevo_client_factory || -> { Notifications::BrevoClient.new }
      end
    end

    def perform(now: Time.current)
      summary = Operations::OperatorStatusSummary.call(now: now)
      return if summary.warnings.empty?
      return if alert_recipient.blank?
      return unless brevo_configured?

      warning_digest = digest(summary.warnings)
      return if alert_already_sent_today?(warning_digest, now)

      message = OperationsMailer.operator_status_alert(
        recipient: alert_recipient,
        summary: summary
      )
      delivered = brevo_client.send_email(
        to: alert_recipient,
        subject: message.subject,
        html: message.html_part&.body&.to_s || message.body.to_s,
        sender_name: ENV.fetch("THESIS_RECORD_MAIL_FROM_NAME", "ThesisRecord"),
        sender_email: ENV.fetch("THESIS_RECORD_MAIL_FROM_EMAIL", "no-reply@example.invalid")
      )
      return unless delivered

      Audit::Recorder.record_system!(
        actor: self.class.name,
        event_type: ALERT_EVENT_TYPE,
        entity_type: "OperationsAlert",
        entity_id: "operator_status",
        change_summary: "Operator status alert sent; warnings=#{summary.warnings.join(",")}",
        reason_code: "operator_status_warning",
        new_state_hash: warning_digest
      )
    end

    private

    def alert_recipient
      ENV["THESIS_RECORD_ALERT_EMAIL_TO"].presence
    end

    def brevo_configured?
      ENV["BREVO_API_KEY"].present?
    end

    def brevo_client
      self.class.brevo_client_factory.call
    end

    def digest(warnings)
      Digest::SHA256.hexdigest(warnings.sort.join("|"))
    end

    def alert_already_sent_today?(warning_digest, now)
      AuditEvent
        .where(event_type: ALERT_EVENT_TYPE, reason_code: "operator_status_warning", new_state_hash: warning_digest)
        .where(occurred_at: now.all_day)
        .exists?
    end
  end
end
