---
record_id: return-2026-06-12-sector-panel-build-plan
record_type: return
workflow_id: 2026-06-12-sector-panel-build-plan
status: completed
created_at: 2026-06-12T00:20:00+08:00
owner: Research
---

# Return: Sector Panel Build Plan

## Scope

This Research pass created the acquisition and cleaning design for the
conservative 17-sector all-source overlap identified in the NAICS code-list QA
slice. It did not download new data, create transformation scripts, create a
processed panel, run quantitative analysis, or write paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/sector_panel_build_plan.md`
- `research/data/acquisition_scaffold.md`
- `research/empirical_strategy.md`
- `docs/operator/returns/2026-06-12-sector-panel-build-plan-return.md`

## Sources And Records Reused

- `research/data/naics_code_list_qa.md`
- `research/data/naics_harmonization_rule.md`
- `research/data/acquisition_scaffold.md`
- `research/data/nes_aies_api_ingestion_readiness.md`
- `research/data/susb_ingestion_readiness.md`
- `research/data/bds_multiyear_firm_age_size_path.md`
- `research/data/schema_mapping.md`
- `research/empirical_strategy.md`
- `paper/evidence_requirements.md`

No new external source was accepted in this slice.

## Dataset Inventory Summary

First-pass sector frame:

```text
11;21;22;23;31-33;42;44-45;48-49;51;52;53;54;56;62;71;72;81
```

First-pass exclusions:

- `55`: absent from inspected NES and AIES-NES code lists.
- `61`: absent from inspected AIES-NES code list.

Planned staging tables:

| Staging Table | Source | Role |
| --- | --- | --- |
| `stg_nes_sector_2023` | NES 2023 API | Nonemployer establishment and receipt outcomes |
| `stg_aies_nes_sector_2023` | AIES-NES 2023 API | National employer/nonemployer revenue comparison |
| `stg_susb_sector_2022` | SUSB 2022 U.S./state raw file | Employer firm, establishment, employment, payroll, and receipts baseline |
| `stg_bds_sector_age_size` | BDS sector-age-size CSV | Employer-firm age/size dynamics |

## Design Decisions

- Use sector-level joins only for first-pass mixed-vintage architecture.
- Keep `55` and `61` out of the all-source frame until a later source path
  closes the coverage gap.
- Keep raw files under ignored `data/raw/`, staging outputs under ignored
  `data/intermediate/`, and manifests under tracked `data/manifests/`.
- Require query inventories and manifests before any additional acquisition.
- Preserve all noise, suppression, and coefficient-of-variation fields before
  numeric coercion.
- Stop before shares, ratios, growth rates, rankings, treatment effects, or
  prediction outcomes.

## Prediction Coverage

| Prediction | Status |
| --- | --- |
| TCE-P001 | Architecture design exists for sector-level nonemployer and employer-baseline staging; AI linkage remains missing. |
| TCE-P007 | Employer-side proxy staging remains partial; no nonemployer-to-employer transition identifier. |
| TCE-P009 | Entry/count and employer-dynamics staging design exists; direct nonemployer survival/churn and AI linkage remain missing. |
| TCE-P010 | Employer-baseline staging design exists; no accepted AI-exposure merge or firm-boundary finding. |
| TCE-P005 | Blocked because no management-layer fields are verified. |

## Remaining Blockers

- No transformation script has been approved.
- No query inventory file has been created.
- No processed sector panel exists.
- No AI-exposure merge design exists.
- BTOS public-use extract schema remains unresolved.
- BFS `category_code` to NAICS mapping remains unresolved.
- Geography-sector QA remains undone.
- Fine-code mixed-vintage panels remain blocked by NAICS comparability and
  allocation issues.

## Guardrails Preserved

- No `paper/draft.md` edit.
- No paper prose.
- No quantitative analysis.
- No new raw data pull.
- No processed panel.
- No API key or secret recorded.
- No Operator Node claim promoted.
- No decision about the Operator Node hypothesis.
- No prohibited philosophical or religious foundation.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
rg -n "sector_panel_build_plan|17-sector|stg_nes_sector_2023|stg_aies_nes_sector_2023|stg_susb_sector_2022|stg_bds_sector_age_size|No quantitative analysis|No processed panel|No new raw data" research/data/sector_panel_build_plan.md research/data/acquisition_scaffold.md research/empirical_strategy.md docs/operator/returns/2026-06-12-sector-panel-build-plan-return.md
rg -n "Buddh[i]sm|Tao[i]sm|Sun[y]ata|dependent[ -]originat[i]on|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" research/data/sector_panel_build_plan.md research/data/acquisition_scaffold.md research/empirical_strategy.md docs/operator/returns/2026-06-12-sector-panel-build-plan-return.md
rg -n "[ \t]+$" research/data/sector_panel_build_plan.md research/data/acquisition_scaffold.md research/empirical_strategy.md docs/operator/returns/2026-06-12-sector-panel-build-plan-return.md
git status --short
```

Expected results:

- `git diff -- paper/draft.md`: no output.
- `git diff --check`: pass with no output.
- Sector-panel scan returns expected matches.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.

## Commit Status

This slice is ready to commit after verification.
