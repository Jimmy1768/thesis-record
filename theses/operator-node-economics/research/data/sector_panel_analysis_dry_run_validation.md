# Sector Panel Analysis Dry-Run Validation

Status: dry-run validation only. Not an analysis result, descriptive summary,
claim update, or paper prose.

Run date: 2026-06-12.

Purpose: record validation of the current processed sector-panel inputs before
any descriptive analysis script is allowed. The validator checks manifests,
hashes, denominator availability, missing AIES cells, and BDS publication
markers without calculating measures.

## Scope

Validator:

- `research/data/sector_panel_analysis_dry_run_validator.py`

Inputs checked:

- `data/manifests/sector_panel_processed_manifest.csv`
- `data/processed/sector_panel/sector_source_index.csv`
- `data/processed/sector_panel/sector_boundary_measure_inputs.csv`
- `data/processed/sector_panel/sector_bds_age_size_inputs.csv`

Ignored processed inputs remain under `data/processed/`.

## Command Run

```bash
python3 research/data/sector_panel_analysis_dry_run_validator.py
```

Output:

```text
analysis_dry_run_validated=true
calculations_performed=false
claim_support_updated=false
source_index_rows=17
nes_denominator_ready=17
aies_denominator_ready=15
aies_missing_sector_rows=2
susb_denominator_ready=17
bds_rows_checked=93840
bds_publication_marker_types_seen=2
```

## Checks Performed

The validator checked:

- processed manifest has exactly three expected rows;
- processed manifest output hashes match ignored processed CSV files;
- all processed manifest rows preserve `analysis_performed=false`;
- source index covers the 17-sector canonical frame;
- AIES sector-row absence is limited to sectors `11` and `81`;
- NES denominator input `nes_NESTAB` is present and positive for all 17
  sectors;
- NES receipt noise fields are present;
- AIES denominator inputs are present for 15 eligible sectors and absent for
  the two flagged missing sectors;
- SUSB denominator inputs for employer baseline measures are present and
  positive for all 17 sectors;
- SUSB noise/suppression flags are present;
- BDS input rows cover the expected 93,840 sector-year-firm-age-firm-size
  records;
- BDS firm-age and firm-size categories are preserved;
- BDS publication markers are preserved where observed.

## What This Does Not Do

The validator does not calculate:

- NES receipts per establishment;
- AIES nonemployer revenue share;
- SUSB payroll per employee;
- SUSB employment per firm;
- SUSB establishments per firm;
- BDS collapsed measures;
- growth rates;
- rankings;
- treatment effects;
- claim support.

## Remaining Before Analysis

A future analysis implementation can calculate the explicitly permitted
descriptive measures only if it:

- reruns staging validation and the processed transform;
- reruns this dry-run validator;
- writes outputs under an ignored analysis directory;
- writes a tracked analysis manifest;
- keeps `claim_support_updated=false`;
- preserves sectors `11` and `81` as missing for AIES-based measures.

No AI-exposure merge, prediction result, or claim-support update is authorized
by this dry-run validation.
