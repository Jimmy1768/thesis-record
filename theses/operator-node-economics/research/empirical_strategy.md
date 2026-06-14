# Empirical Strategy

Status: research design scaffold. Not a results file.

This file turns the current evidence gaps into testable designs. It does not
claim that Operator Nodes are emerging. It defines what data would be needed
to support, weaken, or reject firm-boundary predictions.

## Forecast Program Status

Operator Node Economics is a versioned forecast research program. The current
paper should be treated as V1: a forecast baseline, not a completed empirical
finding.

V1 should define:

- mechanisms;
- sector boundaries;
- 3-, 5-, and 10-year prediction horizons;
- leading indicators;
- feasibility evidence requirements;
- diffusion evidence requirements;
- failure conditions;
- update rules for V2 and V3.

Current Census work provides baseline measurement infrastructure for later
versions. It does not prove the thesis. A later version should publish the
evidence even if the thesis is weakened, narrowed, contradicted, or rejected.

The recurring measurement architecture is defined in
`research/living_forecast_system.md`. Automated jobs may refresh data,
manifests, and indicators, but claim-status changes require human review.

The AI-exposure and node-feasibility linkage architecture is defined in
`research/data/ai_exposure_node_feasibility_architecture.md`. Public exposure
proxies, node feasibility data, and transaction-cost data must remain separate
until a reviewed analysis design links them.

Private, company, partner, platform, payroll, procurement, node, AI-labor-
service, and evaluator data must follow
`research/data/private_data_governance.md` before ingestion.

## Core Measurement Problem

The current verified source base separates into three different layers:

- AI adoption or exposure: BTOS employer-business AI adoption; Bonney et al.
  2026 employer-firm AI diffusion; worker-level GenAI adoption from Bick,
  Blandin, and Deming 2024.
- Business-boundary outcomes: NES/AIES-NES nonemployer receipts and counts;
  BFS business applications and employer formations; BDS/SUSB employer-firm
  dynamics, employment, payroll, and enterprise-size baselines.
- Transaction-cost outcomes: still mostly missing for AI-enabled one-human
  suppliers.

The empirical challenge is linking AI exposure to business-boundary outcomes
without confusing task productivity, worker adoption, ordinary digital-services
growth, or post-pandemic self-employment trends with firm-boundary change.

Remote work is no longer treated as a generic risk factor in this design.
Office-to-remote work is the first unbundling: location separates from the
firm. The strong Operator Node thesis predicts a second unbundling in
AI-exposed, output-measurable digital work: remote salaried employment should
give way to node, vendor, owner-operator, or AI-labor-service capacity. If
remote salaried employment remains durable or grows after capable AI labor
services become available, that is a falsifier for the strong employment-
unbundling version of the thesis.

## Preferred Evidence Hierarchy

1. Direct linked administrative evidence:
   AI use or AI exposure linked to receipts, employment, payroll, survival,
   transitions, vendor status, or management-layer outcomes at the business
   level.
2. Sector-panel evidence:
   high-AI-exposure NAICS sectors compared with lower-exposure sectors before
   and after generative-AI diffusion, using NES/AIES-NES, SUSB, BDS, and BFS.
3. Occupation-to-industry exposure evidence:
   occupational GenAI exposure weighted by industry employment mix, then linked
   to nonemployer and employer-firm outcomes.
4. Worker/task evidence:
   task-productivity or worker-adoption studies. These can motivate exposure
   measures but cannot support firm-boundary claims by themselves.

## Data Source Roles

