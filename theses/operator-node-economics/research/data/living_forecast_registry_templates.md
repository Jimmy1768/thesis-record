# Living Forecast Registry Templates

Status: registry-template documentation only. Not data ingestion, analysis,
claim support, or paper prose.

Run date: 2026-06-12.

Purpose: document the first tracked registry templates for the living forecast
system. These registries are prerequisites for future ingestion jobs.

## Templates

Tracked templates:

- `data/manifests/exposure_source_registry_template.csv`
- `data/manifests/node_case_registry_template.csv`
- `data/manifests/transaction_cost_metric_registry_template.csv`

Validator:

- `research/data/living_forecast_registry_validator.py`

## Command Run

```bash
python3 research/data/living_forecast_registry_validator.py
```

Output:

```text
registry_templates_validated=3
exposure_source_registry_template.csv_rows=0
node_case_registry_template.csv_rows=0
transaction_cost_metric_registry_template.csv_rows=0
data_ingested=false
claim_support_updated=false
```

## Registry Roles

### Exposure Source Registry

Purpose:

- Track candidate and accepted AI-exposure sources.
- Preserve exposure tier, unit, period, source status, limitations, and review
  status.

Guardrail:

- Exposure sources identify where to look. They do not prove node activity or
  boundary change by themselves.

### Node Case Registry

Purpose:

- Track internal or external node-like cases and classify whether they meet
  feasibility criteria.

Guardrail:

- Node status requires labor-boundary, hidden-labor, subcontractor, revenue,
  output, and disclosure review. A single case does not prove diffusion.
- Private-data governance is defined in
  `research/data/private_data_governance.md`; the template remains unpopulated
  until source-specific storage, disclosure, confidentiality, and hidden-labor
  review are complete.

### Transaction-Cost Metric Registry

Purpose:

- Track transaction-cost data sources and fields before procurement,
  contracting, monitoring, dispute, rework, or payment-delay metrics are used.

Guardrail:

- Transaction-cost evidence requires comparison baselines and direct or clearly
  labeled proxy measurement.
- Private-data governance is defined in
  `research/data/private_data_governance.md`; the template remains unpopulated
  until baselines are declared before outcome review.

## Allowed Status Values

Review status values:

- `raw_collected`
- `schema_validated`
- `indicator_computed`
- `review_pending`
- `accepted_for_baseline`
- `accepted_for_forecast_check`
- `rejected_or_superseded`

Claim-status-allowed values:

- `not_evidence`
- `forecast_baseline`
- `leading_indicator`
- `feasibility_case`
- `diffusion_evidence`

Privacy classifications:

- `public`
- `internal`
- `confidential`
- `aggregated_public`
- `redacted_public`

## Current State

The templates currently contain headers only. No case rows or
transaction-cost metric rows have been ingested.

The populated exposure-source registry now contains public forecast-baseline
source rows:

- `data/manifests/exposure_source_registry.csv`

These rows authorize monitoring context only. They do not authorize claim
support, paper prose, node evidence, transaction-cost evidence, or conclusion
language.

Private node, transaction-cost, remote-employment substitution, AI-labor-
service, and experiencer/evaluation rows remain blocked until governed source-
specific review is complete.

First selected pilot source:

- company operator network;
- intake plan:
  `research/data/company_operator_network_pilot_intake_plan.md`.

The pilot source selection does not add registry rows or authorize ingestion.
