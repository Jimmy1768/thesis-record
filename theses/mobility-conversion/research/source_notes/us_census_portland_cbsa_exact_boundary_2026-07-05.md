# U.S. Census Portland-Vancouver-Hillsboro CBSA Exact Boundary Source Note

Date inspected: 2026-07-05

Verification status: `directly_inspected_official_source`

Source:

- Title or dataset: 2023 OMB/Census CBSA delineation file `list1_2023.xlsx`
  and TIGER/Line 2023 CBSA boundary ZIP path
- Authority or publisher: U.S. Census Bureau, using OMB statistical area
  delineations
- URL, DOI, document identifier, archive path, API endpoint, or access path:
  - `https://www2.census.gov/programs-surveys/metro-micro/geographies/reference-files/2023/delineation-files/`
  - `https://www2.census.gov/programs-surveys/metro-micro/geographies/reference-files/2023/delineation-files/list1_2023.xlsx`
  - `https://www2.census.gov/geo/tiger/TIGER2023/CBSA/tl_2023_us_cbsa.zip`
- Release date, source vintage, or version:
  - 2023 delineation files directory lists `list1_2023.xlsx`, modified
    2023-08-04.
  - TIGER 2023 CBSA ZIP response last-modified: 2024-08-19.

Status: independently inspected source note. This note does not admit an MTR,
accept an outcome metric, create an evidence manifest, authorize raw data
archiving, calculate scores, rank MTRs, or make final paper claims.

## Source Authority

The U.S. Census Bureau publishes the official metro/micro delineation files and
TIGER boundary files used here. The delineations are OMB statistical-area
definitions.

## What The Source Defines

The 2023 Census delineation workbook was inspected transiently outside the
repo. It identifies the Portland lead as:

```yaml
portland_cbsa:
  CBSA_code: "38900"
  CBSA_title: "Portland-Vancouver-Hillsboro, OR-WA"
  CBSA_type: "Metropolitan Statistical Area"
  CSA_code: "440"
  CSA_title: "Portland-Vancouver-Salem, OR-WA"
  raw_workbook_archived_in_repo: false
```

The inspected workbook rows identify county membership:

```yaml
counties:
  - county: Clackamas County
    state: Oregon
    state_fips: "41"
    county_fips: "005"
    central_or_outlying: Central
  - county: Columbia County
    state: Oregon
    state_fips: "41"
    county_fips: "009"
    central_or_outlying: Outlying
  - county: Multnomah County
    state: Oregon
    state_fips: "41"
    county_fips: "051"
    central_or_outlying: Central
  - county: Washington County
    state: Oregon
    state_fips: "41"
    county_fips: "067"
    central_or_outlying: Central
  - county: Yamhill County
    state: Oregon
    state_fips: "41"
    county_fips: "071"
    central_or_outlying: Outlying
  - county: Clark County
    state: Washington
    state_fips: "53"
    county_fips: "011"
    central_or_outlying: Central
  - county: Skamania County
    state: Washington
    state_fips: "53"
    county_fips: "059"
    central_or_outlying: Outlying
```

The official TIGER 2023 CBSA ZIP path responded with HTTP 200 and content type
`application/zip`. The raw geometry was not downloaded or archived.

## Source Function For Mobility Conversion

- `boundary_source_family`
- `population_denominator_source`
- `methodology_reference`

## Boundary / Denominator Role

- MTR boundary source: candidate primary boundary source family for the
  Portland-Vancouver-Hillsboro CBSA lead, pending county-coarseness and
  boundary-fit review.
- Resident-population denominator source: candidate denominator source family
  only; this note does not verify any ACS or Census population value.
- Overlay or input only: FTA/NTD, BTS, GTFS, routes, stops, agencies, service
  areas, and fare zones remain overlays only.
- Service-derived denominator risk: downstream only if transit service coverage
  replaces the independent CBSA boundary.

