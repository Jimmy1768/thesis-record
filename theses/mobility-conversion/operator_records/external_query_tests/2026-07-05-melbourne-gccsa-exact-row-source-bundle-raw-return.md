# Raw Return: Greater Melbourne GCCSA Exact Row / Source Bundle

Date: 2026-07-05  
Thesis: Thesis 2 — Mobility Conversion  
Return status: raw research material only

This return is not evidence, not source truth, not an accepted MTR, not a candidate-universe record, not a boundary record, not a metric record, not a score, and not a ranking.

This return does not admit Greater Melbourne as a Metropolitan Transport Region. It does not use transport service geography, GTFS extent, stop buffers, route buffers, fare zones, agency coverage, or Victorian transport service areas as the MTR denominator.

## 1. Short method summary

This source-bundle scan checked official or primary source paths for the Greater Melbourne GCCSA lead `mtr_src_006`.

Source families checked:

- Australian Bureau of Statistics ASGS Edition 3 GCCSA documentation;
- ABS ASGS Edition 3 access/download pages;
- ABS GCCSA digital boundary file path;
- ABS GCCSA allocation file path;
- ABS Census Community Profiles / QuickStats for direct name-to-code mapping;
- ABS Regional Population release for an estimated resident population denominator path;
- Victoria Department of Transport and Planning / Transport Victoria / PTV open-data schedule and API sources;
- Transport Victoria sources for ferries, FlexiRide, school-bus networks, airport buses, and other non-standard or possibly out-of-feed services.

No raw ABS boundary files, allocation files, population workbooks, GTFS feeds, API responses, or operator datasets were downloaded or archived in this return. Exact artifact admission still requires raw acquisition, archiving, and evidence-manifest processing by the Thesis 2 workflow.

The primary exact geography finding is:

```yaml
exact_name: Greater Melbourne
exact_code: 2GMEL
geography_type: Greater Capital City Statistical Area
ASGS_edition: Edition 3, July 2021 - June 2026
```

The source-bundle posture is:

```yaml
boundary_source_family: hybrid_functional_statistical_region
boundary_authority: Australian Bureau of Statistics
exact_gccsa_row_status: exact_code_name_traceable_to_official_ABS_pages
boundary_artifact_status: official_boundary_file_path_identified_not_downloaded
population_denominator_status: official_GCCSA_population_paths_identified_not_downloaded
service_overlay_status: official_statewide_GTFS_schedule_source_identified_coverage_unresolved
```

## 2. Source table

