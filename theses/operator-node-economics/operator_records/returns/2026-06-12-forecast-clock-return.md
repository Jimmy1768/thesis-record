# Forecast Clock Return

Run date: 2026-06-12.

## Task

Record the forecast-versioning decision that the living dissertation should use
quarters as the smallest measurement atom, annual public evidence snapshots,
and 3-, 5-, and 10-year thesis checkpoints.

## Files Changed

- `research/forecast_versioning_framework.md`
- `research/living_forecast_system.md`
- `research/predictions.md`
- `docs/operator/returns/2026-06-12-forecast-clock-return.md`

## Decision Recorded

The forecast program now uses this default clock:

- `T0`: V1 publication date and frozen forecast baseline.
- `T0 + 4 quarters`: annual evidence snapshot 1.
- `T0 + 8 quarters`: annual evidence snapshot 2.
- `T0 + 12 quarters`: V2, the 3-year early structural-signal checkpoint.
- `T0 + 16 quarters`: annual evidence snapshot 4.
- `T0 + 20 quarters`: V3, the 5-year intermediate thesis checkpoint.
- `T0 + 40 quarters`: V4, the 10-year major structural-verdict checkpoint.

Quarterly updates are measurement updates, not thesis verdicts. Annual
snapshots can report directional movement. V2, V3, and V4 are the scheduled
thesis checkpoints.

## Verdict Categories Added

- `directionally_consistent`
- `mixed`
- `adverse`
- `inconclusive`
- `checkpoint_supported`
- `checkpoint_weakened`
- `checkpoint_contradicted`

## Guardrails Added

- Do not use a single quarter as a thesis verdict.
- Do not re-time checkpoints after seeing evidence.
- Do not treat missing or lagged data as support.
- Record business-cycle and macro conditions at scheduled checkpoints.
- Preserve adverse evidence and publish scheduled updates.

## Status Flags

`claim_support_updated=false`
`private_data_ingested=false`
`paper_prose_updated=false`

## Verification

Commands run after edits:

- `git diff -- paper/draft.md` returned no output.
- `git diff --check` passed.
- guardrail term scan across changed files returned no content matches.
- forecast-clock scan confirmed the 12-, 20-, and 40-quarter checkpoints,
  verdict categories, business-cycle control rule, and quarterly measurement
  cadence.
