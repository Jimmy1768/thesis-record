# BFS Metric Definition Scaffold

Status: metric-definition scaffold. Not metric computation, observation
creation, quality review, prediction-link creation, export, claim support,
paper prose, or thesis evidence.

Run date: 2026-06-13.

## Purpose

Create inert `MetricDefinition` rows for the six reserved BFS source-context
metrics. These definitions make later computation work explicit without
authorizing computation.

## Canonical Definitions

Draft BFS metric definitions are controlled by:

- `living_dissertation_app/config/living_dissertation_policy.yml`

Policy sections:

- `public_ingestion_v1.bfs_monthly_api.metric_definition_scaffold_v1`
- `public_ingestion_v1.bfs_monthly_api.metric_definitions`

Current definitions:

- `bfs_business_applications`
- `bfs_high_propensity_business_applications`
- `bfs_business_formations_4q`
- `bfs_business_formations_8q`
- `bfs_projected_business_formations_4q`
- `bfs_projected_business_formations_8q`

All definitions use `formula_status=draft_disabled`.

## Rails Task

```sh
bin/rails public_sources:bfs:scaffold_metric_definitions
```

The task creates or updates `MetricDefinition` rows only.

It does not:

- create `MetricObservation` rows;
- compute BFS metrics;
- aggregate rows;
- calculate ratios, trends, or panels;
- create quality reviews;
- link metrics to predictions or claims;
- authorize exports;
- support or reject the thesis.

## Guardrails

BFS remains an indirect payroll-transition proxy only.

These draft definitions cannot support:

- AI adoption claims;
- Operator Node claims;
- nonemployer-to-employer conversion claims;
- firm-boundary conclusions;
- productivity claims;
- transaction-cost claims;
- remote employment substitution claims.

They become analytically usable only after a later computation slice, quality
review, and human claim-review gate.

Related design:

- `research/data/bfs_sample_row_load.md`
- `research/data/bfs_metric_computation_design.md`
