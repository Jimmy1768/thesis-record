# Sector Panel Query Inventory

Status: query and file QA inventory only. Not a data pull, staging table,
processed panel, transformation script, or analysis.

Run date: 2026-06-12.

Purpose: enumerate the exact first-pass NES and AIES-NES sector API queries,
and define manifest/checksum QA for the already-local SUSB and BDS source
files, before any data acquisition or staging execution.

Companion tracked inventory:

- `data/manifests/sector_panel_query_inventory.csv`

Dry-run validator:

- `research/data/sector_panel_dry_run_validator.py`

Default validator mode is local-only. It checks inventory shape, API-key
redaction, planned row counts, existing local-file checksums, and existing
local-file headers. Optional `--fetch-api` mode may write API payloads under
ignored `data/raw/` paths, but still does not compute empirical measures.

Full API payload QA manifest:

- `data/manifests/sector_panel_api_payload_manifest.csv`

Full fetch validation record:

- `research/data/sector_panel_api_full_fetch_validation.md`

## Scope

This inventory operationalizes `research/data/sector_panel_build_plan.md`.
It creates planned query/file rows only. It does not retrieve API payloads,
download files, parse raw data, create staging tables, compute empirical
measures, or evaluate predictions.

## Sector Frame

First-pass all-source sector frame:

```text
11;21;22;23;31-33;42;44-45;48-49;51;52;53;54;56;62;71;72;81
```

Excluded from the first-pass all-source frame:

- `55`: absent from inspected NES and AIES-NES code lists.
- `61`: absent from inspected AIES-NES code list.

## Census API Secret Handling

API query inventory rows use the placeholder `${CENSUS_API_KEY}` only.

Execution rules:

- Load the key from ignored `.env.local` at command runtime.
- Do not print the key.
- Do not log the key.
- Do not commit API payload URLs containing the literal key.
- Do not store the key in manifests, return records, shell history excerpts,
  or error logs.

## Exact NES Query Template

Endpoint:

```text
https://api.census.gov/data/2023/nonemp
```

Template:

```text
https://api.census.gov/data/2023/nonemp?key=${CENSUS_API_KEY}&get=NAICS2022,NAICS2022_LABEL,NESTAB,NRCPTOT,NRCPTOT_N,NRCPTOT_N_F&LFO=001&RCPSZES=001&NAICS2022={sector}&for=us:1
```

Expected raw header:

```text
NAICS2022;NAICS2022_LABEL;NESTAB;NRCPTOT;NRCPTOT_N;NRCPTOT_N_F;LFO;RCPSZES;NAICS2022;us
```

Duplicate-header note:

- `NAICS2022` is both requested and supplied as a predicate. Preserve both raw
  columns during API-response capture. Canonical mapping can occur only after
  verifying identical values.

Planned sector queries:

| Query ID | Sector |
| --- | --- |
| `nes_2023_us_sector_11` | `11` |
| `nes_2023_us_sector_21` | `21` |
| `nes_2023_us_sector_22` | `22` |
| `nes_2023_us_sector_23` | `23` |
| `nes_2023_us_sector_31_33` | `31-33` |
| `nes_2023_us_sector_42` | `42` |
| `nes_2023_us_sector_44_45` | `44-45` |
| `nes_2023_us_sector_48_49` | `48-49` |
| `nes_2023_us_sector_51` | `51` |
| `nes_2023_us_sector_52` | `52` |
| `nes_2023_us_sector_53` | `53` |
| `nes_2023_us_sector_54` | `54` |
| `nes_2023_us_sector_56` | `56` |
| `nes_2023_us_sector_62` | `62` |
| `nes_2023_us_sector_71` | `71` |
| `nes_2023_us_sector_72` | `72` |
| `nes_2023_us_sector_81` | `81` |

## Exact AIES-NES Query Template

Endpoint:

```text
https://api.census.gov/data/2023/aiesnonemp
```

Template:

```text
https://api.census.gov/data/2023/aiesnonemp?key=${CENSUS_API_KEY}&get=NAICS2017,NAICS2017_LABEL,GEO_ID,RCPT_TOT_VAL,RCPT_TOT_VAL_NS,RCPT_TOT_CV,RCPT_TOT_VAL_NS_N,RCPT_TOT_VAL_NS_N_F,INDLEVEL,SECTOR,SUBSECTOR,INDGROUP&YEAR=2023&SECTOR={sector_predicate}&for=us:1
```

Expected raw header:

```text
NAICS2017;NAICS2017_LABEL;GEO_ID;RCPT_TOT_VAL;RCPT_TOT_VAL_NS;RCPT_TOT_CV;RCPT_TOT_VAL_NS_N;RCPT_TOT_VAL_NS_N_F;INDLEVEL;SECTOR;SUBSECTOR;INDGROUP;YEAR;SECTOR;us
```

Duplicate-header note:

- AIES-NES sector filtering uses `SECTOR`, not `NAICS2017`. A direct
  `NAICS2017=11` diagnostic returned an empty body, while `SECTOR=11` returned
  a valid one-row JSON response.
