class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("THESIS_RECORD_MAIL_FROM", "ThesisRecord <no-reply@example.invalid>")
  layout "mailer"
end
