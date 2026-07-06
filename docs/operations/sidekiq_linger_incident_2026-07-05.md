# Sidekiq User-Service Linger Incident: 2026-07-05

Status: resolved operational incident.

## Summary

ThesisRecord Sidekiq on `sourcegrid-web` was installed as an enabled
user-level systemd service, but the deployment user did not have systemd linger
enabled. As a result, Sidekiq and the user timers only stayed active while a
login session existed.

This was an operations and monitoring failure, not a thesis evidence-integrity
failure.

## Impact

No source rows, metric observations, claim reviews, prediction links, exports,
evidence snapshots, publication state, or thesis verdicts were changed or lost.

The missed work was limited to scheduled maintenance and audit-only jobs:

- daily read-only production summary checks;
- daily read-only v0 readiness checks;
- daily operator status alert checks;
- one weekly read-only source-release endpoint check;
- one quarterly audit-only indicator checkpoint candidate.

Daily jobs do not collect thesis data. They only check health, readiness, or
warnings.

## Timeline

- 2026-06-26 06:30 UTC: last normal `production_summary_checked` audit event.
- 2026-06-26 06:45 UTC: last normal `v0_readiness_checked` audit event.
- 2026-06-27 to 2026-07-05: user-level Sidekiq did not remain persistent
  without an active login session.
- 2026-07-05: `Linger=no` was identified as the persistence cause.
- 2026-07-05: watchdog timers were changed from `OnBootSec` to
  `OnStartupSec` in the installed user units.
- 2026-07-05: safe audit-only maintenance checks were run manually.
- 2026-07-05: user linger was enabled on the droplet.
- 2026-07-05: Sidekiq, watchdog timers, and `operator:status` verified
  healthy.

## Backfilled Audit Events

The following safe audit-only jobs were run after repair:

- `production_summary_checked` at `2026-07-05T12:48:06Z`;
- `v0_readiness_checked` at `2026-07-05T12:48:21Z`;
- `source_release_check_completed` at `2026-07-05T12:49:46Z`;
- `quarterly_checkpoint_requested` at `2026-07-05T12:58:59Z` with
  `as_of=2026-07-01T06:00:00Z`.

The quarterly checkpoint backfill preserved the protected effects:

- no row writes;
- no metric writes;
- no reviews;
- no prediction links;
- no claims;
- no exports;
- no publication;
- no thesis verdict.

No artificial daily historical audit rows were created for each missed daily
check. The audit history should show the actual outage and the later safe
freshness-restoration checks.

## Root Cause

The production deployment uses user-level systemd services. The service and
timers were enabled, but `loginctl show-user jimmy1768_user -p Linger`
reported `Linger=no`.

With linger disabled, `user@1000.service` can stop when the login session ends,
which tears down user-level Sidekiq and timer units.

A secondary timer issue existed: the watchdog timer examples used `OnBootSec`.
For user timers, `OnStartupSec` is more reliable because it schedules relative
to user-manager startup instead of system boot.

## Durable Fixes

- Enable linger for the deployment user:
  `sudo loginctl enable-linger jimmy1768_user`
- Use `OnStartupSec` in user timer examples:
  - `thesis-record-sidekiq-watchdog.timer.example`
  - `thesis-record-status-watchdog.timer.example`
- Verify Sidekiq remains active after logout.

## Verification

Resolved state observed after repair:

- `Linger=yes`;
- `thesis-record-sidekiq.service` active and running;
- Sidekiq process registered as `sidekiq 7.3.9 thesis_record_app [0 of 5 busy]`;
- `thesis-record-sidekiq-watchdog.timer` had a future `NEXT` trigger;
- `thesis-record-status-watchdog.timer` had a future `NEXT` trigger;
- status watchdog printed `warnings=(none)`;
- Sidekiq scheduled, retry, and dead sets were empty.

## Follow-Up

Future production checks should alert if any of these fail:

- `loginctl show-user jimmy1768_user -p Linger` is not `Linger=yes`;
- `thesis-record-sidekiq.service` is not active;
- either watchdog timer has no future `NEXT` trigger;
- `operator:status` reports stale audit events.
