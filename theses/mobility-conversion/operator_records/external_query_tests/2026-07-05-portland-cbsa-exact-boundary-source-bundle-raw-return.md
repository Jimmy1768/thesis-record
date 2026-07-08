# Raw Return: Portland-Vancouver-Hillsboro CBSA Exact Boundary / Source Bundle

Date: 2026-07-05

Thesis: Thesis 2 — Mobility Conversion

Status: raw_research_material_only

This return is not evidence, not source truth, not an accepted MTR, not a candidate-universe record, not a boundary record, not a metric record, not a score, and not a ranking.

Terminology: Metropolitan Transport Region / MTR.

Scope limits followed:

- No city ranking.
- No candidate selection.
- No transport-quality claim.
- No score or metric calculation.
- No raw dataset download or archive.
- No service geography used as denominator.
- GTFS, FTA/NTD, BTS National Transit Map, agency routes, stops, fare zones, and service areas are treated only as service-source overlays or indicator inputs.

---

## 1. Short method summary

This pass checked official or primary source paths for the Portland-Vancouver-Hillsboro CBSA lead `mtr_src_007`.

The boundary path is source-led from OMB / U.S. Census Bureau Core Based Statistical Area sources. The source family is `official_statistical_metro`, not an observed functional urban area and not a service-derived geography.

No raw files were downloaded. Exact rows, schemas, and live feed reachability still require later evidence-manifest acquisition and archive.

The main verified posture is:

```yaml
working_name: Portland-Vancouver-Hillsboro MSA
source_family: official_statistical_metro
source_authority: OMB / U.S. Census Bureau
exact_cbsa_code_found: "38900"
exact_boundary_status: source_path_and_code_found__raw_boundary_not_archived
population_path_status: direct_ACS_CBSA_geography_available__raw_value_not_returned
service_overlay_status: plausible_multi_operator_bundle__current_NTD_rows_not_archived
```

---

## 2. Source table

| Source family | Source title / authority | URL / access path | Use in this return | Status / limits |
|---|---|---|---|---|
| OMB / Census CBSA delineation | Census Metropolitan and Micropolitan Delineation Files, 2023 List 1 | `https://www.census.gov/geographies/reference-files/time-series/demo/metro-micro/delineation-files.html` and `https://www2.census.gov/programs-surveys/metro-micro/geographies/reference-files/2023/delineation-files/list1_2023.xlsx` | Direct name/code/county-membership source path for CBSA `38900` | Exact workbook row not downloaded or archived in this return |
| OMB Bulletin | OMB Bulletin No. 23-01, Revised Delineations of Metropolitan Statistical Areas, Micropolitan Statistical Areas, and Combined Statistical Areas | `https://www.whitehouse.gov/wp-content/uploads/2023/07/OMB-Bulletin-23-01.pdf` | Delineation vintage, official statistical context, county membership source path | PDF not archived here; use for later manifest |
| Census CBSA concepts | U.S. Census Bureau glossary / metro-micro guidance | `https://www.census.gov/programs-surveys/metro-micro/about/glossary.html` and `https://www.census.gov/programs-surveys/geography/guidance/geo-areas/metro-micro.html` | Defines CBSA/MSA, county building blocks, commuting integration, OMB role | Concept source, not a geometry file |
| Census boundary products | TIGER/Line Shapefiles, Core Based Statistical Areas | `https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html` and likely `https://www2.census.gov/geo/tiger/TIGER2023/CBSA/tl_2023_us_cbsa.zip` | Official detailed CBSA geometry source path | Raw file and schema not downloaded here |
| Census cartographic boundary products | Cartographic Boundary Files, Core Based Statistical Areas | `https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html` and `https://www2.census.gov/geo/tiger/GENZ2023/shp/cb_2023_us_cbsa_500k.zip` | Simplified CBSA geometry for mapping / overlay | Simplified geometry, not the highest-resolution boundary source |
| Census county boundaries | TIGER/Line Shapefiles, Counties | `https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html` and likely `https://www2.census.gov/geo/tiger/TIGER2023/COUNTY/tl_2023_us_county.zip` | County aggregation fallback and county-level overlay | Raw file not downloaded; exact field schema to verify |
| ACS population | 2024 ACS 1-Year Detailed Tables / Data Profiles | `https://www.census.gov/data/developers/data-sets/acs-1year/2024.html` | Resident population denominator path for CBSA `38900` | Direct CBSA geography appears available; no value returned |
| ACS uncertainty | ACS margin-of-error guidance / ACS handbook source family | `https://www.census.gov/programs-surveys/acs/guidance/handbooks.html` | MOE handling for direct estimate or county aggregation fallback | Formula and VRE handling should be recorded in later source note |
| FTA / NTD GTFS inventory | General Transit Feed Specification Weblinks | `https://data.transportation.gov/Public-Transit/General-Transit-Feed-Specification-Weblinks/2u7n-ub22/about_data` and `https://catalog.data.gov/dataset/2023-ntd-annual-data-general-transit-feed-specification-gtfs-weblinks` | U.S. fixed-route GTFS feed inventory and feed-discovery source | Current rows not fetched; excludes demand response, vanpool, and non-fixed-route modes |
| BTS National Transit Map | BTS National Transit Map / NTAD Agencies, Routes, Stops | `https://www.bts.gov/national-transit-map` | Fixed-route/fixed-guideway overlay and validation source | Quarterly overlay; not a denominator and not a complete real-time source |
| Local fixed-route sources | TriMet, C-TRAN, SMART, Canby Area Transit, Sandy Area Metro, Yamhill County Transit, Columbia County Rider, Skamania County Transit source pages | URLs listed below | Candidate service-source bundle inside the CBSA | Materiality and current GTFS row verification unresolved |