| Source | Role | Safe Use | Unsafe Use |
| --- | --- | --- | --- |
| BTOS AI supplement | Employer-business AI adoption by size, sector, and function | AI adoption/exposure among employer businesses | Nonemployer, productivity, or boundary outcomes |
| Bonney et al. 2026 | Employer-firm AI diffusion and reported labor effects | Adoption concentration, augmentation/substitution, headcount-impact constraints | Causal firm-boundary change |
| NES | No-paid-employee establishments and receipts | Nonemployer counts, receipts, receipt-size distribution | AI use, one-human status, hidden labor, survival |
| AIES-NES | National employer/nonemployer revenue comparison | Employer/nonemployer revenue-share baseline by covered industry | Causal AI effect |
| SUSB | Employer firm and establishment baselines | Employer counts, employment, payroll, enterprise size | Nonemployer or hierarchy-depth evidence |
| BDS | Employer-firm dynamics | Employer startups, shutdowns, job creation/destruction, firm age/size dynamics | Nonemployer transition or AI-specific effects |
| BFS | Applications and employer formations | Payroll-employer formation proxy and entry timing | Nonemployer-to-employer conversion |
| Bick/Blandin/Deming 2024 | Worker-level GenAI adoption context | Adoption context and possible exposure validation | Firm-boundary or transaction-cost claims |
| ACS PUMS | Worker-level worked-from-home, occupation, industry, and class-of-worker data | Public TCE-P011 monitoring baseline for remote wage/salary versus self-employment cells | AI use, vendor spend, node substitution, output, or replacement events |
| ATUS | Worker-level activity duration and work-location data | Work-at-home/workplace intensity by activity, occupation, and industry | Employment-boundary change, AI use, output, or substitution |
| BLS Contingent and Alternative Employment Arrangements | Alternative work arrangement categories by occupation, industry, and class | Independent-contractor, temporary-help, contract-firm, and traditional-arrangement context | Remote-work location, AI use, output, or firm procurement |
| BLS OEWS/OOH | Occupational employment, wage, and occupation-description context | Weak public proxy baseline for market research, survey research, and adjacent preference-validation occupations | Proof of creator, niche human provider, or experiencer classes |

## AI Exposure Measures

Use this order:

1. Observed employer-business AI adoption:
   BTOS AI adoption by NAICS, size, and business function. This is preferred
   when sector/size cells are available, because it is observed adoption rather
   than theoretical task exposure.
2. Observed sector concentration from Bonney et al. 2026:
   Use cautiously as sector-level adoption context, especially large-firm and
   knowledge-intensive-sector concentration.
3. Occupational GenAI exposure weighted to industry:
   Use only after verifying a durable source and crosswalk. Candidate sources
   include task/occupation exposure papers and O*NET/OEWS-based measures, but
   this pass did not accept a new occupational-exposure source as source truth.
4. Generic AI enthusiasm, media reports, or anecdotal tool use:
   Do not use for prediction tests.

## Prediction Designs

### TCE-P001: Revenue Per Human In AI-Exposed Digital Services

Question:

Do nonemployer businesses in high-AI-exposure, low-asset-specificity digital
services show faster receipts growth than small employer firms?

Primary unit:

- NAICS-year, ideally 6-digit NAICS where NES/SUSB/AIES-NES coverage supports
  comparison.

Candidate sectors:

- Professional, Scientific, and Technical Services.
- Information.
- Administrative and Support Services, limited to digitally deliverable work.
- Legal/accounting/marketing/design/software subindustries where NAICS detail
  permits.

Treatment/exposure:

- Preferred: BTOS AI adoption intensity by industry and firm size.
- Secondary: industry-level GenAI exposure from verified occupation-weighted
  exposure source, not yet accepted.

Outcomes:

- Nonemployer receipts.
- Nonemployer establishment count.
- Receipts per nonemployer establishment.
- High-receipt nonemployer share by receipt-size class.
- Employer-firm revenue or payroll/employment baseline where comparable
  AIES-NES/SUSB data exist.

Comparison:

- High-AI-exposure digital-service NAICS versus lower-exposure service NAICS.
- Nonemployer outcomes versus small employer-firm baselines.
- Pre/post 2022 or 2023, with caution because NES methodology changed in 2022.

Weak support threshold:

- High-AI-exposure sectors show faster nonemployer receipts per establishment
  or high-receipt nonemployer share growth than comparable lower-exposure
  sectors, without equal or stronger growth among small employer firms.

Support threshold:

- Same pattern persists across multiple years, survives sector controls, and
  is linked to verified AI adoption or exposure rather than generic digital
  demand.

Disconfirmation:

- Nonemployer receipts share stagnates or falls in high-AI-exposure sectors
  while employer firms gain revenue, payroll, or concentration share.

