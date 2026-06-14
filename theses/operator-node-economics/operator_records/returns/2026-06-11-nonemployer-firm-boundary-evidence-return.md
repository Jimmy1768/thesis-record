---
record_id: return-2026-06-11-nonemployer-firm-boundary-evidence
record_type: return
workflow_id: 2026-06-11-nonemployer-firm-boundary-evidence
status: completed
created_at: 2026-06-11T13:05:48+08:00
owner: Research
---

# Return: Nonemployer And Firm-Boundary Evidence

## Scope

This direct Research pass focused on nonemployer receipts, formation,
survival/churn, transitions, small-vs-large AI gains, employer-to-vendor
substitution, management-layer measures, and direct evidence for or against
AI-enabled one-human firms.

`paper/draft.md` was not edited.

## Sources Directly Verified

- U.S. Census Bureau Nonemployer Statistics: program page, about page, and API
  documentation directly inspected. Accepted as primary measurement
  infrastructure for no-paid-employee establishments and receipts, not as
  AI-specific evidence.
- U.S. Census Bureau Business Formation Statistics: main page, definitions,
  and June 10, 2026 monthly release directly inspected. Accepted as primary
  measurement infrastructure for applications and employer wage-paying
  formations, not nonemployer-to-employer conversion or AI-specific formation.
- U.S. Census Bureau Business Dynamics Statistics: program page directly
  inspected. Accepted as primary measurement infrastructure for employer
  firm/establishment dynamics, not nonemployer or AI evidence.
- U.S. Census Bureau Statistics of U.S. Businesses: program page directly
  inspected. Accepted as primary employer-firm size, employment, and payroll
  baseline evidence, not nonemployer or management-layer evidence.
- Bick, Blandin, and Deming 2024, "The Rapid Adoption of Generative AI": NBER
  working-paper page, DOI, abstract, and data-appendix listing directly
  inspected. Accepted only as worker-level GenAI adoption and self-reported
  time-savings context, not firm-boundary evidence.

## Sources Rejected Or Not Used As Support

- "AI as Co-founder: GenAI for Entrepreneurship" (arXiv, 2025): appears
  directly relevant to AI and small-firm formation, but only an arXiv record
  was found in this pass. Not used as claim support.
- "Generative AI Fuels Solo Entrepreneurship, but Teams Still Lead at the Top"
  (arXiv, 2026): appears directly relevant to solo entrepreneurship and
  platform launches, but only an arXiv record was found. Not used as claim
  support.
- "Payrolls to Prompts: Firm-Level Evidence on the Substitution of Labor for
  AI" (arXiv, 2026): appears directly relevant to AI substitution for online
  labor marketplace spending, but only an arXiv record was found. Not used as
  claim support.

## Claims Changed

- Added `TCE-CLAIM-013` as `supported`: current verified U.S. data sources can
  measure nonemployer establishments and receipts, employer-business
  formations, and employer-firm dynamics, but they do not yet verify
  AI-enabled one-human firm-boundary change.

No Operator Node claim was promoted.

## Predictions Updated

- Added NES/AIES-NES, BFS, BDS, and SUSB as measurement-source candidates.
- Clarified that TCE-P001 and TCE-P009 can be operationalized with
  nonemployer receipts and counts, but still require AI-exposure linkage and
  survival/churn evidence.
- Clarified that TCE-P007 can use BFS employer formations as a conservative
  payroll-transition proxy, but BFS does not directly measure
  nonemployer-to-employer conversion or one-human nodes becoming firms.
- Clarified that TCE-P005 still lacks management-layer, span-of-control,
  manager-to-worker, and support-staff-ratio evidence.

## Criticisms Updated

- Strengthened `node-becomes-firm` with BFS as a possible payroll-transition
  measurement source while preserving the limitation that BFS does not identify
  AI-enabled one-human nodes.
- Added `nonemployer-data-is-not-node-evidence`: NES and AIES-NES are necessary
  baselines, but nonemployer receipts and counts do not by themselves identify
  AI use, one-human automation stacks, hidden contractors, client retention,
  quality, transaction costs, or durable firm-boundary share.

## Evidence Gaps Remaining

