# AI Exposure And Node Feasibility Data Architecture

Status: data architecture only. Not source truth, analysis, claim support, or
paper prose.

Run date: 2026-06-12.

Purpose: define how the living forecast system should collect and distinguish
public AI-exposure proxies, node feasibility evidence, and transaction-cost
evidence. This architecture solves the current linkage problem structurally:
public proxies can indicate where to look, node data can test feasibility, and
transaction-cost data can test the Coasean mechanism.

## Core Linkage Problem

The current sector panel measures business-boundary outcomes but does not
measure AI exposure at the same unit.

The current AI adoption sources measure employer-business AI adoption or
worker-level AI use, but they do not directly measure:

- nonemployer AI use;
- one-human Operator Nodes;
- hidden labor;
- vendor substitution;
- transaction costs;
- durable node survival.

Therefore, future evidence must be separated into tracks instead of forced
into one false precision measure.

## Evidence Tracks

| Track | Main Question | Strongest Use | Main Limit |
| --- | --- | --- | --- |
| Public exposure proxy | Where should AI effects be expected first? | V1 forecast targeting and macro monitoring. | Not proof of node activity or boundary shift. |
| Node feasibility | Can a node-like production unit work repeatedly? | Feasibility and case evidence. | Does not prove broad diffusion. |
| Transaction-cost evidence | Are market/protocol coordination costs falling relative to firms? | Direct mechanism test. | Requires private procurement, platform, or company data. |

## Track A: Public Exposure Proxy

Purpose:

- Build conservative sector or occupation exposure context for forecast checks.

Allowed sources after verification:

- BTOS/Bonney employer AI adoption by sector, firm size, function, and task.
- Occupation-weighted GenAI exposure from a durable accepted source.
- Theoretical sector scoring for V1 forecasts only.

Possible fields:

- `exposure_source`
- `exposure_tier`
- `sector`
- `naics_code`
- `naics_vintage`
- `occupation_code`
- `occupation_weight`
- `employer_ai_use_rate`
- `employment_weighted_ai_use_rate`
- `function_breadth`
- `task_breadth`
- `occupation_weighted_exposure_score`
- `theoretical_exposure_score`
- `exposure_period`
- `exposure_unit`
- `exposure_limit`

Use:

- Identify sectors where the thesis should be more or less likely.
- Define high/low exposure groups for future forecast checks.
- Track corporate-absorption alternatives.

Guardrails:

- Employer AI adoption is not nonemployer AI use.
- Worker-level GenAI adoption is not firm-boundary change.
- Theoretical exposure scoring is a V1 forecast prior, not evidence.
- No exposure score should update claim support without linked outcome data and
  human review.

## Track B: Node Feasibility

Purpose:

- Test whether a node-like production unit can perform repeatable work without
  becoming a traditional firm.

Possible unit:

- node;
- node-month;
- client-node relationship;
- project;
- transaction;
- external case.

Minimum classification fields:

- `node_id`
- `case_id`
- `node_operator_count`
- `employee_count`
- `manager_count`
- `subcontractor_count`
- `hidden_labor_flag`
- `payroll_started_flag`
- `legal_entity_type`
- `ai_systems_used`
- `workflow_automation_level`
- `institutional_memory_system`
- `audit_trail_available`
- `human_review_required`
- `client_count`
- `repeat_client_count`
- `project_count`
- `revenue_period`
- `revenue_amount`
- `output_unit`
- `output_count`
- `quality_measure`
- `rework_count`
- `delivery_time`
- `node_status`

Node status values:

- `candidate_node`
- `verified_node`
- `partial_node`
- `hidden_firm`
- `converted_to_firm`
- `insufficient_evidence`

Use:

- Feasibility evidence.
- Case evidence.
- Detection of node-becomes-firm transitions.

Guardrails:

- A single feasibility case is not broad diffusion.
- A company-run case must disclose that the user's company is the data source
  or implementation context.