---

## 3. YAML-style raw source bundle

```yaml
portland_cbsa_exact_boundary_return:
  return_status: raw_research_material_only

  reviewed_boundary:
    working_name: Portland-Vancouver-Hillsboro MSA
    source_authority: OMB / U.S. Census Bureau
    exact_name: Portland-Vancouver-Hillsboro, OR-WA Metropolitan Statistical Area
    exact_code: "38900"
    geography_type: Core Based Statistical Area / Metropolitan Statistical Area; county-based official statistical metro
    source_url_or_access_path:
      - https://www.census.gov/geographies/reference-files/time-series/demo/metro-micro/delineation-files.html
      - https://www2.census.gov/programs-surveys/metro-micro/geographies/reference-files/2023/delineation-files/list1_2023.xlsx
      - https://www.whitehouse.gov/wp-content/uploads/2023/07/OMB-Bulletin-23-01.pdf
      - https://www.census.gov/programs-surveys/metro-micro/about/glossary.html
      - https://www.census.gov/programs-surveys/geography/guidance/geo-areas/metro-micro.html
    verification_status: source_path_and_code_found_from_official_sources__exact_workbook_row_not_archived

  delineation_and_membership:
    source_title: 2023 OMB/Census CBSA delineation files; OMB Bulletin No. 23-01
    source_url_or_access_path:
      - https://www.census.gov/geographies/reference-files/time-series/demo/metro-micro/delineation-files.html
      - https://www2.census.gov/programs-surveys/metro-micro/geographies/reference-files/2023/delineation-files/list1_2023.xlsx
      - https://www.whitehouse.gov/wp-content/uploads/2023/07/OMB-Bulletin-23-01.pdf
    standard_vintage: 2020 Standards for Delineating Core Based Statistical Areas
    delineation_vintage: July 2023 OMB delineations based on 2020 standards, 2020 Census data, 2016-2020 ACS commuting data, and Vintage 2021 Population Estimates Program data
    county_list:
      - county_name: Clackamas County
        state: OR
        state_fips: "41"
        county_fips: "005"
        geoid: "41005"
        central_or_outlying_status: requires_official_row_extraction
      - county_name: Columbia County
        state: OR
        state_fips: "41"
        county_fips: "009"
        geoid: "41009"
        central_or_outlying_status: requires_official_row_extraction
      - county_name: Multnomah County
        state: OR
        state_fips: "41"
        county_fips: "051"
        geoid: "41051"
        central_or_outlying_status: requires_official_row_extraction
      - county_name: Washington County
        state: OR
        state_fips: "41"
        county_fips: "067"
        geoid: "41067"
        central_or_outlying_status: requires_official_row_extraction
      - county_name: Yamhill County
        state: OR
        state_fips: "41"
        county_fips: "071"
        geoid: "41071"
        central_or_outlying_status: requires_official_row_extraction
      - county_name: Clark County
        state: WA
        state_fips: "53"
        county_fips: "011"
        geoid: "53011"
        central_or_outlying_status: requires_official_row_extraction
      - county_name: Skamania County
        state: WA
        state_fips: "53"
        county_fips: "059"
        geoid: "53059"
        central_or_outlying_status: requires_official_row_extraction
    county_identifier_fields:
      - cbsa_code
      - cbsa_title
      - metropolitan_or_micropolitan_statistical_area
      - state_name_or_abbreviation
      - county_name
      - state_fips
      - county_fips
      - county_geoid
      - central_or_outlying_status_if_present
    release_or_update_date: OMB Bulletin No. 23-01 dated 2023-07-21; Census 2023 delineation files page/source path to verify exact file timestamp later
    verification_status: code_and_county_list_found_from_official_source_paths__raw_rows_not_archived

  boundary_artifact:
    product_title:
      - TIGER/Line Shapefile, 2023, Nation, U.S., Core Based Statistical Areas
      - Cartographic Boundary File, 2023, U.S., Core Based Statistical Areas, 1:500,000
    catalogue_or_download_path:
      - https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html
      - https://www2.census.gov/geo/tiger/TIGER2023/CBSA/tl_2023_us_cbsa.zip
      - https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html
      - https://www2.census.gov/geo/tiger/GENZ2023/shp/cb_2023_us_cbsa_500k.zip
    file_or_layer:
      - tl_2023_us_cbsa.shp
      - cb_2023_us_cbsa_500k.shp
    vintage: "2023"
    identifier_field: CBSAFP / GEOID likely; exact schema requires raw boundary download and manifest inspection
    license_or_reuse_terms: U.S. Census public geospatial data; exact reuse note to verify in later source manifest
    raw_download_required_later: true

  population_denominator:
    source_title: 2024 ACS 1-Year Detailed Tables / Data Profiles
    source_url_or_access_path:
      - https://www.census.gov/data/developers/data-sets/acs-1year/2024.html
      - https://api.census.gov/data/2024/acs/acs1
      - https://api.census.gov/data/2024/acs/acs1/profile
      - https://data.census.gov/
    geography_identifier: CBSA / metropolitan statistical area-micropolitan statistical area code 38900
    population_field:
      preferred: B01003_001E
      preferred_moe: B01003_001M
      alternative_profile_field: DP05_0001E
      alternative_profile_moe: DP05_0001M
    acs_estimate_period: 2024 ACS 1-year
    direct_cbsa_or_county_aggregation_method: direct_CBSA_geography_preferred; county_aggregation_fallback_only_if_direct_CBSA_query_or_table_path_fails_or_if_county-level reconciliation_is_required
    margin_of_error_or_uncertainty_handling: use direct ACS MOE when using direct CBSA estimate; if aggregating county ACS estimates, combine MOEs using Census ACS derived-estimate guidance and record approximation/covariance limitations; use ACS Variance Replicate Estimates if a high-confidence aggregate is required
    value_returned: do_not_return_value_unless_needed_for_source_identification
    verification_status: official_ACS_source_path_found__live_value_not_fetched_or_archived

  cbsa_caveats:
    source_authority_caveat: OMB CBSA delineations are for federal statistical collection/tabulation/presentation and are not automatically appropriate as general-purpose program, governance, or transport-service boundaries.
    commuting_data_vintage: Current delineations use the 2020 standards and include 2016-2020 ACS commuting inputs, alongside 2020 Census and Vintage 2021 population-estimate inputs.
    pandemic_or_remote_work_caveat: The 2016-2020 ACS window includes the first pandemic year; no Portland-specific remote-work boundary adjustment was verified in this pass. Record a general commuting-vintage caveat rather than rejecting the CBSA boundary family.
    rural_or_exurban_overreach_risk:
      - County-based CBSA geometry can over-include rural or exurban territory relative to an MTR transport denominator.
      - Columbia County, Yamhill County, and Skamania County are higher-risk overreach / weak-integration counties for later overlay review.
      - Rural portions of central counties may also matter because the unit is county based, not tract or municipality based.
    cross_state_or_multi_agency_complexity:
      - Cross-state OR-WA geography.
      - Multiple state legal/funding/data environments.
      - Multiple transit agencies and smaller county/municipal systems.
    weakly_integrated_counties:
      - Columbia County, OR: flag_for_central_outlying_and_service_overlay_verification
      - Yamhill County, OR: flag_for_central_outlying_and_service_overlay_verification
      - Skamania County, WA: flag_for_central_outlying_and_service_overlay_verification
    source_url_or_access_path:
      - https://www.census.gov/programs-surveys/geography/guidance/geo-areas/metro-micro.html
      - https://www.census.gov/programs-surveys/metro-micro/about/glossary.html
      - https://www.whitehouse.gov/wp-content/uploads/2023/07/OMB-Bulletin-23-01.pdf
      - https://www.census.gov/geographies/reference-files/time-series/demo/metro-micro/delineation-files.html

  service_source_bundle:
    fta_ntd_gtfs_weblinks_source:
      source_authority: Federal Transit Administration / National Transit Database
      source_url_or_access_path:
        - https://data.transportation.gov/Public-Transit/General-Transit-Feed-Specification-Weblinks/2u7n-ub22/about_data
        - https://catalog.data.gov/dataset/2023-ntd-annual-data-general-transit-feed-specification-gtfs-weblinks
        - https://www.transit.dot.gov/ntd
      format: Socrata table / CSV export / API; GTFS feed URLs are agency-submitted links to GTFS static zip files
      vintage_or_update_date: current GTFS weblinks table reported as refreshed monthly; specific snapshot not fetched in this pass
      license_or_access_terms: public-domain/public GTFS reporting posture per NTD source; agency-hosted feed terms may vary and must be checked per feed
      coverage_against_CBSA: unresolved; use as fixed-route feed-discovery inventory only, not as denominator

    bts_national_transit_map_source:
      source_authority: Bureau of Transportation Statistics / U.S. Department of Transportation
      source_url_or_access_path:
        - https://www.bts.gov/national-transit-map
        - https://data-usdot.opendata.arcgis.com/search?collection=Dataset&tags=NTM
      format: NTAD geospatial layers for agencies, routes, and stops derived from GTFS Schedule data
      vintage_or_update_date: quarterly updates; exact version not fetched here
      coverage_against_CBSA: useful fixed-route/fixed-guideway overlay and validation source; not complete for non-fixed-route services and not a denominator

    ntd_reporters_or_gtfs_feeds:
      - agency_or_source: TriMet / Tri-County Metropolitan Transportation District of Oregon
        materiality_reason: primary fixed-route provider for Portland urbanized core and major parts of Multnomah, Washington, and Clackamas counties
        source_url_or_access_path:
          - https://developer.trimet.org/GTFS.shtml
          - http://developer.trimet.org/schedule/gtfs.zip
          - https://www.transit.dot.gov/ntd/transit-agency-profiles/trimet
        notes: NTD ID 00008 appears in FTA profile source path; current NTD GTFS Weblinks row still requires snapshot verification.
      - agency_or_source: C-TRAN / Clark County Public Transportation Benefit Area
        materiality_reason: fixed-route service for Clark County, WA, and cross-state Portland-Vancouver travel
        source_url_or_access_path:
          - https://www.c-tran.com/about-c-tran/business/procurement/bids-rfps-sole-sources/terms-and-conditions/gtfs-data
          - https://mail.c-tran.com/images/Google/GoogleTransitUpload.zip
        notes: Current NTD ID/feed row should be verified from FTA/NTD GTFS Weblinks snapshot; source path is official agency GTFS page plus current feed lead.
      - agency_or_source: SMART / South Metro Area Regional Transit / City of Wilsonville
        materiality_reason: Wilsonville fixed-route, commuter/regional connections, and local demand-responsive services in Clackamas/Washington edge context
        source_url_or_access_path:
          - https://www.wilsonvilleoregon.gov/smart/page/routes-schedules
          - https://passio3.com/smart/passioTransit/gtfs/google_transit.zip
        notes: GTFS/feed lead requires official NTD Weblinks row verification; demand-responsive services are outside static GTFS coverage.
      - agency_or_source: Canby Area Transit
        materiality_reason: local and regional fixed-route service in Canby / Oregon City / Woodburn corridor plus paratransit or Dial-A-Ride services
        source_url_or_access_path:
          - https://www.canbyoregon.gov/area-transit/page/routes-and-services
          - https://oregon-gtfs.trilliumtransit.com/gtfs_data/canbytransit-or-us/canbytransit-or-us.zip
        notes: GTFS/feed lead requires current NTD or agency-source verification; non-fixed-route services require separate handling.
      - agency_or_source: Sandy Area Metro / SAM
        materiality_reason: fixed-route and demand-response service in Sandy / Clackamas County edge context, including regional connections
        source_url_or_access_path:
          - https://www.ci.sandy.or.us/transit/page/sam-routes-services
          - https://www.rideclackamas.org/providers/sandy-area-metro-sam/
          - https://passio3.com/sandyor/passioTransit/gtfs/google_transit.zip
        notes: GTFS/feed lead requires current NTD or agency-source verification; SAM Rides demand-response is outside normal static GTFS.
      - agency_or_source: Yamhill County Transit / YCBus
        materiality_reason: Yamhill County fixed-route and demand-response services, including commuter links toward Hillsboro/Tigard/West Salem/Grand Ronde
        source_url_or_access_path:
          - https://ycbus.org/
          - http://ycta.connexionz.net/rtt/public/resource/gtfs.zip
          - https://www.transit.dot.gov/ntd/transit-agency-profiles/yamhill-county-transit-area
        notes: NTD ID 00321 appears in source-path snippets; current NTD GTFS row and feed status still require snapshot verification.
      - agency_or_source: Columbia County Rider / CC Rider
        materiality_reason: Columbia County fixed-route and dial-a-ride services with Portland / Kelso-Longview links; important for county-overreach and outer-area service assessment
        source_url_or_access_path:
          - https://www.columbiacountyor.gov/departments/Transit/Columbia-County-Rider
          - https://www.nwconnector.org/routes/columbia-county-rider/
          - https://oregon-gtfs.trilliumtransit.com/gtfs_data/columbiacounty-or-us/columbiacounty-or-us.zip
        notes: Current NTD ID/feed row should be verified through FTA/NTD; dial-a-ride is outside fixed-route GTFS.
      - agency_or_source: Skamania County Transit / Skamania County Senior Services
        materiality_reason: Skamania County fixed-route and Dial-A-Ride service; important because Skamania is a high-risk county-coarseness/outlying-county case
        source_url_or_access_path:
          - https://gorgetransit.com/providers/skamania-county-transit/
          - https://data.trilliumtransit.com/gtfs/skamaniacounty-wa-us/skamaniacounty-wa-us.zip
          - https://wsdot.wa.gov/travel/public-transportation/about-gtfs-transit-data
        notes: Current NTD ID/feed row should be verified through FTA/NTD or WSDOT GTFS directory; Dial-A-Ride is outside fixed-route GTFS.

    regional_feed_notes:
      - TriMet GTFS may include or reference partner services such as Portland Streetcar and Portland Aerial Tram in some feed/catalog contexts; this must be verified from the official feed contents after acquisition.
      - Oregon regional GTFS feeds hosted by Trillium/oregon-gtfs and Washington GTFS feeds indexed by WSDOT are useful source leads, but the authoritative NTD/Weblinks snapshot should be used for U.S. fixed-route reporter inventory.
      - NW Connector and Gorge Transit are regional coordination/consumer-information overlays, not MTR boundaries.

    missing_operators_or_modes:
      - Demand response, paratransit, and vanpool are excluded from the FTA/NTD GTFS Weblinks source family and require separate mode notes.
      - TriMet LIFT, C-TRAN paratransit/demand-responsive service, SMART Dial-a-Ride, Canby Dial-A-Ride, SAM Rides, Yamhill reserved ride/paratransit, Columbia County Dial-A-Ride, and Skamania Dial-A-Ride are likely material for accessibility/resilience context but not represented as ordinary fixed-route static GTFS.
      - Intercity rail, Amtrak, intercity bus, airport/private shuttle, school-only services, and private employer shuttles are quarantined unless a later indicator explicitly includes them.
      - Regular passenger ferry materiality inside the CBSA was not verified in this pass.

  rejected_or_quarantined_material:
    - item: TriMet service district / C-TRAN service district / agency service areas
      reason: service or governance geography; cannot define MTR denominator
    - item: GTFS route/stops/shape extent
      reason: service-derived geometry can hide unserved population; indicator input only
    - item: BTS National Transit Map agency/route/stop extent
      reason: fixed-route overlay only; cannot define boundary or denominator
    - item: NW Connector / Gorge Transit pass or consumer network geography
      reason: useful coordination overlay, not an official statistical metro or functional-region denominator
    - item: direct local-reputation or transport-reputation claims
      reason: prohibited by prompt and irrelevant to source-bundle verification
```

