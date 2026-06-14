# Living Dissertation Phase 2B Production Operations Return

## Status

Completed.

## Files Changed

- `docs/operator/handoffs/2026-06-12-living-dissertation-phase-2b-production-ops-handoff.md`
- `docs/operator/returns/2026-06-12-living-dissertation-phase-2b-production-ops-return.md`
- `living_dissertation_app/app/models/audit_event.rb`
- `living_dissertation_app/app/services/operations/policy_check.rb`
- `living_dissertation_app/app/services/operators/bootstrap_admin.rb`
- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/lib/tasks/operator.rake`
- `living_dissertation_app/test/services/operations/policy_check_test.rb`
- `living_dissertation_app/test/services/operators/bootstrap_admin_test.rb`
- `research/data/living_dissertation_application_build_plan.md`
- `research/data/living_dissertation_production_operations.md`

## Bootstrap Task Behavior

Added:

- `bin/rails operator:bootstrap_admin`

Behavior:

- reads admin email, password, role, and override variable names from
  `living_dissertation_app/config/living_dissertation_policy.yml`;
- creates the configured role if needed;
- creates or updates the target active admin user;
- enforces the configured minimum password length;
- writes an `operator_admin_bootstrapped` audit event;
- refuses to run when an admin already exists unless
  `LIVING_DISSERTATION_BOOTSTRAP_OVERRIDE` is truthy.

No actual production admin was created by this slice.

## Operations Guardrail Behavior

Added:

- `bin/rails operator:verify_operations_policy`

Behavior:

- checks that production PostgreSQL remains the structured private-data system
  of record;
- checks that secrets remain server-env/managed-secret-store only;
- checks that backup and restore-test requirements remain enabled before
  private ingestion;
- checks that public and private ingestion remain disabled by default;
- checks that production laptop storage, push/deploy authority, secrets in
  Git, raw private rows in Git, and unreviewed private outputs in Git remain
  disabled;
- writes an `operations_policy_checked` audit event when the policy passes.

Operational smoke test result:

- `bin/rails operator:verify_operations_policy`
  - Result: passed.
  - Output: `Operations policy guardrails passed`.
  - Note: this wrote one local development audit event only; it did not ingest
    data or connect to production.

## Runbooks Added

Added:

- `research/data/living_dissertation_production_operations.md`

The runbook documents:

- V1 production shape;
- environment-variable policy;
- admin bootstrap;
- operations guardrail check;
- process supervision expectations;
- backup/restore gate;
- health checks;
- hard boundaries against deployment, ingestion, paper claims, exports, and
  secrets in Git.

Updated the application build plan to reference this runbook as a prerequisite
before private ingestion.

## Verification

- `bin/rails test`
  - Result: passed.
  - Output: 24 runs, 90 assertions, 0 failures, 0 errors, 0 skips.
- `bin/rails operator:verify_operations_policy`
  - Result: passed.
  - Output: `Operations policy guardrails passed`.
- `RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false`
  - Result: passed.
  - Output: 72 files inspected, no offenses detected.
- `bundle exec brakeman --no-pager --no-exit-on-warn`
  - Result: passed with no code warnings.
  - Residual warnings: Ruby 3.2.3 support ended on 2026-03-31; Rails 7.2.3.1 support ends on 2026-08-09.
- `git diff --check`
  - Result: passed with no output.
- `git diff -- paper/draft.md`
  - Result: passed with no output.
- Changed-path secret scan:
  - Command: `rg -n "(BEGIN (RSA|OPENSSH|PRIVATE) KEY|DATABASE_URL=|postgres://[^\\s]+:[^\\s]+@|sk-[A-Za-z0-9]{20,}|AIza[0-9A-Za-z_-]{20,}|AKIA[0-9A-Z]{16})" docs/operator/handoffs/2026-06-12-living-dissertation-phase-2b-production-ops-handoff.md living_dissertation_app research/data/living_dissertation_application_build_plan.md research/data/living_dissertation_production_operations.md`
  - Result: passed with no matches.

## Private Data And Secrets

- No private data was ingested.
- No public dataset was collected.
- No production database connection was used.
- No API keys, database URLs, SSH keys, private keys, or credentials were
  added.
- Test-only password strings were added only inside service tests.

## Paper Boundary

- `paper/draft.md` remained untouched.
- No paper prose, thesis conclusion, claim promotion, or publication text was
  added.

## Remaining Gaps Before Enabling Public Ingestion

- No actual production host has been provisioned or deployed.
- No systemd unit files or process manager configuration have been installed
  on a server.
- No TLS/domain configuration has been created.
- No encrypted backup job or restore-test record exists yet.
- No production admin has been bootstrapped.
- No public-source fetcher has been authorized or enabled.
- Private ingestion remains blocked until production storage, access control,
  backup, restore, redaction, aggregation, and export-review paths are proven.
