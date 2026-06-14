# Evidence Requirements

Status: verification checklist for future drafting. Not a prose draft.

No major section should become prose until its evidence gates are satisfied or
the section explicitly labels remaining uncertainty.

## Global Requirements

- Reinspect full text for theoretical anchors before quoting or paraphrasing
  them in prose.
- Do not use source notes marked `unverified_from_deep_research_return` as
  support for strong claims.
- Keep task-productivity evidence separate from transaction-cost,
  governance-cost, and firm-boundary evidence.
- Attach every prediction to data source, sector, timeframe, comparison group,
  confounders, and failure condition.
- Do not present empirical findings until Research completes data acquisition,
  cleaning, query validation, crosswalk selection, and analysis.
- Preserve the possibility that evidence weakens, narrows, or rejects the
  hypothesis.
- Avoid prohibited foundations and polemical language.

## Section-Level Evidence Gates

### 1. Research Problem, Scope, and Non-Claims

Must verify:

- Final paper scope: sectors, time horizon, organizational forms, and excluded
  claims.
- Terminology consistency with `docs/source_truth/terminology.md`.
- Falsifiability language with `docs/source_truth/falsifiability_contract.md`.

Must not rely on:

- Historical analogy as proof.
- Working title as evidence.
- Advocacy or inevitability claims.

### 2. Transaction Cost Economics

Direct reinspection status:

- Coase 1937, "The Nature of the Firm": directly visually reinspected from an
  archived JSTOR PDF copy for the pages recorded in the source note. Safe for
  Coasean relative-cost claims; do not infer an AI result from Coase alone.
- Williamson 1991, "Comparative Economic Organization": bibliographic reality
  verified and full article directly reinspected on 2026-06-11 from
  user-provided JSTOR read-online screenshots covering pp. 269-296. Safe for
  governance-theory claims about market/hybrid/hierarchy forms, governance
  attributes, asset specificity, bilateral dependency, reputation limits,
  institutional-environment shifts, and hybrid vulnerability under frequent
  disturbances. Do not use it as evidence about AI adoption or Operator Node
  performance.
- Williamson 2009/2010 Nobel lecture article: directly reinspected from the
  official Nobel PDF. Safe for comparative contractual governance, incomplete
  contracts, asset specificity, bilateral dependency, coordinated adaptation,
  hierarchy as internal dispute forum, and the Boeing outsourcing caution.
- Macher and Richman 2008 empirical TCE assessment: Cambridge metadata,
  abstract, DOI, and references directly inspected; full text not obtained.
  A dedicated 2026-06-11 gap-closure attempt through Cambridge, DOI, Crossref,
  OpenAlex, Semantic Scholar, and web searches did not obtain full text. Safe
  only for broad empirical-review framing from the abstract until full text is
  obtained.

Must verify before prose:

- Exact Coasean formulation of firm boundaries and market-use costs.
- Exact Williamson treatment of markets, hybrids, hierarchies, asset
  specificity, opportunism, bounded rationality, and adaptation. Williamson
  1991 and Williamson 2009/2010 are now directly inspected for core
  governance-theory claims.
- Whether and how technology enters the comparative-cost framework.
- Empirical limits and criticisms of TCE.

Required evidence standard:

- Use verified primary sources for core theory.
- Use secondary literature only to frame interpretation or criticism.

### 3. Baseline Organizational Forms and Boundary Definitions

Current V1 starting thresholds are centralized in
`living_dissertation_app/config/living_dissertation_policy.yml`. This section
defines what must be evidenced; the policy file is the current-value source.

Definition thresholds to resolve:

- Maximum human count for an Operator Node; current source truth says one
  human.
- Whether contractors, offshore vendors, family labor, white-label agencies, or
  platform-provided labor disqualify a case.
- Payroll or employee threshold at which a node becomes a firm in practice.
- Managerial-layer threshold: dedicated manager, operations lead, team lead, or
  authority relation.
- Dedicated asset threshold: client-specific automations, proprietary
  integrations, specialized data, exclusive tooling, or non-redeployable
  capital.
- Institutional-memory threshold: persistent, retrievable, operational memory
  beyond generic file storage.
- Protocol threshold: documented process, audit trail, interface standard,
  repeatable workflow, and exception handling.
- Auditability threshold: logs, version history, deliverable traceability,
  approvals, and accountability records.
- Output threshold: measurable economic output that can be compared against
  firms or teams.

Sources to verify:

