# Sector Panel Staging Validation

Status: staged-output QA only. Not a processed panel, analysis, or empirical
result.

Run date: 2026-06-12.

Purpose: record validation of the ignored sector-panel staging outputs against
the tracked staging manifest and staging-table contracts.

## Scope

Validator:

- `research/data/sector_panel_staging_validator.py`

Inputs validated:

- `data/manifests/sector_panel_staging_manifest.csv`
- `data/intermediate/sector_panel/stg_nes_sector_2023.csv`
- `data/intermediate/sector_panel/stg_aies_nes_sector_2023.csv`
- `data/intermediate/sector_panel/stg_susb_sector_2022.csv`
- `data/intermediate/sector_panel/stg_bds_sector_age_size.csv`
- `data/intermediate/sector_panel/qa_sector_panel_staging_summary.csv`

The validator does not create `data/processed/` and does not compute empirical
measures.

## Validation Checks

The validator checks:

- staging manifest exists and has the expected five rows;
- every manifest row has `analysis_performed=false`;
- output paths remain under ignored `data/intermediate/sector_panel/`;
- output SHA-256 values match the tracked staging manifest;
- staging headers match the expected contracts;
- row counts match the tracked staging manifest and expected staging counts;
- staging keys are unique at the intended staging grain;
- canonical sectors are restricted to the 17-sector frame;
- NES duplicate `NAICS2022` fields agree and predicates remain
  `LFO=001`, `RCPSZES=001`, `us=1`;
- AIES-NES duplicate `SECTOR` fields agree and predicates remain
  `YEAR=2023`, `us=1`;
- SUSB rows remain U.S. total and total enterprise-size rows;
- BDS rows remain sector-age-size rows over the 1978-2023 period;
- source-specific NAICS vintage or sector-category metadata is preserved.

## Metadata Correction

The validator exposed a source-truth metadata inconsistency in
`data/manifests/susb_2022_manifest.csv`: the local manifest recorded the SUSB
2022 U.S./state file as `naics_vintage=2022`, while the accepted schema
mapping, harmonization rule, and code-list QA record it as 2017 NAICS.

Correction made:

- `data/manifests/susb_2022_manifest.csv` now records `naics_vintage=2017`.

The staging parser was rerun after this correction, updating the tracked
staging manifest and ignored SUSB staging output metadata. Counts did not
change.

BDS remains recorded as `2017 sector categories`, because the staged file is
the official sector-age-size CSV rather than a fine-code NAICS table.

## Command Run

```bash
python3 research/data/sector_panel_staging_validator.py
```

Output:

```text
staging_manifest_rows=5
staging_outputs_validated=5
staging_rows_validated=94303
analysis_performed=false
```

## Guardrails

- No `paper/draft.md` edit.
- No paper prose.
- No quantitative analysis.
- No processed panel.
- No AI-exposure merge.
- No prediction outcome, claim status, ratio, share, growth, ranking, or
  treatment-effect calculation.
- No API key or secret recorded.
- No Operator Node claim promoted.