Main confounders:

- Post-pandemic self-employment, inflation, sector demand, platform work, tax
  reclassification, methodology change, hidden contractors, and survivorship
  bias.
- Remote salaried employment is not a control-only confounder for the strong
  thesis. It should be measured directly as a transition or falsifier.

### TCE-P011: Remote Employment Displacement

Question:

Does remote salaried employment decline in AI-exposed, output-measurable
digital roles as firms buy node, vendor, owner-operator, or AI-labor-service
capacity instead?

Primary unit:

- Occupation-sector-year where remote-work and AI-exposure measures are
  available.
- Firm-role-year or company procurement records where private data are
  available.

Outcomes:

- Remote employee headcount or share.
- Payroll employment in remote-capable digital roles.
- Contractor/vendor spend in matching service categories.
- AI-labor-service spend or usage where observable.
- Nonemployer receipts in matching digital-service NAICS categories.
- Output per employee or revenue per employee, where available.

Weak support:

- Remote employee share falls in high-AI-exposure, output-measurable roles
  while output holds or rises and contractor/vendor, node, nonemployer, or AI
  labor-service indicators rise.

Support:

- The same pattern persists across multiple years, is linked to verified AI
  exposure or direct AI-labor-service adoption, and survives controls for
  general outsourcing, offshoring, sector demand, and recession/cost cutting.

Disconfirmation:

- Remote salaried employment remains durable or grows in AI-exposed,
  output-measurable roles after capable AI labor services are available, with
  no offsetting increase in node, vendor, owner-operator, or AI-labor-service
  substitution.

Main limitation:

- Current public sources do not cleanly separate remote employees from
  contractors, vendors, owner-operators, AI labor services, offshoring, and
  ordinary outsourcing. This design likely requires private HRIS, payroll,
  procurement, vendor-master, or labor-market posting data.
- Private data for this test must pass the governance, disclosure, hidden-
  labor, baseline, and aggregation gates in
  `research/data/private_data_governance.md`.

Public-source measurement design:

- ACS PUMS can provide `JWTRNS=11` worked-from-home cells crossed with `COW`
  class of worker, `OCCP` occupation, and `INDP` industry.
- ATUS can provide work-location intensity using `TEWHERE`, `TRCODE`, and
  `TUACTDUR24`, with occupation and industry recodes where available.
- BLS Contingent and Alternative Employment Arrangements can provide
  independent-contractor, temporary-help, contract-firm, and traditional-work
  arrangement context by occupation and industry.
- These sources support only a descriptive monitoring baseline until direct
  substitution, output, and AI-service fields are governed and collected.

### TCE-P012: Economic Class Implications

Question:

If AI-enabled production becomes abundant and firms become smaller productivity
nodes, do economic roles shift toward creators, niche human providers, and
experiencers?

Primary unit:

- Role-year or occupation-year for weak public proxies.
- Task-market-year, platform-year, or firm/service-year for direct private
  data where available.

Outcomes:

- Creator/operator income, receipts, or active productive-system orchestration.
- Niche human-provider wages, prices, or scarcity premiums.
- Paid human evaluation task count.
- Paid evaluator count.
- Evaluation compensation by task difficulty, credential, duration, or review
  quality.
- Share of preference validation performed by paid humans versus telemetry,
  synthetic users, automated scoring, or elite tastemakers.

Weak public baseline:

- BLS OEWS employment and wage trends for adjacent occupations such as market
  research analysts and survey researchers.
- ACS PUMS worker-class, occupation, and self-employment context.
- NES/AIES-NES nonemployer receipts and counts for creator/operator proxy
  baselines.

Direct evidence threshold:

- Structured compensated human evaluation is observed;
- buyer decision impact is observed;
- task difficulty, credential, duration, or review quality is measured;
- the evaluated output is linked to AI-enabled production, node production, or
  automated production abundance.

Disconfirmation:

- Preference validation is mostly unpaid, automated, inferred from telemetry,
  simulated by synthetic users, centralized among elite tastemakers, or too
  small to become a meaningful labor category.

Main limitation:

- Current public datasets do not define creators, niche human providers, or
  experiencers as economic classes. Public sources are proxy baselines only.
- Private/platform data for this test must pass the governance, disclosure,
  baseline, and aggregation gates in
  `research/data/private_data_governance.md`.

### TCE-P007: Node-Becomes-Firm Transition

Question:

Do high-output one-human businesses remain nonemployers, or do they become
payroll employers as revenue or complexity grows?

Primary unit:

- Ideally business-level longitudinal records; absent that, sector-year proxy.

Available proxy:

- BFS employer formations from applications by sector and geography.

Outcomes:

- Employer formations within four or eight quarters.
- High-propensity applications.
- Employer startup rates from BDS.
- Where available, nonemployer high-receipt counts from NES.

Weak support for node-becomes-firm criticism:

- High-AI-exposure sectors show rising high-receipt nonemployer counts followed
  by rising employer formations or employer startups.

Support for durable one-human operation:

- High-receipt nonemployer share grows over multiple years without matching
  increases in employer formations, employer startups, or payroll growth.

Disconfirmation of durable-node claim:

- High-receipt nonemployer growth is followed by employer formation or payroll
  expansion, suggesting scaling through firm formation rather than durable
  one-human operation.

Main limitation:

- BFS does not directly identify nonemployer-to-employer conversion or AI use.
  It is only a payroll-transition proxy.

### TCE-P009: Entry, Survival, And Churn

Question:

Does AI exposure increase entry without durable survival or receipts?

Primary unit:

- NAICS-year or geography-NAICS-year.

Outcomes:

- NES establishment counts.
- NES receipts per establishment.
- Receipt-size distribution.
- BFS applications and high-propensity applications.
- BDS employer startup/shutdown rates for employer-side comparison.

Weak support:

- High-AI-exposure sectors show increased nonemployer counts or applications
  but no durable receipts-per-establishment growth.

Support:

- Entry growth is paired with multi-year receipt growth and lower churn or
  stable high-receipt share.

Disconfirmation:

- Entry rises but receipts per establishment fall, high-receipt share does not
  improve, and employer-side dynamics dominate revenue growth.

Main limitation:

- Current verified sources do not provide direct nonemployer survival/churn
  linked to AI use. Survival requires additional longitudinal data.

### TCE-P010: Corporate Absorption Alternative

Question:

Does AI mainly strengthen employer firms rather than nonemployer businesses?

Primary unit:

- NAICS-year, with firm-size categories where available.

Outcomes:

- Employer employment and payroll by enterprise size from SUSB.
- Employer startups/shutdowns and job creation/destruction from BDS.
- Employer/nonemployer revenue comparison from AIES-NES.
- Nonemployer receipts and counts from NES.
- AI adoption by employer size from BTOS/Bonney et al. 2026.

Support for corporate-absorption alternative:

- High-AI-exposure sectors show employer-firm revenue/payroll/concentration or
  large-firm adoption gains while nonemployer receipts share stagnates or
  declines.

Support for Operator Node-compatible boundary shift:

- High-AI-exposure, low-asset-specificity sectors show nonemployer receipts
  share and receipts per establishment rising relative to employer-firm
  baselines.

Disconfirmation of corporate-absorption alternative:

- Employer-firm baselines weaken while durable nonemployer receipt share rises
  in comparable high-AI-exposure sectors.

## Management-Layer Strategy

TCE-P005 remains blocked for public Census sources.

Potential data sources to seek:

- HRIS or payroll records with occupation codes and supervisory structure.
- Org-chart datasets with manager-to-worker ratios and reporting depth.
- LinkedIn or firmographic datasets with management-title counts over time.
- Enterprise internal workforce analytics on span of control.

Minimum acceptable variables:

- Manager headcount.
- Nonmanager headcount.
- Average span of control.
- Reporting layers between frontline and executive.
- Support-staff ratios.
- AI adoption date or intensity.

Current status:

- No directly verified source in the repo measures management-layer thinning
  after AI adoption.

## Employer-To-Vendor Substitution Strategy

This remains blocked without procurement or platform administrative data.

Potential data sources to seek:

