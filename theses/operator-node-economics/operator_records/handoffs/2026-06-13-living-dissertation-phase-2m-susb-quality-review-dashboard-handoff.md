# Living Dissertation Phase 2M: SUSB Quality Review Dashboard Handoff

Role: Research / infrastructure.

Scope: add an authenticated, read-only Rails page for the SUSB quality-review
summary.

## Task

Expose the existing SUSB quality-review summary service through a guarded
internal page.

Create or update:

- controller and route for the SUSB quality-review summary;
- read-only view/partial;
- navigation link from the internal data-source index;
- integration tests proving authentication, research-operator authorization,
  and no writes;
- SUSB data-architecture docs;
- a return record under `docs/operator/returns/`.

## Required Boundaries

- Do not edit `paper/draft.md`.
- Do not write paper prose.
- Do not run quantitative analysis.
- Do not create public exports or downloadable files.
- Do not create prediction links.
- Do not mutate `metric_observations`.
- Do not mutate `metric_quality_reviews`.
- Do not write audit events from the dashboard.
- Do not convert SUSB into AI, Operator Node, transaction-cost, productivity, or
  claim-support evidence.
- Do not add private data, secrets, or credentials.
- Do not push or deploy.

## Return Required

Return with:

- files changed;
- route/page added;
- access-control behavior;
- local dashboard summary behavior;
- tests and verification commands;
- whether `paper/draft.md` remained untouched;
- whether the slice was committed locally.