| Source family | Source title | Source authority | URL / access path | Relevant finding | Verification posture |
|---|---|---|---|---|---|
| ASGS methodology | Greater Capital City Statistical Areas | Australian Bureau of Statistics | https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/main-structure-and-greater-capital-city-statistical-areas/greater-capital-city-statistical-areas | GCCSAs are ASGS Edition 3 geographies built from SA4s and intended to represent the functional area of each capital city. | Source page inspected; no raw data downloaded. |
| ASGS overview | Australian Statistical Geography Standard Edition 3 | Australian Bureau of Statistics | https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/latest-release | ASGS Edition 3 is July 2021-June 2026; ABS notes ASGS geographies may differ from official or commonly understood areas and should be selected by design/purpose/update frequency. | Source page inspected; transition caveat noted. |
| Direct name/code mapping | 2021 Census Community Profiles: Greater Melbourne | Australian Bureau of Statistics | https://www.abs.gov.au/census/find-census-data/community-profiles/2021/2GMEL | Directly maps `Greater Melbourne` to geography type `Greater Capital City Statistical Areas` and area code `2GMEL`. | Source page inspected; raw profile file not downloaded. |
| Direct name/code mapping | 2021 Census QuickStats: Greater Melbourne | Australian Bureau of Statistics | https://www.abs.gov.au/census/find-census-data/quickstats/2021/2GMEL | Directly maps `Greater Melbourne` to geography type `Greater Capital City Statistical Areas` and area code `2GMEL`; displays 2021 Census People value. | Source page inspected; population value not returned except as source-identification context if later needed. |
| Boundary product | ASGS Edition 3 Digital Boundary Files | Australian Bureau of Statistics | https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/digital-boundary-files | Official digital boundary files include GCCSA 2021 products in GeoPackage and ESRI Shapefile formats, with GDA2020 and GDA94 options. | Source page inspected; boundary file not downloaded. |
| Boundary product | GCCSA 2021 Shapefile GDA2020 | Australian Bureau of Statistics | https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/digital-boundary-files/GCCSA_2021_AUST_SHP_GDA2020.zip | Direct download path identified for GCCSA 2021 shapefile in GDA2020. | Direct path identified from ABS page; not downloaded. |
| Allocation / building blocks | ASGS Edition 3 Allocation Files — Greater Capital City Statistical Areas 2021 | Australian Bureau of Statistics | https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/allocation-files | Official allocation files describe how ASGS geographies aggregate from lower-level units; GCCSA allocation file contains SA4-to-GCCSA fields. | Source path identified; raw allocation file not downloaded. |
| Allocation file | GCCSA_2021_AUST.xlsx | Australian Bureau of Statistics | https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/allocation-files/GCCSA_2021_AUST.xlsx | Direct path identified for GCCSA allocation workbook. | Direct path identified; not downloaded. |
| Population denominator | Regional population, 2024-25 | Australian Bureau of Statistics | https://www.abs.gov.au/statistics/people/population/regional-population/latest-release | ABS Regional Population release provides ERP for capital cities / GCCSAs and a downloadable table for SA2 and above. | Source page inspected; population workbook not downloaded. |
| Population table | Population estimates by SA2 and above, 2001 to 2025 | Australian Bureau of Statistics | https://www.abs.gov.au/statistics/people/population/regional-population/2024-25/32180DS0003_2001-25.xlsx | Plausible current GCCSA population denominator path for `2GMEL`, using estimated resident population. | Direct path identified; workbook not downloaded. |
| Service source | GTFS Schedule | Department of Transport and Planning / Transport Victoria Open Data | https://opendata.transport.vic.gov.au/dataset/gtfs-schedule | Static timetable information for public transport in Victoria in GTFS format, including metropolitan/regional trains, metropolitan/regional buses including coach, trams, interstate, and SkyBus folders. | Source page inspected; feed not downloaded. |
| Service source mirror | PTV Timetable and Geographic Information 2015 - GTFS | Department of Transport and Planning / DataVic | https://discover.data.vic.gov.au/dataset/ptv-timetable-and-geographic-information-2015-gtfs | DataVic mirror for GTFS schedule dataset; licence and update metadata visible. | Source page inspected; feed not downloaded. |
| Dynamic API | Public Transport Timetable API FAQs | Transport Victoria / PTV | https://www.vic.gov.au/public-transport-timetable-api-faqs | API is for dynamic access to most up-to-date stop, line, disruption, and timetable data; static bulk schedule data are provided through GTFS. | Source page inspected; no API calls made. |
| Dynamic API | PTV Timetable API | Department of Transport and Planning / DataVic | https://discover.data.vic.gov.au/dataset/ptv-timetable-api | API returns route, stop, disruption, and timetable information for Victoria; real-time where available. | Source page inspected; no API calls made. |
| Real-time feeds | GTFS Realtime | Department of Transport and Planning / DataVic | https://discover.data.vic.gov.au/dataset/gtfs-realtime | GTFS-RT provides trip updates, alerts, and vehicle positions; access uses API key / KeyID and rate limits. | Source page inspected; no realtime feed acquired. |
| Ferry source | Ferries | Transport Victoria | https://transport.vic.gov.au/plan-a-journey/travel-tips-and-resources/ferries | Transport Victoria documents ferry services including Westgate Punt, Western Port Ferry, and Port Phillip Ferries; ferry mode is not evident in the GTFS Schedule folder list inspected. | Source page inspected; materiality inside GCCSA unresolved. |
| On-demand source | FlexiRide on-demand bus service | Transport Victoria | https://transport.vic.gov.au/plan-a-journey/travel-tips-and-resources/flexiride-on-demand-bus-service | FlexiRide is on-demand and has no fixed route; source treatment differs from fixed-route GTFS. | Source page inspected; materiality inside GCCSA unresolved. |
| School bus source | School bus networks and bus stops | Transport Victoria | https://transport.vic.gov.au/plan-a-journey/travel-tips-and-resources/school-bus-networks-and-bus-stops | DTP maintains school-bus stop/network data for eligible services; school-bus services are not general fixed-route urban transport by default. | Source page inspected; materiality unresolved. |
| Airport services | Getting to and from Melbourne and Avalon airports | Transport Victoria | https://transport.vic.gov.au/plan-a-journey/travel-tips-and-resources/getting-to-and-from-melbourne-and-avalon-airports | Airport bus services include public transport and other bus services with separate booking systems; SkyBus cannot use myki. | Source page inspected; service classification unresolved. |
| Airport / SkyBus | SkyBus | SkyBus | https://www.skybus.com.au/ | Official operator page for airport bus services. | Source page identified; not used as boundary or denominator. |
| Non-fixed accessibility transport | Multi Purpose Taxi Program | Commercial Passenger Vehicles Victoria | https://cpv.vic.gov.au/passengers/mptp/using-your-card/trip-restrictions | Subsidized taxi / commercial passenger vehicle program for eligible users; not a fixed-route GTFS service. | Source path identified; materiality for future accessibility context only. |

## 3. YAML-style raw source bundle

