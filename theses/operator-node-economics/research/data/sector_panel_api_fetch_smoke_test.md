# Sector Panel API Fetch Smoke Test

Status: API fetch smoke-test record only. Not an analysis, staging table,
processed panel, or empirical result.

Run date: 2026-06-12.

Purpose: test the sector-panel API fetch path for a minimal subset of planned
queries before any full API acquisition or staging-table creation.

## Scope

This pass tested:

- One NES 2023 U.S. sector query: `nes_2023_us_sector_11`.
- One AIES-NES 2023 U.S. sector query: `aies_nes_2023_us_sector_11`.
- Local-only validation of existing SUSB and BDS raw-file checksums and
  headers.

It did not compute receipts, counts, shares, ratios, rates, growth, rankings,
treatment effects, prediction outcomes, or claim status.

## AIES Predicate Correction

The originally planned AIES-NES sector query used `NAICS2017=11` as an API
predicate. A redacted diagnostic found:

- `NAICS2017=11` returned HTTP 200 with JSON content type but an empty body.
- The all-row AIES query returned 425 rows excluding header.
- In the all-row query, the AIES sector value for agriculture was exposed in
  `SECTOR=11`, while the corresponding `NAICS2017` value was `115`.
- `SECTOR=11` returned a valid one-row JSON response.

Correction applied:

- AIES-NES planned sector queries now use the `SECTOR` predicate.
- Canonical range sectors map as:
  - `31-33` to `SECTOR=31`
  - `44-45` to `SECTOR=44`
  - `48-49` to `SECTOR=48`
- Expected AIES headers now preserve duplicated `SECTOR` columns because
  `SECTOR` is both requested and supplied as a predicate.

## Commands Run

Local-only validation:

```bash
python3 research/data/sector_panel_dry_run_validator.py
```

Output:

```text
mode=local-only
inventory_rows=36
nes_rows=17
aies_rows=17
local_file_rows=2
planned_rows=34
local_files_checked=2
api_payloads_fetched=0
analysis_performed=false
```

Targeted fetch validation:

```bash
python3 research/data/sector_panel_dry_run_validator.py --fetch-api --inventory-id nes_2023_us_sector_11 --inventory-id aies_nes_2023_us_sector_11
```

Output:

```text
mode=fetch-api
inventory_rows=36
nes_rows=17
aies_rows=17
local_file_rows=2
planned_rows=34
local_files_checked=2
api_payloads_fetched=2
analysis_performed=false
```

The fetch command required network escalation. The command loaded the Census
API key from ignored `.env.local`; the key was not printed or stored.

## Payload QA

Fetched raw payloads are local-only and ignored by git.

| Inventory ID | Local Path | Bytes | SHA-256 | Rows Excluding Header | Widths |
| --- | --- | ---: | --- | ---: | --- |
| `nes_2023_us_sector_11` | `data/raw/nes/2023/nes_2023_us_sector_11.json` | 213 | `3c32c275a73f6f229c11149cf84900563afbd253e709ac017f10942cf9b2c50f` | 1 | 10 |
| `aies_nes_2023_us_sector_11` | `data/raw/aies_nes/2023/aies_nes_2023_us_sector_11.json` | 337 | `81e22d783dba32e62c76320c02bf921c166e6c65bdaa7ad3e526443653d540de` | 1 | 15 |

NES fetched header:

```text
NAICS2022;NAICS2022_LABEL;NESTAB;NRCPTOT;NRCPTOT_N;NRCPTOT_N_F;LFO;RCPSZES;NAICS2022;us
```

AIES-NES fetched header:

```text
NAICS2017;NAICS2017_LABEL;GEO_ID;RCPT_TOT_VAL;RCPT_TOT_VAL_NS;RCPT_TOT_CV;RCPT_TOT_VAL_NS_N;RCPT_TOT_VAL_NS_N_F;INDLEVEL;SECTOR;SUBSECTOR;INDGROUP;YEAR;SECTOR;us
```

## Remaining Before Full Acquisition

- Full API fetch validation for all 34 planned NES and AIES-NES API rows is
  recorded in `research/data/sector_panel_api_full_fetch_validation.md`.
- The tracked API payload manifest is
  `data/manifests/sector_panel_api_payload_manifest.csv`.
- Keep API payloads under ignored `data/raw/`.
- Do not create staging tables until full payload headers, row widths, and
  sector predicates pass validation.

## Guardrails

- This smoke test does not authorize quantitative analysis.
- This smoke test does not authorize processed-panel creation.
- This smoke test does not merge AI exposure.
- This smoke test does not support firm-boundary findings.
- NES nonemployers are not one-human firms.
- AIES-NES is a national employer/nonemployer comparison source, not causal AI
  evidence.
