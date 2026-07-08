# Raw Return: Minneapolis-St. Paul ERS CZ Exact Membership / Source Bundle

**Thesis:** Thesis 2 — Mobility Conversion  
**Date:** 2026-07-05  
**Return status:** raw research material only  
**Important status note:** This file is not evidence, not source truth, not an accepted MTR, not a candidate-universe record, not a boundary record, not a metric record, not a score, and not a ranking.

No raw datasets are attached or archived as evidence in this return. Any figures, identifiers, file names, and row-level observations below are raw research notes from public source paths and must be re-acquired, archived, and verified through the Thesis 2 evidence-manifest process before becoming source notes or accepted records.

---

## 1. Short method summary

This return follows the `mtr_src_004` Minneapolis-St. Paul ERS Commuting Zone handoff. The research pass checked official or primary source families only:

- USDA ERS 2020 Commuting Zones and documentation;
- U.S. Census / ACS commuting-flow, county-boundary, and population-denominator source paths;
- FTA / NTD GTFS Weblinks and NTD reporter metadata source paths;
- local or regional transit-agency source pages only for service/source coverage, not as MTR denominators.

The exact ERS 2020 Commuting Zone source path identifies the relevant labor-market region as:

```yaml
CZ2020: 258
CZName: Minneapolis city, MN
```

The working Thesis 2 lead name remains:

```yaml
working_name: Minneapolis-St. Paul ERS CZ
```

The official ERS row name is not exactly the same phrase as the working lead name. The official row name should be preserved as `Minneapolis city, MN` unless Codex later verifies a different authoritative label.

No transport quality claims are made here. No score, access calculation, population coverage, or candidate admission is made here.

---

## 2. Source table

| Source title | Authority | Role in this raw return | URL / access path | Raw verification status |
|---|---|---|---|---|
| Commuting Zones and Labor Market Areas | USDA Economic Research Service | Boundary source family, 2020 CZ download path, update/release metadata | `https://www.ers.usda.gov/data-products/commuting-zones-and-labor-market-areas` | Source family and download path verified; exact row needs Codex re-extraction/archive |
| 2020 Commuting Zones CSV | USDA Economic Research Service | County membership, county FIPS, CZ code, CZ name, county containment, average containment | `https://www.ers.usda.gov/media/6968/2020-commuting-zones.csv?v=92446` | Raw row-level extraction performed for this return; official raw file must be reacquired later |
| 2020 Commuting Zones Documentation | USDA Economic Research Service | Method, data sources, containment definitions, limitations | `https://www.ers.usda.gov/data-products/commuting-zones-and-labor-market-areas/documentation` | Source path verified |
| 2020 Commuting Zones User's Guide | USDA Economic Research Service | Use cautions, labor-market purpose, county-based interpretation limits | `https://www.ers.usda.gov/data-products/commuting-zones-and-labor-market-areas/users-guide` | Source path verified |
| 2016-2020 5-Year ACS Commuting Flows | U.S. Census Bureau | Underlying commuting-flow source family cited by ERS; post-2020 caveat context | `https://www.census.gov/data/tables/2020/demo/metro-micro/commuting-flows-2020.html` | Source path verified |
| TIGER/Line Shapefiles — Counties | U.S. Census Bureau | County boundary pairing source candidate | `https://www2.census.gov/geo/tiger/TIGER2020/COUNTY/tl_2020_us_county.zip` | Source path identified; raw boundary file not downloaded/archived here |
| Cartographic Boundary File — Counties | U.S. Census Bureau | Lighter mapping boundary alternative; not preferred for analytic geometry | `https://www2.census.gov/geo/tiger/GENZ2020/shp/cb_2020_us_county_500k.zip` | Source path identified; raw boundary file not downloaded/archived here |
| ACS 5-Year API, Total Population table B01003 | U.S. Census Bureau | Resident population denominator path for county aggregation | `https://api.census.gov/data/2024/acs/acs5?get=NAME,B01003_001E,B01003_001M&for=county:*&in=state:27` and `https://api.census.gov/data/2024/acs/acs5?get=NAME,B01003_001E,B01003_001M&for=county:*&in=state:55` | Source path candidate identified; no population values returned here |
| ACS margin-of-error guidance | U.S. Census Bureau | Aggregated county MOE handling | `https://www.census.gov/programs-surveys/acs/guidance/training-presentations/acs-moe.html` | Source path candidate identified; Codex should verify exact current guidance |
| Commuting in the United States: 2022 | U.S. Census Bureau | Post-2020 commuting / home-based-work caveat | `https://www.census.gov/library/publications/2024/acs/acsbr-018.html` | Source path verified |
| Home-Based Workers: 2019-2021 | U.S. Census Bureau | Post-2020 commuting / work-from-home caveat | `https://www.census.gov/library/publications/2023/demo/p70br-184.html` | Source path verified |
| 2023 NTD Annual Data — GTFS Weblinks | Federal Transit Administration / National Transit Database | Official public GTFS feed-link inventory source | `https://catalog.data.gov/dataset/2023-ntd-annual-data-general-transit-feed-specification-gtfs-weblinks` | Source path verified; row-level reporter extraction must be archived later |
| Current monthly GTFS Weblinks Socrata view | U.S. DOT / FTA / NTD | Current monthly GTFS weblink inventory path | `https://data.transportation.gov/Public-Transit/General-Transit-Feed-Specification-Weblinks/2u7n-ub22/about_data` | Source path verified; not fetched here |
| 2023 Annual Database — Agency Information | Federal Transit Administration / National Transit Database | NTD reporter metadata, service area and agency identity source | `https://www.transit.dot.gov/ntd/data-product/2023-annual-database-agency-information` | Source path candidate; row-level metadata must be archived later |
| Metro Transit Schedule and Realtime Data Feeds | Metro Transit / Metropolitan Council | Regional GTFS and GTFS-RT source documentation | `https://svc.metrotransit.org/` | Source path verified via public page/search result |
| MVTA GTFS data | Minnesota Valley Transit Authority | Separate GTFS source named by Metro Transit and NTD | `https://srv.mvta.com/InfoPoint/GTFS-zip.ashx` | Source path identified; not fetched here |
| Transit Link | Metropolitan Council | Demand-responsive / shared-ride service source lead outside regular fixed-route GTFS coverage | `https://metrocouncil.org/Transportation/Services/Transit-Link.aspx` | Source path verified |
| Metro Mobility | Metropolitan Council | ADA paratransit / shared-ride source lead outside fixed-route GTFS coverage | `https://metrocouncil.org/Transportation/Services/Metro-Mobility-Home.aspx` | Source path verified |
| Timber Trails Public Transit | Kanabec County / Timber Trails | County-level public transit / dial-a-ride source lead for Kanabec County | `https://timbertrailstransit.com/transportation-programs/` and `https://www.kanabeccounty.org/departments/transportation.php` | Source path lead identified; materiality to ERS CZ source bundle unresolved |
| Arrowhead Transit / Heartland Express transition source leads | Arrowhead Transit / Isanti County / local sources | Potential source lead for Isanti / Chisago / Pine / northern-county service | Source paths unresolved; candidate leads only | Not verified enough for source truth |