## Outcome / Axis Role

- Outcome dimensions supported: none directly.
- Explanatory axes supported: possible future governance-fit or demand-intensity
  context only after separate methodology gates.
- Risk of confusing outcome with explanatory axis: low in this source note.

## Data Availability

- Geography: Core-Based Statistical Area / Metropolitan Statistical Area.
- Spatial unit: county-based CBSA, with TIGER 2023 CBSA geometry available.
- Time period or release vintage: 2023 OMB/Census delineation; TIGER 2023
  boundary file.
- Update frequency: not reviewed beyond the inspected 2023 release.
- Access method: public Census directory, downloadable workbook, and TIGER ZIP
  path. No raw artifact was archived.
- License or usage constraint: not fully reviewed in this note.

## Relevance To Mobility Conversion

This note independently verifies CBSA code `38900`, the official title, the
MSA class, CSA affiliation, and county membership. It supports later
county-coarseness and service-overlay review.

It does not decide whether a county-based CBSA is acceptable as an MTR
denominator.

## Limitations

- The delineation workbook was inspected transiently and not archived in the
  repo.
- TIGERweb REST queries failed locally with TLS/network code 35, so live
  service-layer row verification is blocked in this pass.
- TIGER ZIP availability was checked by HEAD only; raw geometry was not
  downloaded, hashed, or inspected.
- ACS population denominator, MOE handling, and direct-vs-county aggregation
  choice remain unresolved.
- County coarseness is material because Columbia, Yamhill, and Skamania are
  outlying counties and may create rural/exurban inclusion risks.
- Cross-state service and governance overlay remain unresolved.

## Suitability Judgment

Suitability: `candidate_primary_boundary`

Rationale:

The Census/OMB delineation workbook directly verifies the official CBSA code,
title, type, CSA, county membership, and central/outlying status. Suitability is
conditional on boundary-fit review, population-denominator verification, and
service-overlay review.

## Extraction Decision

```yaml
portland_cbsa_exact_boundary_extraction:
  lead_id: mtr_src_007
  working_name: Portland-Vancouver-Hillsboro CBSA
  source_authority: U.S. Census Bureau / OMB
  exact_name: Portland-Vancouver-Hillsboro, OR-WA
  exact_code: "38900"
  geography_type: Metropolitan Statistical Area
  delineation_vintage: "2023"
  boundary_product: "TIGER2023 CBSA"
  boundary_product_url_or_catalogue_path: "https://www2.census.gov/geo/tiger/TIGER2023/CBSA/tl_2023_us_cbsa.zip"
  boundary_geometry_status: not_archived
  population_product: unresolved
  population_field: unresolved
  accepted_denominator_value: false
  county_membership_status: verified_from_transient_official_workbook_inspection
  service_overlay_source: unresolved
  service_coverage_against_boundary: unresolved
  evidence_manifest_status: not_created
  extraction_decision: exact_boundary_membership_verified_boundary_population_and_fit_blocked
  blockers:
    - raw_TIGER_geometry_not_archived
    - ACS_population_denominator_not_verified
    - county_coarseness_review_not_done
    - cross_state_service_overlay_unresolved
    - TIGERweb_REST_query_blocked_by_local_tls_error
```

## Methodology Implication

Portland should not return to ChatGPT for the exact CBSA membership question.
The next work should decide whether county-based official statistical metros
require a standard county-coarseness screen before any not-admitted boundary
record can be drafted.

## Next Allowed Output

Choose one:

- source-note follow-up.

Specific next follow-up:

- verify ACS direct CBSA population denominator and MOE handling;
- review TIGER geometry under a draft evidence manifest if raw geometry is
  about to be acquired;
- run a county-coarseness readiness screen;
- inventory cross-state service-source coverage for Oregon and Washington
  operators.

## Prohibited Outputs

This source note does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted population value;
- filled boundary record;
- raw data archive without manifest.
