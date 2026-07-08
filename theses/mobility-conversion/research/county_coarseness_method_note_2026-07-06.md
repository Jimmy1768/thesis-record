# County-Coarseness Method Note

Date: 2026-07-06

Status: formation-stage method note. No MTR is admitted. No filled boundary
record, evidence manifest, candidate list, candidate-universe ledger, outcome
metric record, score, ranking, accepted denominator value, or raw data archive
is authorized.

## Purpose

Define how Thesis 2 should handle county-based MTR boundary leads before any
not-admitted boundary record, denominator acquisition, service-overlay method,
or evidence manifest is created.

This note applies first to:

- `mtr_src_004` Minneapolis-St. Paul ERS CZ;
- `mtr_src_007` Portland-Vancouver-Hillsboro CBSA.

It may later be reused for other county-based U.S. or county-equivalent
boundary systems.

## Inputs

```yaml
method_inputs:
  readiness_screen: theses/mobility-conversion/research/county_coarseness_readiness_screen_2026-07-06.md
  source_system_note: theses/mobility-conversion/research/batch_s1b_us_county_based_boundary_mechanics_2026-07-01.md
  minneapolis_source_note: theses/mobility-conversion/research/source_notes/usda_ers_minneapolis_cz_exact_membership_2026-07-05.md
  portland_source_note: theses/mobility-conversion/research/source_notes/us_census_portland_cbsa_exact_boundary_2026-07-05.md
```

## Core Rule

County-based boundaries are eligible for MTR denominator testing, but they do
not pass boundary-fit readiness merely because the county membership is
official and exact.

A county-based lead may proceed toward a `record_status: not_admitted` boundary
record only after a county-coarseness screen classifies the boundary-fit risk
and defines what additional overlays are required before metric testing.

## Risk Classes

```yaml
county_coarseness_risk_classes:
  low:
    description: >
      County membership closely matches the functional urban or commuting
      region, no material outlying county problem is visible, and service-source
      overlays are expected to map cleanly to the boundary.
    boundary_record_effect: may_prepare_not_admitted_boundary_record_after_denominator_source_note
    metric_test_effect: still_requires_manifested_geometry_population_and_service_inputs

  moderate:
    description: >
      Some outlying or rural/exurban territory is present, but the source
      family provides a clear integration reason or central/outlying status, and
      the suspected over-inclusion can be described before metric testing.
    boundary_record_effect: may_prepare_not_admitted_boundary_record_with_explicit_coarseness_caveat
    metric_test_effect: requires_subcounty_or_settlement_overlay_before_any_metric_test

  high:
    description: >
      Several counties appear peripheral, rural/exurban, cross-state, weakly
      served, or materially different from the likely transit-access region.
      County membership remains source-valid but boundary fit is unresolved.
    boundary_record_effect: blocked_until_coarseness_overlay_or_sensitivity_plan_exists
    metric_test_effect: blocked

  disqualifying_without_subcounty_overlay:
    description: >
      County membership would likely make the denominator misleading for
      Mobility Conversion unless a subcounty sensitivity layer is explicitly
      used to preserve unserved/weakly served population visibility.
    boundary_record_effect: no_boundary_record_until_methodology_decision
    metric_test_effect: blocked
```

## Required Screen Fields

Every county-based lead must receive the following fields before a boundary
record can be drafted:

```yaml
county_coarseness_screen:
  lead_id:
  working_name:
  source_family:
  source_authority:
  exact_code:
  exact_name:
  membership_vintage:
  county_count:
  county_membership_status:
  county_geometry_source_path:
  county_geometry_status:
  central_or_outlying_status_available:
  containment_or_commuting_fit_measure_available:
  cross_state:
  multi_agency_or_multi_authority:
  outlying_or_peripheral_counties:
  large_rural_or_exurban_counties:
  possible_wrongly_included_population:
  possible_weakly_included_population:
  possible_wrongly_excluded_population:
  denominator_source_path:
  denominator_status:
  service_overlay_source_paths:
  service_overlay_status:
  subcounty_overlay_required:
  candidate_overlay_sources:
  coarseness_risk_class:
  readiness_effect:
  next_allowed_output:
```

## Minimum Evidence Before Risk Classification

