# Sector Panel Transform Run

Status: transformation execution record only. Not analysis or empirical
results.

Run date: 2026-06-12.

Purpose: record the first conservative sector-panel transformation from
validated staging outputs into ignored processed input tables. The
transformation carries source-native fields forward and writes a tracked
manifest. It does not compute empirical measures.

## Scope

Transform script:

- `research/data/sector_panel_transform.py`

Tracked processed manifest:

- `data/manifests/sector_panel_processed_manifest.csv`

Ignored processed outputs:

- `data/processed/sector_panel/sector_source_index.csv`
- `data/processed/sector_panel/sector_boundary_measure_inputs.csv`
- `data/processed/sector_panel/sector_bds_age_size_inputs.csv`

## Command Run

```bash
python3 research/data/sector_panel_transform.py
```

Output:

```text
processed_tables_written=3
processed_manifest_rows=3
analysis_performed=false
missing_aies_sector_rows=11;81
```

## Processed Manifest Summary

| Processed Table | Row Count | Analysis Performed | Warnings |
| --- | ---: | --- | --- |
| `sector_source_index` | 17 | `false` | `missing_aies_sector_rows=11;81` |
| `sector_boundary_measure_inputs` | 17 | `false` | `missing_aies_sector_rows=11;81` |
| `sector_bds_age_size_inputs` | 93,840 | `false` | none |

## AIES Sector-Row Warning

The transform uses the verified sector-row rule:

- `INDLEVEL=2`
- `NAICS2017` equals `canonical_sector`

Under that rule, AIES-NES sector-level rows are present for 15 of the 17
canonical sectors and missing for:

- `11`
- `81`

The transform does not fill, allocate, or infer these values. It leaves AIES
fields blank for those sectors in `sector_boundary_measure_inputs` and flags
the gap in `sector_source_index` and the processed manifest.

## Guardrails

- Source-native fields only.
- No ratios, shares, growth rates, rankings, treatment effects, prediction
  outcomes, or claim-status updates.
- No AI-exposure merge.
- No paper prose.
- NES nonemployers are not one-human firms.
- AIES-NES revenue fields are comparison inputs only.
- SUSB and BDS remain employer-side sources only.
- BDS establishment entry is not firm startup.
