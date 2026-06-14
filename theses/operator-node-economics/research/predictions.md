# Predictions

Predictions must be measurable.

## Forecast-Versioning Status

Operator Node Economics is a versioned forecast research program, not a
settled empirical conclusion. The governing framework is
`research/forecast_versioning_framework.md`.

V1 should publish the thesis, mechanisms, predictions, current evidence,
missing evidence, and failure conditions before the answer is known. The
forecast clock uses quarters as the smallest measurement atom: quarterly
measurement updates, annual evidence snapshots, V2 at 12 full quarters after
V1, V3 at 20 full quarters after V1, and V4 at 40 full quarters after V1.
Later versions should update the record even if the thesis is weakened,
narrowed, contradicted, or rejected.

Prediction status should therefore distinguish:

- `forecast_baseline`: suitable for V1 as an explicit forecast, not evidence.
- `leading_indicator`: a precursor signal consistent with the forecast, not
  proof.
- `feasibility_case`: a node-like case works in a bounded context, but does
  not prove broad diffusion.
- `diffusion_evidence`: repeated cases or sector movement suggest spread.
- `mixed`: evidence is divided between the prediction and alternatives.
- `adverse`: evidence moves against the prediction but has not yet triggered a
  checkpoint contradiction.
- `contradicted`: evidence moves against the forecast or a specified failure
  condition is triggered.

The user's company is one possible implementation case. Its success or failure
can inform the research program, but the broad thesis should not depend on
that single network.

Recurring data collection and indicator updates should follow
`research/living_forecast_system.md`. Automated jobs may refresh indicators,
but prediction status and claim status require human review.

Adverse, null, missing, and contradictory evidence should follow
`research/data/failure_as_first_class_output_policy.md`. Failure records are
publishable research outputs after review, not exceptions to hide.

AI-exposure linkage should follow
`research/data/ai_exposure_node_feasibility_architecture.md`: public exposure
proxies can identify where to look, node data can test feasibility, and
transaction-cost data tests the mechanism.

## Candidate Predictions

