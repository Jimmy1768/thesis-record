# SUSB Context Observations

Status: context-observation computation scaffold. Not analysis, trend
measurement, aggregation, export, claim support, paper prose, or thesis
evidence.

Run date: 2026-06-12.

## Purpose

Compute first-pass SUSB context observations from source-native staging rows
under the V1 guardrails defined in:

- `research/data/susb_metric_computation_design.md`
- `research/data/susb_quality_review_policy.md`
- `living_dissertation_app/config/living_dissertation_policy.yml`

## Rails Task

```sh
bin/rails public_sources:susb:compute_context_observations
```

The task:

- uses only rows where `enterprise_size_code = 01`;
- creates one `MetricObservation` per eligible row and allowed first-pass
  metric key;
- maps `G/H` flags to `staged_context`;
- maps `J` flags to `quality_review_required`;
- excludes `D/S` flagged metric cells from observation creation;
- records source row ID, row hash, evidence class, and guardrails in
  `quality_metadata`;
- deletes and recreates scoped SUSB observations for idempotency.

## Boundary

The observations are employer-side context only.

They do not authorize:

- ratios;
- trends;
- aggregation;
- productivity measures;
- AI or node interpretation;
- export;
- claim support.

SUSB still does not measure AI adoption, nonemployers, one-human firms,
management layers, transaction costs, remote work, or Operator Nodes.

Quality review policy for these stored observations is documented in:

- `research/data/susb_quality_review_policy.md`

Review-state storage for these observations is documented in:

- `research/data/susb_quality_reviews.md`
