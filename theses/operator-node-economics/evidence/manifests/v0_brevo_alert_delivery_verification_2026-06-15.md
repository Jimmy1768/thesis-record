# Operator Nodes Brevo Alert Delivery Verification: 2026-06-15 UTC

Status: Brevo API delivery verified in production.

## Scope

This manifest records the switch from SMTP-based alert delivery scaffolding to
the Golden-Template Brevo HTTP API pattern.

ThesisRecord now uses:

- `BREVO_API_KEY` for Brevo HTTP API delivery;
- `THESIS_RECORD_ALERT_EMAIL_TO` for the alert recipient;
- `THESIS_RECORD_MAIL_FROM_NAME` and `THESIS_RECORD_MAIL_FROM_EMAIL` for sender
  identity;
- Rails mailer templates for rendering only.

No real Brevo key or email credential is committed.

## Execution

- Production host: `sourcecombatives-web`
- Runtime commit: `da330e6`
- Rails environment: `production`
- Sidekiq service: active after restart
- `THESIS_RECORD_ALERT_EMAIL_TO` present after env update: `true`
- `BREVO_API_KEY` present after env update: `true`
- `THESIS_RECORD_MAIL_FROM_EMAIL`: `no-reply@sourcegridlabs.com`
- `bin/rails operator:status_alert`: completed
- `operator:status` after alert check: warnings none
- `operator_status_alert_sent` audit events: `0`

## Direct Smoke Test

A direct Brevo delivery smoke test was sent from production after the env file
was updated:

```ruby
Notifications::BrevoClient.new.send_email(
  to: ENV.fetch("THESIS_RECORD_ALERT_EMAIL_TO"),
  subject: "[ThesisRecord] Brevo smoke test",
  html: "<p>Brevo smoke test from ThesisRecord production.</p>",
  sender_name: ENV.fetch("THESIS_RECORD_MAIL_FROM_NAME", "ThesisRecord"),
  sender_email: ENV.fetch("THESIS_RECORD_MAIL_FROM_EMAIL")
)
```

Result:

- email received by the dev inbox;
- sender displayed as `ThesisRecord <no-reply@sourcegridlabs.com>`;
- subject displayed as `[ThesisRecord] Brevo smoke test`;
- body displayed as `Brevo smoke test from ThesisRecord production.`

## Interpretation

Brevo delivery is verified. The scheduled alert job will still send no email
while `operator:status` is healthy. When `operator:status` reports warnings, the
daily `operator_status_alert` job can deliver to the configured dev inbox
through Brevo.
