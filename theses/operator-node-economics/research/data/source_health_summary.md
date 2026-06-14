# Source Health Summary

Status: read-only combined source health. Not aggregation, trend measurement,
prediction-link creation, export, claim support, paper prose, or thesis
evidence.

Run date: 2026-06-14.

## Purpose

Report BFS, SUSB, and BDS pipeline state in one place so source rows,
definitions, observations, reviews, policy checks, guardrails, prediction
links, and exports can be inspected before any claim-review gate is designed.

## Rails Paths

Command-line summary:

```sh
bin/rails public_sources:source_health_summary
```

Dashboard:

```text
/source_health
```

## Live Result

Observed local result on 2026-06-14:

```text
total_source_rows=676353
total_metric_definitions=21
total_metric_observations=1179605
total_quality_reviews=1179605
total_prediction_links=0
total_export_created_audit_events=0
all_policy_checks_passed=true
overall_evidence_status=context_only_no_claim_links
bfs.source_row_count=1368
bfs.metric_definition_count=6
bfs.metric_observation_count=1351
bfs.quality_review_count=1351
bfs.unreviewed_observation_count=0
bfs.prediction_link_count=0
susb.source_row_count=570105
susb.metric_definition_count=5
susb.metric_observation_count=432080
susb.quality_review_count=432080
susb.unreviewed_observation_count=0
susb.prediction_link_count=0
bds.source_status=staging_rows_loaded
bds.source_row_count=104880
bds.metric_definition_count=10
bds.metric_observation_count=746174
bds.quality_review_count=746174
bds.unreviewed_observation_count=0
bds.prediction_link_count=0
bds.evidence_status=reviewed_context_only_not_claim_support
bds.guardrail_flag_counts={"ratios_computed"=>0, "trends_computed"=>0, "aggregation_computed"=>0, "exports_created"=>0, "prediction_links_created"=>0, "claim_support_authorized"=>0}
```

## Boundary

The source health summary is infrastructure telemetry only.

It does not authorize:

- prediction links;
- exports;
- claim support;
- aggregation;
- trends;
- ratios;
- paper prose;
- thesis conclusions.

Context observations and quality reviews remain claim-neutral until a separate
claim-review gate is designed and explicitly authorized.
