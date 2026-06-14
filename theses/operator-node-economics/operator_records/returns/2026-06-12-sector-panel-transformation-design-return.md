---
record_id: return-2026-06-12-sector-panel-transformation-design
record_type: return
workflow_id: 2026-06-12-sector-panel-transformation-design
status: completed
created_at: 2026-06-12T13:25:00+08:00
owner: Research
---

# Return: Sector Panel Transformation Design

## Scope

This Research pass drafted a conservative transformation design for future
sector-level processed inputs. It defines proposed output tables, allowed joins,
source-field carry-forward rules, QA gates, and stop conditions.

It did not create a transformation script, create `data/processed/`, compute
empirical measures, merge AI exposure, update claim support, or write paper
prose.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/sector_panel_transformation_design.md`
- `research/data/sector_panel_build_plan.md`
- `research/empirical_strategy.md`
- `docs/operator/returns/2026-06-12-sector-panel-transformation-design-return.md`

## Design Summary

Proposed future outputs:

- `sector_source_index`: one row per canonical sector, source coverage and
  native NAICS metadata only.
- `sector_boundary_measure_inputs`: sector-level source-native fields from
  NES, AIES-NES, and SUSB; no derived measures.
- `sector_bds_age_size_inputs`: BDS employer dynamics preserved at
  sector-year-firm-age-firm-size grain; no aggregation.

Allowed future join:

- `canonical_sector` only.

Allowed join class:

- `sector_stable`.

Required source-vintage preservation:

- NES: `2022`.
- AIES-NES: `2017`.
- SUSB: `2017`.
- BDS sector-age-size CSV: `2017 sector categories`.

## Guardrails Added

The design blocks:

- fine-code 2017/2022 NAICS joins;
- allocation across changed NAICS cells;
- AI-exposure labels;
- ratios, shares, growth rates, rankings, treatment-effect estimates,
  prediction results, or claim-status updates;
- treating BDS establishment entry as firm startup;
- treating NES nonemployers as one-human firms.

## Remaining Blockers

- No transformation script exists yet.
- No processed panel exists.
- AIES-NES sector-level row selection must be verified in implementation before
  writing a sector-level processed table.
- No AI-exposure merge exists.
- No empirical findings are authorized.

## Verification Commands

Run after editing:

```bash
python3 research/data/sector_panel_staging_validator.py
git diff -- paper/draft.md
git diff --check
rg -n "sector_stable|analysis_performed=false|No quantitative analysis|No processed panel|No AI-exposure merge|does not authorize implementation or analysis" research/data/sector_panel_transformation_design.md research/data/sector_panel_build_plan.md research/empirical_strategy.md docs/operator/returns/2026-06-12-sector-panel-transformation-design-return.md
rg -n "Buddh[i]sm|Tao[i]sm|Sun[y]ata|dependent[ -]originat[i]on|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" research/data/sector_panel_transformation_design.md research/data/sector_panel_build_plan.md research/empirical_strategy.md docs/operator/returns/2026-06-12-sector-panel-transformation-design-return.md
rg -n "[ \t]+$" research/data/sector_panel_transformation_design.md research/data/sector_panel_build_plan.md research/empirical_strategy.md docs/operator/returns/2026-06-12-sector-panel-transformation-design-return.md
```

Expected results:

- Staging validator reports `staging_manifest_rows=5`,
  `staging_outputs_validated=5`, `staging_rows_validated=94303`, and
  `analysis_performed=false`.
- `git diff -- paper/draft.md`: no output.
- `git diff --check`: pass with no output.
- Guardrail scan returns expected matches.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.

## Next Slice

The next Research slice can implement a transformation script only if it writes
source-native fields, a tracked manifest, and `analysis_performed=false`. It
still must not calculate empirical measures or create claim support.