---

## 3. YAML-style raw source bundle

```yaml
minneapolis_ers_cz_exact_membership_return:
  return_status: raw_research_material_only

  reviewed_boundary:
    working_name: Minneapolis-St. Paul ERS CZ
    source_authority: USDA Economic Research Service
    exact_name: Minneapolis city, MN
    exact_code: "258"
    geography_type: county_based_commuting_zone_labour_market_region
    source_url_or_access_path:
      - https://www.ers.usda.gov/data-products/commuting-zones-and-labor-market-areas
      - https://www.ers.usda.gov/media/6968/2020-commuting-zones.csv?v=92446
    verification_status: raw_row_identified_pending_codex_re_extraction_and_archive

  county_membership:
    source_title: 2020 Commuting Zones
    source_authority: USDA Economic Research Service
    source_url_or_access_path:
      - https://www.ers.usda.gov/data-products/commuting-zones-and-labor-market-areas
      - https://www.ers.usda.gov/media/6968/2020-commuting-zones.csv?v=92446
    county_list:
      - fips: "27003"
        county_name: Anoka County
        state_name: Minnesota
        cz2020: "258"
        cz_name: Minneapolis city, MN
        county_containment_percent: 97.34
        cz_average_containment_percent: 94.00
      - fips: "27019"
        county_name: Carver County
        state_name: Minnesota
        cz2020: "258"
        cz_name: Minneapolis city, MN
        county_containment_percent: 95.39
        cz_average_containment_percent: 94.00
      - fips: "27025"
        county_name: Chisago County
        state_name: Minnesota
        cz2020: "258"
        cz_name: Minneapolis city, MN
        county_containment_percent: 96.31
        cz_average_containment_percent: 94.00
      - fips: "27037"
        county_name: Dakota County
        state_name: Minnesota
        cz2020: "258"
        cz_name: Minneapolis city, MN
        county_containment_percent: 96.30
        cz_average_containment_percent: 94.00
      - fips: "27053"
        county_name: Hennepin County
        state_name: Minnesota
        cz2020: "258"
        cz_name: Minneapolis city, MN
        county_containment_percent: 98.17
        cz_average_containment_percent: 94.00
      - fips: "27059"
        county_name: Isanti County
        state_name: Minnesota
        cz2020: "258"
        cz_name: Minneapolis city, MN
        county_containment_percent: 91.23
        cz_average_containment_percent: 94.00
      - fips: "27065"
        county_name: Kanabec County
        state_name: Minnesota
        cz2020: "258"
        cz_name: Minneapolis city, MN
        county_containment_percent: 86.88
        cz_average_containment_percent: 94.00
      - fips: "27115"
        county_name: Pine County
        state_name: Minnesota
        cz2020: "258"
        cz_name: Minneapolis city, MN
        county_containment_percent: 85.62
        cz_average_containment_percent: 94.00
      - fips: "27123"
        county_name: Ramsey County
        state_name: Minnesota
        cz2020: "258"
        cz_name: Minneapolis city, MN
        county_containment_percent: 99.02
        cz_average_containment_percent: 94.00
      - fips: "27139"
        county_name: Scott County
        state_name: Minnesota
        cz2020: "258"
        cz_name: Minneapolis city, MN
        county_containment_percent: 96.55
        cz_average_containment_percent: 94.00
      - fips: "27163"
        county_name: Washington County
        state_name: Minnesota
        cz2020: "258"
        cz_name: Minneapolis city, MN
        county_containment_percent: 98.30
        cz_average_containment_percent: 94.00
      - fips: "55093"
        county_name: Pierce County
        state_name: Wisconsin
        cz2020: "258"
        cz_name: Minneapolis city, MN
        county_containment_percent: 86.03
        cz_average_containment_percent: 94.00
      - fips: "55109"
        county_name: St. Croix County
        state_name: Wisconsin
        cz2020: "258"
        cz_name: Minneapolis city, MN
        county_containment_percent: 94.86
        cz_average_containment_percent: 94.00
    county_identifier_fields:
      - FIPStxt
      - CountyName
      - StateName
      - CZ2020
      - CZName
      - CZContainment
      - CZAvgContainment
    membership_vintage: 2020 Commuting Zones
    release_or_update_date:
      ers_main_page_updated: 2026-01-09
      ers_2020_cz_download_last_updated: 2026-01-09
      documentation_page_current_as_inspected: 2026-03-18
    verification_status: raw_row_identified_pending_codex_re_extraction_and_archive

  county_boundary_artifact:
    product_title: TIGER/Line Shapefile, 2020, U.S. Counties
    catalogue_or_download_path:
      - https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html
      - https://www2.census.gov/geo/tiger/TIGER2020/COUNTY/tl_2020_us_county.zip
    file_or_layer: tl_2020_us_county
    vintage: 2020
    identifier_field: GEOID
    license_or_reuse_terms: U.S. Census Bureau public data; confirm reuse terms at acquisition
    raw_download_required_later: true
    notes:
      - Use full TIGER/Line county geometry for analytic joining if exact geometry matters.
      - Cartographic boundary files may be acceptable for display-only maps but should not silently replace TIGER/Line in analytic boundary construction.
      - Join GEOID to ERS FIPStxt after preserving leading zeroes.

  population_denominator:
    source_title: ACS 2020-2024 5-Year Detailed Table B01003, Total Population, county geography
    source_authority: U.S. Census Bureau
    source_url_or_access_path:
      minnesota_counties: https://api.census.gov/data/2024/acs/acs5?get=NAME,B01003_001E,B01003_001M&for=county:*&in=state:27
      wisconsin_counties: https://api.census.gov/data/2024/acs/acs5?get=NAME,B01003_001E,B01003_001M&for=county:*&in=state:55
      acs_api_documentation: https://www.census.gov/data/developers/data-sets/acs-5year.html
    geography_identifiers:
      - state
      - county
      - combined_county_geoid
    population_field:
      estimate: B01003_001E
      margin_of_error: B01003_001M
    acs_estimate_period: 2020-2024 ACS 5-year
    aggregation_method:
      - Retrieve county-level B01003_001E and B01003_001M for Minnesota and Wisconsin.
      - Filter to ERS CZ county FIPS list.
      - Sum B01003_001E across the 13 counties.
      - Preserve a county-level audit table rather than storing only the total.
    margin_of_error_or_uncertainty_handling:
      - Preferred rigorous path: use ACS variance replicate estimate tables when collapsing across counties, if available for the chosen ACS release and table.
      - Approximate path for counts if replicate estimates are not used: aggregate MOEs as sqrt(sum(MOE_i^2)), recognizing that this ignores covariance.
      - Document that ACS margins of error are reported at the 90 percent confidence level.
      - Do not calculate or return the aggregate value in this raw source bundle.
    value_returned: do_not_return_value_unless_needed_for_source_identification
    verification_status: source_path_candidate_identified_population_value_not_returned

  county_coarseness_and_caveats:
    commuting_flow_vintage:
      - ERS documentation identifies the 2020 CZ delineation source data as 2016-2020 ACS county-to-county commuting flows.
      - ERS documentation also references 2020 Census DHC population and the 2024 County Adjacency File in the 2020 CZ workflow.
    pandemic_or_remote_work_caveat:
      - The 2016-2020 ACS commuting-flow window overlaps the initial COVID-19 commuting disruption period.
      - U.S. Census commuting briefs document substantial 2019-2021 changes in home-based work and commuting behavior.
      - This supports a boundary-vintage caveat, not a rejection of ERS CZs.
    containment_or_fit_measures:
      county_containment_field: CZContainment
      cz_average_containment_field: CZAvgContainment
      observed_cz_average_containment_percent_for_raw_row: 94.00
      documentation_note: ERS defines county containment as the percentage of a county's resident workforce commuting to work within the CZ; average containment is the unweighted average across member counties.
    rural_or_exurban_overreach_risk:
      - The ERS CZ is county-based and labor-market oriented, not a transport-service or all-purpose daily-access boundary.
      - The 13-county set extends beyond the seven-county Twin Cities metropolitan service/planning core into outer Minnesota counties and two Wisconsin counties.
      - Counties that may require overreach review include Kanabec, Pine, Isanti, Chisago, Pierce WI, and St. Croix WI.
    cross_state_or_multi_agency_complexity:
      - The county set includes Minnesota and Wisconsin counties.
      - Cross-state inclusion creates population, safety, and service-source aggregation complexity.
      - Multi-agency transit-source reconciliation is required because the regional GTFS bundle is not the denominator and may not cover all fixed-route or non-fixed-route services throughout the CZ.
    weakly_integrated_counties:
      raw_lowest_containment_counties:
        - fips: "27115"
          county_name: Pine County
          state_name: Minnesota
          county_containment_percent: 85.62
        - fips: "55093"
          county_name: Pierce County
          state_name: Wisconsin
          county_containment_percent: 86.03
        - fips: "27065"
          county_name: Kanabec County
          state_name: Minnesota
          county_containment_percent: 86.88
        - fips: "27059"
          county_name: Isanti County
          state_name: Minnesota
          county_containment_percent: 91.23
      note: These counties are flagged for review only; this return does not decide exclusion or boundary adjustment.
    source_url_or_access_path:
      - https://www.ers.usda.gov/data-products/commuting-zones-and-labor-market-areas/documentation
      - https://www.census.gov/data/tables/2020/demo/metro-micro/commuting-flows-2020.html
      - https://www.census.gov/library/publications/2024/acs/acsbr-018.html
      - https://www.census.gov/library/publications/2023/demo/p70br-184.html

  service_source_bundle:
    fta_ntd_gtfs_weblinks_source:
      source_authority: Federal Transit Administration / National Transit Database
      source_url_or_access_path:
        - https://catalog.data.gov/dataset/2023-ntd-annual-data-general-transit-feed-specification-gtfs-weblinks
        - https://data.transportation.gov/Public-Transit/General-Transit-Feed-Specification-Weblinks/2u7n-ub22/about_data
      format:
        - CSV
        - XLSX
        - Socrata/API-backed data table
      vintage_or_update_date:
        - 2023 NTD annual data product
        - data.gov page notes most up-to-date monthly refreshed dataset path
        - row-level 2023 extraction requires later archive
      license_or_access_terms: public U.S. government dataset; FTA notes agencies host their own feeds and submitted links may change
      coverage_against_CZ:
        - Coverage unresolved.
        - The source is a GTFS feed-link inventory for NTD fixed-route reporters, not a CZ boundary source and not a complete service-denominator.
        - Demand Response, Vanpool, and other non-fixed-route modes are explicitly outside the GTFS Weblinks coverage family.
    ntd_reporters_or_gtfs_feeds:
      - ntd_id: "50027"
        agency_name: Metro Transit
        reporter_type: Full Reporter
        reporting_module: Urban
        modes_or_tos_seen_in_raw_2023_gtfs_weblinks:
          - CR / PT
          - LR / DO
          - MB / DO
        gtfs_weblink_seen: https://svc.metrotransit.org/mtgtfs/gtfs.zip
        materiality_note: core fixed-route source lead for Minneapolis/St. Paul urban transit; exact CZ coverage unresolved
      - ntd_id: "50154"
        agency_name: Metropolitan Council
        reporter_type: Full Reporter
        reporting_module: Urban
        modes_or_tos_seen_in_raw_2023_gtfs_weblinks:
          - MB / PT
        gtfs_weblink_seen: https://svc.metrotransit.org/mtgtfs/gtfs.zip
        materiality_note: regional contracted/service source lead; fixed-route only in GTFS context
      - ntd_id: "50515"
        agency_name: University of Minnesota
        reporter_type: Full Reporter
        reporting_module: Urban
        modes_or_tos_seen_in_raw_2023_gtfs_weblinks:
          - MB / PT
        gtfs_weblink_seen: Google Drive feed URL in 2023 GTFS Weblinks raw source path
        materiality_note: campus/circulator service source lead; materiality to MTR indicators unresolved
      - ntd_id: "50516"
        agency_name: City of Plymouth / Plymouth Metrolink
        reporter_type: Full Reporter
        reporting_module: Urban
        modes_or_tos_seen_in_raw_2023_gtfs_weblinks:
          - MB / PT
        gtfs_weblink_seen: https://svc.metrotransit.org/mtgtfs/gtfs.zip
        materiality_note: suburban fixed-route/source lead; exact geographic coverage unresolved
      - ntd_id: "50517"
        agency_name: City of Maple Grove / Maple Grove Transit
        reporter_type: Full Reporter
        reporting_module: Urban
        modes_or_tos_seen_in_raw_2023_gtfs_weblinks:
          - unresolved_in_inspected_2023_gtfs_weblinks
        gtfs_weblink_seen: not_confirmed_in_inspected_2023_gtfs_weblinks
        materiality_note: NTD agency metadata and Metro Transit GTFS page identify Maple Grove Transit as relevant; feed-row discrepancy requires Codex/infrastructure check
      - ntd_id: "50518"
        agency_name: SouthWest Transit
        reporter_type: Full Reporter
        reporting_module: Urban
        modes_or_tos_seen_in_raw_2023_gtfs_weblinks:
          - MB / PT
        gtfs_weblink_seen: https://svc.metrotransit.org/mtgtfs/gtfs.zip
        materiality_note: suburban fixed-route/source lead; exact CZ coverage unresolved
      - ntd_id: "50519"
        agency_name: Minnesota Valley Transit Authority
        reporter_type: Full Reporter
        reporting_module: Urban
        modes_or_tos_seen_in_raw_2023_gtfs_weblinks:
          - MB / PT
        gtfs_weblink_seen: https://srv.mvta.com/InfoPoint/GTFS-zip.ashx
        materiality_note: separate MVTA feed source lead; Metro Transit page also states MVTA feed is separate
      - ntd_id: "50520"
        agency_name: Arrowhead Economic Opportunity Agency, Inc.
        reporter_type: Rural Reporter
        reporting_module: Rural
        modes_or_tos_seen_in_raw_2023_gtfs_weblinks:
          - MB / DO
        gtfs_weblink_seen: none_seen_in_2023_source_path
        waiver_seen: true
        materiality_note: possible northern/exurban county source lead; exact relevance to Isanti/Chisago/Pine or CZ fixed-route coverage unresolved
    regional_feed_notes:
      - Metro Transit public GTFS page says its schedule and realtime data include bus, light rail, and commuter rail service for the Minneapolis/St. Paul metropolitan area.
      - The same page says its data include service operated by Metro Transit, the Metropolitan Council, Maple Grove Transit, Plymouth Metrolink, SouthWest Transit, the University of Minnesota, and the Metropolitan Airports Commission.
      - The same page says MVTA service data are available separately.
      - Metro Transit static schedule data are described as weekly-updated and covering roughly seven weeks; GTFS-realtime feeds refresh frequently.
      - This page is a service-source note, not a denominator or MTR-boundary source.
    missing_operators_or_modes:
      - Demand Response, Vanpool, and other non-fixed-route modes are outside the NTD GTFS Weblinks dataset by definition.
      - Transit Link is a Metropolitan Council shared-ride public transportation source for areas where regular route transit is infrequent or unavailable.
      - Metro Mobility is a Metropolitan Council ADA shared-ride/public transportation source for certified riders unable to use regular fixed-route service.
      - Metro Micro / GTFS-Flex appears as a separate Metro Transit feed source; exact treatment as fixed-route, microtransit, or separate indicator input is unresolved.
      - Timber Trails Public Transit is a source lead for Kanabec County service and may indicate non-core county service outside the main regional GTFS bundle.
      - Arrowhead / Heartland Express / other rural or county-level services may matter in Isanti, Chisago, Pine, or adjacent counties, but source paths and fixed-route status remain unresolved.
      - Wisconsin-side services in Pierce and St. Croix counties are unresolved.
      - Intercity coach, airport/private shuttles, school-only services, and employer/private services are unresolved and should be quarantined until source notes exist.

  rejected_or_quarantined_material:
    - item: Use the ERS CZ as an admitted MTR boundary without further readiness review
      reason: This return is raw material only; ERS CZ is a county-based labor-market region and must pass the Thesis 2 boundary readiness checklist.
    - item: Use Metro Transit, MVTA, NTD, GTFS, route, stop, or service geography as the MTR denominator
      reason: Service-derived geographies can hide unserved populations and are explicitly indicator inputs / overlays only.
    - item: Use the seven-county Twin Cities metropolitan service/planning region as a substitute denominator
      reason: It is a different governance/statutory source family and is not the ERS CZ membership being reviewed here.
    - item: Use NTD service-area population as the population denominator
      reason: NTD service-area population is agency/service metadata, not a resident population denominator for the ERS CZ county set.
    - item: Treat the 2023 GTFS Weblinks file as complete current live coverage
      reason: data.gov notes submitted 2023 links may no longer work and points to a current monthly refreshed table; infrastructure must refresh and validate feed reachability.
    - item: Treat all demand-responsive, paratransit, vanpool, rural, school, airport, and private services as represented in static GTFS
      reason: FTA explicitly excludes Demand Response, Vanpool, and other non-fixed-route modes from the GTFS Weblinks coverage family.
```