```yaml
melbourne_gccsa_exact_row_return:
  return_status: raw_research_material_only

  reviewed_boundary:
    working_name: Greater Melbourne GCCSA
    source_authority: Australian Bureau of Statistics
    exact_name: Greater Melbourne
    exact_code: 2GMEL
    ASGS_edition: "Edition 3, July 2021 - June 2026"
    geography_type: GCCSA
    source_url_or_access_path:
      - https://www.abs.gov.au/census/find-census-data/community-profiles/2021/2GMEL
      - https://www.abs.gov.au/census/find-census-data/quickstats/2021/2GMEL
      - https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/main-structure-and-greater-capital-city-statistical-areas/greater-capital-city-statistical-areas
    verification_status: exact_name_and_code_directly_traceable_to_official_ABS_pages__raw_boundary_geometry_not_downloaded

  boundary_artifact:
    product_title: "ASGS Edition 3 Digital Boundary Files — Greater Capital City Statistical Areas 2021"
    catalogue_or_download_path:
      - https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/digital-boundary-files
      - https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/digital-boundary-files/GCCSA_2021_AUST_SHP_GDA2020.zip
    file_or_layer:
      - "GCCSA_2021_AUST_GDA2020 / GCCSA_2021_AUST_SHP_GDA2020"
      - "GCCSA_2021_AUST_GDA94 / GCCSA_2021_AUST_SHP_GDA94 also available"
    vintage: "ASGS Edition 3; 2021 GCCSA boundary product; release period July 2021-June 2026"
    identifier_field:
      geopackage_expected:
        - GCCSA_CODE_2021
        - GCCSA_NAME_2021
      shapefile_expected:
        - GCC_CODE21
        - GCC_NAME21
    raw_download_required_later: true

  population_denominator:
    source_title:
      primary_estimate_path: "ABS Regional population, 2024-25 — Population estimates by SA2 and above, 2001 to 2025"
      census_fallback_path: "2021 Census QuickStats / Community Profiles for Greater Melbourne"
    source_url_or_access_path:
      - https://www.abs.gov.au/statistics/people/population/regional-population/latest-release
      - https://www.abs.gov.au/statistics/people/population/regional-population/2024-25/32180DS0003_2001-25.xlsx
      - https://www.abs.gov.au/census/find-census-data/quickstats/2021/2GMEL
      - https://www.abs.gov.au/census/find-census-data/community-profiles/2021/2GMEL
    geography_identifier: "GCCSA code 2GMEL"
    population_field:
      primary_estimate_path: "Estimated resident population / ERP for GCCSA at 30 June 2025; exact workbook column name requires raw XLSX inspection"
      census_fallback_path: "QuickStats display field 'People' for 2021 Census; General Community Profile machine field should be confirmed from raw profile download if used"
    vintage:
      primary_estimate_path: "2024-25 release; ERP at 30 June 2025"
      census_fallback_path: "2021 Census, place of usual residence"
    value_returned: do_not_return_value_unless_needed_for_source_identification
    verification_status: official_source_paths_identified__population_workbook_not_downloaded__machine_field_not_archived

  building_blocks:
    SA4_membership:
      verification_status: source_path_traceable_not_raw_archived
      source_method: "Use ABS ASGS Edition 3 GCCSA allocation workbook and/or SA4 boundary file fields GCCSA_CODE_2021 / GCCSA_NAME_2021."
      working_list_to_verify_from_official_allocation_file:
        - "206 Melbourne - Inner"
        - "207 Melbourne - Inner East"
        - "208 Melbourne - Inner South"
        - "209 Melbourne - North East"
        - "210 Melbourne - North West"
        - "211 Melbourne - Outer East"
        - "212 Melbourne - South East"
        - "213 Melbourne - West"
        - "214 Mornington Peninsula"
    source_url_or_access_path:
      - https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/allocation-files
      - https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/allocation-files/GCCSA_2021_AUST.xlsx
      - https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/digital-boundary-files
    uncertainty_notes:
      - "Exact SA4 membership must be confirmed by downloading and archiving the official ABS allocation workbook or boundary file."
      - "The working list above should not become evidence until the raw artifact is acquired and processed into an evidence manifest."
      - "GCCSA is built from whole SA4s, so SA4 membership is a plausible building-block reconciliation path."

  methodology_caveats:
    functional_basis:
      - "ABS states GCCSAs are designed to represent the functional area of each capital city."
      - "ABS states GCCSAs include people who regularly interact with the city through work, shopping, social, or economic activity, including surrounding towns and rural areas."
      - "GCCSAs are built from SA4s; SA4s are designed to represent labour markets and functional areas of capital cities."
    statistical_stability:
      - "ABS states GCCSAs are designed to provide a stable definition for socio-economic comparison and time series."
      - "ABS states GCCSA boundaries may differ from official or commonly understood area boundaries."
      - "ABS states GCCSAs have no population criteria."
      - "For Thesis 2, this means Greater Melbourne GCCSA may be a broad functional/statistical container and still requires boundary-fit review before MTR admission."
    ASGS_edition_transition:
      - "ASGS Edition 3 covers July 2021-June 2026."
      - "ASGS Edition 4 releases begin in 2026; use Edition 3 until an Edition 4 boundary/source decision is separately made."
      - "ABS publishes correspondences, including 2016 GCCSA to 2021 GCCSA, for edition-transition work."
    source_url_or_access_path:
      - https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/latest-release
      - https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/main-structure-and-greater-capital-city-statistical-areas/greater-capital-city-statistical-areas
      - https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/correspondences

  service_source_bundle:
    primary_service_source: "GTFS Schedule"
    source_authority:
      - "Department of Transport and Planning"
      - "Transport Victoria Open Data"
      - "PTV / DataVic mirror"
    source_url_or_access_path:
      - https://opendata.transport.vic.gov.au/dataset/gtfs-schedule
      - https://discover.data.vic.gov.au/dataset/ptv-timetable-and-geographic-information-2015-gtfs
      - https://www.vic.gov.au/public-transport-timetable-api-faqs
      - https://discover.data.vic.gov.au/dataset/ptv-timetable-api
      - https://discover.data.vic.gov.au/dataset/gtfs-realtime
    format:
      static_schedule: "GTFS Schedule ZIP / static timetable files"
      dynamic_api: "PTV Timetable API for dynamic stop, line, route, disruption, and timetable queries"
      realtime: "GTFS Realtime Protocol Buffer feeds for trip updates, service alerts, and vehicle positions"
      static_folder_structure_reported:
        - "1 Regional Train"
        - "2 Metropolitan Train"
        - "3 Metropolitan Tram"
        - "4 Myki Bus (Metro Bus and Regional Town Bus)"
        - "5 Regional Coach"
        - "6 Regional Bus"
        - "10 Interstate"
        - "11 SkyBus"
    vintage_or_update_date:
      static_schedule:
        - "OpenData page: updated weekly / as needed; rolling 30-day schedule horizon"
        - "OpenData page reviewed with Reporting Period End / Last Updated around 2026-07-03"
        - "DataVic mirror reviewed with last-updated metadata around 2026-07-04"
      API:
        - "PTV Timetable API gives dynamic access; train updated daily and remaining datasets weekly according to DataVic description"
      GTFS_RT:
        - "GTFS Realtime pages list continual update posture and API-key/rate-limit access"
    license_or_access_terms:
      static_schedule:
        - "DataVic mirror lists Creative Commons Attribution 4.0 International"
        - "OpenData page should be archived for license metadata at retrieval"
      API:
        - "API terms and developer access must be archived before use"
      GTFS_RT:
        - "GTFS-RT access requires KeyID/API-key header and is rate-limited"
    coverage_against_GCCSA:
      - "The GTFS Schedule source is statewide and includes multiple public-transport modes that may intersect Greater Melbourne GCCSA."
      - "Coverage against the Greater Melbourne GCCSA denominator is unresolved until spatial overlay and operator-completeness review are performed."
      - "The feed geography, route geography, stop geography, and agency coverage must not define the MTR denominator."
      - "Static schedule source is likely useful for first service-source readiness testing, not for boundary admission."
    missing_operators_or_modes:
      - item: "Ferries"
        posture: "possibly outside primary GTFS Schedule; Transport Victoria separately documents Westgate Punt, Western Port Ferry, and Port Phillip Ferries. Materiality inside GCCSA unresolved."
        source_url_or_access_path: https://transport.vic.gov.au/plan-a-journey/travel-tips-and-resources/ferries
      - item: "FlexiRide / on-demand bus"
        posture: "on-demand, no fixed route; not equivalent to fixed-route GTFS. Materiality inside GCCSA unresolved."
        source_url_or_access_path: https://transport.vic.gov.au/plan-a-journey/travel-tips-and-resources/flexiride-on-demand-bus-service
      - item: "School bus networks / school bus program"
        posture: "school-service source family, not general fixed-route public transport by default; materiality for public access unresolved."
        source_url_or_access_path:
          - https://transport.vic.gov.au/plan-a-journey/travel-tips-and-resources/school-bus-networks-and-bus-stops
          - https://www2.education.vic.gov.au/pal/school-bus-program/policy
      - item: "Airport buses and SkyBus"
        posture: "SkyBus appears in the static GTFS folder structure, but Transport Victoria states airport bus services may use separate booking systems and SkyBus cannot use myki; confirm feed rows and public-access/fare treatment before use."
        source_url_or_access_path:
          - https://transport.vic.gov.au/plan-a-journey/travel-tips-and-resources/getting-to-and-from-melbourne-and-avalon-airports
          - https://www.skybus.com.au/
      - item: "Demand-responsive / paratransit / subsidized taxi programs"
        posture: "not fixed-route GTFS; potential accessibility-context source only."
        source_url_or_access_path: https://cpv.vic.gov.au/passengers/mptp/using-your-card/trip-restrictions
      - item: "Private coach or intercity services"
        posture: "regional coach appears in the DTP GTFS folder list, but private/intercity completeness requires later operator manifest review."
        source_url_or_access_path: https://opendata.transport.vic.gov.au/dataset/gtfs-schedule

  rejected_or_quarantined_material:
    - item: "Using Greater Melbourne GCCSA as an admitted MTR"
      reason: "This return only verifies source paths; MTR admission requires separate boundary-fit and readiness review."
    - item: "Using DTP/PTV GTFS extent, stop buffers, route buffers, fare zones, or agency coverage as denominator"
      reason: "Service-derived geographies can hide unserved populations and are prohibited as MTR denominators."
    - item: "Using Transport Victoria / PTV API service coverage as boundary"
      reason: "Dynamic timetable/API source is an indicator input or overlay only."
    - item: "Using public-transport operator area as primary boundary"
      reason: "Governance/service geography is not a primary denominator for this source-led boundary request."
    - item: "Using ferries, airport services, school buses, FlexiRide, SkyBus, or paratransit geographies as boundary"
      reason: "These are service or special-purpose overlays; materiality and inclusion rules require later source review."
    - item: "Using livability, city reputation, transit reputation, congestion reputation, or 'best transit city' material"
      reason: "Outcome-adjacent selection evidence is prohibited for this research stage."
```