- No verified direct source links AI use to nonemployer receipts, survival,
  churn, revenue per human, or durable high-receipt one-human businesses.
- No verified direct source links AI use to nonemployer-to-employer transition
  or to successful one-human nodes staying one-human across growth thresholds.
- No verified direct source measures employer-to-contractor or
  employer-to-vendor substitution caused by AI.
- No verified direct source measures management-layer thinning, span of
  control, manager-to-worker ratios, support-staff ratios, or org-chart depth
  after AI adoption.
- No verified direct source shows AI-enabled one-person firms gaining durable
  revenue share against employer firms.

## Evidence Separation

Task-productivity, transaction-cost, and firm-boundary evidence were kept
separate.

- NES/BFS/BDS/SUSB are measurement infrastructure for business boundaries and
  baselines.
- Bick, Blandin, and Deming 2024 is worker-level AI adoption context.
- None of the newly accepted sources is transaction-cost evidence.
- None of the newly accepted sources proves AI-specific firm-boundary change.

## Files Changed

- `research/source_notes/census_2023_nonemployer_statistics.md`
- `research/source_notes/census_2026_business_formation_statistics.md`
- `research/source_notes/census_2023_business_dynamics_statistics.md`
- `research/source_notes/census_2022_statistics_us_businesses.md`
- `research/source_notes/bick_blandin_deming_2024_rapid_adoption_generative_ai.md`
- `research/claims_index.md`
- `research/predictions.md`
- `research/criticisms.md`
- `research/open_questions.md`
- `paper/evidence_requirements.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-11-nonemployer-firm-boundary-evidence-return.md`

## Exact Verification Performed

- Opened Census Nonemployer Statistics program page.
- Opened Census Nonemployer Statistics about page.
- Opened Census Nonemployer Statistics API documentation.
- Opened Census 2023 AIES-NES/nonemployer visualization page as an access path
  to comparable employer/nonemployer national revenue tables.
- Opened Census Business Formation Statistics main page.
- Opened Census Business Formation Statistics definitions page.
- Opened Census Business Formation Statistics June 10, 2026 monthly release.
- Opened Census Business Dynamics Statistics program page.
- Opened Census Statistics of U.S. Businesses program page.
- Opened NBER Working Paper 32966 page and data-appendix listing.
- Searched for AI-specific nonemployer, solo-entrepreneurship,
  employer-to-vendor, online-labor-substitution, and management-layer sources;
  the direct AI-specific hits found in this pass were not accepted as support
  because they were arXiv-only records or did not measure firm-boundary
  outcomes.

## Source Links Used

- https://www.census.gov/programs-surveys/nonemployer-statistics.html
- https://www.census.gov/programs-surveys/nonemployer-statistics/about.html
- https://www.census.gov/data/developers/data-sets/nonemp-api.html
- https://www.census.gov/library/visualizations/2026/econ/2023-nes-industries-revenue.html
- https://www.census.gov/econ/bfs/index.html
- https://www.census.gov/econ/bfs/definitions.html
- https://www.census.gov/econ/bfs/current/index.html
- https://www.census.gov/programs-surveys/bds.html
- https://www.census.gov/programs-surveys/susb.html
- https://www.nber.org/papers/w32966
- https://data.nber.org/data-appendix/w32966/

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
rg -n "TCE-CLAIM-013|nonemployer-data-is-not-node-evidence|NES|AIES-NES|BFS|BDS|SUSB" research/claims_index.md research/predictions.md research/criticisms.md paper/evidence_requirements.md research/reading_queue.md
rg -n "Status:" research/source_notes/census_2023_nonemployer_statistics.md research/source_notes/census_2026_business_formation_statistics.md research/source_notes/census_2023_business_dynamics_statistics.md research/source_notes/census_2022_statistics_us_businesses.md research/source_notes/bick_blandin_deming_2024_rapid_adoption_generative_ai.md
```

Expected results:

- `paper/draft.md` should show no diff.
- `git diff --check` should pass.
- New source notes should show verification statuses.
- Guardrail scans should show no new research-content violations from this
  pass.

## Commit Recommendation

Do not commit until Company Operator or the user approves the slice.