The screen may classify risk from existing source notes if the classification
is only provisional. A final pre-boundary classification requires:

- exact official county membership;
- release or delineation vintage;
- source-family caveats;
- central/outlying status where the source provides it;
- containment or commuting-fit measures where the source provides them;
- county geometry source path;
- population denominator source path;
- service-overlay source plan;
- cross-state or multi-authority note.

This does not require raw artifact archiving. It does require traceable source
paths and a decision on whether a draft evidence manifest is needed before
acquisition.

## Overlay Requirements

County-based boundaries must not be clipped to service coverage. Instead, a
later overlay must preserve population visibility inside the independent
boundary.

Allowed overlay roles:

- settlement or urbanized-area context;
- tract, block group, LSOA-equivalent, or grid population sensitivity layer;
- county central/outlying or containment annotations;
- service-source footprint, route, stop, or agency coverage as an overlay;
- unserved or weakly served population visibility check.

Prohibited overlay roles:

- redefining the MTR denominator from GTFS, stops, routes, agencies, or service
  areas;
- dropping outlying counties without a documented source rule;
- accepting a smaller urbanized core as the boundary because it is easier to
  measure;
- accepting population totals before the denominator method is selected.

## Boundary Record Effects

```yaml
boundary_record_effects:
  low:
    allowed_next_output:
      - source_note_follow_up
      - boundary_record_with_record_status_not_admitted
      - draft_evidence_manifest_if_raw_geometry_or_population_will_be_acquired
    required_boundary_record_caveat:
      - county_based_boundary_not_transport_service_area

  moderate:
    allowed_next_output:
      - source_note_follow_up
      - boundary_record_with_record_status_not_admitted
      - subcounty_overlay_plan
      - draft_evidence_manifest_if_raw_geometry_or_population_will_be_acquired
    required_boundary_record_caveat:
      - county_coarseness_moderate
      - subcounty_overlay_required_before_metric_test

  high:
    allowed_next_output:
      - source_note_follow_up
      - coarseness_overlay_plan
      - denominator_method_note
    blocked_outputs:
      - boundary_record
      - method_test
      - accepted_denominator_value

  disqualifying_without_subcounty_overlay:
    allowed_next_output:
      - methodology_decision
      - rejection_or_quarantine_note
      - subcounty_sensitivity_method_note
    blocked_outputs:
      - boundary_record
      - method_test
      - accepted_denominator_value
```

## Initial Application: Minneapolis-St. Paul ERS CZ

```yaml
minneapolis_county_coarseness_initial_screen:
  lead_id: mtr_src_004
  working_name: Minneapolis-St. Paul ERS CZ
  source_family: national_commuting_zone
  source_authority: USDA Economic Research Service
  exact_code: "258"
  exact_name: Minneapolis city, MN
  membership_vintage: 2020_commuting_zone_source_family
  county_count: 13
  county_membership_status: verified_from_transient_official_csv_inspection
  county_geometry_status: not_archived
  central_or_outlying_status_available: false
  containment_or_commuting_fit_measure_available: true
  cross_state: true
  multi_agency_or_multi_authority: unresolved
  outlying_or_peripheral_counties:
    - Kanabec County, MN
    - Pine County, MN
    - Pierce County, WI
    - Isanti County, MN
    - Chisago County, MN
  possible_wrongly_included_population: unresolved
  possible_weakly_included_population: likely_but_unquantified
  possible_wrongly_excluded_population: unresolved
  denominator_source_path: unresolved_ACS_or_Census_county_aggregation
  denominator_status: unresolved
  service_overlay_source_paths:
    - FTA_NTD_GTFS_Weblinks_unverified_for_current_local_scope
    - local_and_state_service_sources_unresolved
  service_overlay_status: unresolved
  subcounty_overlay_required: true
  candidate_overlay_sources:
    - Census_urban_area_or_urbanized_area_context
    - tract_or_block_group_population_sensitivity_layer
    - agency_or_GTFS_service_footprint_overlay
  coarseness_risk_class: high
  readiness_effect: blocked_until_coarseness_overlay_or_sensitivity_plan_exists
  next_allowed_output: county_coarseness_overlay_plan_or_denominator_method_note
```

