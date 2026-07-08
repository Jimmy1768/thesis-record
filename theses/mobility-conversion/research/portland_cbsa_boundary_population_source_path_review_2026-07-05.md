# Portland-Vancouver-Hillsboro CBSA Boundary / Population Source-Path Review

Date: 2026-07-05

Status: lead-specific source-path review. No MTR admitted. No filled boundary
record, evidence manifest, candidate list, candidate-universe ledger, metric
record, score, ranking, accepted denominator value, or raw data archive is
authorized.

Related lead:

- `mtr_src_007` Portland-Vancouver-Hillsboro MSA

Related source notes:

- `theses/mobility-conversion/research/source_notes/us_omb_core_based_statistical_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/us_census_acs_population_denominator_access_input_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/fta_ntd_gtfs_weblinks_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/bts_national_transit_map_2026-06-28.md`

## Review Decision

Portland-Vancouver-Hillsboro CBSA/MSA can proceed as a U.S. official
statistical-metro source-led lead, but it is not ready for a filled boundary
record.

Existing Thesis 2 notes verify the OMB CBSA source family, ACS population
denominator source family, and U.S. service-source overlay families. They do
not yet verify the exact CBSA code, delineation vintage, county membership,
boundary artifact, ACS denominator path, or cross-state service-overlay
coverage.

## Lead Status

Previous intake status: `ready_for_readiness_checklist_review`

New source-path status:

```yaml
portland_cbsa_status:
  lead_id: mtr_src_007
  working_name: Portland-Vancouver-Hillsboro MSA
  boundary_family: official_statistical_metro
  boundary_authority: OMB / U.S. Census Bureau
  source_path_status: source_families_verified_exact_boundary_unresolved
  exact_cbsa_boundary_status: unresolved
  boundary_record_allowed: false
  evidence_manifest_allowed: false
```

## What Is Now Known

```yaml
source_path_review:
  boundary_source_family:
    title: OMB Core Based Statistical Area standards
    authority: Office of Management and Budget
    role: candidate official statistical-metro source family
    verified_in_existing_notes: true
  boundary_artifact_source_family:
    authority: U.S. Census Bureau
    role: candidate CBSA boundary and county membership source path
    exact_artifact_verified: false
    raw_artifact_archived: false
  population_source_path:
    title: American Community Survey
    authority: U.S. Census Bureau
    role: candidate resident-population denominator source family
    verified_in_existing_notes: true
    accepted_population_value: false
  service_source_paths:
    - FTA / NTD GTFS Weblinks
    - BTS National Transit Map
    role: service-source overlays only
    accepted_as_boundary: false
```

## What Is Not Known

- Exact CBSA/MSA code/name.
- Exact delineation vintage and standard vintage.
- Exact county membership and cross-state county set.
- Exact CBSA boundary file, layer, version, and download path.
- Whether ACS population should use direct CBSA geography or county
  aggregation.
- Margin-of-error or uncertainty handling if county aggregation is used.
- Whether county coarseness includes rural or exurban territory beyond the
  daily transport-access region.
- Which FTA/NTD reporters, GTFS feeds, or National Transit Map records are
  material inside the CBSA.
- Whether cross-state agency coverage creates service-source gaps.
- Whether non-fixed-route, paratransit, demand-responsive, ferry, airport,
  private, or intercity services are material.

## Required Next Fields

```yaml
portland_cbsa_required_fields:
  exact_code:
  exact_name:
  cbsa_standard_vintage:
  cbsa_delineation_vintage:
  county_membership_source:
  county_membership_vintage:
  boundary_file_source:
  boundary_geometry_status: not_archived
  source_authority_caveat:
  commuting_data_vintage:
  pandemic_or_remote_work_caveat:
  county_coarseness_review:
  cross_state_or_multi_agency_complexity:
  population_denominator_source:
  acs_estimate_period:
  direct_cbsa_or_county_aggregation_method:
  margin_of_error_or_uncertainty_handling:
  accepted_denominator_value: false
  service_overlay_sources:
  ntd_reporters_or_gtfs_feeds:
  national_transit_map_use:
  missing_modes_or_services:
  source_rich_region_bias_risk:
```

## Readiness Effect

```yaml
readiness_effect:
  boundary_source_eligibility: pass_at_source_family_level
  source_verification: partial_pass_source_families_only
  boundary_fit: blocked_exact_cbsa_boundary_and_county_coarseness_unresolved
  data_bundle_plausibility: plausible_but_blocked_cross_state_service_coverage_unknown
  evidence_manifest_need: not_created_no_raw_artifact_acquired
  candidate_universe_guardrail: pass_no_admission
```

## Next Recommended Artifact

Create an exact Portland-Vancouver-Hillsboro CBSA boundary extraction workflow
and handoff an exact boundary/source-bundle request to external research.

The next artifact should not ask whether Portland has good transport. It should
ask for source-led extraction fields:

- exact CBSA/MSA code/name;
- delineation vintage and county membership;
- Census boundary product and layer;
- ACS denominator path;
- cross-state county-coarseness and service-source coverage against the CBSA.

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
