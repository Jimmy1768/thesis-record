# Minneapolis-St. Paul ERS CZ Exact Membership Extraction Workflow

Date: 2026-07-05

Status: formation-stage extraction workflow. No MTR admitted. No exact
Minneapolis-St. Paul ERS CZ membership accepted. No filled boundary record,
evidence manifest, candidate list, candidate-universe ledger, metric record,
score, ranking, accepted denominator value, or raw data archive is authorized.

Related lead:

- `mtr_src_004` Minneapolis-St. Paul ERS CZ

Related records:

- `theses/mobility-conversion/research/minneapolis_ers_cz_boundary_population_source_path_review_2026-07-05.md`
- `theses/mobility-conversion/research/batch_s1b_us_county_based_boundary_mechanics_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/usda_ers_commuting_zones_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/us_census_acs_population_denominator_access_input_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/fta_ntd_gtfs_weblinks_2026-06-28.md`

## Purpose

Define the exact extraction gates required before Minneapolis-St. Paul ERS CZ
can move beyond source-family review.

This workflow exists because ERS CZs are a plausible U.S. national
commuting-zone source family, but the exact local CZ code, county membership,
ACS denominator aggregation, and service-overlay fit are not accepted.

## Extraction Principle

Do not infer the Minneapolis-St. Paul ERS CZ from the metropolitan name, common
county assumptions, transit-agency geography, or raw research output.

Accept exact membership only after official or primary sources directly
identify:

- exact CZ code/name;
- county and county-equivalent membership;
- county membership vintage;
- county boundary vintage;
- resident-population denominator aggregation path;
- relation between the county set and any service-overlay sources.

## Required Extraction Fields

```yaml
minneapolis_ers_cz_exact_membership_extraction:
  lead_id: mtr_src_004
  working_name: Minneapolis-St. Paul ERS CZ
  source_authority: USDA ERS
  exact_name:
  exact_code:
  geography_type:
  county_membership_source:
  county_membership_vintage:
  county_boundary_source:
  county_boundary_vintage:
  boundary_geometry_status: not_archived
  commuting_data_vintage:
  containment_or_fit_measure_source:
  county_coarseness_review:
  cross_state_or_multi_agency_complexity:
  pandemic_or_remote_work_caveat:
  population_product:
  population_product_url_or_table_path:
  acs_estimate_period:
  population_field:
  county_aggregation_method:
  margin_of_error_or_uncertainty_handling:
  accepted_denominator_value: false
  service_overlay_sources:
  ntd_reporters_or_gtfs_feeds:
  missing_modes_or_services:
  license_or_reuse_terms:
  evidence_manifest_status: not_created
  extraction_decision:
  blockers:
```

## Step 1. Verify CZ Identifier And Membership

Find an official USDA ERS source, ERS documentation table, or primary dataset
metadata that identifies the Minneapolis-St. Paul CZ and its member counties.

Required:

- exact CZ name and code;
- county list;
- county identifiers;
- state identifiers;
- release/update date;
- whether Puerto Rico or county-equivalent handling is relevant to the product
  but not this lead.

Do not accept:

- Wikipedia;
- local agency service maps;
- CBSA county lists as a substitute for ERS CZ membership;
- NTD agency service areas;
- search-result snippets;
- uncited Deep Research claims.

## Step 2. Verify County Boundary Artifact

Identify the official county boundary source that would later pair with the ERS
county set.

Required:

- product title;
- source authority;
- vintage;
- file/layer name;
- county identifier field;
- license or reuse terms.

Do not download or archive the raw boundary artifact until an evidence manifest
is created.

## Step 3. Verify ACS Population Denominator Path

Identify the ACS population path for the same county set.

Required:

- selected ACS estimate period;
- selected resident-population field;
- county identifiers;
- aggregation method;
- margin-of-error or uncertainty handling;
- mismatch notes if county membership and ACS vintage differ.

Do not accept or copy a population value at this workflow stage.

## Step 4. Verify County-Coarseness Caveats

Record whether ERS CZ membership creates denominator risk:

- large rural or exurban counties;
- weakly connected counties;
- cross-state counties;
- counties with materially different transport agencies;
- containment or fit measures;
- overlap with CBSA or alternative boundary;
- labour-market fit versus transport-access fit.

If a source does not show whether a caveat applies, record `unknown`, not
`none`.

## Step 5. Verify Service-Overlay Implication

Identify service-source questions before any readiness promotion:

- Which NTD reporters are located in or materially serve the ERS CZ?
- Which static GTFS links are available through FTA/NTD GTFS Weblinks?
- Are regional GTFS feeds present, and do they represent all relevant NTD
  reporters?
- Are demand-responsive, paratransit, vanpool, intercity, private, airport, or
  other non-fixed-route services material but excluded?
- Could fixed-route feed coverage hide unserved county population?

Service geography cannot define the MTR.

## Decision Classes

Allowed extraction decisions:

- `exact_membership_verified_ready_for_blocked_readiness_review`
- `blocked_exact_cz_not_found`
- `blocked_county_membership_unresolved`
- `blocked_population_product_unresolved`
- `blocked_service_overlay_unresolved`
- `quarantined_county_coarseness_overreach`
- `quarantined_source_conflict`

No decision here admits Minneapolis-St. Paul or creates a boundary record.

## Manifest Trigger

No evidence manifest is created by this workflow.

Manifest required before:

- archiving ERS membership files;
- archiving county boundary files;
- archiving ACS tables;
- archiving FTA/NTD GTFS Weblinks rows or GTFS feeds;
- extracting and storing accepted population values;
- joining boundary, population, and service artifacts;
- creating any filled boundary record or method test.

## Next Allowed Output

Allowed:

- external research handoff for Minneapolis-St. Paul ERS CZ exact
  membership/source bundle;
- exact-membership extraction note if official source rows are independently
  inspected;
- service-source trace plan for FTA/NTD reporter and GTFS feed coverage.

## Prohibited Outputs

This workflow does not authorize:

- admitted MTR;
- exact Minneapolis-St. Paul ERS CZ membership acceptance without source
  inspection;
- filled boundary record;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted denominator value;
- raw data archive without manifest.
