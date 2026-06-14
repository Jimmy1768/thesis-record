---
record_id: return-2026-06-12-sector-panel-descriptive-analysis
record_type: return
workflow_id: 2026-06-12-sector-panel-descriptive-analysis
status: completed
created_at: 2026-06-12T14:45:00+08:00
owner: Research
---

# Return: Sector Panel Descriptive Analysis

## Scope

This Research pass implemented and ran the first permitted descriptive
sector-panel analysis. It calculates only approved one-year baseline measures,
writes local-only output under ignored `data/analysis/`, and writes a tracked
analysis manifest.

It did not merge AI exposure, rank sectors, calculate growth rates, estimate
treatment effects, update claim support, or write paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `.gitignore`
- `research/data/sector_panel_descriptive_analysis.py`
- `research/data/sector_panel_descriptive_analysis_run.md`
- `data/manifests/sector_panel_processed_manifest.csv`
- `data/manifests/sector_panel_analysis_manifest.csv`
- `research/data/sector_panel_analysis_design.md`
- `research/data/sector_panel_build_plan.md`
- `research/empirical_strategy.md`
- `research/predictions.md`
- `paper/evidence_requirements.md`
- `docs/operator/returns/2026-06-12-sector-panel-descriptive-analysis-return.md`

Ignored local-only output:

- `data/analysis/sector_panel/sector_descriptive_measures.csv`

## Command Result

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

The script calculated only:

- `nes_receipts_per_establishment`
- `aies_nonemployer_revenue_share_available_sectors_only`
- `susb_payroll_per_employee`
- `susb_employment_per_firm`
- `susb_establishments_per_firm`

The output preserves source flags and interpretation-limit fields.

## Missing Cells

AIES sector-level share measures remain missing for:

- `11`
- `81`

The script leaves those cells blank with `missing_aies_sector_row`; no filling,
allocation, inference, or ranking was performed.

## Guardrails Preserved

- `ai_exposure_merged=false`
- `claim_support_updated=false`
- No rankings.
- No growth rates.
- No treatment effects.
- No prediction outcomes.
- No claim-status updates.
- No paper prose.
- No `paper/draft.md` edit.

## Verification Commands

Run after editing:

```bash
python3 research/data/sector_panel_staging_validator.py
python3 research/data/sector_panel_transform.py
python3 research/data/sector_panel_analysis_dry_run_validator.py
python3 research/data/sector_panel_descriptive_analysis.py
python3 - <<'PY'
import csv
from pathlib import Path
rows = list(csv.DictReader(Path("data/analysis/sector_panel/sector_descriptive_measures.csv").open(newline="")))
print("rows=" + str(len(rows)))
print("aies_missing=" + ";".join(r["canonical_sector"] for r in rows if r["aies_measure_status"] == "missing"))
print("claim_support_values=" + ";".join(sorted(set(r["claim_support_updated"] for r in rows))))
print("ai_exposure_values=" + ";".join(sorted(set(r["ai_exposure_merged"] for r in rows))))
PY
git status --short --ignored data/analysis/sector_panel
git diff -- paper/draft.md
git diff --check
rg -n "analysis_tables_written=1|claim_support_updated=false|ai_exposure_merged=false|missing_aies_sector_rows=11;81|No rankings|No paper prose" research/data/sector_panel_descriptive_analysis.py research/data/sector_panel_descriptive_analysis_run.md research/data/sector_panel_analysis_design.md research/data/sector_panel_build_plan.md research/empirical_strategy.md research/predictions.md paper/evidence_requirements.md docs/operator/returns/2026-06-12-sector-panel-descriptive-analysis-return.md
rg -n "philosophical|religious|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" research/data/sector_panel_descriptive_analysis.py research/data/sector_panel_descriptive_analysis_run.md research/data/sector_panel_analysis_design.md research/data/sector_panel_build_plan.md research/empirical_strategy.md research/predictions.md paper/evidence_requirements.md docs/operator/returns/2026-06-12-sector-panel-descriptive-analysis-return.md
rg -n "[ \t]+$" .gitignore research/data/sector_panel_descriptive_analysis.py research/data/sector_panel_descriptive_analysis_run.md data/manifests/sector_panel_analysis_manifest.csv research/data/sector_panel_analysis_design.md research/data/sector_panel_build_plan.md research/empirical_strategy.md research/predictions.md paper/evidence_requirements.md docs/operator/returns/2026-06-12-sector-panel-descriptive-analysis-return.md
```

Expected results:

- Staging validator reports `analysis_performed=false`.
- Transform reports `analysis_performed=false` and
  `missing_aies_sector_rows=11;81`.
- Dry-run validator reports `calculations_performed=false`.
- Descriptive analysis reports `analysis_tables_written=1`,
  `analysis_rows_written=17`, `ai_exposure_merged=false`, and
  `claim_support_updated=false`.
- Analysis output check reports 17 rows, AIES missing sectors `11;81`,
  claim-support values `false`, and AI-exposure values `false`.
- Ignored-output check returns `!! data/analysis/`.
- `git diff -- paper/draft.md`: no output.
- `git diff --check`: pass with no output.
- Guardrail scan returns expected matches.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.

## Gap Reached

The next requirement is AI-exposure linkage design. Current descriptive
baseline measures cannot support sector-panel interpretation, prediction
outcomes, or claim-status changes until a verified exposure source and
comparison-group design are added.
