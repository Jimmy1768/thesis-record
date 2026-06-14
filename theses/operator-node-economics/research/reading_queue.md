# Reading Queue

## Core

- Ronald Coase, "The Nature of the Firm"
- Oliver Williamson, transaction cost economics

## Resolved Full-Text Targets

- Oliver E. Williamson, "Comparative Economic Organization: The Analysis of
  Discrete Structural Alternatives" (1991): directly reinspected on
  2026-06-11 from user-provided JSTOR read-online screenshots covering
  article pp. 269-296. Screenshots were not copied into the repo.
- Kathryn Bonney, Cory Breaux, Emin Dinlersoz, Lucia Foster, John Haltiwanger,
  and Aditya Pande, "The Microstructure of AI Diffusion" (2026): Census CES
  working-paper page and PDF directly inspected on 2026-06-11.
- Rachel Arledge, "How AI and Other Technology Impacted Businesses and
  Workers" (2025): Census America Counts article directly inspected on
  2026-06-11.
- Amanda Pallais, "Inefficient Hiring in Entry-Level Labor Markets" (2014):
  AEA article page directly inspected on 2026-06-11.
- U.S. Census Bureau, Nonemployer Statistics: program page, about page, and
  API documentation directly inspected on 2026-06-11.
- U.S. Census Bureau, Business Formation Statistics: main page, definitions,
  and June 10, 2026 monthly release directly inspected on 2026-06-11.
- U.S. Census Bureau, Business Dynamics Statistics: program page directly
  inspected on 2026-06-11.
- U.S. Census Bureau, Statistics of U.S. Businesses: program page directly
  inspected on 2026-06-11.
- Bick, Blandin, and Deming, "The Rapid Adoption of Generative AI" (NBER
  Working Paper 32966): NBER page, DOI, abstract, and data-appendix listing
  directly inspected on 2026-06-11.
- U.S. Bureau of Labor Statistics, American Time Use Survey: home page,
  data-files page, data-dictionaries page, Handbook of Methods overview,
  tables page, 2024 home-page work-at-home chart, and 2024 interview-data
  dictionary directly inspected on 2026-06-12 for remote/work-at-home
  measurement architecture.
- U.S. Census Bureau, American Community Survey Public Use Microdata Sample:
  ACS program page, PUMS page, and 2024 ACS PUMS Data Dictionary directly
  inspected on 2026-06-12 for worked-from-home, class-of-worker, occupation,
  and industry fields.
- U.S. Bureau of Labor Statistics, Contingent and Alternative Employment
  Arrangements, July 2023: news-release table of contents and Table 6 directly
  inspected on 2026-06-12 for independent-contractor, temporary-help,
  contract-firm, traditional-arrangement, occupation, industry, and
  class-of-worker table categories.
- U.S. Bureau of Labor Statistics, Occupational Employment and Wage Statistics
  home page and Occupational Outlook Handbook pages for Market Research
  Analysts and Survey Researchers: directly inspected on 2026-06-12 for weak
  public proxy architecture around preference-research occupations relevant to
  `TCE-P012`.

## Blocked Full-Text Targets

- Jeffrey T. Macher and Barak D. Richman, "Transaction Cost Economics: An
  Assessment of Empirical Research in the Social Sciences" (2008): Cambridge
  metadata/abstract verified, but full text remains inaccessible after
  Cambridge, DOI, Crossref, OpenAlex, Semantic Scholar, and web-search attempts
  on 2026-06-11. Needed before using detailed empirical-method, measurement,
  opportunism, endogeneity, or exact-count claims.
- Paul Resnick, Richard Zeckhauser, John Swanson, and Kate Lockwood, "The Value
  of Reputation on eBay" (2006): Cambridge metadata/abstract/DOI verified, but
  full text was not retrieved in the 2026-06-11 platform-governance pass.
  Current source note is safe only for the abstract-level field-experiment
  result.

## Citation Correction Targets

- Federal Reserve FEDS Notes, "Monitoring AI Adoption in the US Economy"
  (reported April 3, 2026): exact title, author, FEDS Notes, and
  FederalReserve.gov searches failed in the 2026-06-11 empirical evidence pass.
  Keep excluded from claims unless a primary FederalReserve.gov source or
  corrected citation is found.
- OECD, "The Effects of Generative AI on Productivity, Innovation and
  Entrepreneurship" (reported 2025): exact title, author, OECD.org, and OECD
  iLibrary searches failed in the 2026-06-11 empirical evidence pass. Keep
  excluded from claims unless a primary OECD/OECD iLibrary source or corrected
  citation is found.

## Empirical Evidence Gaps

- Direct firm-boundary evidence: nonemployer receipts, revenue per human,
  outsourcing share, management-layer change, concentration, and node-to-firm
  transitions in AI-exposed sectors.
- Direct nonemployer AI linkage: NES/AIES-NES can measure nonemployer receipts
  and counts, but this pass found no verified source linking those outcomes to
  AI use, AI exposure, one-human automation stacks, or durable Operator Node
  performance.
- Direct formation transition evidence: BFS measures applications and employer
  formations, but this pass found no verified source linking AI use to
  nonemployer survival, churn, or conversion into employer firms.
- Direct transaction-cost evidence: search, contracting, monitoring, dispute,
  enforcement, procurement, payment, liability, and rework costs for
  AI-enabled one-person suppliers versus firm vendors.
- Adoption-to-outcome linkage: merge verified AI adoption measures, such as
  BTOS, with revenue, employment, productivity, survival, and concentration
  outcomes by firm size where possible.