---

## 4. Exact CBSA code, delineation, and county membership findings

### Exact CBSA / MSA name and code

```yaml
exact_name: Portland-Vancouver-Hillsboro, OR-WA Metropolitan Statistical Area
exact_cbsa_code: "38900"
source_family: official_statistical_metro
source_authority: OMB / U.S. Census Bureau
```

Official source paths that map the name to the CBSA code:

```text
https://www.census.gov/geographies/reference-files/time-series/demo/metro-micro/delineation-files.html
https://www2.census.gov/programs-surveys/metro-micro/geographies/reference-files/2023/delineation-files/list1_2023.xlsx
https://www.whitehouse.gov/wp-content/uploads/2023/07/OMB-Bulletin-23-01.pdf
```

### Standard and delineation vintage

```yaml
standard_vintage: 2020 Standards for Delineating Core Based Statistical Areas
delineation_vintage: July 2023 OMB delineations / OMB Bulletin No. 23-01
source_inputs_reported_by_Census:
  - 2020 standards
  - 2020 Census data
  - 2016-2020 ACS commuting data
  - Vintage 2021 Population Estimates Program data
```

### County membership

| County | State | State FIPS | County FIPS | County GEOID | Notes |
|---|---:|---:|---:|---:|---|
| Clackamas County | OR | 41 | 005 | 41005 | Official row extraction still needed for central/outlying field |
| Columbia County | OR | 41 | 009 | 41009 | Higher county-coarseness / exurban-overreach risk |
| Multnomah County | OR | 41 | 051 | 41051 | Official row extraction still needed for central/outlying field |
| Washington County | OR | 41 | 067 | 41067 | Official row extraction still needed for central/outlying field |
| Yamhill County | OR | 41 | 071 | 41071 | Higher county-coarseness / exurban-overreach risk |
| Clark County | WA | 53 | 011 | 53011 | Cross-state service/governance complexity |
| Skamania County | WA | 53 | 059 | 53059 | Higher county-coarseness / exurban-overreach risk |

