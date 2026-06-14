# Living Dissertation Phase 2L: SUSB Quality Review Summary Handoff

Role: Research / infrastructure.

Scope: add read-only inspection for SUSB quality-review storage.

## Task

Implement a terminal-only SUSB quality-review summary. This is inspection, not
analysis or export.

Create or update:

- SUSB quality-review summary service;
- `public_sources:susb:quality_review_summary` task;
- focused tests proving the summary does not write records;
- SUSB data-architecture docs;
- a return record under `docs/operator/returns/`.

## Required Boundaries

- Do not edit `paper/draft.md`.
- Do not write paper prose.
- Do not run quantitative analysis.
- Do not create public exports.
- Do not create prediction links.
- Do not mutate `metric_observations`.
- Do not mutate `metric_quality_reviews`.
- Do not write audit events from the read-only summary.
- Do not convert SUSB into AI, Operator Node, transaction-cost, productivity, or
  claim-support evidence.
- Do not add private data, secrets, or credentials.
- Do not push or deploy.

## Summary Output

The task should report:

- total review rows;
- review-status counts;
- source metric-status counts;
- metric-key counts;
- policy-version counts;
- reviewable observation count;
- unreviewed observation count;
- prohibited guardrail flag counts;
- prediction-link count;
- export-created audit-event count;
- quality-policy check result.

## Return Required

Return with:

- files changed;
- summary fields added;
- local summary output;
- tests and verification commands;
- whether `paper/draft.md` remained untouched;
- whether the slice was committed locally.