| ID | Prediction | Measurement | Failure Condition | Status |
| --- | --- | --- | --- | --- |
| P001 | Employee count per unit output declines in selected sectors. | output per employee, revenue per employee, project delivery per headcount | no decline after AI adoption or decline explained by non-AI factors | candidate |
| P002 | Small operator nodes outperform traditional firms in specific industries. | cost, speed, quality, customer outcomes | firms maintain or improve advantage after controlling for scale | candidate |
| P003 | Capital requirements fall for some productive enterprises. | startup capital, fixed assets, staffing costs, time to first revenue | required capital remains high or shifts to another category | candidate |
| P004 | Protocol-based coordination gains market share. | share of work done through standards, APIs, open protocols, networked independents | hierarchy remains dominant for comparable work | candidate |
| P005 | Corporate hierarchy shrinks in targeted sectors. | management layers, manager-to-worker ratios, org chart depth | hierarchy stays stable or grows | candidate |
| TCE-P001 | One-person AI-enabled businesses show faster revenue-per-human growth than small employer firms in low-asset-specificity digital services. | revenue per owner/operator; receipts per employee; high-receipt nonemployer share in professional services, software, marketing, design, analytics, legal support, accounting support, and content operations | no relative increase in high-revenue nonemployer/one-person firms in AI-exposed sectors versus low-AI-exposure controls | candidate |
| TCE-P002 | AI-enabled Operator Nodes gain share first in transactions with low asset specificity and high output measurability. | vendor counts and spend share for one-person/very-small suppliers in standardized digital deliverables; defect/rework rates; procurement cycle time | procurement remains concentrated in multi-employee firms for standardized, modular, measurable digital tasks | candidate |
| TCE-P003 | Operator Nodes do not gain much share in high-asset-specificity, high-liability, high-uncertainty transactions. | outsourcing rate to one-person suppliers by asset-specificity proxies: regulated data, dedicated integrations, custom compliance, temporal urgency, brand risk | high-specificity/high-liability transactions shift substantially to one-person AI-enabled suppliers without higher dispute, defect, or liability costs | disconfirming/sector boundary |
| TCE-P004 | If Operator Nodes are real governance substitutes, transaction-cost metrics fall, not only task-time metrics. | lead-to-contract time; proposal cost; legal-review cost; monitoring time; change-order frequency; dispute rate; payment delay; rework cost; client acquisition cost; trust/onboarding cost | AI-enabled nodes are faster at production but have equal or higher contracting, monitoring, dispute, and rework costs than firm vendors | candidate |
| TCE-P005 | Large firms use AI to increase managerial span and reduce internal coordination layers. | manager-to-worker ratio; average span of control; layers between frontline and executives; revenue per manager; support-staff ratios | AI adoption correlates with unchanged or increased management layers | disconfirming for hierarchy-shrinking version if hierarchy grows |
| TCE-P006 | Corporations capture AI gains faster in sectors where proprietary data, compliance, brand trust, and capital access matter. | AI adoption rate; productivity growth; market share; concentration ratios; gross margins; revenue per employee by firm size | smaller firms and one-person firms gain share despite large-firm data/capital advantages | disconfirming/alternative |
| TCE-P007 | Successful Operator Nodes often convert into small firms after crossing revenue or complexity thresholds. | hiring events; payroll start date; contractor-to-employee conversion; operations-manager roles; legal entity conversion; dedicated asset investment | high-output nodes sustain growth for multiple years without hiring employees or creating managerial hierarchy | disconfirming/transition |
| TCE-P008 | Protocolized node networks outperform conventional freelance markets only where dispute resolution and auditability are built into the workflow. | dispute frequency; resolution time; chargeback rate; rework rate; SLA compliance; repeat-client rate; insurance claims | protocol/audit-heavy networks do not show lower dispute or rework rates than ordinary freelance marketplaces | candidate |
| TCE-P009 | AI-enabled nodes increase market entry but may also increase churn. | business formation rate; nonemployer entry; 1/3/5-year survival; median receipts; income volatility; exit reasons | increased AI-related entry is not accompanied by durable survival, revenue growth, or repeat demand | candidate |
| TCE-P010 | If AI mainly strengthens firms, concentration and employment-weighted AI adoption rise in AI-exposed sectors while nonemployer revenue share stagnates. | HHI/concentration ratios; top-firm revenue share; employment-weighted AI adoption; nonemployer receipts share; revenue per employee by size class | concentration falls and nonemployer/one-person firms gain durable revenue share in AI-exposed sectors | disconfirming/alternative |
| TCE-P011 | Remote employment is a transitional form: in AI-exposed, output-measurable digital roles, remote salaried employee share should decline as firms buy node, vendor, owner-operator, or AI-labor-service capacity instead. | remote employee headcount/share by role or occupation; payroll employment in remote-capable roles; AI-labor/vendor spend; contractor/vendor share; nonemployer receipts in matching service categories; output per employee | remote salaried employment remains durable or grows in AI-exposed roles where capable AI labor services exist, without offsetting growth in node/vendor/AI-labor-service substitution | candidate/falsifier |
| TCE-P012 | If AI-enabled production becomes abundant and firms become smaller productivity nodes, economic roles should shift toward creators, niche human providers, and experiencers who validate human preference, quality, comfort, trust, prestige, or desirability. | growth in creator/operator income or receipts; paid human evaluation markets; product testing and certification markets; UX/review/taste-panel labor; niche human-service wages and scarcity premiums; share of work classified as human preference validation | human evaluation markets remain small, uncompensated, automated away, or captured by telemetry/synthetic users; ordinary wage employment remains the main mass role despite abundant AI production | forecast_taxonomy |

## Data Source Candidates

- Census Nonemployer Statistics, Annual Business Survey, Business Dynamics
  Statistics, County Business Patterns, Business Formation Statistics, and
  Business Trends and Outlook Survey.
- IRS Schedule C / 1099-NEC aggregates where available.
- Enterprise procurement systems, vendor master data, CLM systems, e-signature
  metadata, invoice/payment systems, and platform administrative records.
- Payroll, HRIS, LinkedIn/firmographic, and org-chart datasets.
- Insurance underwriting and claims data, arbitration records, escrow records,
  and customer dispute logs.
