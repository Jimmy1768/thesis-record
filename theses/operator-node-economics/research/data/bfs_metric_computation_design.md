# BFS Metric Computation Design

Status: source-native context-observation gate. No aggregation, trends, quality
reviews, prediction links, exports, claim support, paper prose, or thesis
evidence.

Run date: 2026-06-13.

## Purpose

Define the conservative gate that must pass before any future BFS source rows
can be converted into metric observations.

This design allows only source-native context observations from already staged
BFS rows. It does not authorize aggregation, trends, quality reviews,
prediction links, exports, or claim support.

## Policy

Canonical defaults are controlled by:

- `thesis_record_app/config/thesis_record_policy.yml`

Policy section:

- `public_ingestion_v1.bfs_monthly_api.metric_computation_design_v1`

The V1 gate allows only source-native observations:

- metric definitions: not authorized;
- metric observations: authorized only at source-native monthly sector grain;
- quality reviews: not authorized;
- exports: not authorized;
- prediction links: not authorized;
- claim-status effect: `unchanged`.

Metric definitions are scaffolded separately in:

- `research/data/bfs_metric_definition_scaffold.md`

Those definitions remain `draft_disabled` and do not authorize observation
creation or analysis.

Source-native observation creation is documented in:

- `research/data/bfs_source_native_observations.md`

## Eligible Source Rows For A Later Pass

The future V1 computation path is limited to already staged rows in:

- `bfs_api_rows`

Eligible row constraints:

- U.S. geography only;
- source-native monthly rows;
- `seasonally_adj=no`;
- source-native sector/aggregate categories already listed in policy;
- target `data_type_code` values:
  - `BA_BA`
  - `BA_HBA`
  - `BF_BF4Q`
  - `BF_BF8Q`
  - `BF_PBF4Q`
  - `BF_PBF8Q`

## First-Pass Metric Keys

Reserved metric keys:

- `bfs_business_applications`
- `bfs_high_propensity_business_applications`
- `bfs_business_formations_4q`
- `bfs_business_formations_8q`
- `bfs_projected_business_formations_4q`
- `bfs_projected_business_formations_8q`

These keys are reserved only. No `MetricDefinition` rows are created by this
slice.

## Source Value Rules

| Source condition | V1 status |
| --- | --- |
| Numeric `cell_value` | `staged_context` |
| Non-numeric `cell_value` | `blocked_suppression_or_non_numeric` |
| `error_data=yes` | `blocked_error_data` |
| Missing `cell_value` | `blocked_missing_value` |

The design intentionally preserves Census suppression or non-numeric markers
instead of coercing them into zero or dropping them silently.

## Prohibited Computation

The V1 design prohibits:

- ratios;
- trends;
- aggregation;
- seasonal-adjustment mixing;
- category harmonization;
- NAICS crosswalk transformation;
- productivity measures;
- AI or Operator Node interpretation;
- nonemployer-conversion interpretation;
- claim support;
- exports;
- prediction links.

## Rails Task

```sh
bin/rails public_sources:bfs:verify_metric_computation_design
```

The task checks that the BFS metric-computation design remains disabled and
context-only. It also fails if BFS metric observations already exist.

## Guardrail

BFS employer formations remain only an indirect payroll-transition proxy. A
future BFS metric observation, if authorized, would still be context evidence
only and would not prove nonemployer-to-employer conversion, AI adoption,
Operator Nodes, transaction-cost change, productivity, or firm-boundary change.