## 4. Exact geography row/code findings

### 4.1 Exact ABS name and code

Official ABS Census pages directly map:

```yaml
exact_name: Greater Melbourne
geography_type: Greater Capital City Statistical Areas
area_code: 2GMEL
```

Source paths:

```text
https://www.abs.gov.au/census/find-census-data/community-profiles/2021/2GMEL
https://www.abs.gov.au/census/find-census-data/quickstats/2021/2GMEL
```

Verification posture:

```yaml
verification_status: official_name_code_mapping_found
raw_download_status: not_downloaded
boundary_record_status: not_created
```

### 4.2 ASGS Edition

The relevant geography is under:

```yaml
ASGS_edition: Edition 3
reference_period: July 2021 - June 2026
```

Source paths:

```text
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/latest-release
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/main-structure-and-greater-capital-city-statistical-areas/greater-capital-city-statistical-areas
```

Caveat:

```yaml
ASGS_edition_transition: "Edition 4 releases begin in 2026; this return does not evaluate Edition 4 changes."
```

### 4.3 Identifier fields for boundary files

ABS digital boundary metadata identifies GCCSA boundary products and field names. The expected identifier fields are:

```yaml
GeoPackage_expected_fields:
  - GCCSA_CODE_2021
  - GCCSA_NAME_2021

ESRI_shapefile_expected_fields:
  - GCC_CODE21
  - GCC_NAME21
```