- Compustat, BEA/BLS productivity accounts, industry concentration datasets,
  and verified agency AI adoption surveys.
- Platform marketplace field experiments and administrative records for
  reputation, evaluation, escrow, arbitration, dispute, rework, payment, and
  repeat-client outcomes.
- Census NES and AIES-NES for nonemployer establishments and receipts,
  including comparable national employer/nonemployer sales or revenue in
  industries covered by AIES-NES.
- Census BFS for applications and employer-business formations.
- Census BDS and SUSB for employer-firm dynamics, employment, payroll, and
  enterprise-size baselines.
- BLS OEWS and OOH for weak public proxy baselines around market research,
  survey research, occupational employment, and occupational wages relevant to
  human preference-validation work.

## Current Evidence Status

- Task-productivity evidence is directly verified for customer support
  (Brynjolfsson, Li, and Raymond 2025), management consulting tasks
  (Dell'Acqua et al. 2026), and bounded professional writing tasks (Noy and
  Zhang 2023 DOI verified; MIT working-paper full text inspected).
- Transaction-cost evidence remains mostly unverified for these predictions.
  Brynjolfsson contains an internal support-process escalation proxy, and
  Dell'Acqua contains verification/correctness risk, but neither measures
  market contracting, enforcement, procurement, dispute, or liability costs.
- Firm-boundary evidence remains unverified for these predictions. The verified
  Census BTOS source measures employer-business AI adoption by firm size, not
  nonemployer share, outsourcing, management layers, revenue per human,
  concentration, or transitions from one-human nodes into firms.
- Census NES, BFS, BDS, SUSB, and AIES-NES now provide verified measurement
  infrastructure for nonemployer receipts, employer formations, and
  employer-firm dynamics, but none of these inspected sources identifies
  AI-enabled one-human firms or AI-driven boundary shifts.
- TCE-P006 has weak adoption-by-size support from Census BTOS, but still lacks
  productivity-capture, profit-capture, and boundary-change evidence.
- TCE-P001, TCE-P002, TCE-P005, TCE-P007, TCE-P009, and TCE-P010 still lack
  direct verified nonemployer, outsourcing, management-layer, concentration, or
  node-to-firm transition evidence.
- TCE-P001 and TCE-P009 can be operationalized with NES/AIES-NES nonemployer
  receipts and counts, but need AI-exposure linkage and survival/churn data
  before they can support a directional claim.
- TCE-P007 can use BFS employer-formation measures as a payroll-transition
  proxy, but BFS does not directly measure nonemployer-to-employer conversion
  or one-human nodes becoming firms.
- TCE-P005 still lacks direct management-layer, span-of-control,
  manager-to-worker, or support-staff-ratio evidence after this pass.
- TCE-P004 has no verified AI-specific transaction-cost evidence yet. Pallais
  2014 supports the narrower point that public evaluations can reduce
  information frictions in online labor markets. Resnick et al. 2006 provides
  abstract-level support for online reputation reducing trust frictions, but
  full text remains pending. Neither source measures AI-enabled supplier
  contracting costs.
- TCE-P008 now has partial non-AI platform-governance support for reputation
  and evaluation mechanisms, while escrow, arbitration, insurance,
  certification, audit-log, SLA, payment-delay, and dispute-resolution evidence
  remain open.
- P001/P005-style hierarchy or headcount-shrinkage predictions face early
  disconfirming pressure from Bonney et al. 2026 and Arledge 2025: official
  Census evidence reports mostly augmentation and rare or mostly absent
  employment decreases among employer businesses, with no direct measurement
  of management-layer change.
- TCE-P011 is a strong-thesis falsifier and has no current support. Remote
  work is no longer treated as a generic risk factor: office-to-remote work is
  the first unbundling, while persistence of remote salaried employment after
  capable AI labor services become available is a possible contradiction of
  the employment-unbundling version of the thesis. ACS PUMS, ATUS, and BLS
  Contingent and Alternative Employment Arrangements now provide public-source
  components for a descriptive monitoring baseline, but they do not observe
  AI-labor-service substitution, node substitution, vendor spend, output, or
  replacement events.
