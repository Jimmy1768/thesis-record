# ThesisRecord Monitoring Runbook

Status: operational hardening active.

## Current Host

ThesisRecord production now runs on `sourcegrid-web`.

Service checks use user-level systemd:

```bash
systemctl --user status thesis-record-web.service thesis-record-sidekiq.service \
  thesis-record-sidekiq-watchdog.timer thesis-record-status-watchdog.timer --no-pager
```

Runtime paths:

- app: `/home/jimmy1768_user/Projects/thesis-record/thesis_record_app`
- env: `/home/jimmy1768_user/.config/thesis-record/thesis-record.env`
- Puma: `127.0.0.1:3400`
- health route: `http://127.0.0.1:3400/up`

Do not use `http://127.0.0.1:3400/thesis` as the local process health check.
The public `/thesis` prefix belongs to the future nginx/path-routing layer.

## Layers

ThesisRecord monitoring has four layers:

1. `bin/rails operator:status` reports source-release, checkpoint, snapshot,
   production-summary, and v0-readiness audit state with freshness warnings.
2. `Operations::OperatorStatusAlertJob` runs daily from Sidekiq and emails only
   when `operator:status` has warnings.
3. systemd watchdog timers check that Sidekiq is active and that
   `operator:status` remains warning-free even if the Rails scheduler is not
   making progress.
4. an external monitor should check droplet availability so total host/network
   failure is visible outside the droplet.

## Rails Alert Email

The daily alert job is configured in `config/thesis_record_policy.yml`:

```text
operator_status_alert=0 7 * * *
```

It sends no email when status is healthy. If warnings exist, it sends one email
per warning digest per UTC day and records an `operator_status_alert_sent` audit
event.

ThesisRecord follows the Golden-Template Brevo pattern: Action Mailer renders
the email template, but delivery goes through the Brevo HTTP API using
`BREVO_API_KEY`. It does not use SMTP.

Production environment variables:

```text
THESIS_RECORD_ALERT_EMAIL_TO=<dev inbox>
THESIS_RECORD_MAIL_FROM_NAME=ThesisRecord
THESIS_RECORD_MAIL_FROM_EMAIL=no-reply@sourcegridlabs.com
BREVO_API_KEY=<Brevo API key>
BREVO_FORCE_IPV4=false
BREVO_OPEN_TIMEOUT=3
BREVO_READ_TIMEOUT=5
```

Use real Brevo values in the server environment only. Do not commit the API key.

The first production verification of the Brevo API delivery code is recorded
at:

```text
theses/operator-node-economics/evidence/manifests/v0_brevo_alert_delivery_verification_2026-06-15.md
```

Manual alert check:

```bash
cd /home/jimmy1768_user/Projects/thesis-record/thesis_record_app
set -a
. /home/jimmy1768_user/.config/thesis-record/thesis-record.env
set +a
bin/rails operator:status
bin/rails operator:status_alert
```

## systemd Watchdogs

Example user-service templates live in:

```text
thesis_record_app/config/deploy/systemd/user/
```

Templates:

- `thesis-record-sidekiq-watchdog.service.example`
- `thesis-record-sidekiq-watchdog.timer.example`
- `thesis-record-status-watchdog.service.example`
- `thesis-record-status-watchdog.timer.example`

The Sidekiq watchdog fails if the user service is inactive. The status watchdog
fails if `operator:status` does not print `warnings=(none)`.

These timers are local host checks. They do not replace external monitoring,
because they cannot run when the droplet itself is down.

Post-migration verification on 2026-06-27 UTC:

- `thesis-record-web.service`: active
- `thesis-record-sidekiq.service`: active
- `thesis-record-sidekiq-watchdog.timer`: active
- `thesis-record-status-watchdog.timer`: active
- Sidekiq watchdog completed multiple five-minute cycles after cutover.
- Status watchdog completed successfully and printed `warnings=(none)`.
- `bin/rails operator:status` reported the restored production counts with no
  warnings.

The first production verification run is recorded at:

```text
theses/operator-node-economics/evidence/manifests/v0_monitoring_hardening_verification_2026-06-15.md
```

## External Monitor

Minimum external monitoring:

- DigitalOcean droplet availability and resource alerts;
- disk space alert;
- CPU and memory alerts;
- optional external SSH or future HTTP check that runs or approximates
  `operator:status`.

Until ThesisRecord has a public web surface, external monitoring should focus
on host availability and resource exhaustion. Once `/thesis` is served through
a reverse proxy, add an HTTP health check.
