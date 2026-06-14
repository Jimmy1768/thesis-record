# Living Dissertation Phase 2E SUSB Fetch Validation Handoff

## Target

- Repo: operator-node-economics
- Worktree path: `/Users/jimmy1768/Projects/operator-node-economics`
- Branch: `main`
- Branch role: main
- Expected HEAD: `9656f45b443b7502870cbabbbefedff659700699`
- Allowed dirty state: clean before implementation; scoped dirty state during implementation
- Target merge branch: `main`
- Push/OTA/deploy authority: none
- Sync-back: not applicable

## Scope

Implement Phase 2E: SUSB public-file fetch dry run and validation.

Required:

- fetch or validate the official Census SUSB 2022 U.S./state public file under
  ignored `data/raw/susb/2022/`;
- compute byte size and SHA-256;
- validate exact header, required fields, row count, row width, duplicate row
  grain, and noise flags;
- reconcile against tracked manifest metadata;
- update Rails metadata/audit status only;
- add a Rails task for repeatable dry-run validation;
- add tests.

## Boundaries

- Do not edit `paper/draft.md`.
- Do not ingest private data.
- Do not add secrets or production credentials.
- Do not compute metrics, ratios, panels, or analysis.
- Do not promote claims or change claim status.
- Do not push or deploy.

## Return Required

Write `docs/operator/returns/2026-06-12-living-dissertation-phase-2e-susb-fetch-validation-return.md`
with:

- files changed;
- exact fetch/validation performed;
- manifest reconciliation result;
- DB metadata/audit behavior;
- verification commands/results;
- confirmation no private data/secrets/claims/paper prose were added;
- remaining gaps before parser/metric phases.