---

## 4. Exact CZ code and county membership findings

### 4.1 Exact ERS row finding

Raw ERS row extraction identifies the relevant 2020 Commuting Zone as:

```yaml
CZ2020: 258
CZName: Minneapolis city, MN
CZAvgContainment: 94.00
```

The working research lead name is `Minneapolis-St. Paul ERS CZ`; the official ERS name field observed in the 2020 CZ source path is `Minneapolis city, MN`.

This difference should be preserved rather than normalized away.

### 4.2 County membership

| FIPS | County | State | CZ2020 | CZName | County containment | CZ average containment |
|---:|---|---|---:|---|---:|---:|
| 27003 | Anoka County | Minnesota | 258 | Minneapolis city, MN | 97.34 | 94.00 |
| 27019 | Carver County | Minnesota | 258 | Minneapolis city, MN | 95.39 | 94.00 |
| 27025 | Chisago County | Minnesota | 258 | Minneapolis city, MN | 96.31 | 94.00 |
| 27037 | Dakota County | Minnesota | 258 | Minneapolis city, MN | 96.30 | 94.00 |
| 27053 | Hennepin County | Minnesota | 258 | Minneapolis city, MN | 98.17 | 94.00 |
| 27059 | Isanti County | Minnesota | 258 | Minneapolis city, MN | 91.23 | 94.00 |
| 27065 | Kanabec County | Minnesota | 258 | Minneapolis city, MN | 86.88 | 94.00 |
| 27115 | Pine County | Minnesota | 258 | Minneapolis city, MN | 85.62 | 94.00 |
| 27123 | Ramsey County | Minnesota | 258 | Minneapolis city, MN | 99.02 | 94.00 |
| 27139 | Scott County | Minnesota | 258 | Minneapolis city, MN | 96.55 | 94.00 |
| 27163 | Washington County | Minnesota | 258 | Minneapolis city, MN | 98.30 | 94.00 |
| 55093 | Pierce County | Wisconsin | 258 | Minneapolis city, MN | 86.03 | 94.00 |
| 55109 | St. Croix County | Wisconsin | 258 | Minneapolis city, MN | 94.86 | 94.00 |

