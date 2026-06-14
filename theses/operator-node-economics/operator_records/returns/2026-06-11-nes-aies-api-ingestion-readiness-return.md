---
record_id: return-2026-06-11-nes-aies-api-ingestion-readiness
record_type: return
workflow_id: 2026-06-11-nes-aies-api-ingestion-readiness
status: completed
created_at: 2026-06-11T23:59:00+08:00
owner: Research
---

# Return: NES And AIES-NES API Ingestion Readiness

## Scope

This Research pass documented ingestion-readiness rules for Census NES 2023
and AIES-NES 2023 API responses. It verified all-class NES predicate labels,
noise fields, noise-flag attributes, schema-only response shapes, and AIES
predicate-column behavior. It did not run quantitative analysis, create an
ingestion script, create a processed panel, or write paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/nes_aies_api_ingestion_readiness.md`
- `research/data/acquisition_scaffold.md`
- `research/data/schema_mapping.md`
- `research/data/field_dictionary.md`
- `docs/operator/returns/2026-06-11-nes-aies-api-ingestion-readiness-return.md`

## Sources And API Docs Inspected

- `https://api.census.gov/data/2023/nonemp/variables/RCPSZES.json`
- `https://api.census.gov/data/2023/nonemp/variables/LFO.json`
- `https://api.census.gov/data/2023/nonemp/variables/NRCPTOT_N.json`
- `https://api.census.gov/data/2023/aiesnonemp/variables/RCPT_TOT_VAL_NS_N.json`
- Tiny key-first Census API label and schema probes using the activated key
  loaded from ignored `.env.local`; the key was not printed or committed.

## Exact Verification Performed

NES:

- `LFO=001` label verified as `All establishments`.
- `RCPSZES=001` label verified as `All establishments`.
- `NRCPTOT_N` verified as the noise range for nonemployer sales, value of
  shipments, or revenue.
- `NRCPTOT_N_F` verified as the attribute flag for `NRCPTOT_N`.
- U.S. all-class NAICS schema query returned 452 rows excluding header.
- Rows with unexpected column count: 0.
- Observed `NRCPTOT_N_F` flag counts: `G` = 452.

AIES-NES:

- `RCPT_TOT_VAL_NS_N` verified as the noise range for nonemployer sales, value
  of shipments, or revenue.
- `RCPT_TOT_VAL_NS_N_F` verified as the attribute flag for
  `RCPT_TOT_VAL_NS_N`.
- Cleaner national schema query returned 425 rows excluding header.
- Rows with unexpected column count: 0.
- Observed `RCPT_TOT_VAL_NS_N_F` flag counts: `G` = 425.
- Requesting `YEAR` in `get=` while using `YEAR=2023` as a predicate creates a
  duplicate `YEAR` header; the cleaner query omits `YEAR` from `get=` and
  carries it from the appended predicate column.

## Rules Added

- Use key-first API query construction.
- Preserve API-appended predicate columns.
- Avoid requesting a predicate field in `get=` unless duplicate headers are
  explicitly handled.
- Preserve noise range fields and noise-flag attributes before numeric
  coercion.
- Keep NES 2022 NAICS and AIES-NES 2017 NAICS vintages separate until a
  crosswalk rule is selected.
- Do not compute shares, ratios, growth, rankings, or prediction outcomes in
  ingestion.

## Guardrails Preserved

- No `paper/draft.md` edit.
- No paper prose.
- No quantitative analysis.
- No ingestion or cleaning script.
- No processed panel.
- No API key or secret recorded.
- No Operator Node claim promoted.
- No decision about the Operator Node hypothesis.
- No prohibited philosophical or religious foundation.
- NES/AIES-NES remain measurement sources, not AI-exposure or direct
  Operator Node evidence.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
git check-ignore .env.local data/raw/bds/2023/bds2023_sec_fa_fz.csv data/raw/susb/2022/us_state_6digitnaics_2022.txt
rg -n 'NES And AIES-NES API Ingestion Readiness|LFO=001|RCPSZES=001|NRCPTOT_N_F|RCPT_TOT_VAL_NS_N_F|452|425|duplicate YEAR|No quantitative analysis|No ingestion' research/data/nes_aies_api_ingestion_readiness.md research/data/acquisition_scaffold.md research/data/schema_mapping.md research/data/field_dictionary.md docs/operator/returns/2026-06-11-nes-aies-api-ingestion-readiness-return.md
rg -n "Buddh[i]sm|Tao[i]sm|Sun[y]ata|dependent[ -]originat[i]on|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" research/data/nes_aies_api_ingestion_readiness.md research/data/acquisition_scaffold.md research/data/schema_mapping.md research/data/field_dictionary.md docs/operator/returns/2026-06-11-nes-aies-api-ingestion-readiness-return.md
rg -n "[ \t]+$" research/data/nes_aies_api_ingestion_readiness.md research/data/acquisition_scaffold.md research/data/schema_mapping.md research/data/field_dictionary.md docs/operator/returns/2026-06-11-nes-aies-api-ingestion-readiness-return.md
```

Expected results:

- `git diff -- paper/draft.md`: no output.
- `git diff --check`: pass with no output.
- `git check-ignore`: returns `.env.local`, BDS raw file, and SUSB raw file.
- Ingestion-readiness scan returns expected matches.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.

## Commit Status

This slice is ready to commit after verification.
