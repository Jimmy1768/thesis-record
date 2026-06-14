# Private Data Governance

Status: research/data governance. Not data ingestion, analysis, claim support,
paper prose, legal advice, or policy recommendation.

Run date: 2026-06-12.

## Purpose

Define the governance layer required before company, partner, platform,
payroll, procurement, node, or evaluator data can be collected for direct
forecast tests.

This closes the architecture gap identified in:

- `research/data/registry_population_policy.md`
- `research/data/remote_employment_measurement_design.md`
- `research/data/economic_class_measurement_design.md`
- `research/data/ai_exposure_node_feasibility_architecture.md`

No private data is ingested by this document.

## Scope

This governance layer covers direct tests for:

- `TCE-P011`: remote employee to node, vendor, owner-operator, contractor, or
  AI-labor-service substitution;
- `TCE-P012`: creators, niche human providers, experiencers, paid evaluation,
  human-preference validation, and synthetic/telemetry substitution;
- `TCE-P004`: transaction-cost metrics for search, contracting, monitoring,
  disputes, rework, payment, repeat purchase, and enforcement.

It also supports node feasibility and hidden-labor checks for `TCE-P001`,
`TCE-P002`, `TCE-P007`, `TCE-P008`, and `TCE-P010`.

## Governance Principles

1. Do not collect private data before the unit, purpose, retention rule, and
   publishable aggregation rule are specified.
2. Do not store client-identifying, worker-identifying, evaluator-identifying,
   or counterparty-identifying fields in public tracked files.
3. Public artifacts should use aggregate, redacted, or hashed identifiers only.
4. Private data can support feasibility or forecast checks only after
   disclosure and hidden-labor review.
5. Company-derived evidence must disclose whether the company is the data
   source, implementation case, network operator, buyer, seller, or evaluator
   coordinator.
6. Faster production is not transaction-cost evidence unless search,
   contracting, monitoring, rework, dispute, payment, and enforcement measures
   are either measured or explicitly unavailable.
7. Claim status remains separate from registry status. No automated job may
   promote a claim.

## Private Storage Decision

Structured private data should be stored in the production PostgreSQL database
for the living dissertation application. Production PostgreSQL is the private
evidence system of record for governed structured records, review states,
metrics, and snapshot metadata.

Guardrails:

- raw private rows must not be stored in Git;
- production database credentials and URLs must not be stored in Git;
- local development should use synthetic, fixture, or redacted data by default;
- production database dumps should not live on the MacBook unless explicitly
  encrypted, temporary, and documented;
- encrypted backups and a tested restore path are required before private
  ingestion;
- confidential source documents may require private object storage or encrypted
  file storage, with PostgreSQL storing only metadata, hashes, privacy status,
  and storage pointers.

Hard storage classification is defined in:

- `research/data/private_storage_classification_matrix.md`

## Privacy Classes

| Class | Storage | Public Use | Examples |
| --- | --- | --- | --- |
| `public` | tracked repo allowed | direct citation allowed | official public source metadata |
| `aggregated_public` | tracked repo allowed after review | aggregate tables only | counts by period/category with minimum cell size |
| `redacted_public` | tracked repo allowed after review | redacted examples only | case IDs, hashed client IDs, no names |
| `internal` | private storage only | aggregate after review | operational metrics without client names |
| `confidential` | restricted private storage only | no public use unless separately approved | contracts, invoices, client names, worker/evaluator identities |

Minimum public-cell rule:

- The current minimum public-cell threshold is defined in
  `living_dissertation_app/config/living_dissertation_policy.yml`.
- Do not publish a private-data aggregate below that threshold for underlying
  clients, workers, evaluators, suppliers, or transactions unless the subject
  has explicitly approved identification and the approval is recorded outside
  the repo.

## Required Review Flags

Every private-data source must carry:

- `data_owner`
- `data_source_role`
- `privacy_classification`
- `disclosure_status`
- `retention_rule`
- `public_aggregation_rule`
- `identity_fields_removed`
- `client_confidentiality_reviewed`
- `worker_or_evaluator_confidentiality_reviewed`
- `hidden_labor_reviewed`
- `baseline_defined_before_outcome_review`
- `claim_status_allowed`
- `human_review_required`