- Vendor master records with supplier size and legal entity.
- Accounts payable/invoice records.
- CLM and e-signature metadata.
- Online labor marketplace administrative records.
- Procurement cycle time, dispute, rework, and payment-delay records.

Minimum acceptable variables:

- Supplier size or nonemployer/sole-proprietor indicator.
- AI-enabled service category or AI-use indicator.
- Contract value and repeat-client status.
- Procurement cycle time.
- Dispute/rework/payment-delay outcomes.
- Comparable firm-vendor control group.

Current status:

- No directly verified source in the repo measures AI-caused
  employer-to-contractor or employer-to-vendor substitution.

## Acceptance Rules

Do not promote a firm-boundary claim unless all of these are satisfied:

- The outcome is a boundary outcome, not just task time or worker adoption.
- Employer and nonemployer evidence are distinguished.
- AI adoption or exposure is measured or defensibly proxied.
- Sector, timeframe, comparison group, and confounders are explicit.
- A failure condition is specified.

Use `weak support` only when the direction is consistent with a prediction but
AI linkage, durability, or confounder control remains incomplete.

Use `supported` only when the evidence directly measures the claim at the
appropriate unit.

Use `contradicted` or a criticism update when employer-firm outcomes improve
relative to nonemployer outcomes in high-AI-exposure sectors.

## Immediate Next Data Tasks

Completed architecture tasks:

- Build NAICS panel inventory:
  NES receipts/counts, AIES-NES employer/nonemployer revenue, SUSB employment
  and payroll, BDS employer dynamics, and BFS employer formations.
- Write a field-level data dictionary before running any quantitative
  analysis.
- Create a data acquisition scaffold that separates metadata-ready inputs from
  blocked pulls.
- Create a sector-panel acquisition and cleaning design for the 17-sector
  all-source overlap.
- Create a tracked query and file QA inventory for the 17-sector build.
- Create a local-only dry-run validator for the 17-sector query/file
  inventory.
- Run a targeted API-fetch smoke test for one NES sector and one corrected
  AIES-NES sector query.
- Run full API fetch validation for all 34 planned NES/AIES sector payloads
  and record a tracked payload QA manifest.
- Design the staging parser contract for validated API payloads plus SUSB/BDS
  raw CSV files.
- Implement the staging parser and write ignored intermediate staging outputs
  plus a tracked staging QA manifest.
- Validate staged output contracts, hashes, sector coverage, source metadata,
  and no-analysis guardrails.
- Draft a conservative transformation design for future sector-level processed
  inputs without creating `data/processed/` or calculating measures.
- Implement the conservative processed-input transform with source-native
  fields only and a tracked manifest marked `analysis_performed=false`.
- Draft a sector-panel analysis design that defines permitted descriptive
  measures, validation gates, and claim-support limits without running
  calculations.
- Implement a sector-panel analysis dry-run validator that checks processed
  input hashes, denominators, missing AIES cells, and manifest shape without
  calculating measures.
- Implement the first descriptive baseline analysis with approved measures,
  local-only output, and a tracked manifest marked
  `claim_support_updated=false`.

Next data tasks:

1. Preserve the local-only Census API key path: `.env.local` is ignored, the
   key is loaded only at command runtime, and future commands must not print or
   log it.
2. Encode the observed key-first Census API query construction in any future
   acquisition script. The schema smoke tests for NES 2023, AIES-NES 2023, BDS
   basic, and one BDS `BDSFAGEFSIZE` predicate combination are now verified.
3. Apply the conservative NAICS harmonization rule in
   `research/data/naics_harmonization_rule.md` before any mixed 2017/2022
   panel: preserve native vintage, default to stable sector-level joins, and
   block changed-code cells unless excluded, aggregated, or covered by a later
   approved allocation source.
4. Use `research/data/naics_code_list_qa.md` as the current sector-readiness
   constraint: first-pass mixed-vintage panels should use the 17-sector
   all-source overlap and exclude `55` and `61` unless later source paths
   close those gaps.
5. Use `research/data/sector_panel_build_plan.md` as the current execution
   gate for the first 17-sector acquisition and cleaning design. This permits
   query inventory and staging QA only, not analysis.
