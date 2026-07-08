# Source-Led MTR Lead Review Template

Date:

Status: template only. Do not use this template to admit an MTR, create a
candidate list, create a candidate-universe ledger, calculate scores, rank
MTRs, or make final paper claims.

## Purpose

Review one source-led MTR proposal lead after the full raw return has been
preserved and an intake note has classified all returned leads.

This template sits between:

- raw return preservation;
- source-led proposal intake;
- boundary/candidate-universe readiness review;
- any later boundary record with `record_status: not_admitted`.

It is intentionally narrower than a boundary record. Its job is to decide what
the next allowed work unit is, not to accept the MTR.

## Required Preconditions

Complete these before using this template:

- raw return saved under `operator_records/external_query_tests/`;
- interpreted intake note created under `research/`;
- all returned leads classified using
  `research/source_led_mtr_proposal_return_intake_protocol.md`;
- no single lead promoted before the full return is reviewed.

## Review Header

```yaml
lead_review_id:
created:
review_status: source_led_lead_review
operator_thread: Thesis 2

raw_return_path:
intake_note_path:
lead_label:
lead_order_in_return:
```

## Lead Identity

```yaml
working_mtr:
  working_name:
  country_or_countries:
  proposed_by_return:
  source_led_reason_for_testing:
  stated_selection_basis:
```

## Non-Selection Test

```yaml
non_selection_test:
  selected_for_transit_reputation:
  selected_for_congestion_reputation:
  selected_for_walkability_reputation:
  selected_for_livability_ranking:
  selected_for_gdp_or_wealth:
  selected_for_country_reputation:
  selected_for_personal_familiarity:
  selected_for_expected_performance:
  selected_for_desired_comparison_story:
  result:
  notes:
```

Allowed `result` values:

- `passes`
- `fails_reputation_led`
- `unclear_requires_review`

## Boundary Source Review

```yaml
boundary_source_review:
  claimed_boundary_source_family:
  normalized_boundary_source_family:
  source_authority:
  source_name:
  source_url_or_access_path:
  source_vintage_or_release:
  geography_type:
  boundary_basis:
  denominator_eligible:
  source_note_exists:
  source_note_path:
  independent_inspection_needed:
  major_caveats:
```

Eligible denominator source families:

- `observed_functional_region`
- `national_commuting_zone`
- `hybrid_functional_statistical_region`
- `official_statistical_metro`
- `modelled_functional_region`

Not eligible as the primary denominator:

- `built_up_urban_core`
- `governance_or_service_region`
- `service_derived_boundary`
- `accessibility_dataset_geography`

## Minimal Source Bundle Review

```yaml
minimal_source_bundle:
  boundary_source:
  resident_population_denominator_source:
  first_outcome_source_family:
  service_or_network_source:
  source_vintage_fields_available:
  bundle_status:
  missing_items:
```

Allowed `bundle_status` values:

- `plausible_for_readiness_review`
- `needs_source_trace`
- `incomplete_quarantine`
- `fails_boundary_basis`

## Boundary Fit Questions

Answer briefly. If unknown, say `unknown`.

- What functional region is represented?
- What resident population is included?
- What resident population may be wrongly excluded?
- What resident population may be weakly included?
- Does polycentricity matter?
- Does cross-border geography matter?
- Do multiple transport authorities matter?
- Is informal or weakly documented transport likely to matter?
- Is governance being treated as an overlay rather than the denominator?
- Is service geography prohibited from becoming the denominator?

## Review Decision

```yaml
decision:
  intake_status:
  review_decision:
  rationale:
  next_allowed_output:
  prohibited_outputs:
```

Allowed `review_decision` values:

- `ready_for_source_note_review`
- `needs_source_trace`
- `needs_boundary_classification_review`
- `ready_for_readiness_checklist_review`
- `ready_for_boundary_record_not_admitted`
- `ready_for_draft_manifest`
- `quarantined_insufficient_source`
- `rejected_reputation_led`
- `rejected_boundary_basis`
- `rejected_service_derived_denominator`
- `rejected_not_mtr_scope`

## Mandatory Closing Statement

Every completed lead review must end with this statement:

> This review does not select or admit an MTR. It only authorizes the next
> source-review, readiness-review, rejection, quarantine, draft-manifest, or
> not-admitted boundary-record action identified above.
