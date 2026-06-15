# Operator Nodes Monitoring Hardening Verification: 2026-06-15 UTC

Status: completed production verification run.

## Scope

This manifest records the production verification of the first monitoring
hardening slice for ThesisRecord.

The slice added:

- freshness windows to `bin/rails operator:status`;
- a daily `operator_status_alert` Sidekiq job;
- Action Mailer SMTP configuration via environment variables;
- a text email alert for operator status warnings;
- duplicate same-day alert suppression by warning digest;
- systemd user-timer examples for Sidekiq and operator-status watchdogs;
- monitoring runbook documentation.

No real SMTP credentials were committed.

## Execution

- Production host: `sourcecombatives-web`
- Runtime commit: `7c178ea`
- Rails environment: `production`
- Sidekiq service: active
- `operator_status_alert` schedule loaded: yes
- `bin/rails operator:status`: warnings none
- `bin/rails operator:status_alert`: completed
- `operator_status_alert_sent` audit events after healthy alert check: `0`

## Freshness Windows

`operator:status` now warns when:

- source-release check is older than eight days;
- quarterly checkpoint is older than 100 days;
- annual snapshot is older than 400 days;
- production summary is older than 26 hours;
- v0 readiness is older than 26 hours.

## Loaded Schedule

The production Sidekiq schedule includes:

- `source_release_check`
- `quarterly_indicator_checkpoint`
- `annual_snapshot_candidate`
- `production_summary_check`
- `v0_readiness_check`
- `operator_status_alert`

## systemd Watchdogs

Installed and enabled user timers:

- `thesis-record-sidekiq-watchdog.timer`
- `thesis-record-status-watchdog.timer`

Verification:

- `thesis-record-sidekiq-watchdog.service`: exited with `status=0/SUCCESS`
- `thesis-record-status-watchdog.service`: exited with `status=0/SUCCESS`
- Sidekiq watchdog next trigger: every five minutes
- status watchdog next trigger: every hour

The status watchdog fails if `bin/rails operator:status` does not print
`warnings=(none)`.

## Remaining External Layer

The remaining layer is outside this repo: configure an external provider such
as DigitalOcean monitoring to alert on droplet availability, disk, CPU, and
memory. That layer is required to detect total droplet or network failure,
because in-droplet Rails and systemd checks cannot run when the host is down.
