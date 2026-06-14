# BFS Quality Review Policy

Status: quality-review policy and review-state storage for BFS source-native
context observations. Not aggregation, trend measurement, prediction-link
creation, export, claim support, paper prose, or thesis evidence.

Run date: 2026-06-13.

## Purpose

Create explicit review-state rows for BFS source-native observations so future
work can distinguish reviewed context from unreviewed observation records.

This review does not make BFS observations claim-supporting evidence.

## Policy

Canonical defaults are controlled by:

- `living_dissertation_app/config/living_dissertation_policy.yml`

Policy section:

- `public_ingestion_v1.bfs_monthly_api.quality_review_policy_v1`

Review storage:

- `metric_quality_reviews`

## Review Mapping

| Source metric status | Review status |
| --- | --- |
| `staged_context` | `reviewed_context` |

Blocked or suppressed BFS source cells are not observations in the current V1
flow, so they do not receive review rows.

## Rails Tasks

```sh
bin/rails public_sources:bfs:verify_quality_review_policy
bin/rails public_sources:bfs:create_quality_reviews
bin/rails public_sources:bfs:quality_review_summary
```

The review task:

- scopes only to Census BFS observations;
- scopes only to `quality_metadata.source_table=bfs_api_rows`;
- writes `MetricQualityReview` rows;
- does not mutate `MetricObservation` rows;
- does not create prediction links;
- does not create exports;
- does not change claim status.

## Live Result

Observed local result on 2026-06-13:

```text
observations_reviewed=1351
reviews_upserted=1351
status_counts={"reviewed_context"=>1351}
prediction_links_created=0
exports_created=0
```

Idempotency rerun returned the same reviewed/upserted counts and did not
increase the total number of BFS quality-review rows.

## Read-Only Summary

Read-only summary paths:

- Rails task: `bin/rails public_sources:bfs:quality_review_summary`
- Dashboard: `/bfs_quality_review`

The summary reports review coverage, review status counts, metric key counts,
guardrail flag counts, prediction-link count, export-created audit-event count,
and policy-check status. It does not write records.

## Required Guardrails

Every reviewed BFS observation must preserve:

- source row ID and row hash;
- metric key;
- raw source cell value;
- `source_error_data`;
- false flags for ratios, trends, aggregation, exports, prediction links, and
  claim support.

## Boundary

BFS quality review confirms only that a source-native context observation
preserves required metadata and guardrails.

It does not authorize:

- claim support;
- exports;
- prediction links;
- aggregation;
- trends;
- ratios;
- AI or Operator Node interpretation;
- nonemployer-to-employer conversion interpretation;
- firm-boundary conclusions.
