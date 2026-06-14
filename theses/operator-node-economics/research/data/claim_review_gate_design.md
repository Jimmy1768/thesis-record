# Claim Review Gate Design

Status: disabled-by-default policy design. Not prediction-link creation, claim
review creation, export, analysis, paper prose, or thesis evidence.

Date: 2026-06-14.

## Purpose

Define the conditions that must exist before reviewed context observations can
be considered for future claim review. The gate prevents BFS, SUSB, and BDS
context records from automatically changing any claim or prediction status.

Canonical values live in:

- `thesis_record_app/config/thesis_record_policy.yml`

Policy section:

- `claim_review_gate_v1`

Checker:

- `Evidence::ClaimReviewGateDesignCheck`

Task:

```sh
bin/rails operator:verify_claim_review_gate
```

## Current Gate State

The current gate is `design_only_disabled`.

The following remain false:

- `claim_reviews_authorized`;
- `prediction_links_authorized`;
- `automatic_claim_promotion_authorized`;
- `evidence_status_change_authorized`;
- `exports_authorized`.

## Future Review Eligibility

Reviewed context observations from these source kinds may be considered by a
future authorized gate:

- `census_bfs_api`;
- `census_susb_public_file`;
- `census_bds_public_file`.

Future review consideration requires quality-review status:

- `reviewed_context`.

This does not make any observation claim-supporting evidence.

## Blocked IDs

All current predictions remain blocked from automatic promotion:

- `TCE-P001` through `TCE-P012`.

All current claims remain blocked from automatic promotion:

- `TCE-CLAIM-001` through `TCE-CLAIM-015`.

This does not change the literature-supported statuses already tracked in
`research/claims_index.md`; it only blocks app context observations from
changing those statuses without a later explicit review workflow.

## Metadata Required Before Any Future Claim Review

A future authorized claim-review workflow must preserve at least:

- metric observation and quality-review IDs;
- source ID, source kind, and source status;
- metric key and source metric status;
- quality-review status;
- evidence classification;
- prediction ID and claim ID;
- prior and proposed claim status;
- source limitations;
- disconfirming alternatives;
- human reviewer;
- authorization record;
- paper-scope effect.

## Prohibited Automatic Effects

The design prohibits automatic:

- claim-status changes;
- prediction-link creation;
- claim-review creation;
- export creation;
- paper prose changes;
- thesis verdicts;
- AI or Operator Node interpretation;
- nonemployer conversion interpretation;
- management-layer interpretation;
- transaction-cost interpretation;
- firm-boundary conclusions.

## Boundary

This gate makes claim promotion harder, not easier. It is a checklist and
policy check for future review work, not evidence that the thesis is true.