- Hidden labor, subcontractors, unpaid labor, and client-provided
  infrastructure must be tracked before a case is called a node.
- Revenue without labor-boundary verification is not node evidence.

## Track C: Transaction-Cost Evidence

Purpose:

- Test whether AI-enabled nodes reduce market or protocol transaction costs
  relative to firm vendors or internal teams.

Possible unit:

- procurement event;
- proposal;
- contract;
- invoice;
- project;
- dispute;
- client-node relationship.

Possible fields:

- `transaction_id`
- `supplier_type`
- `supplier_size`
- `node_id`
- `client_id_hash`
- `service_category`
- `asset_specificity_score`
- `liability_risk_score`
- `output_measurability_score`
- `search_time`
- `proposal_cost`
- `lead_to_contract_time`
- `legal_review_time`
- `procurement_cycle_time`
- `monitoring_time`
- `change_order_count`
- `dispute_count`
- `rework_count`
- `payment_delay_days`
- `repeat_purchase_flag`
- `client_retention_flag`
- `comparison_vendor_type`

Use:

- Direct Coasean/TCE mechanism testing.
- Comparison of protocol/market coordination against firms or internal teams.

Guardrails:

- Faster production is not lower transaction cost unless contracting,
  monitoring, dispute, rework, and enforcement costs are also measured.
- Supplier satisfaction or anecdotal speed is not transaction-cost evidence.
- Client identifiers must be hashed or removed before public evidence use.

## Exposure Ladder

Use a tiered exposure ladder:

| Tier | Evidence | Status |
| --- | --- | --- |
| Tier 1 | Direct node/business AI-use linked to outcomes. | Strongest; feasibility or diffusion depending on scale. |
| Tier 2 | Observed employer-business AI adoption by sector/size/function. | Context; may support corporate-absorption criticism. |
| Tier 3 | Occupation-weighted GenAI exposure mapped to sectors. | Proxy; useful for forecast targeting. |
| Tier 4 | Theoretical sector exposure scoring. | V1 forecast prior only; not evidence. |

## Review Gates

Private-data governance for node, transaction-cost, remote-substitution,
AI-labor-service, and experiencer/evaluation data is defined in
`research/data/private_data_governance.md`.

Before an exposure table can be used:

- source verified;
- unit identified;
- sector or occupation mapping documented;
- time period documented;
- missing cells documented;
- limitations recorded;
- claim-review status remains separate.

Before a node case can be used:

- labor inputs verified;
- hidden labor and subcontractors checked;
- output and revenue period documented;
- client or project evidence checked;
- conversion-to-firm status checked;
- privacy/disclosure review completed.

Before transaction-cost evidence can be used:

- comparison vendor or internal-team baseline defined;
- transaction-cost fields measured directly or labeled proxy;
- asset specificity and liability risk documented;
- disputes/rework/payment-delay definitions fixed before outcome review.

## Immediate Implementation Sequence

Completed registry templates:

- `data/manifests/exposure_source_registry_template.csv`
- `data/manifests/node_case_registry_template.csv`
- `data/manifests/transaction_cost_metric_registry_template.csv`
- `research/data/living_forecast_registry_templates.md`
- `research/data/living_forecast_registry_validator.py`

Current population policy:

- `research/data/registry_population_policy.md`

Current populated registry:

- `data/manifests/exposure_source_registry.csv`

The populated exposure-source rows are accepted only for forecast-baseline
monitoring. They do not update claim support.

Next implementation sequence:

1. Apply `research/data/private_data_governance.md` to one specific source.
2. Select private storage outside the repo.
3. Define source-role disclosure and public aggregation rules for that source.
4. Define transaction-cost comparison baselines and metric formulas before
   observing outcomes.
5. Populate the node-case registry only after source-specific privacy,
   disclosure, confidentiality, and hidden-labor review.
6. Populate the transaction-cost metric registry only after baselines and
   direct/proxy field rules are accepted.
7. Only then implement ingestion jobs.

No current step authorizes claim support or paper prose.