Boundary file paths:

```text
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/digital-boundary-files
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/digital-boundary-files/GCCSA_2021_AUST_SHP_GDA2020.zip
```

Verification posture:

```yaml
source_path_status: official_boundary_file_path_found
raw_geometry_status: not_downloaded_or_archived
exact_geometry_status: unresolved_until_raw_download
```

## 5. Boundary/population artifact findings

### 5.1 Boundary artifact

Primary boundary artifact source path:

```yaml
product_title: "ASGS Edition 3 Digital Boundary Files — Greater Capital City Statistical Areas 2021"
authority: "Australian Bureau of Statistics"
formats:
  - GeoPackage
  - ESRI Shapefile
datums:
  - GDA2020
  - GDA94
direct_shapefile_path_identified: "GCCSA_2021_AUST_SHP_GDA2020.zip"
identifier_fields:
  - "GCCSA_CODE_2021 / GCC_CODE21"
  - "GCCSA_NAME_2021 / GCC_NAME21"
raw_download_required_later: true
```

The direct GDA2020 shapefile path identified is:

```text
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/digital-boundary-files/GCCSA_2021_AUST_SHP_GDA2020.zip
```

This artifact is not downloaded or archived in this return.

### 5.2 Population denominator

Two official ABS population source paths are relevant.

#### Primary estimate path

```yaml
source_title: "ABS Regional population, 2024-25"
data_table: "Population estimates by SA2 and above, 2001 to 2025"
authority: "Australian Bureau of Statistics"
geography_identifier: "GCCSA code 2GMEL"
population_concept: "Estimated resident population / ERP"
vintage: "ERP at 30 June 2025"
download_status: not_downloaded
```

Source paths:

```text
https://www.abs.gov.au/statistics/people/population/regional-population/latest-release
https://www.abs.gov.au/statistics/people/population/regional-population/2024-25/32180DS0003_2001-25.xlsx
```

This is the preferred current population-denominator source path for a future readiness check if the source workbook can be downloaded, archived, and mapped to `2GMEL`.

#### Census fallback path

```yaml
source_title: "2021 Census QuickStats / Community Profiles: Greater Melbourne"
authority: "Australian Bureau of Statistics"
geography_identifier: "2GMEL"
population_concept: "2021 Census usual-residence person count"
display_field: "People"
machine_field: "requires raw profile download if used"
vintage: "2021 Census"
download_status: not_downloaded
```

Source paths:

```text
https://www.abs.gov.au/census/find-census-data/quickstats/2021/2GMEL
https://www.abs.gov.au/census/find-census-data/community-profiles/2021/2GMEL
```

Per the handoff instruction, this return does not return the population value except to identify the source path and field.

### 5.3 SA4 building-block path

Official source path:

```yaml
source_title: "ASGS Edition 3 Allocation Files — Greater Capital City Statistical Areas 2021"
authority: "Australian Bureau of Statistics"
direct_workbook_path: "GCCSA_2021_AUST.xlsx"
building_block_level: SA4
relevant_fields:
  - SA4_CODE_2021
  - SA4_NAME_2021
  - GCCSA_CODE_2021
  - GCCSA_NAME_2021
raw_download_required_later: true
```

Source paths:

```text
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/allocation-files
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/allocation-files/GCCSA_2021_AUST.xlsx
```

Working SA4 membership to verify from the official allocation file:

```yaml
SA4_membership_working_list_to_verify:
  - code: "206"
    name: "Melbourne - Inner"
  - code: "207"
    name: "Melbourne - Inner East"
  - code: "208"
    name: "Melbourne - Inner South"
  - code: "209"
    name: "Melbourne - North East"
  - code: "210"
    name: "Melbourne - North West"
  - code: "211"
    name: "Melbourne - Outer East"
  - code: "212"
    name: "Melbourne - South East"
  - code: "213"
    name: "Melbourne - West"
  - code: "214"
    name: "Mornington Peninsula"
verification_status: source_path_traceable_not_raw_archived
```

Uncertainty note:

```yaml
uncertainty_notes:
  - "The official allocation workbook path has been identified, but the workbook was not downloaded in this return."
  - "The working membership list must be verified by raw extraction before it becomes evidence."
  - "A future evidence manifest should store the raw workbook, extracted rows for GCCSA_CODE_2021 = 2GMEL, and the extraction script/query."
```

### 5.4 Methodology caveats from ABS

ABS documentation supports the following caveats for Thesis 2 processing:

```yaml
functional_basis:
  - "GCCSAs are intended to represent the functional area of each capital city."
  - "GCCSAs include people who regularly interact with the capital city through work, shopping, social, or economic activity."
  - "GCCSAs are built from SA4s; SA4s are designed to represent labour markets and functional areas of capital cities."

statistical_stability:
  - "GCCSAs are intended to provide stable definitions for socio-economic comparison and time series."
  - "GCCSAs have no population criteria."
  - "ABS states that ASGS approximations may differ from official or commonly understood city boundaries."

transport_access_limit:
  - "GCCSA is a functional/statistical geography, not a direct observed transit catchment or service boundary."
  - "It may include surrounding towns or rural areas that interact with the capital city but are not necessarily part of a contiguous high-frequency transport-service region."
  - "Boundary-fit review is required before MTR admission."

ASGS_edition_transition:
  - "ASGS Edition 3 covers July 2021-June 2026."
  - "Edition 4 release timing should be monitored before any long-lived boundary record is locked."
  - "ABS correspondence files can support comparison across editions."
```

Source paths:

```text
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/latest-release
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/main-structure-and-greater-capital-city-statistical-areas/greater-capital-city-statistical-areas
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/correspondences
```

## 6. Service/operator coverage findings

### 6.1 Primary schedule-source path

The main official public-transport schedule-source path identified is:

```yaml
source_title: GTFS Schedule
authority: Department of Transport and Planning / Transport Victoria Open Data
format: GTFS Schedule ZIP / static timetable files
source_urls:
  - https://opendata.transport.vic.gov.au/dataset/gtfs-schedule
  - https://discover.data.vic.gov.au/dataset/ptv-timetable-and-geographic-information-2015-gtfs
```

The inspected source describes coverage as static timetable information for public transport in Victoria, including:

```yaml
reported_modes:
  - all_metropolitan_trains
  - all_regional_trains
  - all_metropolitan_buses
  - all_regional_buses_including_coach
  - all_metropolitan_trams
```

Reported folder structure:

```yaml
static_GTFS_folder_structure:
  - "1 Regional Train"
  - "2 Metropolitan Train"
  - "3 Metropolitan Tram"
  - "4 Myki Bus (Metro Bus and Regional Town Bus)"
  - "5 Regional Coach"
  - "6 Regional Bus"
  - "10 Interstate"
  - "11 SkyBus"
```

Update and limitation posture:

```yaml
update_posture:
  - "Updated weekly / as needed"
  - "Rolling 30-day schedule horizon"
  - "Some route information may not be present for the entire 30-day period"
  - "Travel paths may not precisely align with paths shown in journey planners or on vehicles"
license_posture:
  - "DataVic mirror lists Creative Commons Attribution 4.0 International"
download_status: not_downloaded
coverage_against_GCCSA: unresolved
```

### 6.2 PTV Timetable API and GTFS Realtime

PTV / DTP also provides dynamic timetable and realtime source paths.

```yaml
PTV_Timetable_API:
  source_urls:
    - https://www.vic.gov.au/public-transport-timetable-api-faqs
    - https://discover.data.vic.gov.au/dataset/ptv-timetable-api
  relevant_posture:
    - "Dynamic access to stop, line, route, disruption, and timetable data."
    - "Not designed for downloading all timetable data."
    - "Static timetable dumps should use the GTFS Schedule dataset."
  use_in_Thesis_2:
    - "Potential supplementary source for operator/service metadata."
    - "Not primary denominator."
    - "Not a substitute for archived static schedule evidence."

GTFS_Realtime:
  source_url: https://discover.data.vic.gov.au/dataset/gtfs-realtime
  relevant_posture:
    - "Provides trip updates, service alerts, and vehicle positions."
    - "Uses Protocol Buffer format."
    - "Requires API-key / KeyID access and has rate limits."
  use_in_Thesis_2:
    - "Potential future reliability/operations source."
    - "Not a static service denominator."
    - "Not necessary for first boundary/source-bundle admission."
```

### 6.3 Possible missing or separately handled operators/modes

The primary DTP/PTV GTFS Schedule source is broad, but the following service families require separate materiality and inclusion checks.

#### Ferries

Source:

```text
https://transport.vic.gov.au/plan-a-journey/travel-tips-and-resources/ferries
```

Finding posture:

```yaml
item: Ferries
source_authority: Transport Victoria
reported_services:
  - Western Port Ferry
  - Westgate Punt
  - Port Phillip Ferries
GTFS_static_representation: not_confirmed
coverage_against_GCCSA: unresolved
reason_it_may_matter: "Ferry services may serve parts of Greater Melbourne GCCSA or cross-boundary travel, but ferry mode is not visible in the inspected GTFS Schedule folder list."
next_action: "Determine which ferry services intersect Greater Melbourne GCCSA and whether they are scheduled public transport, private passenger services, tourist/leisure services, or excluded overlays."
```

#### FlexiRide / on-demand bus

Sources:

```text
https://transport.vic.gov.au/plan-a-journey/travel-tips-and-resources/flexiride-on-demand-bus-service
https://opendata.transport.vic.gov.au/News-and-Updates/Streamlining-Timetable-Data
```

Finding posture:

```yaml
item: FlexiRide / on-demand bus
source_authority: Transport Victoria
reported_character: "On-demand bus service with no fixed route."
GTFS_static_representation: unresolved
coverage_against_GCCSA: unresolved
reason_it_may_matter: "On-demand services are not equivalent to fixed-route GTFS and may require separate treatment."
next_action: "Identify whether any FlexiRide zones are inside Greater Melbourne GCCSA and decide whether they are included, excluded, or reported separately in V1 service-source coverage."
```

