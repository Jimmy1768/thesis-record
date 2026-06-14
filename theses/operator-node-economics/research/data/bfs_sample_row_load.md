# BFS Sample Row Load

Status: guarded sample-row staging. Not metric computation, quantitative
analysis, export, claim support, paper prose, or thesis evidence.

Run date: 2026-06-13.

## Purpose

Load one small, policy-authorized BFS sample into the private structured
database so later slices can validate transformation and quality rules against
real source rows.

## Policy

Canonical defaults are controlled by:

- `thesis_record_app/config/thesis_record_policy.yml`

Policy section:

- `public_ingestion_v1.bfs_monthly_api.sample_load_v1`

V1 authorization:

- API pull: authorized for `time=2012` only;
- raw/staged rows: authorized;
- metric computation: not authorized;
- analysis: not authorized;
- exports: not authorized;
- prediction links: not authorized;
- claim-status effect: `unchanged`.

## Query Shape

```text
get=data_type_code,time_slot_id,seasonally_adj,category_code,cell_value,error_data
time=2012
for=us:*
```

## Eligible Scope

- U.S. geography only.
- `seasonally_adj=no`.
- `time_slot_id=0`.
- `error_data=no`.
- target series:
  - `BA_BA`
  - `BA_HBA`
  - `BF_BF4Q`
  - `BF_BF8Q`
  - `BF_PBF4Q`
  - `BF_PBF8Q`
- source-native sector/aggregate categories listed in
  `living_dissertation_policy.yml`.

## Load Result

Task:

```sh
bin/rails public_sources:bfs:load_sample_rows
```

Observed result:

```text
total_rows=5544
eligible_rows=1368
rows_upserted=1368
metric_definitions_created=0
metric_observations_created=0
prediction_links_created=0
exports_created=0
```

The loader is idempotent at the source-native row grain:

- `data_source_id`
- `period_month`
- `data_type_code`
- `category_code`
- `seasonally_adj`
- `geography_level`
- `geography_code`

The metric-computation gate for these rows is documented in:

- `research/data/bfs_metric_computation_design.md`

## Data Quality Notes

`cell_value_raw` is preserved as the Census API returned it.

`cell_value_numeric` is populated only when the raw value is parseable as a
decimal. Non-numeric raw values, including Census suppression markers such as
`D`, remain staged raw values and are flagged in row metadata as
`raw_cell_value_non_numeric=true`.

## Guardrail

The staged BFS rows are source context only. They are not metric observations,
not evidence for AI adoption, not evidence for Operator Nodes, and not evidence
of nonemployer-to-employer conversion.

BFS employer formations remain only an indirect payroll-transition proxy.