- IRS independent-contractor source for contractor definition.
- SBA size standards for small-business distinction.
- Legal entity references for corporation and LLC distinctions; replace
  secondary legal encyclopedia material with primary or authoritative legal
  sources if the paper makes legal claims.

### 4. AI, Task Productivity, and Organizational Change Evidence

Direct reinspection or replacement status:

- Brynjolfsson, Li, and Raymond 2025: directly inspected from the QJE/OUP
  full-text page. Safe for task-productivity, learning, customer-escalation,
  and single-firm limitation claims; not safe for firm-boundary claims.
- Dell'Acqua et al. 2026: directly inspected from the Organization
  Science/INFORMS full-text page and DOI. Safe for task-productivity and
  verification/correctness-risk claims; not safe for firm-boundary claims.
- Noy and Zhang 2023: final *Science* DOI verified through Crossref/OpenAlex;
  MIT working-paper full text previously inspected. Safe for bounded writing
  task-productivity claims; not safe for transaction-cost or firm-boundary
  claims until publisher full text is inspected.
- Census 2026 AI-use source: directly inspected from Census.gov America Counts,
  BTOS program page, and AI-supplement questionnaire PDF. Safe for
  employer-business AI adoption by firm size and sector; not safe for
  productivity, profit capture, nonemployer, or firm-boundary claims.
- Bonney et al. 2026 Census CES working paper on the microstructure of AI
  diffusion: directly inspected from Census working-paper page and PDF. Safe
  for nationally representative employer-firm AI adoption, functional/task-use
  breadth, augmentation/substitution/employment-effect survey responses, and
  associational commercial-performance/labor-outcome summaries. Not safe for
  causal productivity, nonemployer, outsourcing, management-layer, or
  firm-boundary claims.
- Arledge 2025 Census ABS summary on technology impacts: directly inspected
  from Census.gov America Counts. Safe for employer-business reports that
  tracked technologies, including AI, most often did not change worker numbers
  or skill levels in 2020-2022/2023 ABS data. Not safe for post-2024
  generative-AI effects or causal boundary claims.
- Federal Reserve 2026 AI-adoption source: citation_needs_correction after
  exact-title, author, FEDS Notes, and FederalReserve.gov searches failed.
- OECD 2025 generative-AI/productivity/entrepreneurship source:
  citation_needs_correction after exact-title, author, OECD.org, and OECD
  iLibrary searches failed.

Must verify before prose:

- Study setting, sample, treatment, measured outcomes, and external-validity
  limits.
- Whether outcomes are task time, quality, learning, wages, productivity,
  adoption, firm performance, or governance outcomes.
- Whether any study measures contracting, monitoring, dispute, enforcement,
  rework, trust, liability, procurement, or firm-boundary change.

Unverified citations to replace or verify:

- Federal Reserve 2026 monitoring/adoption note.
- OECD 2025 note.

Evidence separation status:

- Task productivity: supported by verified experiment/field-study sources in
  customer support, consulting, and bounded writing.
- Transaction costs: weak direct evidence. Current AI task studies do not
  measure search, contracting, monitoring, dispute, enforcement, liability,
  procurement, or payment costs.
- Firm boundaries: no direct verified evidence yet. Census BTOS measures
  adoption by employer-firm size, not nonemployer share, outsourcing,
  management layers, revenue per human, concentration, or node-to-firm
  transitions.
- Employer-firm labor outcomes: Bonney et al. 2026 and Arledge 2025 add weak
  disconfirming pressure against immediate AI-driven headcount shrinkage, but
  they still do not measure management layers, outsourcing, nonemployer share,
  or node-to-firm transitions.
- Worker-level adoption context: Bick, Blandin, and Deming 2024 NBER working
  paper page directly inspected. Safe for nationally representative U.S.
  worker generative-AI adoption and self-reported time-savings context from
  the NBER abstract. Not safe for firm-boundary, nonemployer, transaction-cost,
  outsourcing, or management-layer claims.

### 5. Operator Node Hypothesis

Must verify or define:

- Minimum viable Operator Node capability stack.
- How to observe AI reasoning systems, AI execution systems, institutional
  memory, shared protocols, audit trails, and automation infrastructure.
- How to distinguish node output from hidden employees, contractors, agencies,
  platform labor, or client-provided infrastructure.
- Whether legal wrappers affect classification.
- Whether high output is durable over time or temporary.

Evidence needed:

- Case-selection protocol.
- Labor-input audit method.
- Output, revenue, quality, and client-retention metrics.
- Comparison cases: freelancer with AI, small firm with AI, corporation with
  AI, and platform-mediated gig work.

### 6. Mechanism and Cost Categories

For each cost category, define:

- Unit of measurement.
- Baseline comparison.
- AI exposure or adoption measure.
- Expected direction of change.
- Failure condition.
- Confounders.

Cost categories requiring evidence:

- Search and discovery.
- Negotiation and contracting.
- Legal review.
- Monitoring and quality control.
- Documentation and institutional memory.
- Coordination and adaptation.
- Enforcement and dispute resolution.
- Rework and defect correction.
- Trust, onboarding, and procurement.
- Verification, security, reliability, liability, and model governance.

Required distinction:

- Production-cost decline does not establish transaction-cost decline unless
  the transaction-cost metric is measured.

### 7. Protocol-Based Networks and Hybrid Governance

Direct reinspection required:

- Powell 1990 on network forms: completed by visual inspection of the
  Stanford-hosted scanned PDF. Safe for network forms as distinct from both
  markets and hierarchies, and for network liabilities including dependency,
  particularism, entry barriers, and control/performance problems.
- Williamson 1991 on hybrid governance and disturbance adaptation: completed
  by visual inspection of user-provided JSTOR read-online screenshots covering
  pp. 269-296. Safe for hybrid as an intermediate governance form and for
  frequent-disturbance vulnerability, but not direct evidence about protocol
  networks or AI.

Additional evidence needed:

- Protocol-network case data.
- API or standards-based coordination evidence.
- Escrow, arbitration, insurance, certification, audit-log, and reputation
  system data.
- Dispute frequency, resolution time, rework rate, chargeback rate, SLA
  compliance, and repeat-client rate.
- Evidence of when networks become platforms, firms, or de facto hierarchies.

Directly inspected platform-governance evidence:

- Resnick et al. 2006, "The Value of Reputation on eBay": Cambridge metadata,
  abstract, DOI, and citation directly inspected. Safe for the narrow claim
  that online reputation can affect willingness to pay in a controlled eBay
  experiment, but only as weak support until full text is inspected. Full text
  remains pending.
- Pallais 2014, "Inefficient Hiring in Entry-Level Labor Markets": AEA article
  page directly inspected. Safe for the narrow claim that public evaluations in
  an online labor market can improve later employment outcomes and that
  information frictions can inefficiently suppress hiring.

Platform-governance boundary:

- These sources provide limited support for reputation/evaluation mechanisms,
  not AI-specific Operator Nodes, escrow, arbitration, insurance, audit logs,
  SLAs, enterprise procurement, or firm-boundary change.

Failure evidence to preserve:

- Frequent disturbances requiring authority.
- Slow mutual-consent adaptation.
- Quality uncertainty.
- Accountability gaps.
- Platform capture.

### 8. Boundary Conditions and Sector Predictions

Data requirements:

- Sector taxonomy by AI exposure, asset specificity, liability, measurability,
  capital intensity, procurement friction, and regulatory burden.
- Nonemployer and employer-firm data by sector.
- Receipts, revenue per human, output per employee, survival, churn, and
  hiring transitions.
- Vendor/procurement data for one-person or very-small suppliers.
- Dispute, rework, insurance, arbitration, and payment-delay data.
- Concentration and market-share data by firm size.

Directly inspected measurement sources:

- Census NES: safe for annual no-paid-employee establishments and receipts by
  industry/geography, legal form, and receipt-size class. Not safe for AI use,
  hidden labor, survival, or one-human status.
- Census AIES-NES: safe as a national employer/nonemployer sales, shipments,
  or revenue comparison source for comparable industries beginning with 2023.
  Not safe for causal AI or Operator Node claims.
- Census BFS: safe for business applications and employer wage-paying
  formations from applications. Not safe for nonemployer-to-employer
  transitions or AI-specific formation claims.
- Census BDS: safe for employer firm/establishment dynamics including job
  creation/destruction, births/deaths, startups/shutdowns. Not safe for
  nonemployer, AI, management-layer, or transaction-cost claims.
- Census SUSB: safe for employer establishments with paid employees by
  industry and enterprise size, including firm/establishment counts,
  employment, and annual payroll. Not safe for nonemployer or hierarchy-depth
  claims.

Current firm-boundary evidence status:

- The measurement base is now clearer, but direct evidence remains missing.
  The inspected sources can frame tests of nonemployer receipts, employer
  formations, employer-size baselines, and employer dynamics. They do not show
  that AI-enabled one-human firms are gaining durable revenue share, surviving,
  converting into firms, replacing vendors, or thinning management layers.

Schema blocker closure constraints:

- SUSB U.S./state annual public-use fields are verified for 2007-present:
  `STATE`, `NAICS`, `ENTRSIZE`, `FIRM`, `ESTB`, `EMPL`, `EMPLFL_R`,
  `EMPLFL_N`, `PAYR`, `PAYRFL_N`, `RCPT`, `RCPTFL_N`, `STATEDSCR`,
  `NAICSDSCR`, and `ENTRSIZEDSCR`.
- BDS `BDSFAGEFSIZE` group metadata is partially closed for `NAICS`, `FAGE`,
  `EMPSZFI`, `GEO_ID`, `YEAR`, `FIRM`, `ESTAB`, `EMP`, `ESTABS_ENTRY`,
  `FIRMDEATH_FIRMS`, and `JOB_CREATION_BIRTHS`; one U.S.-level 2022 combined
  query and 2022 U.S. `FAGE`/`EMPSZFI` value-label sets are verified, but
  tested API `BDSFAGEFSIZE` age/size contexts are verified only for 2022. An
  official multi-year sector by firm age by firm size CSV is now identified for
  1978-2023, but it is sector-level only and does not close six-digit NAICS or
  subnational age/size coverage.
- BTOS AI supplement is verified at coverage, tabulation, and questionnaire
  level only. Public-use variable names, survey-period fields, weights, and
  extract schema remain unresolved.
- BFS measure abbreviations are verified from definitions, but API
  `data_type_code` values and `category_code` to NAICS mapping remain blocked.
  BFS employer formations remain only an indirect payroll-transition proxy.
- NAICS 2022 reference access and the official Census 2022 structure workbook
  have been inspected. Research selected a conservative mixed-vintage
  harmonization rule: preserve native vintage, default to stable sector-level
  joins, allow same-code finer joins only for blank or title-only 2022 change
  indicators, and block changed-code cells unless excluded, aggregated, or
  covered by a later approved allocation source. No mixed-vintage panel
  analysis should proceed until code-list QA applies that rule. Current
  code-list QA supports a first-pass 17-sector all-source overlap and excludes
  `55` and `61` unless later source paths close those gaps.
- TCE-P005 remains blocked because no management-layer, span-of-control,
  manager/nonmanager, support-staff-ratio, or hierarchy-depth fields are
  verified.
- No quantitative analysis has been run. The empirical section can describe
  measurement design and constraints only, not findings.

Empirical strategy status:

- `research/empirical_strategy.md` defines test designs for TCE-P001, TCE-P007,
  TCE-P009, and TCE-P010 using NES/AIES-NES, BFS, BDS, SUSB, and verified
  BTOS/Bonney AI adoption evidence where available.
- The strategy treats BFS employer formations only as a payroll-transition
  proxy, not as direct nonemployer-to-employer conversion evidence.
- The strategy treats Bick, Blandin, and Deming 2024 only as worker-level
  GenAI adoption context, not boundary evidence.
- The strategy leaves TCE-P005 blocked until a direct management-layer data
  source is verified.
- Sector-panel processed inputs and analysis design now exist for future
  descriptive measures, but no descriptive calculations have been run. The
  analysis design permits only future measurement scaffolding unless AI
  exposure, comparison groups, missing-cell handling, and confounder controls
  are added in a later accepted slice.
- Sector-panel analysis dry-run validation now checks processed-input hashes,
  denominator availability, missing AIES cells, and BDS publication markers.
  It does not calculate measures or authorize claim support.
- The first sector-panel descriptive baseline analysis calculates only
  approved one-year measures and keeps `claim_support_updated=false`. The
  empirical section still must not treat these baseline measures as AI effects,
  firm-boundary shifts, or support for Operator Node claims.

Must not do:

- Do not treat nonemployer receipt growth as Operator Node evidence unless AI
  exposure, hidden labor, sector comparability, and durability are addressed.
- Do not treat BFS employer formation as proof that nodes became firms.
- Do not treat worker-level GenAI adoption as firm-boundary change.
- Do not treat office-to-remote work as disconfirmation. Treat persistence or
  growth of remote salaried employment in AI-exposed, output-measurable roles
  as the relevant strong-thesis falsifier.

Prediction fields required before acceptance:

