# Failure As First-Class Output Return

Run date: 2026-06-12.

## Task

Define how the living dissertation should record, preserve, classify, review,
and publish adverse evidence, null results, missing data, failed predictions,
and thesis revisions.

## Files Changed

- `research/data/failure_as_first_class_output_policy.md`
- `research/forecast_versioning_framework.md`
- `research/living_forecast_system.md`
- `research/predictions.md`
- `research/data/living_dissertation_application_build_plan.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-12-failure-as-first-class-output-return.md`

## Decision Recorded

Failure is now treated as a primary output of the research program.

Core rule:

- a future-facing thesis has value only if it can lose;
- adverse evidence, null results, missing data, source downgrades, and failed
  predictions must be preserved and reviewed;
- privacy may require aggregation or redaction, but should not be used to hide
  thesis-adverse evidence.

## Failure Record Design

Added required failure-record fields for:

- affected prediction;
- horizon;
- failure type;
- evidence object;
- source status;
- metric status;
- observed and expected direction;
- triggered failure condition;
- alternative explanation;
- business-cycle context;
- company-case scope;
- human review status;
- publication status;
- revision action;
- audit event.

## Failure Taxonomy Added

- `adverse_indicator`
- `null_result`
- `missing_data`
- `measurement_failure`
- `timing_failure`
- `scope_failure`
- `mechanism_failure`
- `implementation_failure`
- `alternative_dominates`
- `core_theory_failure`

## Guardrails Preserved

- No private data ingestion is authorized.
- No `paper/draft.md` edits.
- No claim support changes.
- Automation may create pending failure records but cannot accept, publish, or
  use them to change claim status without human review.
- Company/network failure remains separate from broad-thesis failure unless
  evidence supports the broader classification.

## Status Flags

`failure_as_first_class_output_policy_created=true`
`private_data_ingested=false`
`claim_support_updated=false`
`paper_prose_updated=false`

## Verification

Commands run after edits:

- `git diff -- paper/draft.md` returned no output.
- `git diff --check` passed.
- guardrail term scan across changed files returned no content matches.
- failure-policy scan confirmed failure records, `adverse_indicator`,
  `null_result`, `alternative_dominates`, `core_theory_failure`, and
  `failure_as_first_class_output_policy_created=true`.
