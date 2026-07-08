# Batch S1B: U.S. County-Based Boundary Mechanics

Date: 2026-07-01

Status: formation-stage source-system mechanics decision. No MTR is selected.
No boundary record, evidence manifest, candidate-universe ledger, outcome
metric record, score, ranking, or MTR comparison is authorized.

Related intake:

- `theses/mobility-conversion/research/source_led_mtr_proposal_intake_2026-07-01.md`

Related existing source notes:

- `theses/mobility-conversion/research/source_notes/usda_ers_commuting_zones_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/us_omb_core_based_statistical_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/fta_ntd_gtfs_weblinks_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/us_census_acs_population_denominator_access_input_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/scientific_data_us_2020_commuting_zones_2026-06-28.md`

## Question

How should Thesis 2 treat U.S. county-based commuting zones and official
statistical metros as possible MTR denominators when they may over-include
territory?

## Short Decision

U.S. county-based boundary systems are admissible for mechanics review, but not
automatically admissible as MTR denominators.

ERS Commuting Zones and OMB/Census CBSAs can support later `not_admitted`
boundary records only after exact code, county membership, release vintage,
population denominator, and county-coarseness risks are documented.

They should remain fallback or validation-oriented source systems unless no
better observed functional transport-region boundary is available.

## Source-System Contrast

### USDA ERS 2020 Commuting Zones

Boundary family:

- `national_commuting_zone`

Strengths:

- nationally produced county-based labour-market areas;
- territorially exhaustive for U.S. and Puerto Rico counties and
  county-equivalents;
- based on county-to-county commuting flows;
- includes containment measures useful for boundary-quality review;
- avoids excluding noncore counties from any labour-market geography.

Risks:

- county building blocks are coarse for metropolitan transport access;
- labour-market geography is not all-purpose daily-access geography;
- real labour markets overlap, while CZs force discrete partitions;
- source is stronger for labour-market analysis than service/access analysis;
- 2016-2020 ACS commuting-flow input requires pandemic/remote-work caveat.

### OMB/Census Core Based Statistical Areas

Boundary family:

- `official_statistical_metro`

Strengths:

- official federal statistical geography;
- county-based and traceable;
- tied to urban cores and adjacent counties with commuting integration;
- strong compatibility with ACS and Census statistical denominators;
- useful as a U.S. statistical container and fallback.

Risks:

- OMB states CBSAs are established for statistical purposes, not general
  program administration or funding formulas;
- county building blocks may include both urban and rural territory;
- CBSAs are not an urban-rural classification;
- noncore counties are outside CBSAs even though they may belong to a labour
  market captured by ERS CZs;
- official statistical fit is not the same as transport-access fit.

### FTA/NTD GTFS Weblinks

Boundary family:

- `service_derived_boundary`

Decision:

- never an MTR denominator;
- service or network source only;
- useful for feed discovery, fixed-route service inputs, agency coverage, and
  service-completeness review after a separate county-based MTR denominator is
  proposed.

## S1B Rule

For U.S. county-based source-led proposals, county-based boundary mechanics may
advance to readiness-checklist review only as a boundary/source-system test.

A future U.S. county-based boundary record must begin as
`record_status: not_admitted` and must include:

```yaml
primary_boundary:
  boundary_source_family:
  source_system:
  source_authority:
  exact_code:
  exact_name:
  county_membership_source:
  county_membership_vintage:
  county_boundary_vintage:
  commuting_data_vintage:
  statistical_standard_vintage:
  release_or_delineation_vintage:
  source_authority_caveat:
  pandemic_or_remote_work_caveat:

county_coarseness_review:
  includes_large_rural_or_exurban_territory:
  includes_counties_with_weak_transport_integration:
  excludes_noncore_but_functionally_related_counties:
  cross_state_or_cross_agency_complexity:
  overlap_with_alternative_boundary:
  containment_or_fit_measure_available:
  boundary_fit_decision:

population_denominator:
  source_name:
  estimate_period:
  geography:
  county_or_cbsa_aggregation_method:
  margin_of_error_or_uncertainty_handling:
  mismatch_notes:

service_overlay:
  source_name:
  source_authority:
  source_vintage:
  agency_coverage_review:
  feed_reachability_review:
  non_fixed_route_exclusion_review:
  denominator_prohibited: true
```

## County Coarseness Decision Rule

A U.S. county-based lead must remain `not_admitted` if any of the following is
unresolved:

- the proposed county set includes large rural or exurban territory that may not
  participate in the relevant daily transport region;
- the source does not explain whether weakly connected counties are included;
- the MTR depends on cross-state, multi-agency, or multi-core relationships not
  captured by the county boundary;
- the resident-population denominator cannot be aligned to the exact county set;
- FTA/NTD/GTFS coverage is being used, even implicitly, to define the
  denominator;
- no caveat distinguishes labour-market/statistical fit from transport-access
  fit.

## Lead Implications

### `mtr_src_004` Minneapolis-St. Paul ERS CZ

Current status after S1B: remains `ready_for_readiness_checklist_review`, but
only for boundary/source-system mechanics.

Allowed next output:

- readiness-checklist review focused on exact ERS CZ code, county membership,
  ACS denominator aggregation, county coarseness, containment measures, and
  FTA/NTD service-overlay limits.

Not allowed:

- boundary record before exact CZ membership is verified;
- treating FTA/NTD GTFS weblinks as denominator;
- candidate admission;
- score or ranking.

### `mtr_src_007` Portland-Vancouver-Hillsboro MSA

Current status after S1B: remains `ready_for_readiness_checklist_review`, but
only for boundary/source-system mechanics.

Allowed next output:

- readiness-checklist review focused on exact CBSA code, delineation vintage,
  county membership, ACS denominator, cross-state agency coverage, and OMB
  source-authority caveat.

Not allowed:

- boundary record before exact CBSA boundary and delineation vintage are
  verified;
- using NTD/GTFS agency coverage to define the denominator;
- candidate admission;
- score or ranking.

## Evidence Manifest Decision

No evidence manifest is created in S1B.

Reason:

- S1B decides boundary-source mechanics and required fields.
- A manifest becomes required only if raw ERS county-membership files, Census
  boundary files, ACS tables, or FTA/NTD feed-link tables are acquired,
  archived, transformed, or version-pinned.

## Next Recommended Work

Run Batch S1D before advancing a specific U.S. lead into a filled boundary
record. The modelled-boundary burden should be clarified so Thesis 2 can compare
observed, official-statistical, national-commuting, and modelled boundary
families without privileging U.S. source convenience.

## Closing Guardrail

This batch does not select, admit, score, rank, or compare MTRs. It only
defines how U.S. county-based source systems may proceed through readiness
review without becoming hidden candidate selection.
