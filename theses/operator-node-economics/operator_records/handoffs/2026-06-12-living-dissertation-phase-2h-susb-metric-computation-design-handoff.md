# Living Dissertation Phase 2H SUSB Metric Computation Design Handoff

## Target

- Repo: operator-node-economics
- Worktree path: `/Users/jimmy1768/Projects/operator-node-economics`
- Branch: `main`
- Branch role: main
- Expected HEAD: `edd7a70d20cddcdc745e2d3279af8483f53950fd`
- Allowed dirty state: clean before implementation; scoped dirty state during implementation
- Target merge branch: `main`
- Push/OTA/deploy authority: none
- Sync-back: not applicable

## Scope

Implement Phase 2H: SUSB metric-computation design with V1 defaults.

Required:

- Add V1 computation-design defaults to the centralized policy file.
- Add a validator/task that confirms the SUSB metric design remains
  conservative before any future computation.
- Add a design doc.
- Add tests.

## Boundaries

- Do not edit `paper/draft.md`.
- Do not create `MetricObservation` rows.
- Do not compute metrics, ratios, aggregates, panels, trends, or exports.
- Do not link metrics to claims.
- Do not ingest private data.
- Do not add secrets or production credentials.
- Do not push or deploy.

## Return Required

Write `docs/operator/returns/2026-06-12-living-dissertation-phase-2h-susb-metric-computation-design-return.md`
with:

- files changed;
- V1 defaults set;
- validator/task behavior;
- verification commands/results;
- confirmation no observations/computation/analysis/claims/private data/secrets/paper prose were added;
- remaining gaps before 2I.
