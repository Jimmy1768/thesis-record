# Living Dissertation Phase 2F SUSB Staging Parser Handoff

## Target

- Repo: operator-node-economics
- Worktree path: `/Users/jimmy1768/Projects/operator-node-economics`
- Branch: `main`
- Branch role: main
- Expected HEAD: `2c4b75cf495d9039ad53758f73bdacca54d0ffb8`
- Allowed dirty state: clean before implementation; scoped dirty state during implementation
- Target merge branch: `main`
- Push/OTA/deploy authority: none
- Sync-back: not applicable

## Scope

Implement Phase 2F: SUSB staging-table parser.

Required:

- Add a dedicated SUSB public-file staging table.
- Preserve source-native row grain and source links.
- Load validated SUSB rows idempotently.
- Preserve all noise flags before numeric coercion.
- Fail closed unless SUSB raw-file validation passes.
- Record load counts and audit metadata.
- Do not compute metrics, ratios, aggregates, panels, trends, observations, or
  claim links.

## Boundaries

- Do not edit `paper/draft.md`.
- Do not ingest private data.
- Do not add secrets or production credentials.
- Do not compute metric observations.
- Do not promote claims or decide the thesis.
- Do not push or deploy.

## Return Required

Write `docs/operator/returns/2026-06-12-living-dissertation-phase-2f-susb-staging-parser-return.md`
with:

- files changed;
- staging table schema;
- loader task behavior;
- load/QA results;
- verification commands/results;
- confirmation no observations/analysis/claims/private data/secrets/paper prose were added;
- remaining gaps before metric computation design.
