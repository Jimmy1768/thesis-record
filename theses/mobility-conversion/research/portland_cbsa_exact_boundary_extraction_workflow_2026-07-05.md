# Portland-Vancouver-Hillsboro CBSA Exact Boundary Extraction Workflow

Date: 2026-07-05

Status: formation-stage extraction workflow. No MTR admitted. No exact
Portland-Vancouver-Hillsboro CBSA boundary accepted. No filled boundary record,
evidence manifest, candidate list, candidate-universe ledger, metric record,
score, ranking, accepted denominator value, or raw data archive is authorized.

Related lead:

- `mtr_src_007` Portland-Vancouver-Hillsboro MSA

Related records:

- `theses/mobility-conversion/research/portland_cbsa_boundary_population_source_path_review_2026-07-05.md`
- `theses/mobility-conversion/research/batch_s1b_us_county_based_boundary_mechanics_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/us_omb_core_based_statistical_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/us_census_acs_population_denominator_access_input_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/fta_ntd_gtfs_weblinks_2026-06-28.md`

## Purpose

Define the exact extraction gates required before Portland-Vancouver-Hillsboro
CBSA/MSA can move beyond source-family review.

This workflow exists because OMB/Census CBSAs are plausible U.S. official
statistical-metro source families, but the exact local CBSA code, delineation
vintage, county membership, ACS denominator path, and service-overlay fit are
not accepted.

## Extraction Principle

Do not infer the Portland-Vancouver-Hillsboro CBSA from the metropolitan name,
transit-agency geography, common county assumptions, or raw research output.

Accept the exact boundary only after official or primary sources directly
identify:

- exact CBSA/MSA code/name;
- standard and delineation vintage;
- county and county-equivalent membership;
- boundary product path;
- resident-population denominator path;
- relation between the county/CBSA geography and service-overlay sources.

## Required Extraction Fields

```yaml
portland_cbsa_exact_boundary_extraction:
  lead_id: mtr_src_007
  working_name: Portland-Vancouver-Hillsboro MSA
  source_authority: OMB / U.S. Census Bureau
  exact_name:
  exact_code:
  geography_type:
  cbsa_standard_vintage:
  cbsa_delineation_vintage:
  county_membership_source:
  county_membership_vintage:
  boundary_product:
  boundary_product_url_or_catalogue_path:
  boundary_file_name_or_layer:
  boundary_geometry_status: not_archived
  source_authority_caveat:
  commuting_data_vintage:
  pandemic_or_remote_work_caveat:
  county_coarseness_review:
  cross_state_or_multi_agency_complexity:
  population_product:
  population_product_url_or_table_path:
  acs_estimate_period:
  population_field:
  direct_cbsa_or_county_aggregation_method:
  margin_of_error_or_uncertainty_handling:
  accepted_denominator_value: false
  service_overlay_sources:
  ntd_reporters_or_gtfs_feeds:
  national_transit_map_use:
  missing_modes_or_services:
  license_or_reuse_terms:
  evidence_manifest_status: not_created
  extraction_decision:
  blockers:
```

## Step 1. Verify CBSA Identifier And Delineation

Find official OMB/Census sources that identify the
Portland-Vancouver-Hillsboro CBSA/MSA row.

Required:

- exact CBSA/MSA name;
- exact CBSA code;
- standard vintage;
- delineation vintage;
- county membership;
- state identifiers;
- release/update date.

Do not accept:

- Wikipedia;
- local transit-agency service maps;
- ERS CZ membership as a substitute for CBSA membership;
- NTD agency service areas;
- search-result snippets;
- uncited Deep Research claims.

## Step 2. Verify Boundary Artifact

Identify the official Census boundary product and layer/file that contains the
CBSA geometry.

Required:

- product title;
- catalogue or download path;
- release/vintage;
- file/layer name;
- identifier field that joins to the CBSA row;
- license or reuse terms.

Do not download or archive the raw boundary artifact until an evidence manifest
is created.

## Step 3. Verify ACS Population Denominator Path

Identify the ACS population path for the same geography.

Required:

- whether ACS direct CBSA geography is available and fit for use;
- selected ACS estimate period;
- selected resident-population field;
- county aggregation method if direct CBSA geography is not used;
- margin-of-error or uncertainty handling;
- mismatch notes if CBSA delineation and ACS geography vintages differ.

Do not accept or copy a population value at this workflow stage.

## Step 4. Verify CBSA Caveats

Record whether the CBSA creates denominator risk:

- county-scale rural or exurban overreach;
- cross-state counties;
- multi-agency governance and service geography;
- OMB statistical-use caveat;
- commuting-data vintage;
- pandemic/remote-work caveat;
- overlap with ERS CZ or alternative boundary.

If a source does not show whether a caveat applies, record `unknown`, not
`none`.

## Step 5. Verify Service-Overlay Implication

Identify service-source questions before any readiness promotion:

- Which NTD reporters are located in or materially serve the CBSA?
- Which static GTFS links are available through FTA/NTD GTFS Weblinks?
- Is BTS National Transit Map useful as an overlay or validation source for
  fixed-route coverage?
- Are regional GTFS feeds present, and do they represent all relevant NTD
  reporters?
- Are ferry, demand-responsive, paratransit, vanpool, intercity, airport,
  private, or other non-fixed-route services material but excluded?
- Could fixed-route feed coverage hide unserved county population?

Service geography cannot define the MTR.

## Decision Classes

Allowed extraction decisions:

- `exact_boundary_verified_ready_for_blocked_readiness_review`
- `blocked_exact_cbsa_not_found`
- `blocked_county_membership_unresolved`
- `blocked_boundary_product_unresolved`
- `blocked_population_product_unresolved`
- `blocked_service_overlay_unresolved`
- `quarantined_county_coarseness_overreach`
- `quarantined_source_conflict`

No decision here admits Portland-Vancouver-Hillsboro or creates a boundary
record.

## Manifest Trigger

No evidence manifest is created by this workflow.

Manifest required before:

- archiving CBSA delineation or membership files;
- archiving Census boundary files;
- archiving ACS tables;
- archiving FTA/NTD GTFS Weblinks rows, National Transit Map files, or GTFS
  feeds;
- extracting and storing accepted population values;
- joining boundary, population, and service artifacts;
- creating any filled boundary record or method test.

## Next Allowed Output

Allowed:

- external research handoff for Portland-Vancouver-Hillsboro CBSA exact
  boundary/source bundle;
- exact-boundary extraction note if official source rows are independently
  inspected;
- service-source trace plan for cross-state FTA/NTD reporter and GTFS feed
  coverage.

## Prohibited Outputs

This workflow does not authorize:

- admitted MTR;
- exact Portland-Vancouver-Hillsboro CBSA boundary acceptance without source
  inspection;
- filled boundary record;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted denominator value;
- raw data archive without manifest.