Unresolved item:

```yaml
central_or_outlying_status: requires official List 1 row extraction and archive
```

Do not infer county weakness from central/outlying status until the official rows are archived. The risk notes above are transport-access denominator risks, not official OMB classifications.

---

## 5. Boundary/population artifact findings

### CBSA geometry

Recommended later boundary artifacts:

```yaml
preferred_detailed_geometry:
  product_title: TIGER/Line Shapefile, 2023, Nation, U.S., Core Based Statistical Areas
  likely_download_path: https://www2.census.gov/geo/tiger/TIGER2023/CBSA/tl_2023_us_cbsa.zip
  use: detailed official CBSA geometry for boundary manifest
  caveat: exact schema and row must be inspected after raw download

mapping_or_lightweight_overlay_geometry:
  product_title: Cartographic Boundary File, 2023, U.S., Core Based Statistical Areas, 1:500,000
  download_path: https://www2.census.gov/geo/tiger/GENZ2023/shp/cb_2023_us_cbsa_500k.zip
  use: simplified map/overlay geometry
  caveat: simplified for small-scale thematic mapping; do not substitute if detailed TIGER boundary is required
```

Expected identifier fields to verify after raw file acquisition:

```yaml
candidate_identifier_fields:
  - CBSAFP
  - GEOID
  - NAME
  - NAMELSAD
  - LSAD
  - MEMI
  - ALAND
  - AWATER
```