Rationale:

The ERS source verifies exact county membership and includes containment
values, but the geography contains 13 counties across two states and several
peripheral counties. The source is strong for labour-market geography; it is
not yet strong enough for transport-access denominator use without a
subcounty/settlement sensitivity plan.

## Initial Application: Portland-Vancouver-Hillsboro CBSA

```yaml
portland_county_coarseness_initial_screen:
  lead_id: mtr_src_007
  working_name: Portland-Vancouver-Hillsboro CBSA
  source_family: official_statistical_metro
  source_authority: U.S. Census Bureau / OMB
  exact_code: "38900"
  exact_name: Portland-Vancouver-Hillsboro, OR-WA
  membership_vintage: "2023"
  county_count: 7
  county_membership_status: verified_from_transient_official_workbook_inspection
  county_geometry_status: TIGER_path_verified_not_archived
  central_or_outlying_status_available: true
  containment_or_commuting_fit_measure_available: not_in_inspected_note
  cross_state: true
  multi_agency_or_multi_authority: unresolved
  outlying_or_peripheral_counties:
    - Columbia County, OR
    - Yamhill County, OR
    - Skamania County, WA
  possible_wrongly_included_population: unresolved
  possible_weakly_included_population: likely_but_unquantified
  possible_wrongly_excluded_population: unresolved
  denominator_source_path: unresolved_ACS_or_Census_CBSA_or_county_aggregation
  denominator_status: unresolved
  service_overlay_source_paths:
    - FTA_NTD_GTFS_Weblinks_unverified_for_current_local_scope
    - BTS_National_Transit_Map_unverified_for_current_local_scope
    - local_Oregon_and_Washington_service_sources_unresolved
  service_overlay_status: unresolved
  subcounty_overlay_required: true
  candidate_overlay_sources:
    - Census_urban_area_or_urbanized_area_context
    - tract_or_block_group_population_sensitivity_layer
    - agency_or_GTFS_service_footprint_overlay
  coarseness_risk_class: high
  readiness_effect: blocked_until_coarseness_overlay_or_sensitivity_plan_exists
  next_allowed_output: county_coarseness_overlay_plan_or_denominator_method_note
```

Rationale:

The CBSA source verifies exact membership, metropolitan status, and
central/outlying county labels. The presence of three outlying counties and
cross-state service/governance issues makes the boundary unsuitable for
transport-access metric testing until a subcounty sensitivity plan exists.

## Method Decision

```yaml
county_coarseness_method_decision:
  decision: require_subcounty_overlay_plan_before_metric_testing
  applies_to:
    - mtr_src_004
    - mtr_src_007
  boundary_record_allowed_now: false
  evidence_manifest_allowed_now: false
  denominator_acquisition_allowed_now: false
  next_allowed_output:
    - county_coarseness_overlay_plan
    - denominator_method_note
    - source_note_follow_up_for_geometry_and_population_source_paths
  rationale: >
    Exact county membership is verified for both leads, but both are currently
    high-risk county-coarseness cases. A not-admitted boundary record would be
    premature until Thesis 2 defines the subcounty overlay or sensitivity method
    that will keep rural, exurban, weakly served, and cross-state populations
    visible.
```

## Implementation Rule For Future Boundary Records

If either lead later receives a boundary record with `record_status:
not_admitted`, the record must include:

- `county_coarseness_risk_class`;
- county membership source and vintage;
- central/outlying labels or containment measures where available;
- explicit county-coarseness caveat;
- cross-state/multi-authority caveat;
- population denominator source path and unresolved status, unless already
  source-noted;
- service-overlay source path and unresolved status, unless already
  source-noted;
- statement that no service geography defines the denominator;
- statement that subcounty overlay is required before metric testing.

## Next Recommended Artifact

Create a county-coarseness overlay plan that defines the allowed subcounty
context layer before any raw geometry, ACS denominator, or service feed archive
is acquired.

The overlay plan should decide whether the first sensitivity layer is:

- Census urban area / urbanized-area context;
- tract or block-group population layer;
- gridded population layer;
- combined settlement plus service-footprint overlay.

## Prohibited Outputs

This method note does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted population value;
- filled boundary record;
- raw data archive without manifest.
