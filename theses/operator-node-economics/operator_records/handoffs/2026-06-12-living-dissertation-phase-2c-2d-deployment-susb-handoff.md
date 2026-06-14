# Living Dissertation Phase 2C/2D Deployment And SUSB Scaffold Handoff

## Target

- Repo: operator-node-economics
- Worktree path: `/Users/jimmy1768/Projects/operator-node-economics`
- Branch: `main`
- Branch role: main
- Expected HEAD: `5eebe289f5807da193c8268c290ff28ee11bd300`
- Allowed dirty state: clean before implementation; scoped dirty state during implementation
- Target merge branch: `main`
- Push/OTA/deploy authority: none
- Sync-back: not applicable

## Role

Research owns this slice because it implements evidence-system operations and
public-source ingestion architecture. This is not a paper-writing slice.

## Scope

Implement two conservative phases using centralized V1 policy values.

### Phase 2C: Deployment-Readiness Scaffold

- Add environment-variable example file with names only, no real values.
- Add systemd template files for Rails/Puma and Sidekiq.
- Add deployment checklist/runbook.
- Add backup and restore-test scaffold tasks or docs.
- Add health-check service/task covering Rails boot, DB connection, Redis
  connectivity, Sidekiq config load, and operations policy.
- Keep adjustable values in
  `living_dissertation_app/config/living_dissertation_policy.yml`.

### Phase 2D: SUSB Public-File Ingestion Scaffold

- Use SUSB public-file ingestion scaffold as the first dataset.
- Register SUSB U.S./state annual public-file source metadata, official access
  path, intake manifest, and verified schema fields without fetching raw data.
- Keep raw public file storage outside Git.
- Do not compute metrics.
- Do not change claim status.
- Keep SUSB as employer-side public context/source evidence only, not AI,
  nonemployer, management-layer, transaction-cost, or one-person-firm evidence.

## Explicit Non-Scope

- Do not edit `paper/draft.md`.
- Do not deploy or push.
- Do not add secrets, database URLs, API keys, SSH keys, production env values,
  or production config.
- Do not fetch public files in this slice.
- Do not ingest private data.
- Do not compute metrics or run analysis.
- Do not promote claims or decide the Operator Node thesis.
- Do not write paper prose or conclusions.

## Verification Required

- `bin/rails test`
- `bin/rails operator:verify_operations_policy`
- health-check dry-run or unit tests
- SUSB scaffold unit tests
- `RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false`
- `bundle exec brakeman --no-pager --no-exit-on-warn`
- `git diff --check`
- `git diff -- paper/draft.md` must show no output.
- Changed-path secret scan.

## Return Required

Write `docs/operator/returns/2026-06-12-living-dissertation-phase-2c-2d-deployment-susb-return.md`
with:

- files changed;
- 2C implementation summary;
- 2D implementation summary;
- V1 defaults used;
- verification commands/results;
- confirmation no raw files were fetched;
- confirmation no private data was ingested;
- confirmation no secrets were added;
- confirmation `paper/draft.md` remained untouched;
- remaining gaps before public ingestion is actually enabled.
