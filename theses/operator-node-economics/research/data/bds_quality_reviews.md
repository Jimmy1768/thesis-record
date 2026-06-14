# BDS Quality Reviews

Status: BDS source-native observations reviewed as context only. Not export,
prediction-link creation, analysis, claim support, or paper prose.

Date: 2026-06-14.

## Purpose

Create review-state rows for BDS source-native observations so the living
dissertation can distinguish reviewed context from unreviewed source-native
observations.

This review does not make BDS observations claim-supporting evidence.

## Rails Objects

Policy checker:

- `PublicSources::Bds::QualityReviewPolicyCheck`

Review creation service:

- `PublicSources::Bds::CreateQualityReviews`

Read-only summary service:

- `PublicSources::Bds::QualityReviewSummary`

Tasks:

```sh
bin/rails public_sources:bds:verify_quality_review_policy
bin/rails public_sources:bds:create_quality_reviews
bin/rails public_sources:bds:quality_review_summary
```

Policy section:

- `public_ingestion_v1.bds_sector_age_size_public_file.parser_design_v1.quality_review_policy_v1`

## Live Result

```text
observations_reviewed=746174
reviews_upserted=746174
status_counts={"reviewed_context"=>746174}
prediction_links_created=0
exports_created=0
```

Source health after review:

```text
bds.metric_observation_count=746174
bds.quality_review_count=746174
bds.unreviewed_observation_count=0
bds.prediction_link_count=0
bds.evidence_status=reviewed_context_only_not_claim_support
```

## Guardrails

The review policy requires:

- `staged_context` observations map to `reviewed_context`;
- required BDS source metadata remains present;
- ratios, trends, aggregation, exports, prediction links, and claim support
  remain false;
- review rows are stored in `metric_quality_reviews`.

The review prohibits:

- claim support;
- export authorization;
- prediction-link authorization;
- thesis interpretation;
- AI or Operator Node evidence;
- nonemployer conversion evidence;
- management-layer evidence;
- transaction-cost evidence;
- firm-boundary conclusions;
- aggregation/trend authorization.

## Boundary

BDS remains employer-firm dynamics context only. Reviewed BDS observations do
not measure AI adoption, nonemployers, hidden contractors, management layers,
transaction costs, Operator Nodes, one-person firms, or firm-boundary change.

## Next Gate

Read-only BDS quality-review summary is now implemented. Claim review,
prediction links, exports, analysis, and paper prose remain blocked.
