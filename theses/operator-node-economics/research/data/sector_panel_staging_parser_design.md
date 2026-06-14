# Sector Panel Staging Parser Design

Status: parser design only. Not a parser implementation, staging output,
processed panel, or analysis.

Run date: 2026-06-12.

Purpose: define how a future staging parser should read validated raw NES,
AIES-NES, SUSB, and BDS inputs into ignored `data/intermediate/` tables while
preserving source fields, duplicate predicate columns, flags, and sector
mapping metadata.

## Scope

Inputs covered:

- 34 validated NES/AIES API JSON payloads from
  `data/manifests/sector_panel_api_payload_manifest.csv`.
- SUSB 2022 U.S./state raw CSV from `data/manifests/susb_2022_manifest.csv`.
- BDS 2023 sector-age-size raw CSV from `data/manifests/bds_2023_manifest.csv`.

Outputs designed:

- `data/intermediate/sector_panel/stg_nes_sector_2023.csv`
- `data/intermediate/sector_panel/stg_aies_nes_sector_2023.csv`
- `data/intermediate/sector_panel/stg_susb_sector_2022.csv`
- `data/intermediate/sector_panel/stg_bds_sector_age_size.csv`
- `data/intermediate/sector_panel/qa_sector_panel_staging_summary.csv`

Tracked manifest template:

- `data/manifests/sector_panel_staging_manifest_template.csv`

Implementation and run record:

- `research/data/sector_panel_staging_parser.py`
- `research/data/sector_panel_staging_parser_run.md`
- `data/manifests/sector_panel_staging_manifest.csv`

The design file itself does not create outputs. The implementation listed above
writes ignored intermediate outputs and a tracked QA manifest.

## General Parser Rules

- Verify every raw input against its tracked manifest before parsing.
- Preserve all raw source fields before any type coercion.
- Preserve duplicate API fields losslessly with deterministic suffixes.
- Preserve source-specific flags, noise fields, and categorical codes.
- Add `source_dataset`, `source_inventory_id`, `raw_local_path`,
  `source_row_number`, `reference_year`, `naics_vintage`, and
  `canonical_sector` metadata fields.
- Add `canonical_sector` only after the row passes the sector mapping rules in
  this document.
- Keep all staging outputs under ignored `data/intermediate/`.
- Write a staging manifest row for each output.
- Do not write `data/processed/`.
- Do not compute ratios, shares, rates, growth, rankings, treatment effects,
  prediction outcomes, or claim status.

## Duplicate Header Policy

The Census API repeats predicate fields when they are also requested in `get=`.
The parser must preserve both columns.

NES duplicate:

- Raw header:
  `NAICS2022;...;LFO;RCPSZES;NAICS2022;us`
- Staging names:
  - `NAICS2022__get`
  - `NAICS2022__predicate`

AIES-NES duplicate:

- Raw header:
  `NAICS2017;...;SECTOR;...;YEAR;SECTOR;us`
- Staging names:
  - `SECTOR__get`
  - `SECTOR__predicate`

Stop condition:

- If duplicate source/predicate fields disagree in a row, stop and record a
  blocker. Do not silently choose one field.

## Sector Frame

Canonical sectors:

```text
11;21;22;23;31-33;42;44-45;48-49;51;52;53;54;56;62;71;72;81
```

Excluded from the first-pass all-source frame:

- `55`
- `61`

Mapping rules:

| Source | Raw Field | Mapping Rule |
| --- | --- | --- |
| NES | `NAICS2022__predicate` | Exact match to canonical sector. |
| AIES-NES | `SECTOR__predicate` | Exact match except `31 -> 31-33`, `44 -> 44-45`, and `48 -> 48-49`. |
| SUSB | `NAICS` | Exact match to canonical sector after filtering `STATE=00` and `ENTRSIZE=01`. |
| BDS | `sector` | Exact match to canonical sector. |

Stop condition:

- Any row outside the source-specific sector mapping must be excluded from the
  first-pass staging table and counted in QA. Do not coerce it into the
  canonical sector frame.

## Staging Table Contracts

### `stg_nes_sector_2023`

Input:

- API payload rows where `dataset=NES 2023 API` in
  `data/manifests/sector_panel_api_payload_manifest.csv`.

Required fields:

- `source_dataset`
- `source_inventory_id`
- `source_row_number`
- `raw_local_path`
- `reference_year`
- `naics_vintage`
- `canonical_sector`
- `NAICS2022__get`
- `NAICS2022_LABEL`
- `NESTAB`
- `NRCPTOT`
- `NRCPTOT_N`
- `NRCPTOT_N_F`
- `LFO`
- `RCPSZES`
- `NAICS2022__predicate`
- `us`

Filters:

- `LFO=001`
- `RCPSZES=001`
- `us=1`
- `NAICS2022__predicate` in the 17-sector frame.

QA:

- Expected row count before staging: 17 rows excluding headers across all NES
  payloads.
- Expected row width: 10 raw fields before staging metadata.
- Duplicate `NAICS2022` fields must match row-by-row.

### `stg_aies_nes_sector_2023`

Input:

- API payload rows where `dataset=AIES-NES 2023 API` in
  `data/manifests/sector_panel_api_payload_manifest.csv`.

Required fields:

- `source_dataset`
- `source_inventory_id`
- `source_row_number`
- `raw_local_path`
- `reference_year`
- `naics_vintage`
- `canonical_sector`
- `NAICS2017`
- `NAICS2017_LABEL`
- `GEO_ID`
- `RCPT_TOT_VAL`
- `RCPT_TOT_VAL_NS`
- `RCPT_TOT_CV`
- `RCPT_TOT_VAL_NS_N`
- `RCPT_TOT_VAL_NS_N_F`
- `INDLEVEL`
- `SECTOR__get`
- `SUBSECTOR`
- `INDGROUP`
- `YEAR`
- `SECTOR__predicate`
- `us`

Filters:

- `YEAR=2023`
- `us=1`
- `SECTOR__predicate` in the AIES sector predicate frame:
  `11;21;22;23;31;42;44;48;51;52;53;54;56;62;71;72;81`.

QA:

- Expected row count before staging: 425 rows excluding headers across all AIES
  sector payloads.
- Expected row width: 15 raw fields before staging metadata.
- Duplicate `SECTOR` fields must match row-by-row.
- `canonical_sector` must use explicit range mappings for `31`, `44`, and
  `48`.

### `stg_susb_sector_2022`

Input:

- `data/raw/susb/2022/us_state_6digitnaics_2022.txt`

Required fields:

- `source_dataset`
- `source_row_number`
- `raw_local_path`
- `reference_year`
- `naics_vintage`
- `canonical_sector`
- `STATE`
- `NAICS`
- `ENTRSIZE`
- `FIRM`
- `ESTB`
- `EMPL`
- `EMPLFL_N`
- `PAYR`
- `PAYRFL_N`
- `RCPT`
- `RCPTFL_N`
- `STATEDSCR`
- `NAICSDSCR`
- `ENTRSIZEDSCR`

Filters:

- `STATE=00`
- `ENTRSIZE=01`
- `NAICS` in the 17-sector frame.

QA:

- Verify SHA-256 against `data/manifests/susb_2022_manifest.csv`.
- Verify raw header exactly.
- Preserve `EMPLFL_N`, `PAYRFL_N`, and `RCPTFL_N`.
- Treat any `D` or `S` flags as withheld publication cells, not true zeros.
- Do not aggregate size classes or geographies.

### `stg_bds_sector_age_size`

Input:

- `data/raw/bds/2023/bds2023_sec_fa_fz.csv`

Required fields:

- `source_dataset`
- `source_row_number`
- `raw_local_path`
- `reference_year`
- `naics_vintage`
- `canonical_sector`
- `year`
- `sector`
- `fage`
- `fsize`
- all original employer-firm and job-flow fields present in the BDS raw header

Filters:

- `sector` in the 17-sector frame.

QA:

- Verify SHA-256 against `data/manifests/bds_2023_manifest.csv`.
- Verify raw header exactly.
- Preserve `fage` and `fsize` as coded categorical fields.
- Preserve observed publication markers such as `D`, `X`, and `N`.
- Do not collapse age/size cells.
- Do not compute rates beyond preserving raw rate fields already present in
  the source file.

## Staging QA Summary

The future parser should write `qa_sector_panel_staging_summary.csv` with one
row per staging output and at least these fields:

- `staging_table`
- `source_type`
- `input_manifest`
- `raw_inputs_checked`
- `raw_rows_seen`
- `rows_written`
- `rows_excluded_outside_sector_frame`
- `duplicate_field_mismatches`
- `header_status`
- `checksum_status`
- `output_path`
- `output_sha256`
- `analysis_performed`

`analysis_performed` must be `false` for every row.

## Stop Conditions

Stop and record a blocker if any of these occur:

- Raw input missing.
- Manifest missing.
- SHA-256 mismatch.
- Header mismatch.
- Bad row width.
- Duplicate predicate/requested field mismatch.
- Undocumented noise, suppression, or publication marker.
- Sector cannot be mapped to the approved 17-sector frame.
- A parser step would require computing ratios, shares, rates, growth,
  rankings, treatment effects, prediction outcomes, or claim status.

## Guardrails

- This design does not authorize parser implementation by itself.
- This design does not authorize quantitative analysis.
- This design does not create a processed panel.
- This design does not merge AI exposure.
- This design does not support firm-boundary findings.
- NES nonemployers are not one-human firms.
- SUSB and BDS remain employer-side sources only.
- AIES-NES is a national employer/nonemployer comparison source, not causal AI
  evidence.
