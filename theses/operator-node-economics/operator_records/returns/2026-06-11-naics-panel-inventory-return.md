---
record_id: return-2026-06-11-naics-panel-inventory
record_type: return
workflow_id: 2026-06-11-naics-panel-inventory
status: completed
created_at: 2026-06-11T14:13:07+08:00
owner: Research
---

# Return: NAICS Panel Inventory

## Scope

This Research pass created a conservative dataset inventory and field-level
dictionary before any quantitative analysis. It is data architecture only.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/naics_panel_inventory.md`
- `research/data/field_dictionary.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-11-naics-panel-inventory-return.md`

## Sources Inspected Or Reused

Reused accepted source notes:

- `research/source_notes/census_2023_nonemployer_statistics.md`
- `research/source_notes/census_2026_business_formation_statistics.md`
- `research/source_notes/census_2023_business_dynamics_statistics.md`
- `research/source_notes/census_2022_statistics_us_businesses.md`
- `research/source_notes/census_2026_ai_use_us_businesses.md`
- `research/source_notes/bonney_et_al_2026_microstructure_ai_diffusion.md`
- `research/source_notes/bick_blandin_deming_2024_rapid_adoption_generative_ai.md`

Additional inspection:

- Official Census NES API variable page for 2023 was inspected to record exact
  NES field names.
- BFS, BDS, and SUSB guessed API variable endpoints returned 404, so their
  fields are documented as concept fields requiring exact mapping before
  analysis.

## Dataset Inventory Summary

- NES: verified primary source for no-paid-employee establishments and
  receipts. Exact 2023 API fields were recorded for `NESTAB`, `NRCPTOT`,
  `RCPSZES`, `LFO`, `NAICS2022`, geography fields, and year. NES supports
  nonemployer baseline measurement but not AI use, survival, hidden labor, or
  one-human status.
- AIES-NES: verified as an access path for national employer/nonemployer
  revenue comparison beginning with 2023. Exact table/API fields still need
  mapping before analysis.
- BFS: verified primary source for business applications and employer
  wage-paying formations. Kept explicitly as an indirect payroll-transition
  proxy, not nonemployer-to-employer conversion evidence.
- BDS: verified primary source for employer firm/establishment dynamics.
  Useful for employer startup/shutdown and job-flow context, not nonemployer
  or AI-specific evidence.
- SUSB: verified primary source for employer establishments with paid
  employees by industry and enterprise size, including firm/establishment
  counts, employment, and payroll. Not hierarchy-depth evidence.
- BTOS AI supplement: verified primary source for employer-business AI
  adoption/exposure. It does not measure nonemployer outcomes or
  firm-boundary change.
- Bonney et al. 2026: verified primary working paper for employer-firm AI
  diffusion and reported labor effects. It is associational and does not
  measure nonemployer transitions, outsourcing, or management layers.
- Bick/Blandin/Deming 2024: kept as worker-level GenAI adoption context only.

## Prediction Coverage Table

| Prediction | Covered By Inventory | Still Missing |
| --- | --- | --- |
| TCE-P001 | NES receipts/counts; AIES-NES employer/nonemployer revenue; SUSB employment/payroll; BTOS/Bonney AI adoption context | Direct nonemployer AI use, hidden labor, survival, client retention |
| TCE-P007 | BFS employer formations; BDS employer startups; NES high-receipt cells | Direct nonemployer-to-employer conversion, one-human status, AI use, managerial hiring |
| TCE-P009 | NES counts and receipt-size classes; BFS applications; BDS startup/shutdown context | Direct nonemployer survival/churn, exit reasons, AI linkage |
| TCE-P010 | NES/AIES-NES nonemployer revenue share; SUSB/BDS employer baselines; BTOS/Bonney large-firm AI adoption | Concentration ratios, direct productivity capture, profits, AI-linked revenue outcomes |
| TCE-P005 | Not covered by public Census inventory | Manager-to-worker ratios, span of control, support-staff ratios, reporting layers after AI adoption |

## Proposed Join Keys

- NAICS-year: first-pass panel unit for NES, AIES-NES, SUSB/BDS, and
  BTOS/Bonney exposure context where industry detail is compatible.
- Geography-NAICS-year: possible when NES geography detail can be matched to
  BFS/BDS/SUSB geography, with explicit geography availability checks.
- Employer/nonemployer comparison cells: possible where AIES-NES/SUSB/NES
  concepts permit national industry comparison.
- Exposure cells: possible only after AI adoption or exposure source, unit,
  and NAICS mapping are documented.

## Missing Fields And Gaps

- AI linkage to nonemployers.
- Hidden contractors, unpaid family labor, offshore labor, and platform labor.
- Nonemployer survival, churn, exit, and transition to payroll employer.
- Management-layer ratios, span of control, support-staff ratios, and org
  depth.
- Employer-to-vendor substitution, procurement cycle time, contracting cost,
  dispute rate, rework rate, and payment-delay outcomes.
- Exact public-use/API variable names for BFS, BDS, SUSB, AIES-NES, and BTOS.
- NAICS-vintage crosswalks and geography compatibility checks.
- Accepted NAICS- or occupation-weighted AI exposure measure beyond observed
  employer-business BTOS/Bonney evidence.

## Boundaries Preserved

- No quantitative analysis was run.
- No Operator Node claim was promoted.
- BFS employer formations were labeled only as an indirect payroll-transition
  proxy.
- Bick/Blandin/Deming 2024 was kept as worker-level GenAI adoption context
  only.
- ArXiv-only AI entrepreneurship or labor-substitution sources remain outside
  source truth and claim support.
- `paper/draft.md` remained untouched.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
rg -n "BFS employer formations|payroll-transition proxy|worker-level GenAI adoption|arXiv-only|TCE-P005|TCE-P001|TCE-P007|TCE-P009|TCE-P010" research/data/naics_panel_inventory.md research/data/field_dictionary.md research/reading_queue.md docs/operator/returns/2026-06-11-naics-panel-inventory-return.md
rg -n "NESTAB|NRCPTOT|RCPSZES|NAICS2022|concept_field|verified_exact" research/data/field_dictionary.md
rg -n "Status:" research/source_notes/census_2023_nonemployer_statistics.md research/source_notes/census_2026_business_formation_statistics.md research/source_notes/census_2023_business_dynamics_statistics.md research/source_notes/census_2022_statistics_us_businesses.md research/source_notes/census_2026_ai_use_us_businesses.md research/source_notes/bonney_et_al_2026_microstructure_ai_diffusion.md research/source_notes/bick_blandin_deming_2024_rapid_adoption_generative_ai.md
```

Expected results:

- `paper/draft.md` should show no diff.
- `git diff --check` should pass.
- Inventory and dictionary should show proxy/guardrail language.
- Source-note status scan should show accepted verification statuses.

## Acceptance Readiness

This slice is ready for Company Operator acceptance review. It should not be
committed until accepted or explicitly approved by the user.
