# European FUA Denominator Vintage Worksheet

Date: 2026-07-03

Status: lead-specific denominator-vintage worksheet. No MTR admitted. No
denominator value accepted. No filled boundary record, evidence manifest,
candidate list, candidate-universe ledger, metric record, score, ranking, or
raw data archive is authorized.

Reviewed leads:

- `mtr_src_001` Helsinki FUA / `FI001F`
- `mtr_src_002` Lyon FUA / `FR002F`

Related policy:

- `theses/mobility-conversion/research/eurostat_fua_population_vintage_status_policy_2026-07-02.md`

Related source note:

- `theses/mobility-conversion/research/source_notes/eurostat_urb_lpop1_fua_population_2026-07-01.md`

## Worksheet Decision

The denominator source family is usable for lead-specific review, but no
denominator values are accepted.

Helsinki receives a candidate denominator posture for later method testing:
`short_window_candidate_unflagged_2023`.

Lyon does not receive a current-testing denominator posture. It remains
`historical_baseline_only_or_blocked_current_testing` unless a newer accepted
denominator source is found.

## Helsinki FUA / `FI001F`

```yaml
eurostat_fua_population_denominator_review:
  lead_id: mtr_src_001
  working_name: Helsinki FUA
  fua_code: FI001F
  dataset_id: URB_LPOP1
  geography_dimension: cities
  indicator_code: DE1001V
  indicator_label: Population on the 1st of January, total
  selected_year: 2023
  selected_year_observation_present: true
  eurostat_status_flag: none_observed_in_prior_source_note
  response_updated_timestamp: 2026-05-29T23:00:00+0200
  inspected_year_window:
    - 2020
    - 2021
    - 2022
    - 2023
    - 2024
    - 2025
  missing_years_in_window:
    - 2025
  flagged_years_in_window:
    2024: break_in_time_series
  vintage_alignment_class: short_window_candidate
  use_posture: short_window_candidate_unflagged_2023
  raw_response_manifest_status: not_created
  accepted_denominator_value: false
  blockers:
    - raw_response_manifest_required_before_value_acceptance
    - boundary_geometry_manifest_not_created
    - service_feed_vintage_unresolved
    - HSL_coverage_against_FI001F_unresolved
    - non_HSL_operator_scan_unresolved
```

### Helsinki Rationale

The 2023 observation is preferred over the 2024 observation because the 2024
observation carries a break-in-time-series flag in the inspected source note.
The 2023 posture is not "current performance"; it is a short-window candidate
for method testing only.

The worksheet does not copy, accept, or use the population value.

### Helsinki Allowed Next Step

Proceed to a Helsinki coverage reconciliation worksheet using:

```yaml
population_denominator_posture: short_window_candidate_unflagged_2023
accepted_denominator_value: false
comparison_allowed: false
```

Do not create a filled boundary record or evidence manifest until raw geometry,
population, and feed-acquisition decisions are explicit.

## Lyon FUA / `FR002F`

```yaml
eurostat_fua_population_denominator_review:
  lead_id: mtr_src_002
  working_name: Lyon FUA
  fua_code: FR002F
  dataset_id: URB_LPOP1
  geography_dimension: cities
  indicator_code: DE1001V
  indicator_label: Population on the 1st of January, total
  selected_year: 2022
  selected_year_observation_present: true
  eurostat_status_flag: none_observed_in_prior_source_note
  response_updated_timestamp: 2026-05-29T23:00:00+0200
  inspected_year_window:
    - 2020
    - 2021
    - 2022
    - 2023
    - 2024
    - 2025
  missing_years_in_window:
    - 2023
    - 2024
    - 2025
  flagged_years_in_window: {}
  vintage_alignment_class: historical_baseline_only
  use_posture: historical_baseline_only_or_blocked_current_testing
  raw_response_manifest_status: not_created
  accepted_denominator_value: false
  blockers:
    - current_denominator_observation_missing
    - raw_response_manifest_required_before_value_acceptance
    - boundary_geometry_manifest_not_created
    - static_GTFS_or_NeTEx_unavailable_in_inspected_catalog_response
    - SIRI_Lite_substitution_method_unresolved
    - TCL_coverage_against_FR002F_unresolved
    - non_TCL_operator_scan_unresolved
```

### Lyon Rationale

The latest inspected observation is too stale for a current-performance claim.
It may support a historical/baseline posture or a stress test of mixed-vintage
method mechanics, but it cannot support readiness promotion for current access
measurement.

The worksheet does not copy, accept, or use the population value.

### Lyon Allowed Next Step

Proceed only to one of:

```yaml
allowed_next_steps:
  - static_feed_availability_followup
  - SIRI_Lite_method_feasibility_note
  - FR002F_non_TCL_operator_scan
  - historical_baseline_method_stress_test_design
```

Do not run a current-performance coverage worksheet for Lyon until a newer
denominator posture or explicit historical/baseline method frame exists.

## Pairwise Comparison Decision

```yaml
pairwise_comparison:
  helsinki_posture: short_window_candidate_unflagged_2023
  lyon_posture: historical_baseline_only_or_blocked_current_testing
  comparison_allowed: false
  reason: denominator_vintage_postures_are_not_equivalent
```

Helsinki and Lyon can remain paired for method stress testing, but not for
access-performance comparison.

## Next Recommended Artifact

Create the Helsinki coverage reconciliation worksheet first.

Reason:

- Helsinki has a defensible short-window denominator posture;
- HSL/Digitransit service-source family is verified;
- the remaining blockers are coverage/operator reconciliation rather than a
  missing static feed.

Lyon should wait for static-feed availability or SIRI Lite method review before
coverage reconciliation.

## Prohibited Outputs

This worksheet does not authorize:

- admitted MTR;
- filled boundary record;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted denominator value;
- raw data archive without manifest.
