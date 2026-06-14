# SUSB Metric Definition Scaffold

Status: metric-definition scaffold. Not metric computation, observation table,
analysis, claim support, paper prose, or thesis evidence.

Run date: 2026-06-12.

## Canonical Definitions

Draft SUSB metric definitions are controlled by:

- `thesis_record_app/config/thesis_record_policy.yml`

Current definitions:

- `susb_employer_firm_count`
- `susb_employer_establishment_count`
- `susb_employment`
- `susb_annual_payroll_thousand`
- `susb_receipts_thousand_economic_census_year`

## Rails Task

```sh
bin/rails public_sources:susb:scaffold_metric_definitions
```

The task creates or updates `MetricDefinition` rows only.

It does not:

- create `MetricObservation` rows;
- parse/load SUSB rows;
- compute aggregates, ratios, panels, or trends;
- link metrics to claims;
- authorize exports;
- support or reject the thesis.

## Guardrails

SUSB remains employer-side public context only.

These draft definitions cannot support:

- AI adoption claims;
- nonemployer or one-human firm claims;
- management-layer thinning claims;
- transaction-cost claims;
- remote employment substitution claims;
- Operator Node thesis claims.

They become analytically usable only after a later staging/parser phase,
metric-computation design, source/quality review, and human claim-review gate.

Staging parser design:

- `research/data/susb_staging_parser.md`

Metric-computation design:

- `research/data/susb_metric_computation_design.md`
