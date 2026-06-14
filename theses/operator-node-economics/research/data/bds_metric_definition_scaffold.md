# BDS Metric Definition Scaffold

Status: draft-disabled source-native metric definitions created. Not metric
observation creation, quality review, export, prediction-link creation,
analysis, claim support, or paper prose.

Date: 2026-06-14.

## Purpose

Create labels and formulas for BDS source-native fields so later slices can
design computation and review policy explicitly.

Definitions are not observations and do not support claims.

## Rails Objects

Service:

- `PublicSources::Bds::MetricDefinitionScaffold`

Task:

```sh
bin/rails public_sources:bds:scaffold_metric_definitions
```

Policy section:

- `public_ingestion_v1.bds_sector_age_size_public_file.parser_design_v1.metric_definition_scaffold_v1`
- `public_ingestion_v1.bds_sector_age_size_public_file.parser_design_v1.metric_definitions`

## Live Result

```text
bds_firms=draft_disabled
bds_establishments=draft_disabled
bds_employment=draft_disabled
bds_establishment_entries=draft_disabled
bds_establishment_exits=draft_disabled
bds_firm_deaths=draft_disabled
bds_job_creation=draft_disabled
bds_job_destruction=draft_disabled
bds_net_job_creation=draft_disabled
bds_reallocation_rate=draft_disabled
metric_definitions_created=10
metric_observations_created=0
quality_reviews_created=0
prediction_links_created=0
exports_created=0
```

## Guardrails

Every BDS definition remains `draft_disabled`.

The scaffold does not authorize:

- metric observations;
- quality reviews;
- exports;
- prediction links;
- aggregation;
- trend analysis;
- ratios beyond source-provided fields;
- claim support.

## Boundary

BDS metrics are employer-firm dynamics context only. They do not measure AI
adoption, nonemployers, hidden contractors, management layers, transaction
costs, Operator Nodes, one-person firms, or firm-boundary change.

## Next Gate

The BDS metric-computation design is recorded in
`research/data/bds_metric_computation_design.md`. Metric observations remain
disabled.
