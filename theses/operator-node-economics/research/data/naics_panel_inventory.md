# NAICS Panel Inventory

Status: data architecture inventory. Not an analysis output.

This file identifies candidate datasets and join units for future empirical
tests. It does not run quantitative analysis and does not support any
Operator Node claim by itself.

## Inventory Summary

| Dataset | Owner | Source-Note Status | Available Years | NAICS Granularity | Geography Granularity | Measures AI Exposure? | Measures Boundary Outcomes? | TCE-P005 Support? |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| NES | U.S. Census Bureau | `verified_primary_source` in `census_2023_nonemployer_statistics.md` | API page lists 1997-2023; 2023 uses 2022 NAICS | 2022 NAICS, varying detail by industry | U.S., state, metro/micro, combined statistical area, county | No | Yes, no-paid-employee establishments and receipts | No |
| AIES-NES | U.S. Census Bureau | covered in NES source note as directly inspected access path | 2023 API endpoint verified | 2017 NAICS, U.S. national employer/nonemployer revenue comparison | U.S. only in inspected API metadata | No | Yes, employer/nonemployer sales, shipments, or revenue comparison | No |
| BFS | U.S. Census Bureau | `verified_primary_source` in `census_2026_business_formation_statistics.md` | Current monthly release inspected for May 2026; API supports year/month `time` field | Industry/category via `category_code`, exact NAICS mapping unresolved; January 2026 monthly release restated time series to 2022 NAICS per Census announcement | U.S. only in inspected API geography metadata | No | Indirect employer-formation proxy only | No |
| BDS | U.S. Census Bureau | `verified_primary_source` in `census_2023_business_dynamics_statistics.md` | 1978-2023 in official downloadable sector-age-size CSV; API `BDSFAGEFSIZE` checks verified selected 2022 contexts only | 2017 NAICS via exact `NAICS` field in API; official multi-year CSV uses `sector`, not six-digit NAICS | U.S., state, county, metro/micro in inspected API metadata; 2022 API `BDSFAGEFSIZE` query forms returned JSON for selected geographies; multi-year CSV is sector-level only | No | Employer-firm dynamics only | No |
| SUSB | U.S. Census Bureau | `verified_primary_source` in `census_2022_statistics_us_businesses.md` | Latest inspected data year 2022; U.S./state annual record layout covers 2007-present | 2017 NAICS via exact `NAICS` field in U.S./state annual layout | U.S./state exact `STATE` field verified; MSA and other layouts require separate check | No | Employer-firm size, employment, payroll baseline | No |
| BTOS AI supplement | U.S. Census Bureau | `verified_primary_source` in `census_2026_ai_use_us_businesses.md` | Inspected article covers Dec. 14, 2025-May 3, 2026; AI wording revised Nov. 17, 2025 | 2017 NAICS sector and three-digit subsector tabulations confirmed by BTOS data page; public-use field names unresolved | State, 25 most populous MSAs, state-sector tabulations confirmed by BTOS data page; public-use field names unresolved | Yes, employer-business AI use and expected use | No direct boundary outcomes | No |
| Bonney et al. 2026 | U.S. Census Bureau CES working paper | `verified_primary_source` in `bonney_et_al_2026_microstructure_ai_diffusion.md` | BTOS AI supplement reference period Nov. 2025-Jan. 2026 | Employer-firm sector/size summaries, not a public panel dataset in repo | National employer-firm survey evidence | Yes, employer-firm AI diffusion and task/function use | Partial reported labor effects; no nonemployer or boundary transitions | No |
| Bick/Blandin/Deming 2024 | NBER | `verified_reputable_working_paper` in `bick_blandin_deming_2024_rapid_adoption_generative_ai.md` | 2024 survey context, revised 2025 | Occupation/worker survey context, not NAICS panel | National worker/adult survey | Worker-level GenAI adoption context only | No | No |

## Dataset Details

### NES

Use for:

- TCE-P001: nonemployer establishments, receipts, receipts per establishment,
  and high-receipt nonemployer cells.
- TCE-P009: entry-like nonemployer count changes and receipt-size patterns.
- TCE-P010: nonemployer side of employer/nonemployer share comparisons.

Key verified API fields:

- `YEAR`
- `NAICS2022`
- `NAICS2022_LABEL`
- `NESTAB`
- `NRCPTOT`
- `NRCPTOT_N`
- `RCPSZES`
- `RCPSZES_LABEL`
- `LFO`
- `LFO_LABEL`
- `GEO_ID`
- `NAME`
- `STATE`
- `COUNTY`
- `CBSA`
- `CSA`

Comparability warnings:

- The 2022 release incorporated major methodology changes that affect
  historical comparability.
- NES does not identify AI use, hidden contractors, labor hours, survival, or
  transitions to employer status.
- "No paid employees" is not equivalent to one-human status.

### AIES-NES

Use for:

- TCE-P001 and TCE-P010: employer/nonemployer revenue-share baselines at the
  national industry level where comparable AIES-NES tables are available.

Fields to verify before analysis:

- Additional downloadable-table fields beyond the API endpoint, if needed.
- Whether years beyond 2023 become available.

Comparability warnings:

- API endpoint is U.S.-only in inspected geography metadata.
- Employer and nonemployer revenues are separate fields, not a row-level
  employer/nonemployer class.
- Uses 2017 NAICS, while 2023 NES uses 2022 NAICS.

### BFS

Use for:

- TCE-P007: indirect payroll-transition proxy.
- TCE-P009: business application and high-propensity application context.

Fields needed:

- Exact API structural fields verified: `time`, `data_type_code`,
  `time_slot_id`, `seasonally_adj`, `program_code`, `category_code`,
  `geo_level_code`, `time_slot_date`, `time_slot_name`, `cell_value`,
  `error_data`.
- Target measure codes verified from official monthly data dictionary and API
  example-shape query: `BA_BA`, `BA_HBA`, `BF_BF4Q`, `BF_BF8Q`,
  `BF_PBF4Q`, and `BF_PBF8Q`.
- Monthly sector/aggregate category codes verified from official data
  dictionary, including `TOTAL`, `NAICS11`, `NAICSMNF`, `NAICSRET`,
  `NAICSTW`, and `NONAICS`.

Required label:

- BFS employer formations are an indirect payroll-transition proxy. They are
  not nonemployer-to-employer conversion evidence.

Implementation scaffold:

- `research/data/bfs_api_ingestion_scaffold.md`
- `research/data/bfs_value_code_mapping.md`
- `research/data/bfs_ingestion_design.md`
- `research/data/bfs_sample_row_load.md`
- `research/data/bfs_metric_definition_scaffold.md`
- `research/data/bfs_metric_computation_design.md`
- `research/data/bfs_source_native_observations.md`
- `research/data/bfs_quality_review_policy.md`
- The Rails scaffold registers official API metadata and verified monthly
  value-code mappings.
- The first ingestion design adds staging schema.
- The V1 sample load stores 2012 U.S.-level raw/staged rows only. It still keeps
  NAICS panel use blocked until transformation, aggregation, suppression, and
  metric rules are approved.
- The metric-definition scaffold creates draft-disabled BFS definitions only.
- The metric-computation design allows source-native monthly context
  observations only, with no aggregation, trends, links, exports, or claim
  support.
- BFS quality reviews mark observations as reviewed context only and remain
  claim-neutral.

Comparability warnings:

- BFS does not identify AI use.
- BFS does not measure nonemployer receipts, survival, hidden contractors, or
  one-human status.
- Applications can include entities that never operate.
- Inspected API geography metadata confirms only U.S. geography; other
  geographies must be verified through another official access path before
  use.
- Industry/NAICS use remains blocked for analysis until an ingestion design
  chooses sector categories, aggregate categories, `NONAICS`, seasonal
  adjustment, and harmonization handling.