#### School buses

Sources:

```text
https://transport.vic.gov.au/plan-a-journey/travel-tips-and-resources/school-bus-networks-and-bus-stops
https://www2.education.vic.gov.au/pal/school-bus-program/policy
```

Finding posture:

```yaml
item: School bus networks / school bus program
source_authority:
  - Department of Transport and Planning
  - Department of Education
reported_character: "School transport / eligible school bus network, especially rural/regional school transport."
GTFS_static_representation: unresolved
coverage_against_GCCSA: unresolved
reason_it_may_matter: "Usually not general public fixed-route transport; may be excluded from ordinary resident access measures or handled as special-purpose service."
next_action: "Quarantine unless a future indicator explicitly requires school-service coverage."
```

#### Airport services and SkyBus

Sources:

```text
https://transport.vic.gov.au/plan-a-journey/travel-tips-and-resources/getting-to-and-from-melbourne-and-avalon-airports
https://www.skybus.com.au/
```

Finding posture:

```yaml
item: Airport bus services / SkyBus
source_authority:
  - Transport Victoria
  - SkyBus
GTFS_static_representation: "Folder 11 SkyBus appears in DTP GTFS Schedule folder structure; exact rows not inspected."
coverage_against_GCCSA: unresolved
reason_it_may_matter: "SkyBus is airport-oriented, has separate fare/payment treatment, and cannot use myki according to Transport Victoria."
next_action: "Verify whether SkyBus services are inside or cross-boundary relative to Greater Melbourne GCCSA and whether they count for ordinary access indicators."
```

#### Regional train, regional coach, regional bus, interstate

Source:

```text
https://opendata.transport.vic.gov.au/dataset/gtfs-schedule
```

Finding posture:

```yaml
item: Regional train / regional coach / regional bus / interstate folders
source_authority: Department of Transport and Planning
GTFS_static_representation: "Reported as part of the GTFS Schedule folder structure."
coverage_against_GCCSA: unresolved
reason_it_may_matter: "Greater Melbourne GCCSA may include peripheral areas where regional services are relevant; scheduled-service overlay should not silently omit them."
next_action: "When the feed is archived, build a mode/operator manifest and clip/analyze against the GCCSA polygon without using service geography as the denominator."
```

#### Demand-responsive / paratransit / subsidized taxi

Source:

```text
https://cpv.vic.gov.au/passengers/mptp/using-your-card/trip-restrictions
```

Finding posture:

```yaml
item: Multi Purpose Taxi Program / subsidized taxi or commercial passenger vehicle support
source_authority: Commercial Passenger Vehicles Victoria
GTFS_static_representation: no
coverage_against_GCCSA: unresolved
reason_it_may_matter: "Potential accessibility context, not fixed-route public-transport coverage."
next_action: "Quarantine for possible accessibility/universal-access source note; do not include in fixed-route service bundle."
```

### 6.4 Service-bundle status

```yaml
service_bundle_status:
  primary_static_feed_source_identified: true
  primary_static_feed_downloaded: false
  primary_static_feed_license_path_identified: true
  primary_static_feed_modes_broadly_identified: true
  coverage_against_GCCSA_resolved: false
  operator_completeness_resolved: false
  non_fixed_route_modes_resolved: false
  use_as_boundary_or_denominator: prohibited
```

## 7. Rejected/quarantined material

| Item | Status | Reason |
|---|---|---|
| Greater Melbourne GCCSA as accepted MTR | Rejected for this return | Source path verification does not admit an MTR. Boundary-fit and readiness review still required. |
| GTFS Schedule service extent as boundary | Rejected | Service-derived geography can hide unserved populations and cannot define the MTR denominator. |
| PTV Timetable API or GTFS-RT coverage as boundary | Rejected | Dynamic service data are indicator inputs or overlays only. |
| Stops, route buffers, agency service areas, fare zones, myki coverage | Rejected | Service/gov/fare geographies are prohibited as primary MTR denominators for this task. |
| DTP/PTV operator coverage as proof of transport quality | Rejected | This task is source-bundle verification only, not performance analysis. |
| Livability, reputation, best-transit-city, congestion, walkability, or city-interest material | Rejected | Outcome-adjacent selection material violates the Thesis 2 source-led guardrail. |
| ABS GCCSA population value as a score or comparison input | Rejected | Population denominator source path may be verified, but no comparison or scoring is performed. |
| Ferries as part of primary GTFS bundle without separate evidence | Quarantined | Transport Victoria documents ferry services, but representation in DTP/PTV GTFS Schedule is unresolved. |
| FlexiRide as fixed-route GTFS service | Quarantined | On-demand/no-fixed-route service requires separate treatment. |
| School buses as ordinary public transport | Quarantined | School-service networks are special-purpose and require an explicit inclusion rule. |
| SkyBus as ordinary local public transport | Quarantined | Airport-oriented service with separate fare/payment treatment; GTFS representation and indicator inclusion must be verified. |
| Multi Purpose Taxi Program as fixed-route service | Quarantined | Accessibility/paratransit context only; not GTFS fixed-route coverage. |

## 8. Open questions for Thesis 2

1. Should `2GMEL` be admitted as the exact boundary identifier for the Greater Melbourne source lead after raw ABS boundary geometry is archived, or does the broad GCCSA functional/statistical scope require an additional boundary-fit screen first?

