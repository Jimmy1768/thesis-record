# Living Dissertation Deployment Readiness

Status: deployment-readiness scaffold. Not deployment approval, production
configuration, secret store, data ingestion authorization, security
certification, paper prose, or thesis evidence.

Run date: 2026-06-12.

## Canonical Defaults

Deployment defaults are controlled by:

- `thesis_record_app/config/thesis_record_policy.yml`

Current V1 defaults include:

- Linux user: `operator-node`;
- deploy path: `/var/www/operator-node-economics/living_dissertation_app`;
- env file path: `/etc/operator-node-economics/living-dissertation.env`;
- process supervision: systemd or equivalent;
- web unit: `living-dissertation-web.service`;
- worker unit: `living-dissertation-sidekiq.service`;
- health endpoint: `/up`;
- public and private ingestion disabled by default.

## Tracked Templates

Tracked templates only:

- `living_dissertation_app/.env.production.example`
- `living_dissertation_app/config/deploy/systemd/living-dissertation-web.service.example`
- `living_dissertation_app/config/deploy/systemd/living-dissertation-sidekiq.service.example`

These files must not contain real credentials, database URLs, API keys, SSH
keys, hostnames that imply access, or private data.

## Deployment Checklist

Before deploy:

1. Provision host and create the configured Linux user.
2. Install Ruby, PostgreSQL, Redis, and system dependencies.
3. Place real environment values in the configured server env file or managed
   secret store only.
4. Install the web and Sidekiq systemd units from the templates after editing
   paths only as needed.
5. Run database setup/migrations.
6. Run `bin/rails operator:verify_operations_policy`.
7. Run `bin/rails operator:health_check`.
8. Bootstrap the first admin with `bin/rails operator:bootstrap_admin`.
9. Configure TLS before exposing the app.
10. Configure encrypted backups before any private ingestion.

## Health Check

Health-check task:

```sh
bin/rails operator:health_check
```

It verifies:

- Rails boot;
- database connection;
- Redis ping;
- Sidekiq schedule config load;
- production operations policy guardrails.

Passing this task does not authorize ingestion. It only shows that the runtime
dependencies and conservative policy settings are present.

## Backup And Restore Gate

Before public or private ingestion is enabled:

- define backup destination outside Git;
- ensure backups are encrypted;
- run at least one restore test;
- record the restore test outside secrets;
- confirm production dumps are not stored on the MacBook;
- keep raw private records out of Git permanently.

## Hard Boundary

This readiness scaffold does not deploy, push, fetch public files, ingest
private data, compute metrics, export evidence, or change claim status.
