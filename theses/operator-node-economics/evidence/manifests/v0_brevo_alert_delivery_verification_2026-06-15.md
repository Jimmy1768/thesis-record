# Operator Nodes Brevo Alert Delivery Verification: 2026-06-15 UTC

Status: Brevo API delivery code deployed; production credentials pending.

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
- `THESIS_RECORD_ALERT_EMAIL_TO` present: `false`
- `BREVO_API_KEY` present: `false`
- `bin/rails operator:status_alert`: completed
- `operator:status` after alert check: warnings none
- `operator_status_alert_sent` audit events: `0`

## Interpretation

The alert job is safe before credentials are configured: it does not attempt
delivery unless both an alert recipient and `BREVO_API_KEY` are present.

After the Brevo key is added to the production env file, run:

```bash
bin/rails operator:status_alert
```

If status is healthy, no email will be sent. To test actual Brevo delivery, use
a controlled temporary warning or a dedicated smoke task before relying on the
daily scheduled alert.
