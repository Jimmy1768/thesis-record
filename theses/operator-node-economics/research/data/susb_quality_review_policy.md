# SUSB Quality Review Policy

Status: policy scaffold. Not review-state storage, export, claim support,
paper prose, quantitative analysis, or thesis evidence.

Run date: 2026-06-12.

## Canonical Defaults

V1 defaults are controlled by:

- `thesis_record_app/config/thesis_record_policy.yml`

Policy section:

- `public_ingestion_v1.susb_us_state_annual.quality_review_policy_v1`

## Purpose

The quality-review policy defines when SUSB context observations can move from
stored context into reviewed context. It does not decide whether the Operator
Node thesis is true.

The policy asks narrow questions:

- did the observation come from the verified SUSB public-file path?
- does it preserve source row identity and row hash?
- does it preserve the source-native grain?
- does it keep claim, export, ratio, trend, and aggregation flags false?
- does noisy or suppressed data stay separated from ordinary reviewed context?

## V1 Review Statuses

| Source Observation Status | V1 Review Status |
| --- | --- |
| `staged_context` | `reviewed_context` |
| `quality_review_required` | `reviewed_with_high_noise` |
| `blocked_noise_or_suppression` | `excluded_noise_or_suppression` |

Additional final statuses:

- `excluded_policy_violation`
- `needs_manual_review`

## Required Quality Metadata

Each reviewed SUSB context observation must preserve:

- `source_table`
- `source_row_id`
- `source_row_hash`
- `metric_key`
- `metric_status_reason`
- `claim_status_effect`
- `ratios_computed`
- `trends_computed`
- `aggregation_computed`
- `exports_created`
- `claim_support_authorized`
- `guardrail`

## Hard False Flags

The following metadata flags must remain false:

- `ratios_computed`
- `trends_computed`
- `aggregation_computed`
- `exports_created`
- `claim_support_authorized`

## Manual Review Triggers

Manual review remains required for:

- missing source row;
- missing source row hash;
- missing required dimensions;
- unknown metric key;
- unsupported metric status;
- high-noise status.

## Prohibited Review Effects

Quality review cannot authorize:

- claim support;
- exports;
- thesis interpretation;
- AI or node evidence;
- aggregation;
- trend measurement.

## Rails Task

```sh
bin/rails public_sources:susb:verify_quality_policy
```

The task verifies the centralized policy and checks that existing
`MetricObservation` rows do not contain unsupported source statuses, missing
required quality metadata, or prohibited claim/export/computation flags.

## Next Storage Step

Phase 2K adds review-state storage as a separate `metric_quality_reviews`
table. The review table references `metric_observations` rather than mutating
source observations in place.

Rails task:

```sh
bin/rails public_sources:susb:create_quality_reviews
```

The task is idempotent. It maps SUSB context-observation statuses to V1 review
statuses and writes review rows only. It does not change `metric_observations`,
create exports, create prediction links, authorize claims, aggregate cells, or
compute trends/ratios.

## Boundary

SUSB remains employer-side public context only. It still does not measure AI
adoption, nonemployers, one-human firms, management layers, transaction costs,
remote work, or Operator Nodes.
