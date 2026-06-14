---
record_id: return-2026-06-12-sector-panel-analysis-design
record_type: return
workflow_id: 2026-06-12-sector-panel-analysis-design
status: completed
created_at: 2026-06-12T14:05:00+08:00
owner: Research
---

# Return: Sector Panel Analysis Design

## Scope

This Research pass drafted the sector-panel analysis design for future
descriptive measures. It defines permitted measure families, validation gates,
interpretation rules, prediction mapping, and stop conditions.

It did not implement an analysis script, calculate measures, merge AI exposure,
update claim support, or write paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/sector_panel_analysis_design.md`
- `research/data/sector_panel_build_plan.md`
- `research/empirical_strategy.md`
- `research/predictions.md`
- `paper/evidence_requirements.md`
- `data/manifests/sector_panel_processed_manifest.csv`
- `docs/operator/returns/2026-06-12-sector-panel-analysis-design-return.md`

## Design Decisions

Future descriptive measures may be designed for:

- NES receipts per nonemployer establishment.
- AIES nonemployer revenue share where sector-level rows exist.
- SUSB employer baseline measures such as payroll per employee, employment per
  firm, and establishments per firm.
- BDS source-native employer dynamics fields without collapsing age/size cells.

Still blocked:

- AI-exposure labels.
- Treatment/control assignment.
- Growth rates.
- Inflation adjustment.
- Concentration ratios.
- High-receipt nonemployer shares.
- Nonemployer survival/churn.
- Nonemployer-to-employer transitions.
- Vendor substitution.
- Management-layer measures.
- Claim-support or contradiction updates.

## Key Guardrail

The current processed inputs can support only measurement readiness, baseline
descriptive design, and missing-cell identification. They cannot support
Operator Node claims, causal AI effects, durable firm-boundary shifts,
transaction-cost reductions, or management-layer thinning.

## AIES Missing-Cell Rule

The design preserves the current transform finding:

- AIES sector-level rows are missing for canonical sectors `11` and `81`.
- Those sectors must be excluded from AIES-based ratios or retained with an
  explicit missing-value flag.
- No filling, allocation, or inference is authorized.

## Remaining Blockers

- No analysis dry-run validator exists yet.
- No analysis script exists.
- No descriptive calculations have been run.
- No AI-exposure source has been merged.
- Claim support remains unchanged.

## Verification Commands

Run after editing:

```bash
python3 research/data/sector_panel_staging_validator.py
python3 research/data/sector_panel_transform.py
git diff -- paper/draft.md
git diff --check
rg -n "analysis design only|claim-support|missing_aies_sector_rows|No descriptive calculations|No quantitative analysis|No AI-exposure|No paper prose" research/data/sector_panel_analysis_design.md research/data/sector_panel_build_plan.md research/empirical_strategy.md research/predictions.md paper/evidence_requirements.md docs/operator/returns/2026-06-12-sector-panel-analysis-design-return.md
rg -n "philosophical|religious|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" research/data/sector_panel_analysis_design.md research/data/sector_panel_build_plan.md research/empirical_strategy.md research/predictions.md paper/evidence_requirements.md docs/operator/returns/2026-06-12-sector-panel-analysis-design-return.md
rg -n "[ \t]+$" research/data/sector_panel_analysis_design.md research/data/sector_panel_build_plan.md research/empirical_strategy.md research/predictions.md paper/evidence_requirements.md docs/operator/returns/2026-06-12-sector-panel-analysis-design-return.md
```

Expected results:

- Staging validator reports `staging_manifest_rows=5`,
  `staging_outputs_validated=5`, `staging_rows_validated=94303`, and
  `analysis_performed=false`.
- Transform reports `processed_tables_written=3`,
  `processed_manifest_rows=3`, `analysis_performed=false`, and
  `missing_aies_sector_rows=11;81`.
- `git diff -- paper/draft.md`: no output.
- `git diff --check`: pass with no output.
- Guardrail scan returns expected matches.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.

## Next Slice

The next Research slice can implement an analysis dry-run validator or skeleton
that checks processed-input hashes, denominator availability, missing AIES
cells, and manifest shape without calculating measures.