### 4.3 Source of membership vintage and release/update date

Raw source path:

```text
https://www.ers.usda.gov/data-products/commuting-zones-and-labor-market-areas
https://www.ers.usda.gov/media/6968/2020-commuting-zones.csv?v=92446
```

Observed metadata from ERS page/source path:

```yaml
product: 2020 Commuting Zones
main_page_updated: 2026-01-09
download_last_updated: 2026-01-09
documentation_source: USDA ERS documentation page
underlying_commuting_flow_source: 2016-2020 ACS county-to-county commuting flows
additional_documented_inputs:
  - 2020 Census DHC population
  - 2024 County Adjacency File
```

---

## 5. Boundary/population artifact findings

### 5.1 County boundary pairing

Recommended later raw artifact acquisition:

```yaml
preferred_boundary_product: TIGER/Line Shapefile, 2020, U.S. Counties
download_path: https://www2.census.gov/geo/tiger/TIGER2020/COUNTY/tl_2020_us_county.zip
join_field: GEOID
join_to_ERS_field: FIPStxt
raw_download_required_later: true
```

Use TIGER/Line county geometry for analytic boundary construction if exact county geometry is needed. Use cartographic boundary files only if the task is display/generalized mapping:

```yaml
display_boundary_candidate: Cartographic Boundary File, 2020, U.S. Counties, 500k
download_path: https://www2.census.gov/geo/tiger/GENZ2020/shp/cb_2020_us_county_500k.zip
```

