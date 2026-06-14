# BFS Source-Native Observations

Status: source-native context-observation computation. Not aggregation, trend
measurement, prediction-link creation, export, claim support, paper prose, or
thesis evidence.

Run date: 2026-06-13.

## Purpose

Create first-pass BFS context observations from already staged BFS API rows
under the V1 guardrails defined in:

- `research/data/bfs_sample_row_load.md`
- `research/data/bfs_metric_definition_scaffold.md`
- `research/data/bfs_metric_computation_design.md`
- `thesis_record_app/config/thesis_record_policy.yml`

## Rails Task

```sh
bin/rails public_sources:bfs:compute_source_native_observations
```

The task:

- uses only already staged `bfs_api_rows`;
- uses only U.S.-level, non-seasonally adjusted, source-native sector/aggregate
  rows in the V1 eligible category list;
- creates at most one `MetricObservation` per numeric eligible source row;
- maps numeric `cell_value` rows to `staged_context`;
- excludes non-numeric or suppressed `cell_value` rows from observation
  creation;
- records source row ID, row hash, raw source value, evidence class, and
  guardrails in `quality_metadata`;
- deletes and recreates scoped BFS observations for idempotency.

## Live Result

Observed local result on 2026-06-13:

```text
eligible_rows=1368
observations_created=1351
status_counts={"staged_context"=>1351}
metric_counts={"bfs_business_applications"=>228, "bfs_high_propensity_business_applications"=>228, "bfs_business_formations_4q"=>228, "bfs_business_formations_8q"=>211, "bfs_projected_business_formations_4q"=>228, "bfs_projected_business_formations_8q"=>228}
blocked_cells={"bfs_business_formations_8q"=>17}
prediction_links_created=0
exports_created=0
```

The 17 blocked cells are source rows with non-numeric/suppressed values. They
were not converted into observations.

## Boundary

The observations are source-native context only.

They do not authorize:

- ratios;
- trends;
- aggregation;
- productivity measures;
- AI or Operator Node interpretation;
- nonemployer-to-employer conversion interpretation;
- firm-boundary conclusions;
- export;
- prediction links;
- claim support.

BFS still does not measure AI adoption, nonemployers, one-human firms,
management layers, transaction costs, remote work, or Operator Nodes.

Quality-review storage for BFS observations is now a context-only review gate,
not claim support.

Quality-review policy and review-state storage:

- `research/data/bfs_quality_review_policy.md`