- The January 2026 monthly release restated the entire time series to 2022
  NAICS, so joins to 2017-NAICS sources need an explicit crosswalk or
  aggregation rule.

### BDS

Use for:

- TCE-P007: employer startup/shutdown and firm-age dynamics as indirect scaling
  or payroll-transition context.
- TCE-P009: employer-side startup/shutdown comparison when nonemployer entry
  changes.
- TCE-P010: employer-firm growth, concentration-adjacent, and
  corporate-absorption context.

Fields needed:

- Exact fields verified: `FIRM`, `ESTAB`, `EMP`, `ESTABS_ENTRY`,
  `ESTABS_EXIT`, `FIRMDEATH_FIRMS`, `JOB_CREATION`,
  `JOB_CREATION_BIRTHS`, `JOB_DESTRUCTION`, `JOB_DESTRUCTION_DEATHS`,
  `NET_JOB_CREATION`, `FAGE`, `EMPSZFI`, `EMPSZES`, `NAICS`, `GEO_ID`,
  `STATE`, `COUNTY`, `CBSA`, `time`, `YEAR`.
- Group metadata partially closes firm-age-by-firm-size compatibility:
  `BDSFAGEFSIZE` includes `NAICS`, `FAGE`, `EMPSZFI`, `GEO_ID`, `YEAR`,
  `FIRM`, `ESTAB`, `EMP`, `ESTABS_ENTRY`, `FIRMDEATH_FIRMS`, and
  `JOB_CREATION_BIRTHS`.
- 2022 U.S. value-label queries verify 15 `FAGE` rows and 14 `EMPSZFI` rows;
  see `research/data/bds_value_sets.md`.
- 2022 coverage validation verifies U.S., state, selected county, metro/micro,
  and selected NAICS query forms; see `research/data/bds_coverage_validation.md`.
- Official 2023 BDS datasets page exposes `bds2023_sec_fa_fz.csv`, a
  multi-year sector by firm age by firm size CSV covering 1978-2023; see
  `research/data/bds_multiyear_firm_age_size_path.md`.
- The living dissertation app has a metadata-only scaffold for this public
  file; see `research/data/bds_public_file_scaffold.md`. The scaffold does not
  fetch rows, create metrics, authorize analysis, or support claims.
- The living dissertation app also has disabled acquisition/parser design
  guardrails for the same file; see
  `research/data/bds_acquisition_parser_design.md`. These guardrails define
  the future parser contract but do not create rows or findings.
- The living dissertation app has validated the ignored local BDS public file
  against the committed manifest; see `research/data/bds_fetch_validation.md`.
  This is still metadata/source validation only, not staged rows or findings.
- The living dissertation app has an empty BDS staging-table skeleton; see
  `research/data/bds_staging_table_skeleton.md`. The table has no BDS rows and
  does not change prediction or claim status.
- The living dissertation app has a fixture-only BDS parser skeleton; see
  `research/data/bds_parser_skeleton.md`. It parses in memory, persists zero
  rows, and does not change prediction or claim status.
- The living dissertation app has a full local-file BDS parser dry run; see
  `research/data/bds_parser_dry_run.md`. It reads the ignored local CSV,
  reports row, duplicate-key, coverage, numeric-cell, and publication-flag
  counts, persists zero rows, and does not change prediction or claim status.
- The living dissertation app has a BDS row-load QA policy gate; see
  `research/data/bds_row_load_qa_policy.md`.
- The living dissertation app has loaded source-native BDS rows into
  PostgreSQL; see `research/data/bds_source_row_load.md`. These are source rows
  only, not metric observations or claim support.
- The living dissertation app has draft-disabled BDS metric definitions; see
  `research/data/bds_metric_definition_scaffold.md`. These are definitions
  only, not observations or claim support.
- The living dissertation app has a BDS metric-computation design; see
  `research/data/bds_metric_computation_design.md`.
