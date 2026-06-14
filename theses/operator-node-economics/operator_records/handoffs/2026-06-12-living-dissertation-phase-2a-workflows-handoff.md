# Living Dissertation Phase 2A Workflow Scaffold Handoff

## Target

- Repo: operator-node-economics
- Worktree path: `/Users/jimmy1768/Projects/operator-node-economics`
- Branch: `main`
- Branch role: main
- Expected HEAD: `9351fa710fe91972d4ebdb12334139e189c5859e`
- Allowed dirty state: clean before implementation; scoped dirty state while implementing this handoff
- Target merge branch: `main`
- Push/OTA/deploy authority: none
- Sync-back: not applicable

## Role

Research owns this implementation slice because it is evidence-system infrastructure and data-architecture workflow. This is not a paper-writing slice.

## Scope

Implement Phase 2A of the living dissertation Rails app:

1. Add authenticated operator access for the local Rails app.
2. Add source registry workflows for creating and updating `DataSource` records through audited service objects.
3. Add intake manifest workflows for creating and updating `IntakeManifest` records through audited service objects.
4. Preserve storage-zone, privacy-classification, secret-material, redaction, human-review, and public-repo guardrails.
5. Add Sidekiq scheduler scaffolding for future periodic collection/checkpoint work, but do not run or enable private-data ingestion.
6. Add tests covering authentication, audited source creation/update, audited intake creation/update, and scheduler job no-op audit behavior.

## Explicit Non-Scope

- Do not edit `paper/draft.md`.
- Do not ingest private data.
- Do not store secrets, Census API keys, DB URLs, SSH keys, or production credentials.
- Do not deploy or push.
- Do not run quantitative analysis.
- Do not write paper prose or paper conclusions.
- Do not promote or decide the Operator Node thesis.
- Do not add philosophical or religious foundations.

## Implementation Notes

- Keep all private-data-related workflows fail-closed and audit-first.
- New workflow code should use service objects rather than direct controller writes.
- Scheduler jobs should only create audit/checkpoint records for now. They must not fetch data, call external APIs, or touch production-only storage.
- Scheduled cadence should reflect prior research guidance: quarterly checkpoints are the base economic-time unit, with separate source-release and annual snapshot scaffolds.

## Verification Required

- `bundle install` if Gemfile changes.
- `bin/rails test`
- `RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false`
- `bundle exec brakeman --no-pager --no-exit-on-warn`
- `git diff --check`
- `git diff -- paper/draft.md` must show no output.
- Secret scan for API keys, database URLs, private keys, and obvious credential strings in changed files.

## Return Required

Write `docs/operator/returns/2026-06-12-living-dissertation-phase-2a-workflows-return.md` with:

- files changed;
- implementation summary;
- scheduler jobs added and their cadence;
- tests/verification commands and results;
- explicit confirmation that no private data was ingested;
- explicit confirmation that no secrets were added;
- explicit confirmation that `paper/draft.md` remained untouched;
- remaining gaps before Phase 2B.
