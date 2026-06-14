# Claim Review Candidate Dry Run

Status: read-only candidate inventory. Not prediction-link creation, claim
review creation, export, analysis, claim support, paper prose, or thesis
evidence.

Date: 2026-06-14.

## Purpose

Create a group-level dry run showing which reviewed context observations could
be inspected by a future manually authorized claim-review workflow.

This is not claim review. It creates no `PredictionLink` rows, no
`ClaimReview` rows, no exports, and no claim-status changes.

Canonical values live in:

- `thesis_record_app/config/thesis_record_policy.yml`

Policy section:

- `claim_review_candidate_dry_run_v1`

Service:

- `Evidence::ClaimReviewCandidateDryRun`

Task:

```sh
bin/rails operator:claim_review_candidate_dry_run
```

## Candidate Groups

V1 dry-run groups:

- `bfs_business_formation_context`: BFS business applications, high-propensity
  applications, and employer formation proxy measures. Related predictions:
  `TCE-P009`, `TCE-P010`. Related claim: `TCE-CLAIM-013`.
- `susb_employer_size_context`: SUSB employer firm, establishment,
  employment, payroll, and economic-census receipts context. Related
  prediction: `TCE-P010`. Related claim: `TCE-CLAIM-013`.
- `bds_employer_dynamics_context`: BDS employer firm dynamics, job-flow, and
  reallocation context. Related predictions: `TCE-P007`, `TCE-P009`,
  `TCE-P010`. Related claim: `TCE-CLAIM-013`.

Every candidate group remains:

- `candidate_status=dry_run_candidate_only`;
- `evidence_classification=context_only_not_claim_support`;
- `proposed_claim_status=unchanged`.

## Live Result

Observed local result on 2026-06-14:

```text
policy_check_passed=true
total_reviewed_observations=1143262
total_unreviewed_observations=0
prediction_link_count=0
claim_review_count=0
export_created_audit_event_count=0
bfs_business_formation_context.reviewed_observation_count=1351
susb_employer_size_context.reviewed_observation_count=395737
bds_employer_dynamics_context.reviewed_observation_count=746174
```

The SUSB dry-run count is lower than total SUSB quality reviews because the
candidate dry run includes only `reviewed_context` rows and excludes
high-noise/nonstandard review statuses from future claim-review consideration.

## Boundary

The dry run does not mean these sources support the related predictions or
claims. The groups identify only where a future human reviewer might inspect
context after a separate authorization gate.

The dry run still prohibits:

- prediction-link creation;
- claim-review creation;
- claim-status change;
- export creation;
- paper prose change;
- thesis verdicts.
