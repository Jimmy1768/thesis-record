# MTR Boundary Record Template

Status: formation-stage template. Do not use this template to select an MTR by
reputation, familiarity, transit fame, congestion fame, livability ranking, or
intuition.

Purpose: define the minimum record a proposed Metropolitan Transport Region
must satisfy before it can be admitted to the candidate universe.

This is not a scoring template. It does not approve candidate selection,
outcome measurement, case inclusion, ranking, or paper claims.

## Use Rule

Create one boundary record per proposed MTR only after the operator has a
source-led reason to test the region.

The first filled record for any proposed MTR must remain `not_admitted` until
all required fields are complete and reviewed against the admission checklist.

## Record Status Values

Allowed values:

- `not_started`
- `not_admitted`
- `needs_source_verification`
- `needs_methodology_decision`
- `admissible_for_candidate_universe`
- `rejected_boundary_basis`

No record may use `admissible_for_candidate_universe` until the admission
checklist is complete.

## Confidence Classes

Allowed values:

- `observed_functional_region`
- `national_commuting_zone`
- `hybrid_functional_statistical_region`
- `official_statistical_metro`
- `modelled_functional_region`
- `built_up_urban_core`
- `governance_or_service_region`
- `service_derived_boundary`
- `accessibility_dataset_geography`

Only these classes can potentially define the MTR denominator during candidate
formation:

- `observed_functional_region`
- `national_commuting_zone`
- `hybrid_functional_statistical_region`
- `official_statistical_metro`
- `modelled_functional_region`

The other classes are overlays, validation layers, indicator inputs, or
contextual sources.

## YAML Record Shape

```yaml
record_id:
record_status: not_admitted
record_created:
record_updated:
operator_thread: Thesis 2

proposed_mtr:
  working_id:
  working_name:
  country_or_countries:
  region_context:
  proposal_origin:
  source_led_reason_for_testing:
  prohibited_selection_check:
    selected_for_transit_reputation: false
    selected_for_congestion_reputation: false
    selected_for_livability_ranking: false
    selected_for_walkability_reputation: false
    selected_for_personal_familiarity: false
    notes:

primary_boundary:
  boundary_source_id:
  boundary_family:
  source_name:
  source_authority:
  source_url_or_access_path:
  source_vintage:
  latest_known_release:
  retrieval_or_inspection_date:
  raw_archive_path:
  processed_geometry_path:
  geometry_type:
  spatial_unit:
  geographic_coverage:
  observed_or_modelled:
  basis_type:
  confidence_class:
  license:
  verification_status:
  source_note_path:
  known_limitations:
  source_authority_caveat:
  boundary_quality_notes:

commute_or_functional_basis:
  applies: false
  commuting_data_vintage:
  geography_release_vintage:
  flow_type:
  threshold_or_algorithm:
  pandemic_or_remote_work_caveat:
  non_work_trip_limitation:
  work_from_home_treatment:
  source_sampling_or_estimation_limits:

hybrid_or_statistical_rules:
  applies: false
  population_thresholds:
  administrative_building_blocks:
  stability_rules:
  historical_comparability_rules:
  manual_adjustment_rules:
  merge_or_split_rules:
  official_use_limitations:

fallback_or_validation_boundaries:
  observed_functional_region:
    available: false
    source_id:
    confidence_class:
    notes:
  national_commuting_zone:
    available: false
    source_id:
    confidence_class:
    notes:
  hybrid_functional_statistical_region:
    available: false
    source_id:
    confidence_class:
    notes:
  official_statistical_metro:
    available: false
    source_id:
    confidence_class:
    notes:
  modelled_functional_region:
    available: false
    source_id:
    confidence_class:
    notes:

required_overlays:
  built_up_urban_core:
    source_id:
    source_name:
    role:
    notes:
  governance_or_service_region:
    source_id:
    source_name:
    role:
    notes:
  service_derived_sources:
    gtfs_or_feed_sources:
    national_service_catalogs:
    role: indicator_input_only
    denominator_prohibited: true
    notes:
  accessibility_dataset_geographies:
    source_id:
    source_name:
    role:
    notes:

boundary_fit_review:
  includes_functional_core:
  includes_peripheral_populations_shaped_by_mtr:
  excludes_distant_weakly_related_populations:
  handles_polycentricity:
  handles_cross_border_region:
  handles_multiple_transport_authorities:
  handles_informal_or_weakly_documented_transport:
  governance_not_baked_into_outcome:
  service_area_not_used_as_denominator:
  known_boundary_mismatches:

data_alignment_review:
  population_data_alignment:
  income_or_capacity_data_alignment:
  safety_data_alignment:
  service_data_alignment:
  accessibility_indicator_alignment:
  affordability_data_alignment:
  asset_condition_data_alignment:
  mismatch_notes:

admission_checklist:
  source_traceable: false
  source_note_exists: false
  confidence_class_allowed_for_denominator: false
  vintage_recorded: false
  geography_release_recorded: false
  limitations_recorded: false
  caveats_recorded: false
  fallback_or_validation_boundary_recorded: false
  governance_overlay_recorded: false
  service_overlay_recorded_without_denominator_use: false
  unserved_population_risk_reviewed: false
  reputation_selection_rejected: false
  missing_data_rule_applied: false

admission_decision:
  decision: not_admitted
  decision_date:
  decided_by:
  rationale:
  required_follow_up:
```

## Admission Checklist Interpretation

The checklist is a gate, not a score.

If any required item is false, the proposed MTR remains outside the candidate
universe.

If `confidence_class_allowed_for_denominator` is false because the only
available source is `built_up_urban_core`, `governance_or_service_region`,
`service_derived_boundary`, or `accessibility_dataset_geography`, the record
must be marked `rejected_boundary_basis` or `needs_methodology_decision`.

If the boundary uses commuting, labour-market, travel-to-work, or
commute-informed statistical logic, the commute caveat fields are mandatory.

## Review Questions

Before admitting a proposed MTR, answer:

1. Is this boundary source-led rather than reputation-led?
2. Does the boundary approximate metropolitan transport access geography?
3. What populations would be excluded if this boundary is used?
4. What populations would be included despite weak transport relationship?
5. Does a better observed functional boundary exist?
6. Is the fallback source being used because it is better, or only because it
   is easier to join to indicators?
7. Are service data being used only as indicators and overlays?
8. Are governance structures recorded without making governance performance
   circular?
9. Are source vintage and release vintage clear enough for comparison?
10. What methodology decision would change the admission outcome?

## Storage Rule

Filled records should live under:

```text
theses/mobility-conversion/research/boundary_records/
```

Do not create a filled boundary record until there is a source-led proposal and
the candidate-universe protocol permits testing a proposed MTR.