Schema status:

```yaml
schema_verified: false
reason: raw shapefile not downloaded in this pass
```

### County geometry for aggregation fallback

If a county aggregation fallback or county-coarseness worksheet is needed, use Census TIGER/Line county geometries:

```yaml
product_title: TIGER/Line Shapefile, Counties
likely_download_path: https://www2.census.gov/geo/tiger/TIGER2023/COUNTY/tl_2023_us_county.zip
identifier_fields_to_verify:
  - STATEFP
  - COUNTYFP
  - GEOID
  - NAME
  - NAMELSAD
raw_download_required_later: true
```

### ACS population denominator

Preferred source posture:

```yaml
source_title: 2024 ACS 1-Year Detailed Tables
geography: metropolitan statistical area/micropolitan statistical area
geography_code: "38900"
preferred_field: B01003_001E
preferred_field_label: Total population estimate
preferred_moe_field: B01003_001M
alternative_profile_field: DP05_0001E
alternative_profile_moe_field: DP05_0001M
value_returned: false
```

Candidate API path pattern to verify later:

```text
https://api.census.gov/data/2024/acs/acs1?get=NAME,B01003_001E,B01003_001M&for=metropolitan%20statistical%20area/micropolitan%20statistical%20area:38900
```

Direct CBSA geography is preferred because the boundary source is itself a CBSA. County aggregation should be a fallback or reconciliation method, not the primary source, unless the direct ACS CBSA query path fails or the analysis deliberately needs county-level uncertainty propagation.

MOE / uncertainty handling:

```yaml
direct_CBSA_estimate:
  use: direct ACS estimate and direct ACS MOE
county_aggregation_fallback:
  method: sum county estimates; combine MOEs using Census ACS derived-estimate guidance
  caution: simple summed-MOE formula is approximate because covariances are usually not available
  higher_confidence_option: ACS Variance Replicate Estimates, if needed
```

---