- The living dissertation app has BDS source-native context observations; see
  `research/data/bds_source_native_observations.md`.
- The living dissertation app has BDS quality reviews; see
  `research/data/bds_quality_reviews.md`. They are reviewed context only, not
  claim support.
- Direct firm-startup field remains unresolved in the extracted field set.

Comparability warnings:

- BDS is employer-firm evidence only.
- It does not measure AI adoption, nonemployers, management layers, vendor
  substitution, or transaction costs.
- BDS uses 2017 NAICS in the inspected API metadata.
- Geography metadata confirms U.S., state, county, and metro/micro levels.
- Key-first data-query syntax is verified for selected 2022 age/size coverage
  contexts, but 2019-2021 and 2023 checks returned no rows for the tested
  all-industry U.S. context.
- Do not assume six-digit NAICS coverage in `BDSFAGEFSIZE`; `NAICS=541511`
  returned no rows in the tested 2022 U.S. context.
- The official multi-year sector-age-size CSV closes a sector-level trend path
  but not a six-digit NAICS or subnational age/size path.

### SUSB

Use for:

- TCE-P001: small employer comparison group against nonemployer cells.
- TCE-P010: employer size, employment, payroll, and enterprise-size baseline.

Key verified U.S./state annual layout fields:

- `FIRM`
- `ESTB`
- `EMPL`
- `PAYR`
- `ENTRSIZE`
- `NAICS`
- `STATE`
- `EMPLFL_N`
- `PAYRFL_N`
- `RCPT` and `RCPTFL_N` for years ending in 2 and 7.
- Year should be carried from file vintage unless a year field is verified in a
  specific extract.

Comparability warnings:

- SUSB excludes nonemployers.
- Enterprise size does not measure hierarchy depth.
- Employment/payroll baselines are not AI adoption or transaction-cost
  outcomes.
- The verified record layout is for U.S./state annual datasets; MSA and other
  geographies require their own record-layout verification.

### BTOS AI Supplement

Use for:

- TCE-P001 and TCE-P010: preferred observed employer-business AI adoption or
  expected-use exposure measure where industry/size cells are available.
- TCE-P006: adoption-by-size criticism already tracked in claims.

Question concepts verified from the AI-supplement questionnaire:

- Question 23: current AI use in any business function.
- Question 24: AI use by business function.
- Question 25: whether AI performed, supplemented, or introduced employee
  tasks.
- Question 28: total employment effect.
- Question 29: changes made to use AI.
- Question 31: employee generative-AI use.
- Question 32: generative-AI work-task categories.
- Questions 33-34: expected AI use.

Fields still needed before analysis:

- Public-use variable names.
- Survey period field.
- Weights.
- Download/API access path for tabular extracts.

Comparability warnings:

- BTOS covers employer businesses, not nonemployers.
- The November 17, 2025 wording change means pre/post wording comparisons
  require caution.
- BTOS adoption does not measure productivity, nonemployer outcomes,
  management layers, or firm-boundary transitions.

### Bonney et al. 2026

Use for:

- AI adoption concentration by firm size and knowledge-intensive sectors.
- Employer-firm augmentation/substitution context.
- Disconfirming pressure against immediate broad employer headcount shrinkage.

Fields/concepts used:

- AI use.
- Employment-weighted AI use.
- Business function breadth.
- Worker task categories.
- Augmentation/substitution reports.
- Reported employment increases/decreases.
- Firm size and sector summaries.

Comparability warnings:

- The paper is associational, not causal.
- It covers employer firms, not nonemployer Operator Nodes.
- It does not measure management layers, outsourcing, vendor substitution, or
  nonemployer transitions.

## Proposed Join Keys

### NAICS-Year

Primary candidate for first panel design.

Use when:

- Combining NES nonemployer receipts/counts with SUSB/BDS employer baselines.
- Adding BTOS/Bonney sector-level AI adoption exposure.

Required normalization:

- NAICS vintage.
- Industry level.
- Suppression/noise flags.
- Inflation adjustment for receipts/payroll before analysis.

### Geography-NAICS-Year

Use when:

- NES geography detail is retained.
- BFS applications/formations or BDS/SUSB subnational data are available at
  compatible geography.

Risks:

- Geography coverage differs by dataset.
- Small cells may be suppressed or noisy.
- Subnational AI exposure may be unavailable.

### Employer/Nonemployer Comparison Cells

Use when:

- AIES-NES and SUSB/NES permit comparable national industry cells.

Candidate dimensions:

- Year.
- NAICS.
- Employer/nonemployer class.
- Revenue or receipts.
- Establishments/firms where comparable.

Risks:

- AIES-NES is currently verified as an access path, not a fully documented API
  schema in the repo.
- Employer/nonemployer concepts are not identical to firm hierarchy or
  one-human status.

## Prediction Coverage Table

| Prediction | Covered Fields | Partial Proxy | Missing Blockers |
| --- | --- | --- | --- |
| TCE-P001 | NES receipts/counts; AIES-NES employer/nonemployer revenue; SUSB employment/payroll; BTOS/Bonney AI adoption exposure | Receipts per nonemployer establishment and nonemployer revenue share | Direct AI use among nonemployers, hidden labor, survival, quality, client retention |
| TCE-P007 | BFS employer formations; BDS employer startups; NES high-receipt cells | Payroll-transition proxy | Direct nonemployer-to-employer conversion, AI use, one-human status, managerial hiring |
| TCE-P009 | NES establishment counts and receipt-size classes; BFS applications; BDS startup/shutdown context | Entry/churn-like sector patterns | Direct nonemployer survival/churn, AI linkage, exit reasons, repeat demand |
| TCE-P010 | NES/AIES-NES nonemployer revenue share; SUSB/BDS employer baselines; BTOS/Bonney large-firm AI adoption | Corporate-absorption alternative by sector | Concentration ratios, direct productivity capture, profits, AI linkage to revenue outcomes |
| TCE-P005 | None from public Census sources in this inventory | None | Manager-to-worker ratios, span of control, support-staff ratios, reporting layers after AI adoption |

## Missing Fields Blocking Stronger Claims

- AI use or AI exposure at the nonemployer/business-owner level.
- Hidden contractors, unpaid family labor, offshore labor, or platform labor.
- Nonemployer survival, churn, exit, and transition to payroll employer.
- Receipt durability and client retention.
- Management-layer ratios, span of control, support-staff ratios, and org
  depth.
- Vendor substitution, procurement cycle time, contracting cost, dispute rate,
  rework rate, and payment-delay outcomes.
- Sector-level asset specificity, liability, measurability, and procurement
  friction scores.
- A many-to-many 2017-to-2022 allocation-weight source for changed NAICS
  codes, if fine-grained changed-code comparisons are later required.

## Pre-Analysis Rules

- Do not run quantitative analysis until exact table schemas and NAICS vintages
  are documented for every dataset used.
- Use `research/data/naics_harmonization_rule.md` for mixed 2017/2022-vintage
  panels: default to stable sector-level comparison, allow same-code finer
  comparison only where the 2022 Census change indicator is blank or `*`, and
  block `**`, `***`, and `****` changed-code cells unless they are excluded,
  aggregated to a stable parent, or covered by a later approved allocation
  source.
- Use `research/data/naics_code_list_qa.md` for current code-list readiness:
  first-pass mixed-vintage panels should use the 17-sector all-source overlap
  and should exclude `55` and `61` unless later source paths close those gaps.
- Do not compare pre-2022 and post-2022 NES values without a methodology
  adjustment or explicit caveat.
- Do not treat BFS employer formations as nonemployer-to-employer conversions.
- Do not treat worker-level GenAI adoption as business-boundary evidence.
- Do not use arXiv-only AI entrepreneurship or labor-substitution sources as
  source truth or claim support.