- Platform governance evidence: escrow, arbitration, reputation, insurance,
  certification, audit-log, SLA, and payment-system effects on dispute and
  enforcement costs.
- AI-specific platform governance evidence: reputation/evaluation evidence now
  exists for non-AI online marketplaces and online labor markets, but evidence
  remains missing for AI-enabled one-person suppliers using escrow,
  arbitration, insurance, audit logs, SLAs, and enterprise procurement systems.
- Employer-firm labor outcomes: Census evidence now adds headcount-impact
  constraints, but management-layer, outsourcing, nonemployer, and
  firm-boundary transition evidence remains missing.
- Field-level data gaps: exact SUSB U.S./state annual record-layout fields are
  now verified, but MSA and other SUSB layouts still need separate checks if
  used. BTOS public-use variable names, weights, and extract paths remain
  unresolved; the official BTOS data page and AI-supplement questionnaire
  verify coverage and question wording only. BFS `data_type_code` and
  `category_code` value-code mappings, BDS direct firm-startup status,
  deciding whether sector-level BDS firm-age-by-size coverage is sufficient,
  and AIES-NES year expansion remain open.
- Join/crosswalk gaps: Census NAICS reference access and the 2022 NAICS
  structure workbook have been inspected. A conservative mixed-vintage
  harmonization rule is now recorded in
  `research/data/naics_harmonization_rule.md`, but a many-to-many
  2017-to-2022 allocation-weight source remains unselected for fine-grained
  changed-code comparisons. Current code-list QA supports a 17-sector
  all-source overlap for first-pass mixed-vintage panels; geography
  comparability and an accepted NAICS- or occupation-weighted AI exposure
  measure also remain needed.
- Living forecast ingestion gaps: create an exposure-source registry,
  node-case registry schema, and transaction-cost metric schema before
  implementing recurring ingestion jobs. Keep public exposure proxies, node
  feasibility evidence, and transaction-cost evidence separate.
- Registry population gaps: the exposure-source registry now has conservative
  public forecast-baseline rows for already verified source notes. Node-case
  and transaction-cost registries remain blocked pending company/privacy
  disclosure rules, hidden-labor rules, and transaction-cost comparison
  baselines.
- Remote-employment substitution gap: public ACS PUMS, ATUS, and BLS
  Contingent and Alternative Employment Arrangements sources can support a
  descriptive TCE-P011 monitoring baseline, but they do not observe AI labor
  services, node substitution, vendor spend, output preservation, or direct
  replacement events. Strong TCE-P011 testing remains blocked pending private
  HRIS, payroll, procurement, vendor-master, node-case, or labor-market posting
  governance.
- Economic-class implication gap: BLS OEWS/OOH can provide weak public proxy
  baselines for adjacent preference-research occupations, but direct TCE-P012
  evidence remains blocked pending platform/private data on compensated human
  evaluation tasks, evaluator quality, buyer decision impact, niche
  human-presence premiums, and substitution by telemetry or synthetic users.
- Private-data implementation gap: governance rules now exist in
  `research/data/private_data_governance.md`, and production PostgreSQL is now
  selected as the system of record for structured private data. No private
  rows should be ingested until production PostgreSQL is provisioned with
  access control, encrypted backup/restore, audit logging, an empty intake
  manifest, disclosure rule, hidden-labor review, confidentiality workflow,
  aggregation rule, and comparison baseline.
- Living dissertation app build gap: a Rails/PostgreSQL/Sidekiq build plan now
  exists in `research/data/living_dissertation_application_build_plan.md`, but
  no app, database schema, deployment, private storage, recurring jobs, or
  empty intake manifest has been implemented yet.
- Storage-classification implementation gap: storage zones are now specified
  in `research/data/private_storage_classification_matrix.md`, but Rails does
  not yet enforce `storage_zone`, privacy class, public-repo allowance, secret
  detection, minimum-cell checks, or reviewed-export gates.
- Audit-trail implementation gap: minimum audit events are now specified in
  `research/data/audit_trail_minimum_design.md`, but Rails does not yet
  implement `audit_events`, actor capture, request/job IDs, protected-action
  fail-closed behavior, claim-review audit links, or export audit links.
- Failure-output implementation gap: failure records are now specified in
  `research/data/failure_as_first_class_output_policy.md`, but Rails does not
  yet implement failure-record creation, review, publication status,
  prediction links, alternative-dominance classification, or checkpoint export.

## Current Preprint Candidates Not Accepted As Source Truth

- "AI as Co-founder: GenAI for Entrepreneurship" (arXiv, 2025) appears
  directly relevant to AI and small-firm formation, but only an arXiv record
  was found in this pass. Do not use as claim support unless a more durable
  working-paper, publisher, institutional, or peer-reviewed source is verified.
- "Generative AI Fuels Solo Entrepreneurship, but Teams Still Lead at the Top"
  (arXiv, 2026) appears directly relevant to solo entrepreneurship and product
  launches, but only an arXiv record was found in this pass. Do not use as
  claim support unless a more durable source is verified.
- "Payrolls to Prompts: Firm-Level Evidence on the Substitution of Labor for
  AI" (arXiv, 2026) appears directly relevant to AI substitution for online
  labor marketplaces, but only an arXiv record was found in this pass. Do not
  use as claim support unless a more durable source is verified.

## To Add

- theory of the firm literature;
- agency theory;
- organizational economics;
- network organization literature;
- open-source governance;
- AI and organizational change;
- institutional memory and knowledge management.

No source is accepted until it has a source note.