## 6. County-coarseness and caveat findings

### OMB statistical-use caveat

Record this caveat in any Portland CBSA boundary note:

```yaml
OMB_caveat: CBSA delineations are created for federal statistical purposes and should not automatically be treated as governance, program, service, or transport-planning boundaries.
```

For Thesis 2, this means:

- CBSA `38900` can be evaluated as an `official_statistical_metro` boundary source.
- It is not automatically a valid MTR denominator.
- It requires boundary-fit testing against population distribution, built-up area, commuting flows, and service-source overlays.
- The CBSA cannot be replaced by GTFS or service areas.

### County-coarseness risk

The Portland-Vancouver-Hillsboro CBSA is county-based. County-level boundaries can be too coarse for transport-access work because large rural or exurban areas may be included along with the urban core.

Higher-risk counties for later fit review:

```yaml
higher_risk_counties:
  - Columbia County, OR
  - Yamhill County, OR
  - Skamania County, WA
risk_type:
  - rural_or_exurban_overreach
  - weaker_fixed_route_coverage_possible
  - cross-jurisdiction_service_complexity
  - denominator_may_include_low-density territory outside routine urban transport catchment
verification_needed:
  - official central/outlying field extraction
  - GHSL / built-up-area overlay
  - gridded population overlay
  - fixed-route service-source overlay
  - county-level ACS commuter-flow review if later allowed
```

### Cross-state and multi-agency complexity

The CBSA spans Oregon and Washington. This creates a service-overlay risk even before any transport outcome is calculated.

```yaml
cross_state_risk:
  states:
    - Oregon
    - Washington
  likely_implications:
    - multiple state DOT data environments
    - multiple transit agencies
    - multiple funding and planning frameworks
    - different GTFS source paths
    - potential fare / service integration questions
```

### Pandemic / remote-work caveat

The current delineation uses 2016-2020 ACS commuting inputs. The 2020 ACS period intersects the initial COVID-19 disruption period. This return did not find a Portland-specific OMB/Census adjustment rule for remote work.

Recommended caveat posture:

```yaml
pandemic_remote_work_caveat:
  status: general_caveat_only
  note: commuting-flow vintage should be recorded; do not reject or adjust the CBSA boundary without a verified official rule or later thesis decision
```

---

## 7. Service/operator coverage findings

### General service-source posture

FTA/NTD GTFS Weblinks and BTS National Transit Map are useful for discovering and validating fixed-route service sources. They are not sufficient for full MTR service coverage because:

- GTFS Weblinks are fixed-route focused.
- Demand response, vanpool, and other non-fixed-route modes are excluded from the NTD GTFS Weblinks source family.
- Local agency feeds may be stale or invalid unless verified at a specific snapshot date.
- NTM is updated quarterly and can miss invalid or late submissions.
- None of these sources define the MTR denominator.

### FTA/NTD GTFS Weblinks

```yaml
source_authority: Federal Transit Administration / National Transit Database
source_name: General Transit Feed Specification Weblinks
current_table_path: https://data.transportation.gov/Public-Transit/General-Transit-Feed-Specification-Weblinks/2u7n-ub22/about_data
archived_2023_dataset_path: https://catalog.data.gov/dataset/2023-ntd-annual-data-general-transit-feed-specification-gtfs-weblinks
role: fixed-route GTFS feed-discovery inventory
refresh_posture: current table reported as refreshed monthly
coverage_limit: excludes demand response, vanpool, and other non-fixed-route modes
use_in_thesis: service-source overlay and indicator input only
raw_snapshot_required_later: true
```

### BTS National Transit Map

```yaml
source_authority: Bureau of Transportation Statistics / U.S. DOT
source_name: National Transit Map
source_path: https://www.bts.gov/national-transit-map
role: fixed-guideway and fixed-route agency/route/stop geospatial overlay from GTFS Schedule
update_posture: quarterly
use_in_thesis: overlay / validation source for fixed-route coverage
not_for: boundary definition, denominator, real-time source, complete non-fixed-route inventory
raw_snapshot_required_later: true
```

### Candidate material fixed-route operators / feeds for later reconciliation

This is a source-discovery inventory only. It is not a claim of complete coverage.

