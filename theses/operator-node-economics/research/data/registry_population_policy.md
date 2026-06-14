# Registry Population Policy

Status: research/data-architecture policy. Not data ingestion, analysis, claim
support, or paper prose.

Run date: 2026-06-12.

Purpose: define the safest path from empty living-forecast registry templates
to usable evidence tracking without converting exposure proxies or company
cases into unsupported claims.

## Decision

The best next path is staged registry population:

1. Seed public exposure-source candidates from already verified source notes.
2. Keep node-case registry rows blocked until the governance rules in
   `research/data/private_data_governance.md` are applied to a specific
   source, private storage location, disclosure rule, and hidden-labor review.
3. Keep transaction-cost metric rows blocked until comparison baselines and
   metric definitions are fixed before observing outcomes under
   `research/data/private_data_governance.md`.
4. Only after those gates are complete should recurring ingestion jobs or
   dashboard refresh jobs be implemented.

## Why This Path

The central thesis is a forecast about future firm-boundary change, not a
retrospective finding. That makes the first version vulnerable to false
precision. The registry system should therefore preserve three different
things separately:

- exposure context, which says where to look;
- node feasibility, which says whether a node-like unit can operate in a
  bounded case;
- transaction-cost measurement, which tests the mechanism.

Combining these too early would make a forecast look like a conclusion.

## Population Rules

### Exposure Source Registry

Allowed now:

- verified public sources already covered by source notes;
- rows with `claim_status_allowed=forecast_baseline`;
- rows that clearly say whether nonemployer AI use, node use, and outcome
  linkage are observed.

Not allowed yet:

- arXiv-only sources as source truth;
- unverified URLs or source claims;
- treating employer AI adoption as nonemployer or Operator Node evidence;
- treating worker-level AI adoption as firm-boundary evidence.

Initial accepted rows:

- `EXP-001`: Census BTOS "AI Use at U.S. Businesses" as employer-business
  adoption context.
- `EXP-002`: Bonney et al. 2026 as employer-firm AI diffusion context.
- `EXP-003`: Bick, Blandin, and Deming as worker-level GenAI adoption context.

These rows are accepted only for forecast-baseline targeting and monitoring.
They do not update claim support.

### Node Case Registry

Governance policy now exists in
`research/data/private_data_governance.md`, but row population remains blocked
until a specific source passes review.

Blocked until source-specific governance defines:

- whether company-run nodes, partner nodes, or external cases may be tracked;
- what can be stored publicly, internally, confidentially, aggregated, or
  redacted;
- minimum evidence for operator count, employee count, manager count,
  subcontractor count, and hidden labor;
- client and revenue handling rules;
- how to disclose when the user's company is the data source or implementation
  case.

Minimum safe rule:

- no row should be marked `feasibility_case` until hidden labor,
  subcontractors, payroll status, output, revenue period, and repeat demand
  have been reviewed.

### Transaction-Cost Metric Registry

Governance policy now exists in
`research/data/private_data_governance.md`, but row population remains blocked
until baselines are defined before outcome review:

- comparable traditional firm vendor;
- comparable internal team;
- comparable ordinary freelancer or contractor;
- service category;
- asset-specificity, liability-risk, and output-measurability scoring;
- direct versus proxy measurement for search, proposal, legal, procurement,
  monitoring, dispute, rework, payment delay, and repeat purchase.

Minimum safe rule:

- faster production time is not transaction-cost evidence unless contracting,
  monitoring, dispute, rework, enforcement, and payment frictions are measured
  or explicitly marked unavailable.

## Current Registry State

Created populated public registry:

- `data/manifests/exposure_source_registry.csv`

Still header-only templates:

- `data/manifests/node_case_registry_template.csv`
- `data/manifests/transaction_cost_metric_registry_template.csv`

No node cases, transaction-cost metrics, private data, quantitative analysis,
or claim-support changes were added in this pass.

## Next Gap

The governance policy is now defined and the first pilot source has been
selected:

- `company_operator_network`
- `research/data/company_operator_network_pilot_intake_plan.md`

Implementation remains blocked until source-specific operational choices are
made:

- choose private storage outside the repo;
- create a source-specific empty intake manifest with no raw records;
- record comparison baselines before outcome review;
- implement hidden-labor, confidentiality, and aggregation review workflows.

Until those source-specific gates are closed, recurring jobs should not ingest
company, node, evaluator, HRIS, payroll, procurement, or transaction-cost data.
