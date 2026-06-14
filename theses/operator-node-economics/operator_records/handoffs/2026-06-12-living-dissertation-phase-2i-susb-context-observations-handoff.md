# Living Dissertation Phase 2I SUSB Context Observations Handoff

## Target

- Repo: operator-node-economics
- Worktree path: `/Users/jimmy1768/Projects/operator-node-economics`
- Branch: `main`
- Branch role: main
- Expected HEAD: `ae1ce686b5031207c8e844294b835fe989eec8de`
- Allowed dirty state: clean before implementation; scoped dirty state during implementation
- Target merge branch: `main`
- Push/OTA/deploy authority: none
- Sync-back: not applicable

## Scope

Implement Phase 2I: first-pass SUSB context observations.

Required:

- Compute `MetricObservation` rows only from staged SUSB rows where
  `ENTRSIZE=01`.
- Use the 2H V1 policy defaults.
- Map SUSB noise flags to policy-defined statuses.
- Exclude D/S suppressed or blocked cells from observation creation.
- Keep SUSB observations as employer-side context only.
- Do not compute ratios, trends, aggregation, productivity measures, exports,
  or claim support.
- Make the task idempotent.
- Add tests and a return record.

## Boundaries

- Do not edit `paper/draft.md`.
- Do not ingest private data.
- Do not fetch public files.
- Do not link observations to claims.
- Do not create exports.
- Do not decide or promote the thesis.
- Do not add secrets or production credentials.
- Do not push or deploy.

## Return Required

Write `docs/operator/returns/2026-06-12-living-dissertation-phase-2i-susb-context-observations-return.md`
with:

- files changed;
- observation rules applied;
- task behavior;
- actual observation counts/status counts;
- verification commands/results;
- confirmation no ratios/trends/exports/claims/private data/secrets/paper prose were added;
- remaining gaps before quality review/export/claim use.