### 5.2 Population denominator

Recommended ACS source path:

```yaml
source: ACS 2020-2024 5-Year Detailed Table B01003
field_estimate: B01003_001E
field_moe: B01003_001M
geography: county
states_required:
  - Minnesota: state 27
  - Wisconsin: state 55
```

Candidate API calls:

```text
https://api.census.gov/data/2024/acs/acs5?get=NAME,B01003_001E,B01003_001M&for=county:*&in=state:27
https://api.census.gov/data/2024/acs/acs5?get=NAME,B01003_001E,B01003_001M&for=county:*&in=state:55
```

Population aggregation method:

1. Retrieve county rows for Minnesota and Wisconsin.
2. Construct five-digit county GEOID from state and county fields.
3. Filter to the 13 ERS county FIPS values.
4. Sum `B01003_001E`.
5. Preserve county rows and the aggregation script as source-processing material.
6. Do not return the aggregate value in this source bundle.

MOE handling:

```yaml
preferred: Use ACS variance replicate estimates when collapsing across counties, if available for the chosen ACS release/table.
approximate: sqrt(sum(MOE_i^2)) for independent count estimates, with the limitation that covariance is ignored.
confidence_level: ACS MOEs are reported at the 90 percent confidence level.
```

### 5.3 Boundary/population compatibility notes