| Operator/source | Why it may be material inside CBSA | Source paths | Verification posture |
|---|---|---|---|
| TriMet | Main urban-core fixed-route provider across Portland area | `https://developer.trimet.org/GTFS.shtml`; `http://developer.trimet.org/schedule/gtfs.zip`; `https://www.transit.dot.gov/ntd/transit-agency-profiles/trimet` | Official source path found; current NTD Weblinks row still needs snapshot |
| C-TRAN | Clark County / Vancouver fixed-route and cross-state service | `https://www.c-tran.com/about-c-tran/business/procurement/bids-rfps-sole-sources/terms-and-conditions/gtfs-data`; `https://mail.c-tran.com/images/Google/GoogleTransitUpload.zip` | Official agency source path found; current NTD row/feed status unresolved |
| SMART / Wilsonville | Wilsonville local and regional/commuter service; edge/intermunicipal relevance | `https://www.wilsonvilleoregon.gov/smart/page/routes-schedules`; `https://passio3.com/smart/passioTransit/gtfs/google_transit.zip` | Feed lead found; official NTD row unresolved |
| Canby Area Transit | Canby local/99X regional service and paratransit/Dial-A-Ride context | `https://www.canbyoregon.gov/area-transit/page/routes-and-services`; `https://oregon-gtfs.trilliumtransit.com/gtfs_data/canbytransit-or-us/canbytransit-or-us.zip` | Feed lead found; current NTD row unresolved |
| Sandy Area Metro / SAM | Sandy and Clackamas edge service; Gresham/Clackamas connections and demand response | `https://www.ci.sandy.or.us/transit/page/sam-routes-services`; `https://www.rideclackamas.org/providers/sandy-area-metro-sam/`; `https://passio3.com/sandyor/passioTransit/gtfs/google_transit.zip` | Feed lead found; current NTD row unresolved |
| Yamhill County Transit / YCBus | Yamhill County service and commuter links to larger regional nodes | `https://ycbus.org/`; `http://ycta.connexionz.net/rtt/public/resource/gtfs.zip`; `https://www.transit.dot.gov/ntd/transit-agency-profiles/yamhill-county-transit-area` | Official/primary source paths found; current GTFS row unresolved |
| Columbia County Rider / CC Rider | Columbia County service and Portland / Kelso-Longview links | `https://www.columbiacountyor.gov/departments/Transit/Columbia-County-Rider`; `https://www.nwconnector.org/routes/columbia-county-rider/`; `https://oregon-gtfs.trilliumtransit.com/gtfs_data/columbiacounty-or-us/columbiacounty-or-us.zip` | Source paths found; current NTD row unresolved |
| Skamania County Transit | Skamania County service and Gorge transit links; high county-coarseness relevance | `https://gorgetransit.com/providers/skamania-county-transit/`; `https://data.trilliumtransit.com/gtfs/skamaniacounty-wa-us/skamaniacounty-wa-us.zip`; `https://wsdot.wa.gov/travel/public-transportation/about-gtfs-transit-data` | Source paths found; current NTD/WSDOT row unresolved |

### Likely missing or outside-static-GTFS services

```yaml
outside_static_GTFS_or_requires_separate_handling:
  - demand_response
  - ADA_paratransit
  - vanpool
  - school_only_services
  - private_employer_shuttles
  - airport_private_shuttles
  - intercity_bus
  - Amtrak_or_intercity_rail
  - regular_passenger_ferry_if_later_found_material
```

Non-fixed-route service examples to check later:

```yaml
examples_requiring_source_notes:
  - TriMet LIFT
  - C-TRAN paratransit / demand-responsive services
  - SMART Dial-a-Ride
  - Canby Dial-A-Ride / paratransit
  - SAM Rides demand-response
  - Yamhill reserved ride / paratransit
  - Columbia County Rider Dial-A-Ride
  - Skamania County Dial-A-Ride
```

Regional coordination sources such as NW Connector and Gorge Transit may help identify operators and consumer-facing connections, but they should be stored as overlays only.

---

## 8. Rejected/quarantined material

```yaml
rejected_or_quarantined_material:
  - item: TriMet service district as MTR boundary
    reason: governance/service geography; cannot define denominator
  - item: C-TRAN service area as MTR boundary
    reason: governance/service geography; cannot define denominator
  - item: GTFS stop/route/shape extent
    reason: service-derived geography can hide unserved population
  - item: BTS National Transit Map coverage extent
    reason: fixed-route overlay only; not a statistical or functional-region boundary
  - item: NW Connector / Gorge Transit pass geography
    reason: useful regional service/coordination overlay, not an official MTR boundary source
  - item: agency fare zones or customer-service maps
    reason: service/fare artifacts cannot replace OMB/Census denominator
  - item: Wikipedia, blogs, travel guides, livability rankings, best-transit-city material
    reason: explicitly outside prompt scope and outcome-adjacent
  - item: direct transport-quality conclusions about Portland
    reason: not requested and prohibited by raw-return status
```

---

## 9. Open questions for Thesis 2

1. Should CBSA `38900` remain in `official_statistical_metro` class only, or can it become an MTR denominator after county-coarseness review?
2. What exact boundary-fit tests are required before admitting a county-based CBSA as an MTR denominator?
3. Should the detailed TIGER/Line CBSA file or the cartographic boundary file be the default raw geometry for CBSA proposals?
4. Should ACS direct CBSA population be preferred over county aggregation for CBSA boundaries, even if service overlays are county/operator based?
5. What is the acceptable handling of ACS MOE when the direct CBSA estimate is available but later derived subarea checks require county or tract aggregation?
6. Should central/outlying county status be stored as required metadata for every CBSA boundary proposal?
7. Should Columbia, Yamhill, and Skamania receive mandatory built-up-area / gridded-population overlays before any Portland CBSA admission decision?
8. What threshold determines whether a small fixed-route agency inside a CBSA is “material” for service-source completeness?
9. Should NTD GTFS Weblinks be the controlling U.S. feed inventory, with agency pages used only to confirm or supplement broken links?
10. Should BTS National Transit Map be archived as a separate overlay after FTA/NTD Weblinks, or only used for validation?
11. Should intercity rail/bus and airport services be excluded by default from V1 local transport indicators, or stored as an optional external-access module?
12. How should demand-responsive and ADA/paratransit services be recorded when they are material for universal access but outside static GTFS coverage?
13. Should the 2016-2020 ACS commute-flow input vintage trigger a standard post-2020 remote-work caveat for every current U.S. CBSA record?
14. Should cross-state CBSAs receive a standard governance-complexity flag even when the boundary is accepted as a statistical denominator?

---

## 10. Source URL list

