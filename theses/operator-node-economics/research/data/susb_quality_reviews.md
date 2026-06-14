# SUSB Quality Reviews

Status: review-state storage scaffold. Not export, claim support, quantitative
analysis, paper prose, or thesis evidence.

Run date: 2026-06-12.

## Purpose

SUSB context observations need a separate review state before they can be used
as reviewed context in the living dissertation system. The review state belongs
in a separate table so source observations remain immutable.

## Storage

Table:

- `metric_quality_reviews`

Key relationship:

- one review row per `metric_observation`;
- `metric_observations` remain unchanged;
- `data_source_id` is copied for filtering and auditability;
- review metadata preserves source row identity, row hash, metric key, and
  hard false flags.

## Rails Task

```sh
bin/rails public_sources:susb:create_quality_reviews
```

The task:

- verifies `public_sources:susb:verify_quality_policy` guardrails first;
- scopes to SUSB public-file observations only;
- requires `quality_metadata.source_table = susb_public_file_rows`;
- maps `staged_context` to `reviewed_context`;
- maps `quality_review_required` to `reviewed_with_high_noise`;
- remains idempotent through one review row per observation.

Read-only summary task:

```sh
bin/rails public_sources:susb:quality_review_summary
```

The summary task prints review counts, status counts, metric-key counts,
policy-version counts, unreviewed-observation count, prohibited flag counts,
prediction-link count, and export-created audit-event count. It writes no
records and creates no files.

Internal read-only Rails page:

```text
/susb_quality_review
```

The page renders the same summary service for authenticated research operators.
It writes no audit events, observations, review rows, prediction links, files,
or exports.

## Boundary

The task does not authorize:

- export;
- claim support;
- prediction links;
- ratios;
- trends;
- aggregation;
- productivity measures;
- AI or Operator Node interpretation.

SUSB remains employer-side public context only. It still does not measure AI
adoption, nonemployers, one-human firms, management layers, transaction costs,
remote work, or Operator Nodes.
