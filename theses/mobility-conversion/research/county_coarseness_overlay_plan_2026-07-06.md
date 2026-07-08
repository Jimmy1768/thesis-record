# County-Coarseness Overlay Plan

Date: 2026-07-06

Status: formation-stage overlay plan. No MTR is admitted. No filled boundary
record, evidence manifest, candidate list, candidate-universe ledger, outcome
metric record, score, ranking, accepted denominator value, or raw data archive
is authorized.

## Purpose

Choose the first subcounty context layer for high-risk county-based boundary
leads and define what it may and may not do.

This plan implements:

- `theses/mobility-conversion/research/county_coarseness_method_note_2026-07-06.md`
- `theses/mobility-conversion/research/county_coarseness_readiness_screen_2026-07-06.md`

Applicable leads:

- `mtr_src_004` Minneapolis-St. Paul ERS CZ
- `mtr_src_007` Portland-Vancouver-Hillsboro CBSA

## Overlay Choice

Selected first overlay:

```yaml
selected_overlay:
  overlay_type: tract_or_block_group_population_sensitivity_layer
  source_family: U.S. Census ACS resident population
  source_note: theses/mobility-conversion/research/source_notes/us_census_acs_population_denominator_access_input_2026-07-01.md
  role: population_visibility_and_boundary_fit_sensitivity
  denominator_role: not_primary_denominator_yet
  raw_acquisition_authorized: false
```

Rationale:

ACS tract or block-group population is the safest first overlay because it
keeps the official county-based boundary intact while making intra-county
population distribution visible. It does not replace the county boundary with
an urbanized core, route buffer, stop buffer, or service area.

The overlay is for sensitivity and visibility only. It does not create an
accepted population denominator.

## Overlays Not Selected First

```yaml
deferred_overlays:
  census_urban_area:
    status: deferred_requires_source_note
    reason: >
      Useful as settlement context, but if used first it could tempt the method
      to substitute an urban core for the county-based source boundary.
  gridded_population:
    status: deferred
    reason: >
      Useful for cross-national comparability later, but ACS is already the
      verified U.S. denominator source family and better aligned with U.S.
      county, tract, and block-group geography.
  combined_settlement_plus_service_footprint:
    status: deferred
    reason: >
      Service footprints must not define the denominator. A service-footprint
      overlay should be added only after the population visibility layer exists.
  service_footprint_only:
    status: rejected_as_first_overlay
    reason: >
      GTFS, agencies, stops, routes, and NTD feed links are overlays only. They
      can hide unserved population if used before a population visibility layer.
```

## Overlay Function

The tract or block-group sensitivity layer should answer:

- which parts of included counties contain resident population;
- whether flagged peripheral counties have concentrated or dispersed
  population;
- whether large rural/exurban land area would dominate visual or spatial
  interpretation;
- where later service-source overlays need to preserve unserved or weakly
  served population visibility;
- whether county-based boundary fit should remain `high` risk or can be
  downgraded to `moderate` after sensitivity review.

It must not answer:

- final population total;
- final metric denominator;
- final access, service, or coverage performance;
- final inclusion or admission;
- score or ranking.

## Required Overlay Fields

```yaml
county_coarseness_overlay_fields:
  lead_id:
  working_name:
  county_boundary_source:
  county_boundary_status:
  subcounty_population_source:
  subcounty_population_source_note:
  subcounty_geography_level:
  estimate_period:
  total_population_field:
  margin_of_error_field:
  geometry_join_key:
  county_join_key:
  crosswalk_method:
  raw_data_status:
  evidence_manifest_status:
  accepted_population_value: false
  service_overlay_status:
  sensitivity_questions_answered:
  unresolved_questions:
  next_allowed_output:
```

Allowed `subcounty_geography_level` values for the first pass:

- `tract`
- `block_group`
- `tract_then_block_group_if_needed`

Initial preference:

```yaml
initial_subcounty_geography_level: tract_then_block_group_if_needed
```

Reason:

Tracts are less granular and easier to inspect for a first boundary-fit
sensitivity review. Block groups may be added only if tracts are too coarse to
identify peripheral or edge-area population visibility.

## Data Acquisition Posture

No raw ACS, TIGER, county, tract, block-group, GTFS, or service data is acquired
by this plan.

Before any raw acquisition, create or update a draft evidence manifest if the
work will archive:

- TIGER county geometry;
- TIGER tract or block-group geometry;
- ACS API/table responses;
- transformed crosswalk tables;
- service feed or GTFS artifacts;
- derived overlay outputs.

For source-note-only work, a manifest is not required, but no raw data can be
stored in the repo.

## Minneapolis Overlay Plan

