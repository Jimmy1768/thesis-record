# Living Dissertation Phase 2G SUSB Metric Definition Handoff

## Target

- Repo: operator-node-economics
- Worktree path: `/Users/jimmy1768/Projects/operator-node-economics`
- Branch: `main`
- Branch role: main
- Expected HEAD: `0166051c2e0b882be4bf678dae8809c4f45d0855`
- Allowed dirty state: clean before implementation; scoped dirty state during implementation
- Target merge branch: `main`
- Push/OTA/deploy authority: none
- Sync-back: not applicable

## Scope

Implement Phase 2G: SUSB metric-definition scaffold only.

Required:

- Define conservative draft SUSB metric definitions in the centralized policy
  file.
- Add an idempotent Rails service and task to create/update `MetricDefinition`
  rows from policy.
- Keep all definitions disabled/draft and context-only.
- Do not create `MetricObservation` rows.
- Do not compute metrics, ratios, aggregates, panels, or trends.
- Do not link metrics to claim support.
- Add tests and a return record.

## Boundaries

- Do not edit `paper/draft.md`.
- Do not ingest private data.
- Do not fetch public files.
- Do not parse/load SUSB rows.
- Do not compute observations.
- Do not promote claims or decide the thesis.
- Do not add secrets or production credentials.
- Do not push or deploy.

## Return Required

Write `docs/operator/returns/2026-06-12-living-dissertation-phase-2g-susb-metric-definition-return.md`
with:

- files changed;
- metric definitions scaffolded;
- task behavior;
- verification commands/results;
- confirmation no observations/metrics were computed;
- confirmation no private data/secrets/paper prose were added;
- remaining gaps before 2F/2H.
