# Evidence Gate Pipeline Return

Run date: 2026-06-12.

## Task

Record the rule that evidence must be collected, verified, validated,
calculated, classified, reviewed, and only then published or used to change
claim status.

## Files Changed

- `research/living_forecast_system.md`
- `research/data/living_dissertation_application_build_plan.md`
- `research/forecast_versioning_framework.md`
- `docs/operator/returns/2026-06-12-evidence-gate-pipeline-return.md`

## Decision Recorded

The living dissertation now has a locked evidence pipeline:

`collect -> verify -> validate -> compute -> classify -> review -> publish`

The forbidden shortcut is:

`collect -> interpret -> write`

## Gate Summary

- Collection can record source/data existence, retrieval timestamps, checksums,
  access paths, and source metadata.
- Verification checks source reality, citation, access path, source-note
  status, version/date, schema documentation, and limitations.
- Validation checks fields, units, time period, geography, industry
  granularity, missing/suppressed cells, private identifiers, and schema
  version.
- Metric calculation is math only and cannot contain thesis interpretation.
- Evidence classification identifies what a metric can speak to without
  deciding the thesis.
- Human review is required for prediction or claim-status changes.
- Publication can use only reviewed evidence.

## Guardrails Preserved

- Automated jobs may collect, validate, calculate, classify candidates, and
  prepare reviewed exports.
- Automated jobs may not update claim status, thesis status, or paper prose.
- No private data ingestion is authorized.
- No paper prose is added.

## Status Flags

`claim_support_updated=false`
`private_data_ingested=false`
`paper_prose_updated=false`

## Verification

Commands run after edits:

- `git diff -- paper/draft.md` returned no output.
- `git diff --check` passed.
- guardrail term scan across changed files returned no content matches.
- pipeline scan confirmed the required order and forbidden shortcut are present
  in the architecture and build-plan files.
