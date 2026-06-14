# Living Dissertation Phase 2B Production Operations Scaffold Handoff

## Target

- Repo: operator-node-economics
- Worktree path: `/Users/jimmy1768/Projects/operator-node-economics`
- Branch: `main`
- Branch role: main
- Expected HEAD: `4e2f09576f833429a5e52230d02b56722fe6143b`
- Allowed dirty state: clean before implementation; scoped dirty state during implementation
- Target merge branch: `main`
- Push/OTA/deploy authority: none
- Sync-back: not applicable

## Role

Research owns this infrastructure slice because it controls evidence-system
operations, source governance, privacy boundaries, and auditability. This is
not a paper-writing slice.

## Scope

Implement Phase 2B: production operations scaffold.

Required implementation:

1. Add a one-time admin bootstrap path using environment variables, with a
   refusal guard when an admin already exists unless explicit override is set.
2. Add an operations guardrail check that reports whether production operations
   defaults still keep ingestion disabled and secrets/private rows out of Git.
3. Add runbook documentation for production env/secrets loading, Sidekiq/Redis
   process supervision, backup/restore, and health checks.
4. Keep all adjustable operations values tied to
   `living_dissertation_app/config/living_dissertation_policy.yml`.
5. Add tests for bootstrap guardrails and operations policy checks.

## Explicit Non-Scope

- Do not edit `paper/draft.md`.
- Do not deploy.
- Do not push.
- Do not add secrets, database URLs, API keys, SSH keys, or production config.
- Do not ingest public or private data.
- Do not enable collection jobs.
- Do not write paper prose or conclusions.
- Do not decide or promote the Operator Node thesis.

## Verification Required

- `bin/rails test`
- `RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false`
- `bundle exec brakeman --no-pager --no-exit-on-warn`
- `git diff --check`
- `git diff -- paper/draft.md` must show no output.
- Changed-path secret scan.

## Return Required

Write `docs/operator/returns/2026-06-12-living-dissertation-phase-2b-production-ops-return.md`
with:

- files changed;
- bootstrap task behavior;
- operations guardrail behavior;
- runbooks added;
- verification commands/results;
- confirmation that no private data was ingested;
- confirmation that no secrets were added;
- confirmation that `paper/draft.md` remained untouched;
- remaining gaps before enabling public ingestion.