- Claim.
- Unit of measurement.
- Expected direction.
- Comparison group.
- Timeframe.
- Data source.
- Failure condition.
- Confounders.

Confounders and falsifiers to track:

- Digitization, post-pandemic self-employment, outsourcing cycles, tax
  reclassification, reporting changes, inflation, sector demand shocks,
  survivorship bias, hidden subcontracting, disguised employment, platform
  moderation, client sophistication, antitrust enforcement, model quality,
  cloud pricing, and model-provider dependency.
- Remote employment should be measured separately: the strong thesis predicts
  that remote salaried employee share should decline in AI-exposed,
  output-measurable roles as node, vendor, owner-operator, or AI-labor-service
  capacity rises. ACS PUMS, ATUS, and BLS alternative-arrangement tables can
  support a public monitoring baseline, but not a substitution claim unless
  direct destination-of-work, output, and AI-service fields are added.

### 9. Criticisms and Failure Modes

Evidence needed for each criticism:

- A measurable version of the objection.
- Evidence that would strengthen the objection.
- Evidence that would weaken the objection.
- Failure condition for the broader hypothesis.

Criticism-specific verification needs:

- Large-firm AI adoption and productivity capture data.
- Liability, procurement, insurance, and trust data for one-person suppliers.
- Asset-specificity proxies and switching-cost evidence.
- Fraud, synthetic credential, breach, arbitration, and quality-failure data.
- Evidence on high-output nodes converting into firms.
- Evidence on systems integration, final accountability, and multi-module
  delivery failure.

Current unverified or narrowed criticism support:

- Census 2026 adoption evidence is verified and can support only the narrowed
  adoption-by-size criticism; it cannot support productivity capture,
  nonemployer, or firm-boundary claims.
- Federal Reserve 2026 adoption citation cannot support claims until replaced
  or corrected.
- OECD 2025 productivity and entrepreneurship citation cannot support strong
  claims until replaced or corrected.
- Joskow 2010 vertical integration note remains unverified and should not be
  used as support until directly checked.

### 10. Falsifiable Predictions and Empirical Strategy

Data access requirements:

- Public datasets: Census Nonemployer Statistics, Annual Business Survey,
  Business Dynamics Statistics, County Business Patterns, Business Formation
  Statistics, BEA/BLS productivity accounts, and concentration datasets.
- Administrative or private datasets: procurement systems, vendor master data,
  CLM systems, e-signature metadata, invoice and payment systems, platform
  records, payroll/HRIS data, org charts, insurance claims, escrow records,
  arbitration records, and customer dispute logs.
- Firmographic datasets for employee counts, revenue, hiring events, and
  management layers.

Method requirements:

- Frame V1 as a forecast baseline, not as completed proof.
- Assign 3-, 5-, and 10-year horizons where predictions require future data.
- Separate thesis-level forecast evidence from the user's company or any single
  implementation case.
- Precommit to publishing V2/V3 updates even when evidence is null or adverse.
- Treat the living forecast system as data and indicator infrastructure only:
  automated jobs may refresh evidence snapshots, but claim-status changes
  require human review.
- Separate AI-exposure linkage into public exposure proxies, node feasibility
  evidence, and transaction-cost evidence. Public exposure proxies can identify
  where to look, but cannot prove node activity or boundary change.
- Treat economic class implications as a forecast taxonomy only. Creator,
  niche human provider, and experiencer categories need measurable definitions,
  data sources, comparison groups, and failure conditions before prose claims.
- Define AI exposure.
- Define Operator Node classification.
- Define comparison groups.
- Use sector controls and pre/post or matched comparisons where possible.
- Track null results and disconfirming evidence.
- Avoid treating proxy movement as proof without robustness checks.

### 11. Evidence Gap Register and Research Agenda

Must maintain:

- List of sections not ready for prose.
- List of claims intentionally withheld.
- List of unverified source notes.
- List of prediction fields still missing.
- List of definition thresholds still unresolved.

Additional unresolved class-implication thresholds:

- Creator versus passive owner, ordinary entrepreneur, or self-employed worker.
- Niche human provider versus ordinary in-person service worker.
- Paid experiencer versus unpaid reviewer, passive telemetry subject, synthetic
  user, internal QA worker, or elite tastemaker.
- Human-preference validation revenue versus marketing, content moderation,
  product research, or ordinary customer support.

Return to drafting only after:

- The Company Operator approves moving from architecture to prose.
- Source-truth constraints are still satisfied.
- `paper/draft.md` is explicitly authorized for editing.
