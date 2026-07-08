# Helsinki FUA Coverage Reconciliation Worksheet

Date: 2026-07-03

Status: lead-specific coverage reconciliation worksheet. No MTR admitted. No
filled boundary record, evidence manifest, candidate list, candidate-universe
ledger, metric record, score, ranking, accepted denominator value, or raw data
archive is authorized.

Lead:

- `mtr_src_001` Helsinki FUA / `FI001F`

Related records:

- `theses/mobility-conversion/research/european_fua_coverage_reconciliation_protocol.md`
- `theses/mobility-conversion/research/european_fua_denominator_vintage_worksheet_2026-07-03.md`
- `theses/mobility-conversion/research/helsinki_fua_service_source_trace_note_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/hsl_digitransit_service_sources_2026-07-01.md`

## Reconciliation Decision

Helsinki FUA is not ready for a filled boundary record or evidence manifest.

It is the first European FUA lead eligible for coverage reconciliation because
it has:

- verified FUA code: `FI001F`;
- candidate denominator posture:
  `short_window_candidate_unflagged_2023`;
- verified HSL/Digitransit service-source family.

It remains blocked because service coverage has not been reconciled against the
independent FUA boundary, and operator completeness is unresolved.

## Coverage Reconciliation Fields

```yaml
coverage_reconciliation:
  lead_id: mtr_src_001
  working_name: Helsinki FUA
  fua_code: FI001F
  boundary_source: Eurostat GISCO Urban Audit FUA
  boundary_vintage: 2024 GISCO path inspected
  boundary_geometry_status: not_archived
  population_source: Eurostat URB_LPOP1
  population_candidate_year: 2023
  population_status_flag: none_observed_for_selected_year_in_prior_source_note
  population_missingness_review:
    selected_posture: short_window_candidate_unflagged_2023
    accepted_denominator_value: false
    raw_response_manifest_status: not_created
  service_source_family: HSL / Digitransit
  static_feed_status: documented_but_not_archived
  realtime_feed_status: documented_but_not_archived
  service_feed_vintage: unresolved
  service_feed_validity_window: documented_as_two_month_gtfs_window_but_not_archived
  service_geography_basis: HSL_service_or_journey_planner_geography_unaccepted
  service_geography_not_used_as_boundary: true
  operator_inventory_status: unresolved
  missing_operator_scan_status: unresolved
  modes_covered: unresolved_until_feed_archive
  modes_missing_or_unknown:
    - regional_rail_if_material
    - ferry_if_material
    - demand_responsive_or_paratransit_if_material
    - non_HSL_local_or_regional_services_if_material
  non_fixed_route_services_review: unresolved
  regional_rail_or_interurban_review: unresolved
  fare_or_accessibility_fields_review: unresolved
  unserved_population_visibility_method: unresolved
  edge_area_review: unresolved
  vintage_alignment_class: short_window_candidate_for_population_only
  license_and_access_status: source_family_terms_traced_but_feed_archive_not_manifested
  evidence_manifest_status: not_created
  reconciliation_decision: blocked_missing_operator_inventory_and_coverage_against_fua
  blockers:
    - boundary_geometry_not_archived
    - raw_population_response_not_archived
    - static_GTFS_not_archived
    - HSL_coverage_against_FI001F_unknown
    - non_HSL_operator_inventory_unknown
    - unserved_population_visibility_method_missing
    - service_feed_vintage_unresolved
```

## What The Worksheet Allows

This worksheet allows Helsinki to proceed to source planning for:

- HSL static GTFS acquisition plan;
- HSL/Digitransit license and attribution manifest fields;
- non-HSL operator inventory;
- FUA edge-area review;
- unserved-population visibility method.

It does not allow:

- raw feed download into the repo;
- raw geometry archive;
- raw population archive;
- accepted population value;
- boundary record;
- metric record.

## Operator Inventory Requirement

The next Helsinki-specific source task must identify whether HSL/Digitransit is
complete enough for the `FI001F` FUA.

Minimum questions:

- Which public-transport operators serve population or job centers inside
  `FI001F`?
- Which of those are represented in HSL/Digitransit static or routing data?
- Are regional rail, ferry, demand-responsive, paratransit, interurban bus, or
  non-HSL municipal/regional services material?
- Are there FUA edge municipalities outside the HSL service-source footprint?
- Would excluding any non-HSL services make unserved/weakly served population
  invisible?

Until answered:

```yaml
operator_inventory_status: unresolved
readiness_promotion_allowed: false
```

## Unserved Population Visibility Requirement

Helsinki cannot use service feeds for access testing unless residents outside
the feed footprint remain visible.

The later method must choose one:

```yaml
unserved_population_visibility_options:
  - compare_stop_or_service_access_to_independent_population_geography
  - classify_FI001F_subareas_as_served_weakly_served_unserved
  - record_missing_service_source_coverage_as_explicit_missingness
```

Prohibited:

- clipping `FI001F` to HSL coverage;
- dropping places with no stops;
- using stop buffers as the denominator;
- using Journey Planner routability as the MTR boundary.

## Manifest Posture

No evidence manifest is created by this worksheet.

Manifest will be required before:

- archiving `FI001F` geometry;
- archiving Eurostat `URB_LPOP1` API response;
- archiving HSL GTFS or GTFS-RT feeds;
- joining population, service, and boundary inputs;
- running any method test.

## Next Recommended Artifact

Create a Helsinki operator-inventory research handoff or source-note plan.

The handoff should ask for source-led operator completeness evidence, not for a
claim that Helsinki has good transport.

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
