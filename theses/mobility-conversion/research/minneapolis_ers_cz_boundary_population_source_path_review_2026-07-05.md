# Minneapolis-St. Paul ERS CZ Boundary / Population Source-Path Review

Date: 2026-07-05

Status: lead-specific source-path review. No MTR admitted. No filled boundary
record, evidence manifest, candidate list, candidate-universe ledger, metric
record, score, ranking, accepted denominator value, or raw data archive is
authorized.

Related lead:

- `mtr_src_004` Minneapolis-St. Paul ERS CZ

Related source notes:

- `theses/mobility-conversion/research/source_notes/usda_ers_commuting_zones_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/scientific_data_us_2020_commuting_zones_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/us_census_acs_population_denominator_access_input_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/fta_ntd_gtfs_weblinks_2026-06-28.md`

## Review Decision

Minneapolis-St. Paul ERS CZ can proceed as a U.S. national commuting-zone
source-led lead, but it is not ready for a filled boundary record.

Existing Thesis 2 notes verify the ERS CZ source family, ACS population
denominator source family, and FTA/NTD GTFS Weblinks service-source family. They
do not yet verify the exact Minneapolis-St. Paul ERS CZ code, county membership,
population aggregation, county-coarseness risk, or transit operator/feed
coverage against the proposed county set.

## Lead Status

Previous intake status: `ready_for_readiness_checklist_review`

New source-path status:

```yaml
minneapolis_ers_cz_status:
  lead_id: mtr_src_004
  working_name: Minneapolis-St. Paul ERS CZ
  boundary_family: national_commuting_zone
  boundary_authority: USDA ERS
  source_path_status: source_families_verified_exact_membership_unresolved
  exact_cz_membership_status: unresolved
  boundary_record_allowed: false
  evidence_manifest_allowed: false
```

## What Is Now Known

```yaml
source_path_review:
  boundary_source_path:
    title: Commuting Zones and Labor Market Areas
    authority: USDA Economic Research Service
    role: candidate national commuting-zone source family
    verified_in_existing_notes: true
    raw_artifact_archived: false
  population_source_path:
    title: American Community Survey
    authority: U.S. Census Bureau
    role: candidate resident-population denominator source family
    verified_in_existing_notes: true
    accepted_population_value: false
  service_source_path:
    title: FTA / NTD GTFS Weblinks
    authority: Federal Transit Administration / National Transit Database
    role: fixed-route feed discovery and service-overlay input only
    verified_in_existing_notes: true
```

## What Is Not Known

- Exact ERS CZ code/name for the Minneapolis-St. Paul labour-market region.
- Exact county and county-equivalent membership.
- County-boundary vintage to pair with ERS membership.
- Whether ERS containment measures identify weakly included counties.
- Whether the county set includes large rural or exurban territory that would
  overstate a transport-access denominator.
- ACS geography, estimate period, aggregation method, and uncertainty handling
  for the exact county set.
- Which NTD reporters and GTFS feeds are material inside the ERS CZ.
- Whether FTA/NTD fixed-route feeds omit material demand-responsive,
  paratransit, intercity, private, airport, or non-fixed-route services.
- Whether cross-state or multi-agency service geography creates coverage
  issues.

## Required Next Fields

```yaml
minneapolis_ers_cz_required_fields:
  exact_code:
  exact_name:
  county_membership_source:
  county_membership_vintage:
  county_boundary_vintage:
  commuting_data_vintage:
  containment_or_fit_measure_available:
  county_coarseness_review:
  cross_state_or_multi_agency_complexity:
  pandemic_or_remote_work_caveat:
  population_denominator_source:
  acs_estimate_period:
  county_aggregation_method:
  margin_of_error_or_uncertainty_handling:
  accepted_denominator_value: false
  service_overlay_sources:
  ntd_reporters_or_gtfs_feeds:
  missing_modes_or_services:
  source_rich_region_bias_risk:
```

## Readiness Effect

```yaml
readiness_effect:
  boundary_source_eligibility: pass_at_source_family_level
  source_verification: partial_pass_source_families_only
  boundary_fit: blocked_exact_membership_and_county_coarseness_unresolved
  data_bundle_plausibility: plausible_but_blocked_service_coverage_unknown
  evidence_manifest_need: not_created_no_raw_artifact_acquired
  candidate_universe_guardrail: pass_no_admission
```

## Next Recommended Artifact

Create an exact Minneapolis-St. Paul ERS CZ membership extraction workflow and
handoff an exact membership/source-bundle request to external research.

The next artifact should not ask whether Minneapolis-St. Paul is a good
transport region. It should ask for source-led extraction fields:

- exact ERS CZ code/name;
- county membership and county-boundary vintage;
- ACS population aggregation path;
- county-coarseness and containment/fit measures;
- FTA/NTD reporter and GTFS feed coverage against the county set.

## Prohibited Outputs

This review does not authorize:

- admitted MTR;
- filled boundary record;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted denominator value;
- raw data archive without manifest.
