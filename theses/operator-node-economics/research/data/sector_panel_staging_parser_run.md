# Sector Panel Staging Parser Run

Status: staging parser execution record only. Not a processed panel, analysis,
or empirical result.

Run date: 2026-06-12.

Purpose: record the first staging parser execution for validated NES,
AIES-NES, SUSB, and BDS sector-panel inputs.

## Scope

Parser:

- `research/data/sector_panel_staging_parser.py`

Tracked staging manifest:

- `data/manifests/sector_panel_staging_manifest.csv`

Ignored staging outputs:

- `data/intermediate/sector_panel/stg_nes_sector_2023.csv`
- `data/intermediate/sector_panel/stg_aies_nes_sector_2023.csv`
- `data/intermediate/sector_panel/stg_susb_sector_2022.csv`
- `data/intermediate/sector_panel/stg_bds_sector_age_size.csv`
- `data/intermediate/sector_panel/qa_sector_panel_staging_summary.csv`

The parser did not create `data/processed/`.

## Command Run

```bash
python3 research/data/sector_panel_staging_parser.py
```

Output:

```text
staging_tables_written=4
qa_summary_written=1
analysis_performed=false
```

## Staging Manifest Summary

| Staging Table | Raw Rows Seen | Rows Written | Rows Excluded Outside Sector Frame | Duplicate Field Mismatches | Analysis Performed |
| --- | ---: | ---: | ---: | ---: | --- |
| `stg_nes_sector_2023` | 17 | 17 | 0 | 0 | `false` |
| `stg_aies_nes_sector_2023` | 425 | 425 | 0 | 0 | `false` |
| `stg_susb_sector_2022` | 570,105 | 17 | 1,986 | 0 | `false` |
| `stg_bds_sector_age_size` | 104,880 | 93,840 | 11,040 | 0 | `false` |
| `qa_sector_panel_staging_summary` | 4 | 4 | 0 | 0 | `false` |

Interpretation:

- Counts are parser QA counts, not empirical findings.
- SUSB exclusions are rows outside the 17-sector frame after the U.S. total and
  total enterprise-size filters are applied.
- BDS exclusions are rows outside the 17-sector frame in the sector-age-size
  CSV.
- Duplicate API predicate/requested field mismatches were zero.

## Output Status

Ignored-output check:

```text
!! data/intermediate/
```

Tracked manifest:

- `data/manifests/sector_panel_staging_manifest.csv`

## Remaining Before Analysis

- Staged column contracts and QA manifest have a companion validation record:
  `research/data/sector_panel_staging_validation.md`.
- Keep `data/processed/` blocked until a separate transformation design and
  approval step.
- Do not compute empirical measures from staging outputs yet.

## Guardrails

- This run does not authorize quantitative analysis.
- This run does not create a processed panel.
- This run does not merge AI exposure.
- This run does not support firm-boundary findings.
- NES nonemployers are not one-human firms.
- SUSB and BDS remain employer-side sources only.
- AIES-NES is a national employer/nonemployer comparison source, not causal AI
  evidence.
