class OperationsMailer < ApplicationMailer
  def operator_status_alert(recipient:, summary:)
    @summary = summary

    mail(
      to: recipient,
      subject: "[ThesisRecord] Operator status warning"
    )
  end
end