```yaml
minneapolis_overlay_plan:
  lead_id: mtr_src_004
  working_name: Minneapolis-St. Paul ERS CZ
  current_coarseness_risk_class: high
  selected_overlay: tract_or_block_group_population_sensitivity_layer
  initial_subcounty_geography_level: tract_then_block_group_if_needed
  included_counties:
    - Anoka County, MN
    - Carver County, MN
    - Chisago County, MN
    - Dakota County, MN
    - Hennepin County, MN
    - Isanti County, MN
    - Kanabec County, MN
    - Pine County, MN
    - Ramsey County, MN
    - Scott County, MN
    - Washington County, MN
    - Pierce County, WI
    - St. Croix County, WI
  peripheral_focus_counties:
    - Kanabec County, MN
    - Pine County, MN
    - Pierce County, WI
    - Isanti County, MN
    - Chisago County, MN
  sensitivity_questions:
    - Are peripheral-county residents concentrated near likely service or commuting corridors?
    - Does cross-state county inclusion create population visibility outside the main service-source bundle?
    - Would tract-level distribution show weakly included rural/exurban population that county totals would hide?
    - Is block-group detail needed for Pine, Kanabec, Pierce, Isanti, or Chisago?
  overlay_decision_status: plan_ready_no_raw_acquisition
  next_allowed_output: draft_evidence_manifest_or_source_note_for_ACS_TIGER_overlay_sources
```

## Portland Overlay Plan

```yaml
portland_overlay_plan:
  lead_id: mtr_src_007
  working_name: Portland-Vancouver-Hillsboro CBSA
  current_coarseness_risk_class: high
  selected_overlay: tract_or_block_group_population_sensitivity_layer
  initial_subcounty_geography_level: tract_then_block_group_if_needed
  included_counties:
    - Clackamas County, OR
    - Columbia County, OR
    - Multnomah County, OR
    - Washington County, OR
    - Yamhill County, OR
    - Clark County, WA
    - Skamania County, WA
  peripheral_focus_counties:
    - Columbia County, OR
    - Yamhill County, OR
    - Skamania County, WA
  sensitivity_questions:
    - Are outlying-county residents concentrated near the Portland-Vancouver core or along service corridors?
    - Does Skamania County create a high land-area, low-service-visibility problem?
    - Does cross-state county inclusion require separate Oregon and Washington service-source overlay plans?
    - Would direct CBSA ACS geography hide county-level or tract-level coarseness?
  overlay_decision_status: plan_ready_no_raw_acquisition
  next_allowed_output: draft_evidence_manifest_or_source_note_for_ACS_TIGER_overlay_sources
```

## Service Overlay Sequencing

Service overlays come after the population visibility layer.

Allowed later service-overlay source families:

- FTA/NTD GTFS Weblinks for feed discovery;
- BTS National Transit Map if separately source-noted for the specific use;
- local or state GTFS/operator feeds after source-note verification;
- agency service areas only as governance or service context;
- demand-responsive or non-fixed-route source notes where material.

Sequencing rule:

```yaml
service_overlay_sequence:
  step_1: population_visibility_overlay
  step_2: service_source_inventory
  step_3: service_footprint_overlay
  step_4: unserved_or_weakly_served_population_visibility_check
  prohibited: service_footprint_as_denominator
```

## Risk-Class Update Rule

After the overlay source paths are verified, risk may update only through a
separate screen:

```yaml
risk_update_rule:
  high_to_moderate_allowed_if:
    - peripheral_population_distribution_is_described
    - cross_state_service_source_plan_exists
    - denominator_source_path_and_MOE_handling_are_defined
    - service_geography_is_explicitly_denominator_prohibited
  high_to_low_allowed: false
  reason: >
    A county-based cross-state metro or commuting zone with outlying counties
    cannot become low coarseness risk before at least one manifested overlay or
    source-note-backed sensitivity review.
```

## Decision

```yaml
county_coarseness_overlay_decision:
  decision: use_ACS_tract_or_block_group_population_sensitivity_first
  boundary_record_allowed_now: false
  denominator_acquisition_allowed_now: false
  evidence_manifest_required_before_raw_acquisition: true
  service_overlay_allowed_now: planning_only
  next_allowed_output:
    - draft_evidence_manifest_for_ACS_TIGER_overlay_sources
    - source_note_follow_up_for_Census_subcounty_geography_paths
    - source_note_follow_up_for_current_FTA_NTD_GTFS_weblinks_by_lead
  rationale: >
    The first overlay must preserve population visibility inside the independent
    county-based boundary. ACS tract or block-group population sensitivity is
    the most conservative first layer because it directly targets the
    denominator-visibility problem without substituting a smaller urban core or
    service footprint for the boundary.
```

## Prohibited Outputs

This overlay plan does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted population value;
- filled boundary record;
- raw data archive without manifest.
