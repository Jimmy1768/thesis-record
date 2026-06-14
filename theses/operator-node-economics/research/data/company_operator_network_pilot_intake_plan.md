# Company Operator Network Pilot Intake Plan

Status: source-specific private-data intake plan. Not data ingestion, analysis,
claim support, paper prose, legal advice, or policy recommendation.

Run date: 2026-06-12.

## Decision

The first governed private source should be the company operator network.

This is a pilot source for testing data governance, schema fit, hidden-labor
review, redaction, aggregation, and evidence workflow. It is not broad market
evidence and cannot prove the Operator Node thesis by itself.

## Source Classification

| Field | Value |
| --- | --- |
| `data_source_role` | `company_operator_network` |
| `claim_status_allowed` | `not_evidence` until reviewed; `feasibility_case` at most after review |
| `private_data_ingested` | `false` |
| `registry_rows_added` | `false` |
| `claim_support_updated` | `false` |
| `public_repo_raw_data_allowed` | `false` |

## Scope

The pilot may cover four tracks after private storage and review workflows are
ready:

1. Node case feasibility.
2. Transaction-cost metrics.
3. Remote role or vendor substitution.
4. Experiencer or evaluation-task markets.

The pilot should start with schema validation and redacted aggregate manifests,
not raw data ingestion.

## Private Storage Rule

Raw private data must live outside the repo.

The repo may only contain:

- schema documents;
- field dictionaries;
- validation scripts that do not embed private records;
- aggregate manifests after review;
- redacted case summaries after review;
- claim-review records.

The private storage class is selected: governed structured private records
should be stored in the production PostgreSQL database for the living
dissertation application. The production host, database URL, credentials, and
any private file-storage path are not recorded in the repo.

The current implementation target is a Rails, PostgreSQL, and Sidekiq living
dissertation application as specified in
`research/data/living_dissertation_application_build_plan.md`. That plan is a
build plan only; it does not authorize private data ingestion.

Storage-zone classification must follow:

- `research/data/private_storage_classification_matrix.md`

## Pilot Intake Sequence

1. Provision production PostgreSQL with access control, audit logging,
   encrypted backups, and tested restore before private ingestion.
2. Create a source-specific intake manifest with no raw records.
3. Map available company fields to the governance schemas in
   `research/data/private_data_governance.md`.
4. Define source-role disclosure language before observing outcomes.
5. Define transaction-cost and substitution baselines before observing
   outcomes.
6. Run hidden-labor and subcontractor review for each candidate node case.
7. Redact or hash client, worker, evaluator, supplier, account, project, and
   contract identifiers.
8. Produce only aggregate or redacted public artifacts that satisfy the minimum
   public-cell rule.
9. Submit any claim-status change to human review.

## Intake Tracks

### Node Case Feasibility

Purpose:

- determine whether a candidate node can be classified as candidate, partial,
  verified, hidden firm, converted to firm, or insufficient evidence.

Minimum fields before review:

- operator count;
- employee count;
- manager count;
- subcontractor count;
- unpaid labor count;
- client-provided labor or infrastructure flag;
- hidden-labor flag;
- payroll-started flag;
- legal entity type;
- AI systems used;
- workflow automation level;
- institutional memory system;
- audit trail availability;
- client count band;
- repeat-client count band;
- project count;
- revenue band;
- output unit;
- output count;
- quality or acceptance metric;
- rework count;
- delivery time.

Guardrail:

- hidden labor blocks `verified_node`.
- company-run case evidence is feasibility evidence only unless independently
  replicated.

### Transaction-Cost Metrics

Purpose:

- test whether node or AI-enabled supplier coordination reduces transaction
  costs relative to firm vendors, internal teams, ordinary contractors, or
  platform workers.

Minimum fields before review:

- supplier type;
- service category;
- comparison baseline ID;
- asset-specificity score;
- liability-risk score;
- output-measurability score;
- search time;
- proposal count or proposal cost;
- lead-to-contract time;
- legal-review time;
- procurement-cycle time;
- monitoring time;
- change-order count;
- dispute count;
- rework count;
- payment-delay days;
- repeat-purchase flag.

Guardrail:

- faster production alone is not transaction-cost evidence.
- baselines must be declared before outcome review.

### Remote Role Or Vendor Substitution

Purpose:

- test `TCE-P011` only when remote employee, vendor, node, owner-operator,
  contractor, or AI-labor-service destination can be observed.

Minimum fields before review:

- role or service category;
- remote status if employee role;
- employment or supplier status;
- replacement event flag;
- replacement destination;
- output unit;
- output count;
- quality or acceptance metric;
- AI service access or use;
- period;
- comparison role or business unit.

Guardrail:

- remote role decline does not support `TCE-P011` without stable/rising output
  and observed replacement destination.

### Experiencer / Evaluation Tasks

Purpose:

- test whether compensated human preference validation exists in the company
  operator network or related evaluation workflows.

Minimum fields before review:

- evaluation task ID hash;
- evaluator ID hash;
- buyer ID hash;
- producer type;
- output type;
- evaluation category;
- task duration;
- task difficulty;
- credential requirement;
- embodied-experience requirement;
- evaluator compensation band;
- reviewer quality metric;
- buyer decision impact;
- repeat evaluator demand;
- synthetic or telemetry substitution flag.

Guardrail:

- unpaid reviews, passive telemetry, and synthetic-user simulation are
  substitution or failure categories, not experiencer evidence.

## Disclosure Rules

Any public artifact derived from the pilot must say:

- the data source is the company operator network;
- the evidence is internal case or feasibility evidence;
- the evidence is not broad market diffusion evidence;
- hidden-labor, subcontractor, and client-infrastructure checks were reviewed
  or remain unresolved.

## Allowed Public Artifacts

Allowed after review:

- aggregate counts by quarter or month;
- banded revenue, contract value, compensation, or timing metrics;
- redacted case summaries;
- schema-validation reports;
- evidence insufficiency reports.

Not allowed:

- raw contracts;
- raw invoices;
- raw HRIS/payroll exports;
- client names;
- worker or evaluator names;
- exact client-level revenue;
- account identifiers;
- unredacted project details;
- claim-support changes without human review.

## Current Decision

The company operator network is selected as the first governed pilot source.

No data ingestion is authorized by this plan.

`private_data_ingested=false`
`registry_rows_added=false`
`claim_support_updated=false`
`production_postgresql_selected_for_private_structured_data=true`
`storage_classification_matrix_created=true`

## Next Implementation Gap

Implement the private application foundation, provision production PostgreSQL
with access control and backup/restore, then create a source-specific empty
intake manifest. Until that exists, no private data should be collected or
transformed.
