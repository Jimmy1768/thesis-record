# Failure As First-Class Output Policy

Status: research-method and system-design policy. Not evidence, analysis,
claim support, paper prose, legal advice, or security certification.

Run date: 2026-06-12.

## Purpose

Define how the living dissertation records, preserves, classifies, reviews,
and publishes adverse evidence, null results, failed predictions, and thesis
revisions.

Core principle:

Failure is not an exception path. It is a primary output of the research
program.

If a prediction is wrong, delayed, narrowed, contradicted, or unsupported, the
system should preserve that result and make it publishable at the scheduled
snapshot or checkpoint.

## First-Principles Rule

A future-facing thesis has value only if it can lose.

Therefore:

- adverse evidence must be collected with the same discipline as supportive
  evidence;
- null results must not be hidden;
- missing data must not be treated as support;
- failed company implementation must remain separate from failed thesis logic;
- failed thesis logic must not be relabeled as implementation failure;
- definitions must not be changed after seeing adverse data unless the
  revision is explicit, versioned, and auditable.

## Failure Record

The Rails implementation should support a `failure_records` or equivalent
review object.

Required fields:

| Field | Purpose |
| --- | --- |
| `id` | Stable failure-record identifier. |
| `prediction_id` | Prediction or claim candidate affected. |
| `horizon` | 3-year, 5-year, 10-year, annual snapshot, or other scheduled checkpoint. |
| `failure_type` | Controlled taxonomy value. |
| `evidence_object_id` | Metric, source, review, or snapshot object behind the record. |
| `source_status` | Source-truth status. |
| `metric_status` | Computed, missing, suppressed, not comparable, or failed validation. |
| `observed_direction` | Supportive, adverse, mixed, null, or inconclusive. |
| `expected_direction` | Predeclared expected direction. |
| `failure_condition_triggered` | Whether a V1 failure condition was triggered. |
| `alternative_explanation` | Strongest non-thesis explanation. |
| `business_cycle_context` | Macro or sector condition relevant to interpretation. |
| `company_case_scope` | Whether the record concerns the user's company, another case, or the broad thesis. |
| `human_review_status` | Pending, accepted, rejected, superseded, or reopened. |
| `publication_status` | Not public, snapshot-ready, published, or embargoed for privacy. |
| `revision_action` | None, defer, narrow, revise, contradict, reject, or replace. |
| `audit_event_id` | Audit event for creation or status change. |

Failure records should store structured summaries and links, not raw private
payloads.

## Failure Taxonomy

| Type | Meaning | Default Response |
| --- | --- | --- |
| `adverse_indicator` | A measured indicator moves against the prediction. | Preserve and review; do not reinterpret automatically. |
| `null_result` | A metric produces no meaningful movement. | Preserve as evidence; do not count as support. |
| `missing_data` | Required data are unavailable, lagged, suppressed, or not comparable. | Mark inconclusive; do not count as support. |
| `measurement_failure` | Proxy does not measure the intended phenomenon. | Improve design; keep original forecast status unchanged unless repeated. |
| `timing_failure` | Direction may still be plausible, but the predicted horizon was too short. | Defer only if leading indicators survive and falsifiers are not triggered. |
| `scope_failure` | Evidence supports a narrower sector, transaction, or role than predicted. | Narrow the thesis and update predictions. |
| `mechanism_failure` | AI changes task productivity but not the predicted transaction-cost or firm-boundary mechanism. | Revise or reject the mechanism. |
| `implementation_failure` | A company, network, or product attempt fails for execution-specific reasons. | Separate case failure from broad thesis failure. |
| `alternative_dominates` | Corporate absorption, regulation, capital, trust, compliance, or other alternatives explain evidence better. | Weaken, contradict, or reject affected prediction. |
| `core_theory_failure` | Scheduled checkpoint evidence contradicts the central mechanism or outcome. | Reject or replace the thesis. |

## Trigger Rules

A failure record should be created when:

- a predeclared failure condition is triggered;
- a scheduled annual snapshot finds adverse movement;
- v1/v2/v3 evidence is mixed, adverse, null, or inconclusive;
- a required metric is missing, suppressed, not comparable, or fails
  validation;
- an alternative explanation is stronger than the Operator Node mechanism;
- a company/network case fails after being used as feasibility evidence;
- a claim-support proposal is rejected by human review;
- a source previously used as support is downgraded or corrected.

Failure records can be created by automation as `review_pending`, but only
human review can accept, reject, publish, or use them to change claim status.

## Publication Rule

Scheduled publications must include adverse evidence when it is reviewed and
publishable.

Annual snapshots should report:

- supportive indicators;
- mixed indicators;
- adverse indicators;
- null results;
- missing or suppressed data;
- measurement failures;
- source downgrades;
- unresolved alternatives.

v1/v2/v3 checkpoints should report:

- which predictions survived;
- which predictions weakened;
- which predictions were contradicted;
- which predictions were deferred and why;
- whether errors were timing, scope, mechanism, measurement, implementation,
  alternative-dominance, or core-theory failures.

Privacy may delay or aggregate a failure record, but privacy should not be used
to hide thesis-adverse evidence. If private details cannot be published, the
public version should say what can be disclosed: category, affected prediction,
direction, limitation, and review status.

## Revision Discipline

A revision is allowed only when:

- the original prediction remains visible;
- the adverse or null evidence remains visible;
- the reason for revision is classified;
- the revision date and version are recorded;
- the revision does not retroactively convert failure into success.

Forbidden:

- changing definitions after seeing results without recording the failure;
- moving the horizon later without marking timing failure;
- narrowing scope without marking scope failure;
- blaming implementation when the mechanism failed;
- treating missing evidence as support;
- excluding adverse evidence from scheduled snapshots because it is awkward.

## Claim-Status Interaction

Failure records can support these status changes after human review:

- `directionally_consistent` to `mixed`;
- `mixed` to `adverse`;
- `leading_indicator` to `weakened`;
- `weak_support` to `unsupported`;
- `supported` to `weak_support`;
- any status to `contradicted`;
- a prediction to `rejected`.

Automation must not perform these changes.

## Company Case Separation

A company or network failure can mean different things:

- implementation failure: the company failed but the broad thesis remains
  testable elsewhere;
- case-boundary failure: the case was not a valid Operator Node example;
- mechanism failure: the company could not reduce transaction or coordination
  costs as predicted;
- broad-thesis failure: similar attempts fail across contexts and alternatives
  explain the evidence better.

The failure record must classify which one applies.

## Current Status Flags

`failure_as_first_class_output_policy_created=true`
`private_data_ingested=false`
`claim_support_updated=false`
`paper_prose_updated=false`