- ERS CZ membership uses county/county-equivalent units.
- Census county geometry and ACS county population are compatible source families.
- The main risk is not identifier compatibility; the main risk is **transport-access fit**, because a county-based labor-market boundary can be much broader than the transport-service region an ordinary resident experiences.

---

## 6. County-coarseness and caveat findings

### 6.1 ERS CZ method / fit measures

ERS documentation identifies the 2020 CZs as county-based labor-market regions created from county-to-county commuting flows. It includes containment fields intended to help users assess how well a Commuting Zone represents the labor market of its counties.

Relevant raw field interpretation:

```yaml
CZContainment: percentage of a county's resident workforce commuting to work within the CZ
CZAvgContainment: unweighted average of county containment among CZ member counties
```

The observed raw `CZAvgContainment` for `CZ2020 = 258` is:

```yaml
CZAvgContainment: 94.00
```

### 6.2 County coarseness

The CZ includes 13 counties. Several are clearly beyond the core urban counties typically associated with the Twin Cities transit network or seven-county metropolitan service/planning frame:

```yaml
outer_or_exurban_review_counties:
  - Chisago County, Minnesota
  - Isanti County, Minnesota
  - Kanabec County, Minnesota
  - Pine County, Minnesota
  - Pierce County, Wisconsin
  - St. Croix County, Wisconsin
```

This does not mean these counties should be removed. It means county-level denominator fit requires a boundary-readiness review.

### 6.3 Lower-containment counties

The lowest county containment values in the raw ERS row are:

| FIPS | County | State | County containment |
|---:|---|---|---:|
| 27115 | Pine County | Minnesota | 85.62 |
| 55093 | Pierce County | Wisconsin | 86.03 |
| 27065 | Kanabec County | Minnesota | 86.88 |
| 27059 | Isanti County | Minnesota | 91.23 |

These are review flags only. They do not decide exclusion.

### 6.4 Cross-state and multi-agency complexity

The ERS county set crosses from Minnesota into Wisconsin:

```yaml
wisconsin_member_counties:
  - Pierce County
  - St. Croix County
```

This creates several source-bundle complications:

- Census/ACS population must combine Minnesota and Wisconsin counties.
- Road-safety, employment, and service-source inputs may come from more than one state.
- Fixed-route GTFS coverage for the core Minneapolis/St. Paul area may not cover all outer or Wisconsin-side county services.
- Local or county-level demand-responsive services may be material even where regular fixed-route service is absent.

### 6.5 Pandemic / remote-work caveat

ERS 2020 CZs use 2016-2020 ACS commuting-flow data. That period overlaps the initial COVID-19 disruption to work trips. U.S. Census commuting publications document substantial changes in commuting behavior and home-based work during 2019-2021 and continuing adjustments by 2022.

This supports a **boundary-vintage caveat**:

```yaml
caveat: Commuting-flow boundaries based on 2016-2020 data may be affected by pandemic-period commuting disruption and subsequent remote/hybrid work changes.
effect_on_this_return: caveat_only_not_rejection
```

This raw return does not verify an official ERS correction for remote work and does not propose one.

---

## 7. Service/operator coverage findings

### 7.1 NTD GTFS Weblinks source family

The official public GTFS feed-inventory source family is:

```yaml
source_title: 2023 NTD Annual Data - General Transit Feed Specification (GTFS) Weblinks
authority: Federal Transit Administration / National Transit Database
data_gov_page: https://catalog.data.gov/dataset/2023-ntd-annual-data-general-transit-feed-specification-gtfs-weblinks
current_monthly_table: https://data.transportation.gov/Public-Transit/General-Transit-Feed-Specification-Weblinks/2u7n-ub22/about_data
```

Key limits to preserve:

- GTFS Weblinks are fixed-route service feed links, not geographic denominators.
- FTA states submitted links may become stale or fail.
- FTA states Demand Response, Vanpool, and other non-fixed-route modes are excluded.
- Agency-hosted GTFS files require later infrastructure validation for reachability, date, and content.

### 7.2 Raw NTD/GTFS reporter/source leads

Raw source path notes identify these likely material fixed-route reporter/source leads:

| NTD ID | Agency / reporter | Raw feed/source note | Status |
|---:|---|---|---|
| 50027 | Metro Transit | `https://svc.metrotransit.org/mtgtfs/gtfs.zip` | Core regional fixed-route source lead |
| 50154 | Metropolitan Council | Same Metro Transit GTFS source seen for MB/PT in raw NTD path | Regional contracted/service source lead |
| 50515 | University of Minnesota | Separate Google Drive feed URL seen in raw NTD path | Campus fixed-route/circulator source lead; materiality unresolved |
| 50516 | City of Plymouth / Plymouth Metrolink | Metro Transit GTFS source seen in raw NTD path | Suburban fixed-route source lead |
| 50517 | City of Maple Grove / Maple Grove Transit | NTD agency metadata and Metro Transit page indicate relevance; exact GTFS Weblinks row unresolved in inspected file | Requires reconciliation |
| 50518 | SouthWest Transit | Metro Transit GTFS source seen in raw NTD path | Suburban fixed-route source lead |
| 50519 | Minnesota Valley Transit Authority | `https://srv.mvta.com/InfoPoint/GTFS-zip.ashx` | Separate MVTA feed source lead |
| 50520 | Arrowhead Economic Opportunity Agency, Inc. | Rural reporter / waiver in raw NTD path; possible outer-county service relevance | Materiality unresolved |