- TCE-P012 is a conditional economic-class implication, not evidence and not a
  policy claim. It says that, if automated production and Operator Nodes become
  important, the scarce human input may shift toward creators, niche human
  providers, and experiencers. BLS OEWS/OOH can provide weak public proxies for
  adjacent preference-research occupations, but no current support is claimed.

## Confounders To Track

- General digitization, post-pandemic self-employment, tax reclassification,
  reporting changes, outsourcing cycles, inflation, sector demand shocks,
  survivorship bias, hidden subcontracting, disguised employment, platform
  moderation, client sophistication, antitrust enforcement, open-source model
  quality, cloud pricing, and model-provider dependency.
- Remote employment should be tracked separately as a thesis-relevant
  transition/falsifier. The office-to-remote shift shows location unbundling;
  the strong thesis predicts later employment unbundling in AI-exposed,
  output-measurable digital roles.
- Economic class implications should be tracked as a separate forecast
  taxonomy, not as a conclusion. Do not collapse creator, owner, investor,
  entrepreneur, niche human provider, and experiencer into existing wage/self-
  employment categories without measurement rules.

## Required Fields Before Acceptance

- data source;
- sector;
- timeframe;
- comparison group;
- confounders;
- failure condition.

## Empirical Strategy Operationalization

Detailed test designs are recorded in `research/empirical_strategy.md`.
Sector-panel analysis-design constraints are recorded in
`research/data/sector_panel_analysis_design.md`; no descriptive calculations
have been run and no claim support changes are authorized from the current
processed inputs.
Dry-run validation is recorded in
`research/data/sector_panel_analysis_dry_run_validation.md`; it confirms
denominator availability and missing AIES cells before descriptive
calculations, but still does not produce evidence for or against any
prediction.
The first descriptive baseline run is recorded in
`research/data/sector_panel_descriptive_analysis_run.md`; it calculates only
approved one-year baseline measures and keeps `claim_support_updated=false`.
These outputs remain insufficient for prediction support without AI-exposure
linkage, comparison groups, and confounder handling.

Current operational status:

- TCE-P001 can be tested only as a sector-panel design until direct business
  AI-use linkage exists. Use NES/AIES-NES nonemployer receipts and counts,
  SUSB/BDS employer baselines, and BTOS/Bonney sector AI adoption where cells
  are available.
- TCE-P007 can use BFS employer formations and BDS employer startups as
  payroll-transition proxies, but this is indirect because current verified
  sources do not track nonemployer-to-employer conversion.
- TCE-P009 can use NES counts, receipt-size classes, BFS applications, and BDS
  employer dynamics to test entry and churn-like patterns, but direct
  nonemployer survival linked to AI remains missing.
- TCE-P010 can compare NES/AIES-NES nonemployer revenue share against
  SUSB/BDS employer baselines in high-AI-exposure sectors to test the
  corporate-absorption alternative.
- TCE-P005 remains blocked pending direct management-layer data such as
  manager-to-worker ratios, span of control, support-staff ratios, or
  org-chart depth after AI adoption.
- TCE-P011 has public monitoring sources for remote work, worker class,
  occupation, industry, work-location intensity, and alternative-arrangement
  context. It remains blocked for support pending data that distinguishes
  remote salaried employees from contractors, vendors, owner-operators, and AI
  labor services by role, sector, exposure, output, and replacement event.
- TCE-P012 is partially operationalized as measurement design, but remains
  blocked for evidence. It still needs accepted field definitions and direct
  data for creators, niche human providers, experiencers, compensated
  evaluation work, human-preference validation, and scarcity premiums before
  evidence can be accepted. The first measurement design is recorded in
  `research/data/economic_class_measurement_design.md`; public BLS sources are
  proxy baselines only.

Acceptance thresholds:

- `weak support`: directional patterns match a prediction, but AI linkage,
  durability, or confounder controls remain incomplete.
- `supported`: the source directly measures the relevant firm-boundary outcome
  at the appropriate unit with an explicit comparison group.
- `contradicted`: high-AI-exposure sectors show employer-firm gains or
  management-layer stability/growth where the prediction expected durable
  nonemployer gains or hierarchy shrinkage.
