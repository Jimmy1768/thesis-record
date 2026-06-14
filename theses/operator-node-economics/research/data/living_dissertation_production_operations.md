# Living Dissertation Production Operations

Status: operations scaffold. Not deployment record, secret store, production
credential, data ingestion authorization, security certification, paper prose,
or thesis evidence.

Run date: 2026-06-12.

## Canonical Defaults

Adjustable operations defaults are controlled by:

- `thesis_record_app/config/thesis_record_policy.yml`

This runbook explains how to operate those defaults. Change the policy file
first when changing cadence, thresholds, bootstrap env names, or ingestion
defaults.

## V1 Production Shape

Default V1 shape:

- one DigitalOcean droplet or equivalent host;
- Rails app;
- production PostgreSQL as structured private-data system of record;
- Redis for Sidekiq;
- Sidekiq for scheduled jobs;
- systemd or equivalent process supervision;
- secrets loaded from server environment or a managed secret store.

No production secrets, database URLs, API keys, SSH keys, dumps, or raw private
rows belong in Git.

## Required Environment Variables

The first admin bootstrap task reads the variable names defined in the policy
file. Current V1 names:

- `LIVING_DISSERTATION_ADMIN_EMAIL`
- `LIVING_DISSERTATION_ADMIN_PASSWORD`
- `LIVING_DISSERTATION_ADMIN_ROLE`
- `LIVING_DISSERTATION_BOOTSTRAP_OVERRIDE`

Runtime variables should be stored only in server environment configuration or
a managed secret store. Do not commit an env file containing real values.

## Admin Bootstrap

One-time bootstrap command:

```sh
bin/rails operator:bootstrap_admin
```

Behavior:

- reads admin email/password/role from environment variables;
- creates the role if needed;
- creates or updates the target user;
- marks the user active;
- writes an audit event;
- refuses to run when an admin already exists unless the explicit override
  environment flag is set.

This task should be used only during initial production setup or intentional
admin recovery.

## Operations Guardrail Check

Guardrail command:

```sh
bin/rails operator:verify_operations_policy
```

The check fails if policy defaults allow:

- private ingestion by default;
- public ingestion by default;
- laptop production-data storage;
- deployment or push authority;
- secrets in Git;
- private raw rows in Git;
- unreviewed private outputs in Git;
- private ingestion before backup and restore-test requirements.

Passing this task does not prove the system is secure. It only confirms that
the current policy defaults are still conservative.

## Process Supervision

Production should supervise at least:

- Rails web process;
- Sidekiq worker process;
- PostgreSQL;
- Redis.

Sidekiq jobs remain audit-only scaffolds until a later slice explicitly enables
public ingestion. Private ingestion remains disabled until backups, restore
tests, access control, redaction, and export review are implemented.

## Backup And Restore Gate

Before any private ingestion:

- configure encrypted PostgreSQL backups;
- document backup location outside Git;
- run and record a restore test;
- verify that production dumps are not stored on the MacBook;
- verify that dumps, private rows, and client/worker/evaluator identifiers are
  ignored by Git and absent from tracked files.

## Health Checks

Minimum health checks:

- Rails boot check at `/up`;
- PostgreSQL connectivity;
- Redis connectivity;
- Sidekiq process liveness;
- scheduler config loads from policy;
- `operator:verify_operations_policy` passes.

## Hard Boundary

This runbook does not authorize:

- deployment;
- public data collection;
- private data ingestion;
- paper claims;
- publication exports;
- changing claim status;
- storing secrets in this repo.