2. Should the future boundary record use the GCCSA shapefile, the Main Structure/GCCSA GeoPackage, or both, and should GDA2020 be the default spatial reference for stored geometry?

3. Should the population denominator use current ABS ERP from the Regional Population table, 2021 Census usual-residence population, or both with a reconciliation note?

4. What exact raw population field should be persisted from the ABS Regional Population workbook for GCCSA `2GMEL` after acquisition?

5. Should the official ABS allocation workbook `GCCSA_2021_AUST.xlsx` be the authoritative SA4-membership source, or should membership be extracted from the SA4 boundary file using `GCCSA_CODE_2021 = 2GMEL`?

6. Does the working SA4 membership list require a separate source-note artifact before it can be used by infrastructure?

7. Should every ASGS GCCSA boundary record include the ABS caveat that ASGS approximations may differ from official or commonly understood boundaries?

8. Should ASGS Edition 4 release timing block long-lived boundary admission, or should Edition 3 remain valid until an Edition 4 migration review is complete?

9. What minimum operator/mode completeness threshold is required before the Victoria DTP/PTV GTFS Schedule bundle can be considered usable for a first service-coverage method test?

10. Should ferry services be included in ordinary public transport coverage if they are scheduled passenger services but are not represented in the inspected GTFS Schedule folder list?

11. Should FlexiRide/on-demand services be excluded from fixed-route coverage indicators, included as a separate accessibility supplement, or handled through a special source note?

12. Should airport services such as SkyBus be included in ordinary service coverage, excluded as premium/special-purpose airport service, or included only for airport-access indicators?

13. Should school-bus services and the School Bus Program be excluded from ordinary resident access indicators by default?

14. Should GTFS Realtime / PTV API be part of the first evidence manifest, or deferred until reliability indicators are in scope?

15. Should source-rich-region bias be logged for Greater Melbourne, given strong ABS and DTP/PTV source paths compared with less source-rich jurisdictions?

## 9. Source URL list

```text
ABS — Australian Statistical Geography Standard Edition 3
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/latest-release

ABS — Greater Capital City Statistical Areas
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/main-structure-and-greater-capital-city-statistical-areas/greater-capital-city-statistical-areas

ABS — ASGS Edition 3 Access and downloads
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads

ABS — ASGS Edition 3 Digital Boundary Files
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/digital-boundary-files

ABS — GCCSA 2021 Shapefile GDA2020 direct path
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/digital-boundary-files/GCCSA_2021_AUST_SHP_GDA2020.zip

ABS — ASGS Edition 3 Allocation Files
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/allocation-files

ABS — GCCSA 2021 Allocation Workbook direct path
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/allocation-files/GCCSA_2021_AUST.xlsx

ABS — ASGS Edition 3 Correspondences
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/correspondences

ABS — 2021 Census Community Profiles: Greater Melbourne
https://www.abs.gov.au/census/find-census-data/community-profiles/2021/2GMEL

ABS — 2021 Census QuickStats: Greater Melbourne
https://www.abs.gov.au/census/find-census-data/quickstats/2021/2GMEL

ABS — Regional Population latest release
https://www.abs.gov.au/statistics/people/population/regional-population/latest-release

ABS — Population estimates by SA2 and above, 2001 to 2025
https://www.abs.gov.au/statistics/people/population/regional-population/2024-25/32180DS0003_2001-25.xlsx

Transport Victoria Open Data — GTFS Schedule
https://opendata.transport.vic.gov.au/dataset/gtfs-schedule

DataVic / DTP — PTV Timetable and Geographic Information 2015 - GTFS
https://discover.data.vic.gov.au/dataset/ptv-timetable-and-geographic-information-2015-gtfs

Transport Victoria — Public Transport Timetable API FAQs
https://www.vic.gov.au/public-transport-timetable-api-faqs

DataVic / DTP — PTV Timetable API
https://discover.data.vic.gov.au/dataset/ptv-timetable-api

DataVic / DTP — GTFS Realtime
https://discover.data.vic.gov.au/dataset/gtfs-realtime

DataVic / DTP — GTFS Realtime Bus Trip Updates resource
https://opendata.transport.vic.gov.au/dataset/gtfs-realtime/resource/c2cbf93f-5d29-4f91-86a9-95811291996d

Transport Victoria — Ferries
https://transport.vic.gov.au/plan-a-journey/travel-tips-and-resources/ferries

Transport Victoria — FlexiRide on-demand bus service
https://transport.vic.gov.au/plan-a-journey/travel-tips-and-resources/flexiride-on-demand-bus-service

Transport Victoria Open Data — Streamlining Timetable Data
https://opendata.transport.vic.gov.au/News-and-Updates/Streamlining-Timetable-Data

Transport Victoria — School bus networks and bus stops
https://transport.vic.gov.au/plan-a-journey/travel-tips-and-resources/school-bus-networks-and-bus-stops

Victoria Department of Education — School Bus Program
https://www2.education.vic.gov.au/pal/school-bus-program/policy

Transport Victoria — Getting to and from Melbourne and Avalon airports
https://transport.vic.gov.au/plan-a-journey/travel-tips-and-resources/getting-to-and-from-melbourne-and-avalon-airports

SkyBus
https://www.skybus.com.au/

Commercial Passenger Vehicles Victoria — Multi Purpose Taxi Program
https://cpv.vic.gov.au/passengers/mptp/using-your-card/trip-restrictions
```
