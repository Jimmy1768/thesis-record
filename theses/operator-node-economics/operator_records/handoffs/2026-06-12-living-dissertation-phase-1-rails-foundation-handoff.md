# Living Dissertation Phase 1 Rails Foundation Handoff

record_id: handoff-2026-06-12-living-dissertation-phase-1-rails-foundation
record_type: handoff
workflow_id: workflow-2026-06-12-living-dissertation-phase-1-rails-foundation
repo_id: operator-node-economics
node_id: jimmy-local
mode: manual_operational_v1
created_at: 2026-06-12
status: submitted

## OperatorKit Target Block

Repo: operator-node-economics
Worktree path: `/Users/jimmy1768/Projects/operator-node-economics`
Branch: `main`
Branch role: main
Expected HEAD: `162c44144fea5537a854731478bdbb64354a7912`
Allowed dirty state: clean before implementation; scoped dirty state during implementation
Target merge branch: `main`
Push/OTA/deploy authority: none
Sync-back requirement: not applicable; work is on `main`

## Task

Implement Phase 1 of the living dissertation application foundation.

This is infrastructure scaffolding only. It should create a Rails/PostgreSQL
and Sidekiq-ready foundation with audit, storage-classification, source
registry, and intake-manifest model shape, but no private data ingestion.

## Read First

- `research/data/living_dissertation_application_build_plan.md`
- `research/data/private_storage_classification_matrix.md`
- `research/data/audit_trail_minimum_design.md`
- `research/data/failure_as_first_class_output_policy.md`
- `research/data/private_data_governance.md`
- `research/living_forecast_system.md`

## Scope

Create a contained Rails application scaffold inside this repository.

Required implementation targets:

- Rails application configured for PostgreSQL.
- Sidekiq dependency and configuration.
- no production credentials or secrets in Git.
- no private data ingestion path.
- baseline models/migrations for:
  - users and roles;
  - audit events;
  - data sources;
  - source access paths;
  - intake manifests;
  - schema versions;
  - privacy reviews;
  - private artifacts metadata;
  - metric definitions;
  - metric observations;
  - quality flags;
  - prediction links;
  - claim reviews;
  - failure records;
  - evidence snapshots;
  - export artifacts.
- storage-zone and privacy-classification fields sufficient to enforce the
  storage classification matrix later.
- tests for audit-event creation and fail-closed protected actions where
  feasible in this first slice.

## Hard Boundaries

- Do not edit `paper/draft.md`.
- Do not ingest private data.
- Do not add production credentials, API keys, database URLs, SSH keys, or
  secrets.
- Do not write paper prose.
- Do not decide the Operator Node thesis is true.
- Do not promote any claim support.
- Do not deploy.
- Do not push.

## Verification Required

- Rails app boots or a clear blocker is recorded.
- Migration/schema checks run if dependencies allow.
- Relevant test suite runs if dependencies allow.
- `git diff -- paper/draft.md` returns no output.
- `git diff --check` passes.
- secret/private-data scan across changed files.
- return record under `docs/operator/returns/`.

## Expected Return

Return with:

- completed implementation summary;
- files changed;
- generated app path;
- verification commands/results;
- skipped checks and why;
- residual risks;
- worktree state;
- whether `paper/draft.md` remained untouched;
- next gap if implementation cannot continue.
