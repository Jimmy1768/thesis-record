---
record_id: return-2026-06-11-susb-ingestion-readiness
record_type: return
workflow_id: 2026-06-11-susb-ingestion-readiness
status: completed
created_at: 2026-06-11T23:52:00+08:00
owner: Research
---

# Return: SUSB CSV Ingestion Readiness

## Scope

This Research pass documented ingestion-readiness rules for the official SUSB
2022 U.S./state 6-digit NAICS file. It inspected raw file structure and the
official SUSB U.S./state record layout for noise-flag handling. It did not run
quantitative analysis, create an ingestion script, create a processed panel, or
write paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/susb_ingestion_readiness.md`
- `research/data/acquisition_scaffold.md`
- `research/data/schema_mapping.md`
- `research/data/field_dictionary.md`
- `data/manifests/susb_2022_manifest.csv`
- `docs/operator/returns/2026-06-11-susb-ingestion-readiness-return.md`

## Exact Verification Performed

Raw-file QA:

- Rows excluding header: 570,105.
- Column count: 14.
- Rows with unexpected column count: 0.
- Blank lines: 0.
- Duplicate `STATE`/`NAICS`/`ENTRSIZE` keys: 0.
- State-code count: 52.
- NAICS-code count: 2,003.
- Enterprise-size category count: 9.
- Non-numeric values in `FIRM`, `ESTB`, `EMPL`, `PAYR`, and `RCPT`: 0.

Checksum and size:

- SHA-256:
  `6f7b2f2b14cbad9dbfeb31d3bfc9f729368a0e971727de4eda88c9f83f77a513`
- Bytes: 56,000,447.
- Lines including header: 570,106.

Official record layout inspected:

- `https://www2.census.gov/programs-surveys/susb/technical-documentation/record_layout_us_and_state_2007_to_present.txt`

## Noise Flags Verified

Observed in `us_state_6digitnaics_2022.txt`:

| Column | G | H | J | D | S |
| --- | ---: | ---: | ---: | ---: | ---: |
| `EMPLFL_N` | 277,234 | 167,925 | 124,946 | 0 | 0 |
| `PAYRFL_N` | 332,347 | 170,712 | 67,046 | 0 | 0 |
| `RCPTFL_N` | 313,670 | 181,566 | 74,869 | 0 | 0 |

Interpretation recorded:

- `G`, `H`, and `J` are noise-quality flags.
- `D` and `S` are official withheld-cell flags and must be handled even though
  they were not observed in this file.
- `EMPLFL_R` is absent from this 2022 file and should not be expected in this
  extract.

## Rules Added

- Preserve `EMPLFL_N`, `PAYRFL_N`, and `RCPTFL_N` before numeric coercion.
- Treat any observed `D` or `S` as withheld publication values, not true zeros.
- Do not impute withheld or high-noise cells during ingestion.
- Verify header, row width, checksum, category values, and key uniqueness
  before any processed panel is created.
- Carry `year=2022` from the file vintage because no year column is present.

## Companion File Decision

The companion SUSB detailed-size file was not downloaded. The current
U.S./state 6-digit NAICS file already has verified enterprise-size classes.
Pull the companion file only if a future prediction design requires narrower
enterprise-size categories.

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
- SUSB enterprise-size classes remain employer-size context, not management
  hierarchy or TCE-P005 evidence.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
git check-ignore .env.local data/raw/bds/2023/bds2023_sec_fa_fz.csv data/raw/susb/2022/us_state_6digitnaics_2022.txt
rg -n "SUSB CSV Ingestion Readiness|570,105|G|H|J|D|S|EMPLFL_N|PAYRFL_N|RCPTFL_N|No quantitative analysis|No ingestion" research/data/susb_ingestion_readiness.md research/data/acquisition_scaffold.md research/data/schema_mapping.md research/data/field_dictionary.md data/manifests/susb_2022_manifest.csv docs/operator/returns/2026-06-11-susb-ingestion-readiness-return.md
rg -n "Buddh[i]sm|Tao[i]sm|Sun[y]ata|dependent[ -]originat[i]on|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" research/data/susb_ingestion_readiness.md research/data/acquisition_scaffold.md research/data/schema_mapping.md research/data/field_dictionary.md data/manifests/susb_2022_manifest.csv docs/operator/returns/2026-06-11-susb-ingestion-readiness-return.md
rg -n "[ \t]+$" research/data/susb_ingestion_readiness.md research/data/acquisition_scaffold.md research/data/schema_mapping.md research/data/field_dictionary.md data/manifests/susb_2022_manifest.csv docs/operator/returns/2026-06-11-susb-ingestion-readiness-return.md
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
