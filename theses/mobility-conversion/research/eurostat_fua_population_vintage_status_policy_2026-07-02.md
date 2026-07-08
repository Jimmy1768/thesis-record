# Eurostat FUA Population Vintage And Status Policy

Date: 2026-07-02

Status: formation-stage methodology policy. No MTR admitted. No denominator
value accepted. No filled boundary record, evidence manifest, candidate list,
metric record, score, ranking, or raw data archive is authorized.

Applies to:

- Eurostat/GISCO FUA leads using Eurostat `URB_LPOP1` as candidate population
  denominator source family.

Initial affected leads:

- `mtr_src_001` Helsinki FUA / `FI001F`
- `mtr_src_002` Lyon FUA / `FR002F`

Related notes:

- `theses/mobility-conversion/research/source_notes/eurostat_urb_lpop1_fua_population_2026-07-01.md`
- `theses/mobility-conversion/research/eurostat_fua_population_denominator_path_note_2026-07-01.md`
- `theses/mobility-conversion/research/european_fua_blocked_readiness_dry_review_2026-07-02.md`

## Core Rule

Eurostat `URB_LPOP1` can be used as a candidate FUA population-denominator
source family only after a lead-specific vintage and status review.

Do not:

- accept a population value from a source note alone;
- carry a population value forward into missing years;
- interpolate missing years;
- hide Eurostat status flags;
- treat a stale population year as current performance;
- use a population observation without recording its exact FUA code, indicator,
  year, source timestamp, status flag, and vintage alignment class.

## Required Denominator Fields

Before any denominator can be accepted into a boundary record, method test, or
manifest, record:

```yaml
eurostat_fua_population_denominator_review:
  lead_id:
  fua_code:
  dataset_id: URB_LPOP1
  geography_dimension: cities
  indicator_code: DE1001V
  indicator_label: Population on the 1st of January, total
  selected_year:
  selected_year_observation_present:
  eurostat_status_flag:
  response_updated_timestamp:
  inspected_year_window:
  missing_years_in_window:
  flagged_years_in_window:
  vintage_alignment_class:
  use_posture:
  raw_response_manifest_status:
  accepted_denominator_value: false
  blockers:
```

## Vintage Classes For Denominator Use

Allowed formation-stage denominator postures:

- `same_year_candidate`: denominator year matches the intended analysis year.
- `short_window_candidate`: denominator year is within a documented two- to
  three-year window and no high-risk growth/missingness issue is identified.
- `mixed_vintage_candidate`: denominator year falls outside the short window
  but may support a constrained method test with caveats.
- `historical_baseline_only`: denominator can describe a past baseline but not
  current transport quality.
- `blocked_missing_observation`: target year or acceptable window has no
  usable observation.
- `blocked_status_flag_unresolved`: observation exists but the flag policy has
  not been resolved.
- `blocked_raw_manifest_required`: value is ready for acquisition, but raw
  response/archive workflow has not been documented.

No posture authorizes final scores, rankings, or candidate admission.

## Status Flag Rule

Eurostat status flags must be carried forward into every downstream review.

For formation-stage work:

- unflagged observations are preferred over flagged observations when both are
  in the acceptable vintage window;
- a break-in-time-series flag may be used only in a method test if the test
  explicitly carries the caveat and does not compare MTRs;
- a flagged observation must not be silently mixed with unflagged observations
  from other MTRs;
- if a flagged observation is the only near-current option, use
  `blocked_status_flag_unresolved` until a method note justifies the use.

## Missing-Year Rule

Missing years are not neutral.

If the target year is missing:

1. inspect the intended vintage window;
2. identify the latest observed year;
3. classify the vintage posture;
4. do not carry the latest value forward;
5. do not call the result current unless the posture is
   `same_year_candidate` or explicitly justified `short_window_candidate`.

If all observations inside the acceptable window are missing, use
`blocked_missing_observation`.

## Lead Implications

### Helsinki FUA / `FI001F`

Inspected posture:

```yaml
lead_id: mtr_src_001
fua_code: FI001F
inspected_year_window: 2020-2025
observed_inspection_summary:
  observations_present:
    - 2020
    - 2021
    - 2022
    - 2023
    - 2024
  missing_years:
    - 2025
  flagged_years:
    2024: break_in_time_series
recommended_next_review_posture: short_window_candidate_using_unflagged_2023_or_blocked_status_flag_unresolved_for_2024
accepted_denominator_value: false
```

Interpretation:

- Helsinki is no longer blocked by lack of a population source family.
- Helsinki remains blocked until the reviewer chooses either:
  - unflagged 2023 as a short-window candidate; or
  - flagged 2024 with a specific break-flag method note.
- Neither choice accepts a value until a manifest/acquisition path exists.

### Lyon FUA / `FR002F`

Inspected posture:

```yaml
lead_id: mtr_src_002
fua_code: FR002F
inspected_year_window: 2020-2025
observed_inspection_summary:
  observations_present:
    - 2020
    - 2021
    - 2022
  missing_years:
    - 2023
    - 2024
    - 2025
  flagged_years: {}
recommended_next_review_posture: historical_baseline_only_or_blocked_missing_observation_for_current_testing
accepted_denominator_value: false
```

Interpretation:

- Lyon is no longer blocked by lack of a population source family.
- Lyon remains blocked for current-performance testing unless a newer accepted
  denominator source is found.
- A 2022 denominator may support only a historical/baseline posture or a
  mixed-vintage method stress test with clear caveats.

## Comparison Rule

Do not compare European FUA leads if their denominator postures differ
materially.

Examples:

- Helsinki using unflagged 2023 and Lyon using 2022 historical/baseline is not
  a clean current-performance comparison.
- Helsinki using flagged 2024 and Lyon using unflagged 2022 requires a
  mixed-vintage caveat and is not suitable for scoring.
- If one lead has `same_year_candidate` and another has
  `historical_baseline_only`, the pair can be used for method stress testing
  only, not comparative performance claims.

## Manifest Rule

No raw Eurostat population response is archived by this policy.

Manifest required before:

- storing raw `URB_LPOP1` API responses in the repository;
- extracting and accepting a denominator value;
- joining population values to FUA geometry;
- using population in a metric or boundary record.

## Next Allowed Output

Allowed:

- Helsinki denominator-vintage review worksheet;
- Lyon denominator-vintage review worksheet;
- lead-specific coverage reconciliation worksheet;
- manifest draft only if raw API responses are intentionally acquired.

## Prohibited Outputs

This policy does not authorize:

- admitted MTR;
- filled boundary record;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted denominator value;
- raw data archive without manifest.
