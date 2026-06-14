# ThesisRecord Production Deployment Runbook

## Scope

This runbook covers the first production deployment slice for ThesisRecord on a
single droplet.

The first target is a private production runtime, not a public web surface:

- Rails/Puma running on localhost port `3400`
- Sidekiq running as a separate systemd service
- Redis for Sidekiq
- PostgreSQL as the production system of record
- access by SSH and, when needed, SSH tunnel
- no nginx requirement until a public browser surface is approved

Public path target remains `sourcegridlabs.com/thesis`. The app should run with
`RAILS_RELATIVE_URL_ROOT=/thesis` from the start so route and asset assumptions
do not drift.

Worker placement follows `docs/operations/worker_droplet_policy.md`.
ThesisRecord does not need a dedicated worker droplet for the current
low-frequency evidence/checkpoint jobs. Product worker droplets stay dedicated;
the only planned shared worker is a future SourceGrid Ops Agent for internal
operations jobs.

## Service Shape

Expected production process names:

- web unit: `thesis-record-web.service`
- worker unit: `thesis-record-sidekiq.service`
- Sidekiq process name: `thesis-record-sidekiq`
- Redis namespace: `thesis-record-production`

Expected app paths:

- app directory: `/var/www/thesis-record/thesis_record_app`
- env file: `/etc/thesis-record/thesis-record.env`
- backup manifest path: `/var/backups/thesis-record/thesis-record`

Current interim deployment on `sourcecombatives-web` uses user-level systemd
because passwordless sudo is not available from the deployment session:

- app directory: `/home/jimmy1768_user/Projects/thesis-record/thesis_record_app`
- env file: `/home/jimmy1768_user/.config/thesis-record/thesis-record.env`
- service examples:
  `thesis_record_app/config/deploy/systemd/user/`
- service manager: `systemctl --user`
- process supervision: enabled user services with linger already active

Promote to the root-owned paths above when sudo access is available.

## Required Environment

The server env file must be created on the droplet only. Do not commit real
values.

Required values:

- `RAILS_ENV=production`
- `RAILS_FORCE_SSL=false`
- `RAILS_RELATIVE_URL_ROOT=/thesis`
- `PORT=3400`
- `THESIS_RECORD_BIND=127.0.0.1`
- `DATABASE_URL`
- `REDIS_URL`
- `SECRET_KEY_BASE`

Optional but expected for bootstrap:

- `THESIS_RECORD_ADMIN_EMAIL`
- `THESIS_RECORD_ADMIN_PASSWORD`
- `THESIS_RECORD_ADMIN_ROLE=research_admin`
- `THESIS_RECORD_BOOTSTRAP_OVERRIDE=false`

`THESIS_RECORD_ALLOW_CANONICAL_DATA_PROMOTION` must not be set to `true` by
default.

## Initial Deployment Sequence

1. Create the `thesis-record` Linux user.
2. Install Ruby, Bundler, PostgreSQL client libraries, Redis, and systemd units.
3. Place the app at `/var/www/thesis-record/thesis_record_app`.
4. Create `/etc/thesis-record/thesis-record.env` with real server-only values.
5. Install the sanitized systemd units from
   `thesis_record_app/config/deploy/systemd/`.
6. Run database migrations against production PostgreSQL.
7. Run deployment verification:

   ```bash
   bin/rails operator:verify_operations_policy
   bin/rails operator:verify_deployment_config
   bin/rails operator:health_check
   ```

8. Start services:

   ```bash
   sudo systemctl start thesis-record-web.service
   sudo systemctl start thesis-record-sidekiq.service
   ```

9. Verify services:

   ```bash
   sudo systemctl status thesis-record-web.service
   sudo systemctl status thesis-record-sidekiq.service
   curl -fsS http://127.0.0.1:3400/up
   ```

10. For operator browser access before nginx:

    ```bash
    ssh -L 3400:127.0.0.1:3400 <droplet>
    ```

    Use the tunnel for private checks only. The initial raw Puma verification is
    `http://127.0.0.1:3400/up`; do not assume the public `/thesis` browser path
    is reachable until nginx or another mount layer is added.

## User-Level Systemd Fallback

Use this fallback only when root-owned systemd installation is blocked by sudo.
It is acceptable for the current private runtime because the SSH user has
systemd user services and linger enabled.

Install service files:

```bash
mkdir -p ~/.config/systemd/user
cp thesis_record_app/config/deploy/systemd/user/thesis-record-web.service.example \
  ~/.config/systemd/user/thesis-record-web.service
cp thesis_record_app/config/deploy/systemd/user/thesis-record-sidekiq.service.example \
  ~/.config/systemd/user/thesis-record-sidekiq.service
systemctl --user daemon-reload
systemctl --user enable --now thesis-record-web.service thesis-record-sidekiq.service
```

Verify:

```bash
systemctl --user status thesis-record-web.service
systemctl --user status thesis-record-sidekiq.service
curl -fsS http://127.0.0.1:3400/up
bin/rails operator:verify_operations_policy
bin/rails operator:verify_deployment_config
bin/rails operator:health_check
```

This fallback does not replace the final root-owned service target. Before a
public web surface is enabled, move the app/env/services to the root-owned
paths or explicitly accept the operational risk.

## Routine Production Summary

Use the read-only production summary task for a quick operator check after
deploys, data promotions, service restarts, and before starting a new evidence
workflow:

```bash
bin/rails operator:production_summary
```

The task reports app health, deployment environment assumptions, key evidence
table counts, the latest audit event timestamp, and warnings such as missing
operator users or accidental canonical data-promotion enablement. It must not
print secret values.

## Data Promotion Guardrails

Production PostgreSQL is the only canonical system of record.

Local databases are development and rehearsal stores only. Rows captured locally
may be promoted only through a reviewed migration manifest.

Before moving local captured data to production:

1. Identify the exact source local database and table set.
2. Export only approved structured rows; do not export local raw private files.
3. Create a migration manifest with source DB, export timestamp, table names,
   row counts, checksums where possible, exclusions, and reviewer approval.
4. Take a production PostgreSQL backup before import.
5. Import into production PostgreSQL.
6. Reconcile source row counts to production row counts.
7. Run:

   ```bash
   bin/rails operator:health_check
   bin/rails public_sources:source_health_summary
   ```

8. Record the promotion as an operator return before treating the rows as
   production evidence records.

Do not set `THESIS_RECORD_ALLOW_CANONICAL_DATA_PROMOTION=true` as a standing
environment value. If a future task uses it, it must be one-shot and tied to a
reviewed manifest.

## Nginx Position

Nginx is not required for this stage because ThesisRecord does not yet need a
public web surface. Puma should bind to localhost on `3400`, and operators can
verify through SSH.

Add nginx only when one of these becomes true:

- a public browser surface is approved;
- TLS termination is needed for non-tunneled access;
- static asset serving or request buffering becomes operationally necessary;
- sourcegridlabs.com routing is ready to expose `/thesis`.

When nginx/TLS is introduced, update the environment and policy in the same
slice; do not turn on `RAILS_FORCE_SSL=true` while Puma is only verified over
plain localhost.
