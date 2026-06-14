# Sector Panel Descriptive Analysis Run

Status: descriptive baseline analysis only. Not causal analysis, AI-exposure
analysis, claim support, or paper prose.

Run date: 2026-06-12.

Purpose: record the first permitted descriptive calculations from the
sector-panel processed inputs. The output is local-only under ignored
`data/analysis/`, while the analysis manifest is tracked.

## Scope

Analysis script:

- `research/data/sector_panel_descriptive_analysis.py`

Tracked analysis manifest:

- `data/manifests/sector_panel_analysis_manifest.csv`

Ignored analysis output:

- `data/analysis/sector_panel/sector_descriptive_measures.csv`

## Command Run

```bash
python3 research/data/sector_panel_descriptive_analysis.py
```

Output:

```text
analysis_tables_written=1
analysis_rows_written=17
ai_exposure_merged=false
claim_support_updated=false
missing_aies_sector_rows=11;81
```

## Measures Calculated

The script calculated only the measures permitted by
`research/data/sector_panel_analysis_design.md`:

- `nes_receipts_per_establishment`
- `aies_nonemployer_revenue_share_available_sectors_only`
- `susb_payroll_per_employee`
- `susb_employment_per_firm`
- `susb_establishments_per_firm`

## Missing Cells

AIES sector-level revenue-share calculations remain missing for:

- `11`
- `81`

The script does not fill, allocate, infer, or rank these sectors.

## Interpretation Limits

These descriptive measures can support only:

- measurement readiness;
- baseline descriptive summaries;
- missing-cell identification;
- future AI-exposure test design.

They do not support:

- Operator Node claims;
- AI-enabled one-human firm claims;
- causal AI effects;
- durable firm-boundary shifts;
- transaction-cost reductions;
- management-layer thinning.

## Guardrails

- `ai_exposure_merged=false`
- `claim_support_updated=false`
- no rankings;
- no growth rates;
- no treatment effects;
- no prediction outcomes;
- no paper prose.
