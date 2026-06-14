# Living Dissertation Phase 2K: SUSB Quality Review Storage Handoff

Role: Research / infrastructure.

Scope: add separate review-state storage for SUSB context observations.

## Task

Implement `metric_quality_reviews` as the first review ledger for SUSB context
observations.

Create or update:

- Rails migration and schema for `metric_quality_reviews`;
- `MetricQualityReview` model and associations;
- SUSB quality-review creation service;
- `public_sources:susb:create_quality_reviews` task;
- focused tests;
- SUSB data-architecture docs;
- a return record under `docs/operator/returns/`.

## Required Boundaries

- Do not edit `paper/draft.md`.
- Do not write paper prose.
- Do not run quantitative analysis.
- Do not create public exports.
- Do not create prediction links.
- Do not mutate `metric_observations`.
- Do not convert SUSB into AI, Operator Node, transaction-cost, productivity, or
  claim-support evidence.
- Do not add private data, secrets, or credentials.
- Do not push or deploy.

## Review Mapping

- `staged_context` -> `reviewed_context`
- `quality_review_required` -> `reviewed_with_high_noise`
- `blocked_noise_or_suppression` -> `excluded_noise_or_suppression`

The first implementation may not create rows for blocked cells if no blocked
`metric_observations` exist.

## Return Required

Return with:

- files changed;
- schema added;
- task behavior;
- review counts from local run if executed;
- tests and verification commands;
- whether `paper/draft.md` remained untouched;
- whether the slice was committed locally.
