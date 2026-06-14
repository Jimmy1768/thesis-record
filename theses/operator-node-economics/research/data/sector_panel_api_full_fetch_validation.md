# Sector Panel API Full Fetch Validation

Status: API payload validation record only. Not an analysis, staging table,
processed panel, or empirical result.

Run date: 2026-06-12.

Purpose: validate all planned NES and AIES-NES sector API payloads for the
17-sector first-pass frame before creating any staging parser.

## Scope

This pass fetched and validated:

- 17 NES 2023 U.S.-sector API payloads.
- 17 AIES-NES 2023 U.S.-sector API payloads.
- Existing SUSB and BDS local-file checksums and headers.

It did not compute receipts, counts, shares, ratios, rates, growth, rankings,
treatment effects, prediction outcomes, or claim status.

## Command Run

```bash
python3 research/data/sector_panel_dry_run_validator.py --fetch-api --write-api-manifest data/manifests/sector_panel_api_payload_manifest.csv
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
api_payloads_fetched=34
api_manifest=data/manifests/sector_panel_api_payload_manifest.csv
analysis_performed=false
```

The command required network escalation. It loaded the Census API key from
ignored `.env.local`; the key was not printed or stored.

## Manifest

Tracked API payload manifest:

- `data/manifests/sector_panel_api_payload_manifest.csv`

Manifest QA:

- Rows: 34.
- NES rows: 17.
- AIES-NES rows: 17.
- HTTP statuses: `200`.
- Content types: `application/json;charset=utf-8`.
- Row widths: `10` for NES payloads and `15` for AIES-NES payloads.
- Minimum rows excluding header across payloads: 1.
- Maximum rows excluding header across payloads: 88.
- Literal API key present in manifest: no.

Raw payloads:

- 34 JSON files under ignored `data/raw/nes/` and `data/raw/aies_nes/`.
- `git status --short --ignored data/raw/nes data/raw/aies_nes` reports
  `!! data/raw/`.

## Validated Headers

NES payload header:

```text
NAICS2022;NAICS2022_LABEL;NESTAB;NRCPTOT;NRCPTOT_N;NRCPTOT_N_F;LFO;RCPSZES;NAICS2022;us
```

AIES-NES payload header:

```text
NAICS2017;NAICS2017_LABEL;GEO_ID;RCPT_TOT_VAL;RCPT_TOT_VAL_NS;RCPT_TOT_CV;RCPT_TOT_VAL_NS_N;RCPT_TOT_VAL_NS_N_F;INDLEVEL;SECTOR;SUBSECTOR;INDGROUP;YEAR;SECTOR;us
```

Duplicate predicate fields remain intentionally preserved in raw payloads.
Canonical staging can only collapse duplicate fields after verifying identical
values row-by-row.

## Remaining Before Staging

- Design a staging parser that reads the 34 raw API payloads, the SUSB raw CSV,
  and the BDS raw CSV.
- Preserve duplicate predicate/requested fields losslessly in raw parse output.
- Verify row-level sector mapping before adding `canonical_sector`.
- Keep staging outputs under ignored `data/intermediate/`.
- Do not create `data/processed/` until parser QA passes.
- Do not compute empirical measures in staging.

## Guardrails

- This validation does not authorize quantitative analysis.
- This validation does not authorize processed-panel creation.
- This validation does not merge AI exposure.
- This validation does not support firm-boundary findings.
- NES nonemployers are not one-human firms.
- AIES-NES is a national employer/nonemployer comparison source, not causal AI
  evidence.
