# County-Coarseness Readiness Screen

Date: 2026-07-06

Status: formation-stage cluster readiness screen. No MTR is admitted. No filled
boundary record, evidence manifest, candidate list, candidate-universe ledger,
outcome metric record, score, ranking, accepted denominator value, or raw data
archive is authorized.

## Purpose

Choose the next readiness-screen cluster after the eight 2026-07-05 raw
returns were intaked and independently source-verified or blocked.

Selected cluster:

```yaml
readiness_cluster:
  cluster_id: county_coarse_official_boundaries
  leads:
    - mtr_src_004_minneapolis_st_paul_ers_cz
    - mtr_src_007_portland_vancouver_hillsboro_cbsa
  reason_for_selection: >
    Both leads now have exact official county membership verified, both use
    eligible source families, and both are blocked by the same pre-boundary
    question: whether county-scale geographies are too coarse for Mobility
    Conversion denominator use.
  non_selection_statement: >
    This cluster is selected for methodology leverage, not because either
    region is expected to perform well or poorly.
```

## Source Inputs

Minneapolis-St. Paul ERS CZ:

- source note:
  `theses/mobility-conversion/research/source_notes/usda_ers_minneapolis_cz_exact_membership_2026-07-05.md`
- source authority: USDA Economic Research Service
- verified code/name: `CZ2020 = 258`, `CZName = Minneapolis city, MN`
- verified membership: 13 county rows across Minnesota and Wisconsin
- current status:
  `exact_membership_verified_county_population_and_service_blocked`

Portland-Vancouver-Hillsboro CBSA:

- source note:
  `theses/mobility-conversion/research/source_notes/us_census_portland_cbsa_exact_boundary_2026-07-05.md`
- source authority: U.S. Census Bureau / OMB
- verified code/name: `CBSA = 38900`,
  `Portland-Vancouver-Hillsboro, OR-WA`
- verified membership: seven county rows across Oregon and Washington
- current status:
  `exact_boundary_membership_verified_county_coarseness_blocked`

## Gate Results

### Gate 1. Boundary Source Eligibility

```yaml
boundary_source_eligibility:
  minneapolis_ers_cz:
    source_family: national_commuting_zone
    result: pass
  portland_cbsa:
    source_family: official_statistical_metro
    result: pass
```

Both source families are eligible for denominator testing. Neither is admitted
as an MTR.

### Gate 2. Source Verification

```yaml
source_verification:
  minneapolis_ers_cz:
    exact_membership_verified: true
    raw_source_archived: false
    unresolved:
      - county_geometry
      - ACS_population_denominator
      - service_overlay
  portland_cbsa:
    exact_membership_verified: true
    raw_source_archived: false
    unresolved:
      - TIGER_geometry
      - ACS_population_denominator
      - service_overlay
```

Both pass source verification for exact county membership. Neither passes raw
geometry, denominator, or service-overlay readiness.

### Gate 3. Boundary Fit

Both leads remain blocked by county-scale fit risk.

Required county-coarseness questions:

- How much of each county is plausibly part of the urbanized or transit-relevant
  catchment?
- Which counties are central/core versus outlying/peripheral?
- Do large rural or exurban counties dominate area while contributing less to
  likely transit-service relevance?
- Would county-level inclusion hide weakly served or unserved populations?
- Does cross-state geography create agency, data, or denominator alignment
  problems?
- Should county-based sources require a standard subcounty sensitivity overlay
  before any not-admitted boundary record?

Known fit concerns:

```yaml
known_fit_concerns:
  minneapolis_ers_cz:
    county_count: 13
    cross_state: true
    peripheral_counties_flagged:
      - Kanabec County, MN
      - Pine County, MN
      - Pierce County, WI
      - Isanti County, MN
      - Chisago County, MN
    issue: county_coarseness_and_cross_state_service_overlay
  portland_cbsa:
    county_count: 7
    cross_state: true
    outlying_counties:
      - Columbia County, OR
      - Yamhill County, OR
      - Skamania County, WA
    issue: county_coarseness_and_cross_state_service_overlay
```

### Gate 4. Data Bundle Plausibility

```yaml
data_bundle_plausibility:
  minneapolis_ers_cz:
    boundary_source: verified_county_membership
    population_denominator_source: ACS_or_Census_county_aggregation_unverified
    service_or_network_source: FTA_NTD_GTFS_and_local_sources_unverified
    result: plausible_but_blocked_by_coarseness_and_denominator_method
  portland_cbsa:
    boundary_source: verified_county_membership
    population_denominator_source: ACS_or_Census_CBSA_or_county_aggregation_unverified
    service_or_network_source: FTA_NTD_GTFS_BTS_and_local_sources_unverified
    result: plausible_but_blocked_by_coarseness_and_denominator_method
```

The cluster is plausible enough for a method note, not for boundary records.

### Gate 5. Evidence Manifest Need

No evidence manifest is created by this screen.

Before raw acquisition:

- TIGER/Line CBSA geometry requires a draft evidence manifest.
- County boundary geometry requires a draft evidence manifest.
- ACS or Census API/table responses require a denominator-source manifest or a
  separate source note, depending on acquisition posture.
- GTFS/NTD/source-feed archives require manifesting and service-coverage
  method notes.

### Gate 6. Candidate-Universe Guardrail

```yaml
candidate_universe_guardrail:
  admitted_mtrs: false
  candidate_list_created: false
  candidate_universe_ledger_created: false
  outcome_metric_record_created: false
  score_or_ranking_created: false
  accepted_denominator_value_created: false
```

## Cluster Decision

```yaml
decision:
  selected_next_cluster: county_coarse_official_boundaries
  review_decision: needs_methodology_decision
  next_allowed_output: county_coarseness_method_note
  rationale: >
    Portland and Minneapolis are the cleanest next methodological pair because
    exact membership is verified and the remaining blocker is shared. A single
    county-coarseness method note can define the screen required before either
    lead proceeds to a not-admitted boundary record, draft manifest, or
    denominator acquisition.
```

## Recommended County-Coarseness Method Note Fields

The next artifact should define:

```yaml
county_coarseness_method_note_fields:
  county_scale_risk_categories:
    - low
    - moderate
    - high
    - disqualifying_without_subcounty_overlay
  required_inputs_before_boundary_record:
    - central_or_outlying_status_if_available
    - county_area_or_land_area
    - population_denominator_source_path
    - urbanized_area_or_settlement_overlay_source_path
    - service_source_coverage_overlay_plan
    - cross_state_or_multi_authority_note
  required_decisions:
    - whether county-based boundaries can proceed with caveats
    - whether outlying counties require sensitivity classification
    - whether subcounty overlays are mandatory before metric testing
    - whether rural/exurban inclusion is a feature or a blocker
  prohibited_shortcuts:
    - dropping outlying counties without source rule
    - clipping the denominator to GTFS or service coverage
    - accepting population values before denominator method review
    - treating county membership as proof of transport-service fit
```

## Leads Not Selected For This Immediate Cluster

The other leads remain active but are not the next method cluster:

- Helsinki and Lyon: blocked by European FUA service-source completeness and
  authenticated/static-feed issues.
- Bristol, Calgary, Melbourne: exact row or feature verified, but population
  path and service-overlay questions are not yet a shared method issue as clean
  as the U.S. county-coarseness pair.
- Sao Paulo: still high-burden modelled-boundary fallback; needs IBGE review or
  manifest planning before exact GHS-FUA row extraction.

## Prohibited Outputs

This readiness screen does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted population value;
- filled boundary record;
- raw data archive without manifest.