- `SECTOR` is both requested and supplied as a predicate. Preserve both raw
  columns during API-response capture. Canonical mapping can occur only after
  verifying identical values.
- `YEAR` is not requested in `get=` because it is already a predicate.
- Canonical range sectors use AIES sector predicates `31`, `44`, and `48` for
  `31-33`, `44-45`, and `48-49`, respectively.

Planned sector queries:

| Query ID | Canonical Sector | AIES `SECTOR` Predicate |
| --- | --- | --- |
| `aies_nes_2023_us_sector_11` | `11` | `11` |
| `aies_nes_2023_us_sector_21` | `21` | `21` |
| `aies_nes_2023_us_sector_22` | `22` | `22` |
| `aies_nes_2023_us_sector_23` | `23` | `23` |
| `aies_nes_2023_us_sector_31_33` | `31-33` | `31` |
| `aies_nes_2023_us_sector_42` | `42` | `42` |
| `aies_nes_2023_us_sector_44_45` | `44-45` | `44` |
| `aies_nes_2023_us_sector_48_49` | `48-49` | `48` |
| `aies_nes_2023_us_sector_51` | `51` | `51` |
| `aies_nes_2023_us_sector_52` | `52` | `52` |
| `aies_nes_2023_us_sector_53` | `53` | `53` |
| `aies_nes_2023_us_sector_54` | `54` | `54` |
| `aies_nes_2023_us_sector_56` | `56` | `56` |
| `aies_nes_2023_us_sector_62` | `62` | `62` |
| `aies_nes_2023_us_sector_71` | `71` | `71` |
| `aies_nes_2023_us_sector_72` | `72` | `72` |
| `aies_nes_2023_us_sector_81` | `81` | `81` |

## Local File QA Rows

SUSB row:

- Inventory ID: `susb_2022_us_state_sector_file`
- Existing manifest: `data/manifests/susb_2022_manifest.csv`
- Local ignored raw file: `data/raw/susb/2022/us_state_6digitnaics_2022.txt`
- Required checksum:
  `6f7b2f2b14cbad9dbfeb31d3bfc9f729368a0e971727de4eda88c9f83f77a513`
- Required filters: `STATE=00`, `ENTRSIZE=01`, `NAICS` in the 17-sector frame.

BDS row:

- Inventory ID: `bds_2023_sector_age_size_file`
- Existing manifest: `data/manifests/bds_2023_manifest.csv`
- Local ignored raw file: `data/raw/bds/2023/bds2023_sec_fa_fz.csv`
- Required checksum:
  `c4790ccdf964788a8bbc8404349df69db2a7457f8784411a39ddb228dedfbabd`
- Required filters: `sector` in the 17-sector frame.

## Staging QA Specification

Before creating any staging table:

- Verify raw input exists in ignored `data/raw/`.
- Verify manifest or query-inventory row exists.
- Verify API key is redacted in every tracked file.
- Verify HTTP response is JSON for API rows.
- Verify file checksum for local raw-file rows.
- Verify exact header or stop and record a blocker.
- Verify row width equals header width.
- Preserve duplicate raw predicate/requested fields losslessly.
- Preserve noise, suppression, and coefficient-of-variation fields.
- Verify sector code is in the 17-sector frame.
- Count excluded-sector rows only in QA logs, not in the all-source frame.
- Record NAICS vintage and source dataset.
- Do not compute ratios, shares, rates, growth, rankings, treatment effects,
  prediction outcomes, or claim status.

Current validator command:

```bash
python3 research/data/sector_panel_dry_run_validator.py
```

Expected local-only output fields:

- `mode=local-only`
- `inventory_rows=36`
- `nes_rows=17`
- `aies_rows=17`
- `local_file_rows=2`
- `planned_rows=34`
- `local_files_checked=2`
- `api_payloads_fetched=0`
- `analysis_performed=false`

Full fetch validation command:

```bash
python3 research/data/sector_panel_dry_run_validator.py --fetch-api --write-api-manifest data/manifests/sector_panel_api_payload_manifest.csv
```

Expected full-fetch output fields:

- `mode=fetch-api`
- `api_payloads_fetched=34`
- `api_manifest=data/manifests/sector_panel_api_payload_manifest.csv`
- `analysis_performed=false`

## Stop Conditions

Stop and create a blocker record if any of these occur:

- A tracked query contains a literal Census API key.
- API response is HTML, a key error, a redirect, an empty body, or malformed
  JSON.
- Header differs from the expected inventory row.
- Duplicate predicate/requested fields cannot be preserved losslessly.
- File checksum does not match the manifest.
- Sector value is outside the 17-sector frame after filtering.
- Noise, suppression, or coefficient-of-variation fields are missing or
  undocumented.

## Guardrails

- This inventory does not authorize quantitative analysis.
- This inventory does not authorize processed-panel creation.
- This inventory does not merge AI exposure.
- This inventory does not support firm-boundary findings.
- NES nonemployers are not one-human firms.
- SUSB and BDS remain employer-side sources only.
- AIES-NES is a national employer/nonemployer comparison source, not causal AI
  evidence.