### 7.3 Regional GTFS feed notes

Metro Transit’s public GTFS source page says its schedule and realtime data include bus, light rail, and commuter rail service for the Minneapolis/St. Paul metropolitan area. It also says the data include services operated by Metro Transit, the Metropolitan Council, Maple Grove Transit, Plymouth Metrolink, SouthWest Transit, the University of Minnesota, and the Metropolitan Airports Commission. It separately identifies MVTA GTFS data.

Important source handling:

```yaml
metro_transit_static_gtfs: https://svc.metrotransit.org/mtgtfs/gtfs.zip
metro_transit_gtfs_flex: https://svc.metrotransit.org/mtgtfs/gtfs-flex.zip
metro_transit_upcoming_static_gtfs: https://svc.metrotransit.org/mtgtfs/next/gtfs.zip
metro_transit_gtfs_archive: https://svc.metrotransit.org/mtgtfs/archive/
mvta_static_gtfs: https://srv.mvta.com/InfoPoint/GTFS-zip.ashx
```

These feeds are not denominator sources. They can only become indicator inputs or service-completeness overlays after feed reachability, date, agency, route, calendar, and spatial coverage are validated.

### 7.4 Known non-fixed-route and incomplete-coverage issues

The service-source bundle must not be bus/rail GTFS-only without caveats. Source leads outside standard static GTFS include:

| Service / mode | Why it may matter | Source path / note | Status |
|---|---|---|---|
| Transit Link | Shared-ride public transportation where regular route transit is infrequent or unavailable in Twin Cities metro area | `https://metrocouncil.org/Transportation/Services/Transit-Link.aspx` | Material non-fixed-route / demand-responsive lead |
| Metro Mobility | ADA shared-ride public transportation for certified riders unable to use regular fixed-route service | `https://metrocouncil.org/Transportation/Services/Metro-Mobility-Home.aspx` | Material paratransit lead |
| Metro Micro / GTFS-Flex | Microtransit; Metro Transit provides GTFS-Flex source path | `https://svc.metrotransit.org/mtgtfs/gtfs-flex.zip` | Requires method decision |
| Timber Trails Public Transit | Public transit bus / dial-a-ride source lead in Kanabec County | `https://timbertrailstransit.com/transportation-programs/` | Outer-county source lead; materiality unresolved |
| Arrowhead / Heartland Express / local northern-county services | Potential source lead for Isanti, Chisago, Pine or nearby counties | Source paths unresolved | Quarantined until source notes exist |
| Wisconsin-side services | Pierce and St. Croix counties are in the ERS CZ | Source paths unresolved | Quarantined until source notes exist |
| Intercity coach / airport / private shuttle / school-only services | May operate inside county set but may not be relevant to MTR ordinary-access indicators | Source paths unresolved | Quarantined until inclusion rules exist |
| Vanpool | Excluded from FTA GTFS Weblinks family | FTA GTFS Weblinks documentation | Indicator treatment unresolved |

### 7.5 Coverage against ERS CZ

Raw coverage assessment:

```yaml
likely_inside_core_gtfs_bundle:
  - Metro Transit core services
  - Metropolitan Council fixed-route/contracted services represented in Metro Transit GTFS
  - Plymouth Metrolink
  - SouthWest Transit
  - University of Minnesota
  - Metropolitan Airports Commission if represented in Metro Transit GTFS
  - MVTA through separate feed

likely_outside_or_unresolved_for_full_CZ:
  - Kanabec County service
  - Pine County service
  - Isanti County service
  - Chisago County service
  - Pierce County, WI services
  - St. Croix County, WI services
  - demand-responsive / paratransit / vanpool services
  - rural public transit providers without static GTFS
  - intercity or private services

coverage_conclusion: unresolved
```

The current fixed-route source bundle is plausible for the core Minneapolis/St. Paul regional transit system, but it is not yet proven complete for the entire ERS CZ county denominator.

---

## 8. Rejected/quarantined material

| Item | Status | Reason |
|---|---|---|
| ERS CZ `258` as admitted MTR | Quarantined | Boundary/source row is identified, but admission requires Thesis 2 readiness review. |
| Metro Transit GTFS extent as boundary | Rejected | Service-derived geography cannot define the MTR denominator. |
| MVTA feed extent as boundary | Rejected | Service-derived geography cannot define the MTR denominator. |
| NTD GTFS Weblinks as boundary | Rejected | Feed-inventory source, not a functional region. |
| National Transit Map as boundary | Rejected | Service-derived fixed-route map; not a denominator. |
| Seven-county Twin Cities metro as silent replacement | Quarantined | It is a separate governance/statutory geography, not the ERS CZ source family under review. |
| NTD service-area population as population denominator | Rejected | Agency/service metadata, not resident population for the 13-county ERS CZ. |
| Bus/rail GTFS-only source bundle as complete CZ public transport | Quarantined | Demand-response, paratransit, rural services, Wisconsin-side services, and vanpool are unresolved or outside NTD GTFS Weblinks coverage. |
| City reputation, congestion reputation, or transit reputation | Rejected | Outcome-adjacent and prohibited by Thesis 2 guardrails. |
| Population coverage calculation | Rejected for this return | Prompt prohibits population coverage calculation. |
| Access, coverage, or score calculation | Rejected for this return | Prompt prohibits metrics, scores, or rankings. |