6. Use `research/data/sector_panel_query_inventory.md` and
   `data/manifests/sector_panel_query_inventory.csv` as the current planned
   query/file inventory. Run
   `python3 research/data/sector_panel_dry_run_validator.py` before any API
   fetch; default mode verifies inventory shape, headers, checksums, and
   API-key redaction without computing empirical measures.
7. Full API payload validation for all 34 planned NES/AIES rows is recorded in
   `research/data/sector_panel_api_full_fetch_validation.md`; the tracked
   payload QA manifest is
   `data/manifests/sector_panel_api_payload_manifest.csv`.
8. AIES-NES sector queries must use `SECTOR` predicates, not sector-level
   `NAICS2017` predicates. Current range-sector mappings are `31-33` to `31`,
   `44-45` to `44`, and `48-49` to `48`.
9. The staging parser design is recorded in
   `research/data/sector_panel_staging_parser_design.md`; the tracked staging
   manifest template is
   `data/manifests/sector_panel_staging_manifest_template.csv`.
10. The staging parser run is recorded in
   `research/data/sector_panel_staging_parser_run.md`; the tracked QA manifest
   is `data/manifests/sector_panel_staging_manifest.csv`; ignored staging
   outputs live under `data/intermediate/sector_panel/`.
11. Staged-output validation is recorded in
   `research/data/sector_panel_staging_validation.md`; the validator is
   `research/data/sector_panel_staging_validator.py`. The validator also
   corrected the SUSB local manifest to preserve the verified 2017 NAICS
   vintage.
12. The conservative transformation design is recorded in
   `research/data/sector_panel_transformation_design.md`. It specifies
   proposed future outputs, allowed joins, source-field carry-forward rules,
   and QA gates, but does not authorize implementation or analysis.
13. The conservative transform implementation is recorded in
   `research/data/sector_panel_transform.py` and
   `research/data/sector_panel_transform_run.md`; the tracked processed
   manifest is `data/manifests/sector_panel_processed_manifest.csv`. It writes
   ignored processed inputs only, carries source-native fields forward, and
   keeps `analysis_performed=false`.
14. AIES-NES sector-level rows are missing for canonical sectors `11` and `81`
   under the verified `INDLEVEL=2` sector-row rule. Those fields remain blank
   and flagged; do not fill, allocate, or infer them.
15. The sector-panel analysis design is recorded in
   `research/data/sector_panel_analysis_design.md`. It permits only future
   descriptive measure definitions and keeps claim-support updates blocked.
16. The sector-panel analysis dry-run validator is recorded in
   `research/data/sector_panel_analysis_dry_run_validator.py`; its validation
   record is
   `research/data/sector_panel_analysis_dry_run_validation.md`. It checks
   processed-input hashes, denominators, missing AIES cells, and BDS
   publication markers without calculating measures.
17. The descriptive baseline analysis is recorded in
   `research/data/sector_panel_descriptive_analysis_run.md`; the script is
   `research/data/sector_panel_descriptive_analysis.py`; the tracked manifest
   is `data/manifests/sector_panel_analysis_manifest.csv`. The ignored output
   is under `data/analysis/sector_panel/` and does not update claim support.
18. The next execution slice should design an AI-exposure linkage path before
   any sector-panel interpretation, prediction outcome, or claim-status update.
19. Decide whether BDS age/size acquisition should use the verified official
   multi-year sector-age-size CSV or remain scoped to API-verified 2022
   contexts. The CSV closes sector-level multi-year coverage but not six-digit
   NAICS or subnational age/size coverage.
20. Before additional SUSB acquisition, create a manifest row first, then
   download any selected file only under ignored `data/raw/`.
21. Define high-AI-exposure sectors:
   first from verified BTOS/Bonney sector adoption evidence, then from a
   separately verified occupation-weighted GenAI exposure source if needed.
22. Identify sectors where low asset specificity and measurable digital output
   make Operator Node predictions plausible.
23. Keep arXiv-only AI entrepreneurship or labor-substitution papers out of
   source truth until a more durable source is verified or Company Operator
   approves their use with explicit status.