```text
U.S. Census — Metropolitan and Micropolitan Delineation Files
https://www.census.gov/geographies/reference-files/time-series/demo/metro-micro/delineation-files.html

U.S. Census — 2023 CBSA List 1 workbook
https://www2.census.gov/programs-surveys/metro-micro/geographies/reference-files/2023/delineation-files/list1_2023.xlsx

OMB Bulletin No. 23-01
https://www.whitehouse.gov/wp-content/uploads/2023/07/OMB-Bulletin-23-01.pdf

U.S. Census — CBSA glossary
https://www.census.gov/programs-surveys/metro-micro/about/glossary.html

U.S. Census — Metropolitan and Micropolitan Statistical Areas guidance
https://www.census.gov/programs-surveys/geography/guidance/geo-areas/metro-micro.html

Federal Register — 2020 Standards for Delineating Core Based Statistical Areas
https://www.federalregister.gov/documents/2021/07/16/2021-15159/2020-standards-for-delineating-core-based-statistical-areas

U.S. Census — TIGER/Line Shapefiles
https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html

Likely 2023 TIGER/Line CBSA shapefile path
https://www2.census.gov/geo/tiger/TIGER2023/CBSA/tl_2023_us_cbsa.zip

Likely 2023 TIGER/Line county shapefile path
https://www2.census.gov/geo/tiger/TIGER2023/COUNTY/tl_2023_us_county.zip

U.S. Census — Cartographic Boundary Files
https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html

2023 CBSA cartographic boundary file, 1:500,000
https://www2.census.gov/geo/tiger/GENZ2023/shp/cb_2023_us_cbsa_500k.zip

U.S. Census — 2024 ACS 1-Year API documentation
https://www.census.gov/data/developers/data-sets/acs-1year/2024.html

U.S. Census API — 2024 ACS 1-Year detailed tables root
https://api.census.gov/data/2024/acs/acs1

U.S. Census API — 2024 ACS 1-Year profile root
https://api.census.gov/data/2024/acs/acs1/profile

U.S. Census ACS Handbooks / MOE guidance source family
https://www.census.gov/programs-surveys/acs/guidance/handbooks.html

FTA / NTD — Current GTFS Weblinks table
https://data.transportation.gov/Public-Transit/General-Transit-Feed-Specification-Weblinks/2u7n-ub22/about_data

Data.gov — 2023 NTD Annual Data GTFS Weblinks
https://catalog.data.gov/dataset/2023-ntd-annual-data-general-transit-feed-specification-gtfs-weblinks

FTA / NTD main page
https://www.transit.dot.gov/ntd

BTS — National Transit Map
https://www.bts.gov/national-transit-map

BTS / USDOT ArcGIS Open Data search for National Transit Map layers
https://data-usdot.opendata.arcgis.com/search?collection=Dataset&tags=NTM

TriMet GTFS developer page
https://developer.trimet.org/GTFS.shtml

TriMet GTFS static feed lead
http://developer.trimet.org/schedule/gtfs.zip

FTA / NTD TriMet agency profile source path
https://www.transit.dot.gov/ntd/transit-agency-profiles/trimet

C-TRAN GTFS terms/source page
https://www.c-tran.com/about-c-tran/business/procurement/bids-rfps-sole-sources/terms-and-conditions/gtfs-data

C-TRAN GTFS static feed lead
https://mail.c-tran.com/images/Google/GoogleTransitUpload.zip

SMART / Wilsonville routes and schedules
https://www.wilsonvilleoregon.gov/smart/page/routes-schedules

SMART GTFS feed lead
https://passio3.com/smart/passioTransit/gtfs/google_transit.zip

Canby Area Transit routes and services
https://www.canbyoregon.gov/area-transit/page/routes-and-services

Canby Area Transit GTFS feed lead
https://oregon-gtfs.trilliumtransit.com/gtfs_data/canbytransit-or-us/canbytransit-or-us.zip

Sandy Area Metro routes and services
https://www.ci.sandy.or.us/transit/page/sam-routes-services

Ride Clackamas — Sandy Area Metro
https://www.rideclackamas.org/providers/sandy-area-metro-sam/

Sandy Area Metro GTFS feed lead
https://passio3.com/sandyor/passioTransit/gtfs/google_transit.zip

Yamhill County Transit
https://ycbus.org/

Yamhill County Transit GTFS feed lead
http://ycta.connexionz.net/rtt/public/resource/gtfs.zip

FTA / NTD Yamhill County Transit agency profile source path
https://www.transit.dot.gov/ntd/transit-agency-profiles/yamhill-county-transit-area

Columbia County Rider
https://www.columbiacountyor.gov/departments/Transit/Columbia-County-Rider

NW Connector — Columbia County Rider
https://www.nwconnector.org/routes/columbia-county-rider/

Columbia County Rider GTFS feed lead
https://oregon-gtfs.trilliumtransit.com/gtfs_data/columbiacounty-or-us/columbiacounty-or-us.zip

Gorge Transit — Skamania County Transit
https://gorgetransit.com/providers/skamania-county-transit/

Skamania County GTFS feed lead
https://data.trilliumtransit.com/gtfs/skamaniacounty-wa-us/skamaniacounty-wa-us.zip

WSDOT — GTFS transit data
https://wsdot.wa.gov/travel/public-transportation/about-gtfs-transit-data

BTS — Intercity Bus Atlas note path
https://www.bts.gov/national-transit-map
```