---

## 9. Open questions for Thesis 2

1. Should ERS CZ `258` remain under review if its county denominator substantially exceeds the practical fixed-route transit service area?
2. Should Thesis 2 define a maximum acceptable county-coarseness risk for county-based labor-market boundaries?
3. Should the lower-containment counties, especially Pine, Pierce, Kanabec, and Isanti, trigger a boundary-fit worksheet before any service-source work proceeds?
4. Should `CZAvgContainment` be stored as a formal boundary-quality field in the boundary registry?
5. Should the 2016-2020 ACS commuting-flow vintage automatically trigger a post-2020 commuting caveat for all ERS 2020 CZ proposals?
6. Should ACS 2020-2024 5-year population be used for current denominator alignment, or should a 2020 Decennial DHC population denominator be paired with the 2020 ERS boundary vintage?
7. Should the infrastructure thread use ACS replicate estimates for aggregate MOE, or is the approximate root-sum-square method acceptable for county-level total population counts in raw denominator screening?
8. Should Maple Grove Transit be treated as covered by the Metro Transit GTFS bundle despite the unresolved raw 2023 GTFS Weblinks discrepancy?
9. What minimum operator-completeness threshold is required before a U.S. county-based CZ can support even a basic scheduled-transit method test?
10. Should demand-responsive public transit such as Transit Link be included in coverage/access indicators, treated separately, or used only as an outer-region service caveat?
11. What source family should identify Wisconsin-side public transport in Pierce and St. Croix counties?
12. Should vanpool, intercity coach, airport shuttle, school-only, and private services remain excluded from V1 indicators unless a specific ordinary-access rule admits them?

---

## 10. Source URL list

```text
USDA ERS — Commuting Zones and Labor Market Areas
https://www.ers.usda.gov/data-products/commuting-zones-and-labor-market-areas

USDA ERS — 2020 Commuting Zones CSV
https://www.ers.usda.gov/media/6968/2020-commuting-zones.csv?v=92446

USDA ERS — 2020 Commuting Zones documentation
https://www.ers.usda.gov/data-products/commuting-zones-and-labor-market-areas/documentation

USDA ERS — Commuting Zones User's Guide
https://www.ers.usda.gov/data-products/commuting-zones-and-labor-market-areas/users-guide

U.S. Census Bureau — 2016-2020 5-Year ACS Commuting Flows
https://www.census.gov/data/tables/2020/demo/metro-micro/commuting-flows-2020.html

U.S. Census Bureau — TIGER/Line Shapefiles
https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html

U.S. Census Bureau — 2020 TIGER/Line county shapefile candidate
https://www2.census.gov/geo/tiger/TIGER2020/COUNTY/tl_2020_us_county.zip

U.S. Census Bureau — 2020 cartographic county boundary candidate
https://www2.census.gov/geo/tiger/GENZ2020/shp/cb_2020_us_county_500k.zip

U.S. Census Bureau — ACS 5-Year data API documentation
https://www.census.gov/data/developers/data-sets/acs-5year.html

U.S. Census Bureau — 2024 ACS 5-Year B01003 county API, Minnesota
https://api.census.gov/data/2024/acs/acs5?get=NAME,B01003_001E,B01003_001M&for=county:*&in=state:27

U.S. Census Bureau — 2024 ACS 5-Year B01003 county API, Wisconsin
https://api.census.gov/data/2024/acs/acs5?get=NAME,B01003_001E,B01003_001M&for=county:*&in=state:55

U.S. Census Bureau — ACS margin-of-error guidance
https://www.census.gov/programs-surveys/acs/guidance/training-presentations/acs-moe.html

U.S. Census Bureau — Commuting in the United States: 2022
https://www.census.gov/library/publications/2024/acs/acsbr-018.html

U.S. Census Bureau — Home-Based Workers: 2019-2021
https://www.census.gov/library/publications/2023/demo/p70br-184.html

FTA / Data.gov — 2023 NTD Annual Data, GTFS Weblinks
https://catalog.data.gov/dataset/2023-ntd-annual-data-general-transit-feed-specification-gtfs-weblinks

U.S. DOT Socrata — current monthly GTFS Weblinks table
https://data.transportation.gov/Public-Transit/General-Transit-Feed-Specification-Weblinks/2u7n-ub22/about_data

FTA — 2023 Annual Database Agency Information
https://www.transit.dot.gov/ntd/data-product/2023-annual-database-agency-information

Metro Transit — Schedule and Realtime Data Feeds
https://svc.metrotransit.org/

Metro Transit — current static GTFS
https://svc.metrotransit.org/mtgtfs/gtfs.zip

Metro Transit — GTFS-Flex / Metro Micro
https://svc.metrotransit.org/mtgtfs/gtfs-flex.zip

Metro Transit — upcoming static GTFS
https://svc.metrotransit.org/mtgtfs/next/gtfs.zip

Metro Transit — GTFS archive
https://svc.metrotransit.org/mtgtfs/archive/

MVTA — static GTFS
https://srv.mvta.com/InfoPoint/GTFS-zip.ashx

Metropolitan Council — Transit Link
https://metrocouncil.org/Transportation/Services/Transit-Link.aspx

Metropolitan Council — Metro Mobility
https://metrocouncil.org/Transportation/Services/Metro-Mobility-Home.aspx

Timber Trails Public Transit — Transportation Programs
https://timbertrailstransit.com/transportation-programs/

Kanabec County — Transportation
https://www.kanabeccounty.org/departments/transportation.php
```