## Data Source Roles

| Role | Meaning | Guardrail |
| --- | --- | --- |
| `company_operator_network` | Data from the user's company or managed node network | Case/feasibility evidence only unless independently replicated |
| `partner_company` | Data from a partner buyer, seller, or platform | Requires source-role disclosure and aggregation rules |
| `external_platform` | Marketplace, evaluator, labor, or procurement platform data | Check platform definitions and survivorship bias |
| `buyer_procurement` | Buyer-side vendor, contract, invoice, or project data | Client confidentiality and comparable baseline required |
| `seller_node` | Node/operator-side revenue, output, labor, and client data | Hidden-labor review required |
| `public_proxy` | Public dataset used as context | Not private evidence |

## First Pilot Source Decision

The selected first governed private source is the company operator network.

Detailed pilot intake plan:

- `research/data/company_operator_network_pilot_intake_plan.md`

Application build plan:

- `research/data/living_dissertation_application_build_plan.md`

Guardrail:

- company operator network data can test governance workflow and may later
  provide feasibility-case evidence after review, but it is not broad diffusion
  evidence and does not prove the Operator Node thesis by itself.

## Minimum Viable Schemas

These schemas define fields to govern before ingestion. They are not database
tables and should not be treated as collected data.

### HRIS / Payroll Role Schema

Purpose: test whether remote salaried roles persist, decline, convert, or move
to external capacity.

Required fields:

- `org_id_hash`
- `role_id_hash`
- `worker_id_hash`
- `period`
- `employment_status`
- `remote_status`
- `occupation_or_role`
- `department_or_function`
- `start_date`
- `end_date`
- `compensation_band`
- `hours_or_fte`
- `output_unit`
- `output_count`
- `quality_or_acceptance_metric`
- `ai_tool_or_ai_service_access`
- `replacement_event_flag`
- `replacement_destination`
- `client_or_business_unit_hash`
- `privacy_classification`

Guardrails:

- `replacement_destination` must use a closed vocabulary:
  `internal_employee`, `node`, `firm_vendor`, `owner_operator`,
  `contractor`, `ai_labor_service`, `offshore_vendor`, `automation_only`,
  `role_eliminated_no_replacement`, `unknown`.
- A remote role decline is not support for `TCE-P011` unless output is stable
  or rising and replacement destination is observed.

### Procurement / Vendor Schema

Purpose: test substitution and transaction costs across supplier categories.

Required fields:

- `transaction_id_hash`
- `buyer_id_hash`
- `supplier_id_hash`
- `supplier_type`
- `supplier_size_band`
- `service_category`
- `project_start_date`
- `project_end_date`
- `contract_value_band`
- `proposal_count`
- `search_time`
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
- `comparison_baseline_id`
- `privacy_classification`

Guardrails:

- `supplier_type` must distinguish node, firm vendor, owner-operator,
  contractor, platform worker, AI labor service, and internal team.
- A baseline must be defined before outcome review.

### Node Case Schema

Purpose: classify node feasibility without hiding labor inputs.

Required fields:

- `case_id`
- `node_id_hash`
- `case_source`
- `data_source_role`
- `operator_count`
- `employee_count`
- `manager_count`
- `subcontractor_count`
- `unpaid_labor_count`
- `client_provided_labor_or_infrastructure_flag`
- `hidden_labor_flag`
- `payroll_started_flag`
- `legal_entity_type`
- `ai_systems_used`
- `workflow_automation_level`
- `institutional_memory_system`
- `audit_trail_available`
- `client_count_band`
- `repeat_client_count_band`
- `project_count`
- `revenue_band`
- `revenue_period`
- `output_unit`
- `output_count`
- `quality_or_acceptance_metric`
- `rework_count`
- `delivery_time`
- `node_status`
- `conversion_status`
- `disclosure_status`
- `privacy_classification`

Guardrails:

- Hidden labor blocks `verified_node`.
- Company-run cases require explicit source-role disclosure.
- Revenue without labor-boundary review is not node evidence.

### AI Labor Service Schema

Purpose: distinguish software/tool spend from purchased AI labor capacity.

Required fields:

- `ai_service_id_hash`
- `buyer_id_hash`
- `service_category`
- `ai_service_type`
- `usage_period`
- `capacity_measure`
- `human_oversight_required`
- `human_oversight_time`
- `output_unit`
- `output_count`
- `quality_or_acceptance_metric`
- `rework_count`
- `service_spend_band`
- `replaced_role_or_vendor_flag`
- `replacement_origin`
- `privacy_classification`

Guardrails:

- Software subscription spend is not AI labor-service substitution unless
  capacity, output, and replacement origin are defined.

### Experiencer / Evaluation Task Schema

Purpose: test whether compensated human preference validation becomes a
meaningful labor category.

Required fields:

- `evaluation_task_id_hash`
- `evaluator_id_hash`
- `buyer_id_hash`
- `producer_type`
- `output_type`
- `evaluation_category`
- `task_duration`
- `task_difficulty`
- `credential_requirement`
- `embodied_experience_requirement`
- `evaluator_compensation_band`
- `reviewer_quality_metric`
- `buyer_decision_impact`
- `repeat_evaluator_demand`
- `synthetic_or_telemetry_substitution_flag`
- `automated_evaluation_cost_band`
- `evaluated_output_revenue_or_adoption_band`
- `privacy_classification`

Guardrails:

- Unpaid reviews, passive telemetry, and synthetic users are substitution or
  failure categories, not experiencer evidence.
- Compensation and buyer decision impact are required before a task can count
  as experiencer evidence.

## Claim-Status Gates

### `TCE-P011`

Minimum for `leading_indicator`:

- remote salaried role count/share changes by role or function;
- AI exposure or AI labor-service availability is observed;
- replacement destination is observed or explicitly marked unknown;
- output is stable, rising, or explicitly unavailable.

Minimum for `weak_support`:

- remote salaried roles decline in a predeclared AI-exposed role set;
- output is stable or rising;
- replacement destination shifts toward node, vendor, owner-operator,
  contractor, or AI labor service;
- comparison role/sector is defined.

### `TCE-P012`

Minimum for `leading_indicator`:

- compensated evaluation tasks, evaluator counts, or niche human-presence
  premiums grow in a predeclared market segment;
- unpaid reviews, telemetry, and synthetic-user substitution are tracked
  separately.

Minimum for `weak_support`:

- paid human preference-validation work grows durably;
- buyer decision impact is observed;
- compensation rises with difficulty, credential, duration, embodied
  experience, or reviewer quality;
- the evaluated output is linked to AI-produced, node-produced, or automated
  production abundance.

### `TCE-P004`

Minimum for `leading_indicator`:

- at least one transaction-cost metric improves for node or AI-enabled supplier
  transactions versus a predeclared baseline;
- directness and missing metric limits are recorded.

Minimum for `weak_support`:

- procurement/search/contracting, monitoring, dispute/rework, and payment or
  repeat-purchase metrics are compared against firm-vendor or internal-team
  baselines in the same service category;
- asset specificity, liability risk, and output measurability are scored
  before outcome review.

## Allowed Public Outputs

Allowed after review:

- aggregate counts by period, source role, privacy class, and high-level
  supplier/evaluator category;
- deidentified case summaries with no client, worker, evaluator, or
  counterparty names;
- metric distributions in bands rather than exact contract values;
- claim-review tables that say evidence is insufficient.

Not allowed:

- raw contracts, invoices, HRIS exports, payroll records, client names,
  evaluator names, worker names, account identifiers, or unredacted project
  details;
- exact client-level revenue or contract values unless explicitly approved;
- public claims based on private data before disclosure review.

## Registry Implication

The node-case and transaction-cost metric registry templates can now be treated
as governance-ready templates, not populated evidence.

They remain blocked for row population until:

- production PostgreSQL is provisioned with access control, backup, restore,
  and audit logging;
- source-role disclosure rules are accepted for each source;
- baseline definitions are recorded before outcome review;
- hidden-labor and confidentiality review workflows exist.

## Current Decision

This document closes the governance-design gap but does not authorize private
data ingestion.

`claim_support_updated=false`
`private_data_ingested=false`
`registry_rows_added=false`
`rails_app_implemented=false`
`production_postgresql_selected_for_private_structured_data=true`
`storage_classification_matrix_created=true`
