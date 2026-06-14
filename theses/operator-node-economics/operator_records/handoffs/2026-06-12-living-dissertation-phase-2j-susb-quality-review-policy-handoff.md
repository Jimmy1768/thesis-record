# Living Dissertation Phase 2J: SUSB Quality Review Policy Handoff

Role: Research / infrastructure.

Scope: define the first SUSB quality-review policy layer before adding
review-state storage, exports, ratios, trends, aggregation, or claim support.

## Task

Implement a conservative quality-review policy for SUSB context observations.

Create or update:

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/app/services/public_sources/susb/quality_review_policy_check.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/susb/quality_review_policy_check_test.rb`
- `research/data/susb_quality_review_policy.md`
- related SUSB data-architecture docs if cross-references need correction
- a return record under `docs/operator/returns/`

## Required Boundaries

- Do not edit `paper/draft.md`.
- Do not write paper prose.
- Do not run quantitative analysis.
- Do not create public exports.
- Do not convert SUSB into AI, Operator Node, transaction-cost, productivity, or
  claim-support evidence.
- Do not add private data, secrets, or credentials.
- Do not push or deploy.

## Policy Requirements

Centralize V1 statuses in `living_dissertation_policy.yml`:

- `reviewed_context`
- `reviewed_with_high_noise`
- `excluded_noise_or_suppression`
- `excluded_policy_violation`
- `needs_manual_review`

Preserve SUSB context-observation boundaries:

- source row identity required;
- row hash required;
- source-native grain preserved;
- ratios/trends/aggregation flags remain false;
- export and claim-support flags remain false.

Recommend later review-state storage as a separate `metric_quality_reviews`
table rather than mutating `metric_observations`.

## Return Required

Return with:

- files changed;
- policy defaults added;
- validator behavior;
- tests and verification commands;
- whether `paper/draft.md` remained untouched;
- whether the slice was committed locally.
