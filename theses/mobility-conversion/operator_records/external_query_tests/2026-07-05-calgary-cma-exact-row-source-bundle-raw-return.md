# Raw Return: Calgary CMA Exact Row / Source Bundle

Date: 2026-07-05

Status: raw research material only. This is not evidence, not source truth, not an accepted Metropolitan Transport Region, not a candidate-universe record, not a boundary record, not a metric record, not a score, not a ranking, and not paper prose.

Thesis: Mobility Conversion

Working lead: `mtr_src_005` / Calgary CMA

Use term: Metropolitan Transport Region / MTR

Do not use: Metropolitan Transit Region

---

## 1. Short method summary

This return checks whether the Calgary CMA lead has traceable official sources for:

- exact Statistics Canada 2021 Census geography identity;
- 2021 Census boundary artifact path;
- matching population-denominator source path;
- building-block / census-subdivision source path;
- Calgary CMA methodology caveats;
- Calgary Transit and surrounding regional service-source overlays.

No raw datasets were downloaded. No feeds were archived. No population coverage was calculated. No score, ranking, or MTR admission decision is made here.

The main finding is that the Calgary CMA identity is traceable to Statistics Canada geography code `825` and DGUID `2021S0503825`. The boundary layer path is traceable to the 2021 Cartographic Boundary Files CMA layer `CMA - lcma000b21s_e` / ArcGIS layer ID `6`. The population denominator can be sourced from Statistics Canada 2021 Census Profile / population and dwelling count tables / GeoSuite, but exact raw table rows still need to be downloaded or archived by the evidence-manifest process.

The service-source check indicates that Calgary Transit GTFS is a primary local fixed-route source, but it is not sufficient by itself to represent all public-transport services inside the full Calgary CMA without an operator-completeness reconciliation. Airdrie and Cochrane have separate or related local/regional services; Chestermere has Calgary Transit extension service and separate handi-bus / paratransit leads. Service geography must not define the MTR denominator.

---

## 2. Source table

| Use | Source title | Authority | URL / access path | Verification status | Notes |
|---|---|---|---|---|---|
| Exact CMA code/name source | 2021 Census reference map — Southern Alberta CMAs/CAs | Statistics Canada | `https://www12.statcan.gc.ca/census-recensement/2021/geo/maps-cartes/referencemaps-cartesdereference/sgc-cgt/map-eng.cfm?SGC=02_16` | Code/name traceable | Page table maps `825` to `Calgary`, type `CMA`. |
| Exact DGUID/name source | Census Profile, 2021 Census of Population — Calgary CMA | Statistics Canada | `https://www12.statcan.gc.ca/census-recensement/2021/dp-pd/prof/details/page.cfm?DGUIDlist=2021S0503825&GENDERlist=1&HEADERlist=0&Lang=E&STATISTIClist=1&SearchText=Calgary` | DGUID/name path traceable | Profile URL directly uses `DGUIDlist=2021S0503825`. |
| Exact DGUID/name source | Focus on Geography Series — Calgary (CMA) | Statistics Canada | `https://www12.statcan.gc.ca/census-recensement/2021/as-sa/fogs-spg/alternative.cfm?dguid=2021S0503825&lang=e&objectId=1&topic=2` | DGUID/name path traceable | Focus-on-Geography URL directly uses `dguid=2021S0503825` and titles the geography as Calgary (CMA). |
| Boundary product source | 2021 Census Boundary Files | Statistics Canada / Government of Canada / Geo.ca | `https://app.geo.ca/en-ca/map-browser/record/ef70dc3b-1069-4037-9bce-61f47e628a1d` | Product path traceable | Product includes 2021 boundary files for standard geographies including CMAs/CAs and DGUID linkage. |
| Boundary layer source | 2021 Cartographic Boundary Files — CMA - `lcma000b21s_e` | Statistics Canada | `https://geo.statcan.gc.ca/geo_wa/rest/services/2021/Cartographic_boundary_files/MapServer/6` | Layer path traceable | ArcGIS REST layer ID `6`, polygon feature layer; fields include `CMAUID`, `DGUID`, `CMANAME`, `CMATYPE`, `PRUID`, `LANDAREA`. |
| Population denominator | Table 98-10-0005-01: Population and dwelling counts | Statistics Canada | `https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=9810000501` | Source path traceable | CMA/CA-level population and dwelling counts; 2021 and 2016 Census universe. |
| Population / geography hierarchy | 2021 GeoSuite Data Package | Statistics Canada | `https://www150.statcan.gc.ca/n1/pub/92-150-g/92-150-g2021001-eng.htm` | Source path traceable | Provides geographic identifiers, names, population counts, dwelling counts, land area, coordinates, and relationships between geographies. |
| CMA/CA definition and rules | Illustrated Glossary: Census metropolitan area and census agglomeration | Statistics Canada | `https://www150.statcan.gc.ca/n1/pub/92-195-x/2021001/geo/cma-rmr/cma-rmr-eng.htm` | Method source traceable | Defines CMA/CA and rules including CSD building blocks, forward/reverse commuting flows, contiguity, historical comparability, manual adjustments, merging and secondary cores. |
| 2021 delineation inputs | Preliminary 2021 CMA/CA delineation | Statistics Canada | `https://www150.statcan.gc.ca/n1/pub/92f0138m/92f0138m2019002-eng.htm` | Method source traceable | Describes preliminary 2021 delineation using 2016 Census place-of-work commuting data and 2018 CSD boundaries. |
| Primary local service feed | Calgary Transit Scheduling Data | City of Calgary / Calgary Transit / Open Calgary | `https://data.calgary.ca/Transportation-Transit/Calgary-Transit-Scheduling-Data/npk7-z3bj` | Source path traceable | GTFS static schedule/routing source. Exact feed archive/vintage must be captured later. |
| Calgary Transit real-time | Calgary Transit Realtime Vehicle Positions / Trip Updates | City of Calgary / Calgary Transit / Open Calgary | `https://data.calgary.ca/Transportation-Transit/Calgary-Transit-Realtime-Vehicle-Positions-GTFS-RT/am7c-qe3u`; `https://data.calgary.ca/Transportation-Transit/Calgary-Transit-Realtime-Trip-Updates-GTFS-RT/gs4m-mdc2` | Source path traceable | GTFS-Realtime source family; not needed to define boundary. |
| Open data terms | Open Calgary Terms of Use | City of Calgary | `https://data.calgary.ca/stories/s/Open-Calgary-Terms-of-Use/u45n-7awa/` | Terms path traceable | Use for licensing/access notes after intake verification. |
| National GTFS overlay | Canadian Public Transit Network Database | Statistics Canada | `https://www150.statcan.gc.ca/n1/en/catalogue/23-26-0001` | Overlay source path traceable | Consolidated national GTFS dataset; useful as service-source inventory/validation, not denominator. |
| Regional/local service lead | Airdrie Transit services and routes | City of Airdrie | `https://www.airdrie.ca/index.cfm?serviceID=2196`; `https://www.airdrie.ca/index.cfm?serviceID=2221` | Service lead traceable | Separate local/intercity/on-demand/paratransit services need operator-completeness review. |
| Regional/local service lead | Cochrane Transit / COLT | Town of Cochrane | `https://www.cochrane.ca/145/Cochrane-Transit`; `https://www.cochrane.ca/1012/On-Request-Transit` | Service lead traceable | Local fixed-route and on-request transit; regional service links require timestamped verification. |
| Regional/local service lead | Chestermere Transit Link / Calgary Transit regional extension | City of Chestermere / Calgary Transit | `https://thecityofchestermere.ca/cityservices/transit/`; `https://www.calgarytransit.com/content/transit/en/home/rider-information/regional-transit.html` | Service lead traceable | Calgary Transit extension to Chestermere likely included in Calgary Transit source; verify exact feed representation later. |
| Paratransit / demand-responsive lead | Chestermere Handi-Bus / Rocky View Regional Handi Bus | City of Chestermere / Rocky View Regional Handi Bus | `https://thecityofchestermere.ca/cityservices/chestermere-handi-bus/` | Service lead traceable | Demand-responsive/paratransit source; not expected in GTFS static feed without verification. |
| Regional service caveat | On-It Regional Transit Cochrane service update | On-It Regional Transit | `https://www.onitregionaltransit.ca/` | Service-status lead only | Source indicated Cochrane-Calgary services ending in 2026; exact archive/status requires timestamped verification. |
| Airport service context | YYC public transit page | Calgary Airport Authority | `https://www.yyc.com/en-us/navigatingyyc/transportation/publictransit.aspx` | Context source traceable | Airport bus routes are Calgary Transit routes; source is context only, not a boundary source. |

---

## 3. YAML-style raw source bundle

```yaml
calgary_cma_exact_row_return:
  return_status: raw_research_material_only

  reviewed_boundary:
    working_name: Calgary CMA
    source_authority: Statistics Canada
    exact_name: Calgary
    exact_code: "825"
    DGUID_or_equivalent: "2021S0503825"
    geography_type: Census metropolitan area (CMA)
    source_url_or_access_path:
      - "https://www12.statcan.gc.ca/census-recensement/2021/geo/maps-cartes/referencemaps-cartesdereference/sgc-cgt/map-eng.cfm?SGC=02_16"
      - "https://www12.statcan.gc.ca/census-recensement/2021/dp-pd/prof/details/page.cfm?DGUIDlist=2021S0503825&GENDERlist=1&HEADERlist=0&Lang=E&STATISTIClist=1&SearchText=Calgary"
      - "https://www12.statcan.gc.ca/census-recensement/2021/as-sa/fogs-spg/alternative.cfm?dguid=2021S0503825&lang=e&objectId=1&topic=2"
    verification_status: code_and_dguid_traceable__exact_boundary_feature_row_not_downloaded

  boundary_artifact:
    product_title: 2021 Cartographic Boundary Files — Census metropolitan area / census agglomeration layer
    catalogue_or_download_path:
      - "https://app.geo.ca/en-ca/map-browser/record/ef70dc3b-1069-4037-9bce-61f47e628a1d"
      - "https://geo.statcan.gc.ca/geo_wa/rest/services/2021/Cartographic_boundary_files/MapServer"
      - "https://geo.statcan.gc.ca/geo_wa/rest/services/2021/Cartographic_boundary_files/MapServer/6"
    file_or_layer: "CMA - lcma000b21s_e; ArcGIS REST MapServer layer ID 6"
    vintage: "2021 Census boundary product; service publication date 2022-09-21; standard geography reference date 2021-01-01"
    identifier_field:
      - CMAUID
      - DGUID
      - CMANAME
      - CMATYPE
      - PRUID
      - LANDAREA
    raw_download_required_later: true

  population_denominator:
    source_title:
      - Census Profile, 2021 Census of Population
      - Table 98-10-0005-01 — Population and dwelling counts: Canada, provinces and territories, census metropolitan areas and census agglomerations
      - 2021 GeoSuite Data Package
    source_url_or_access_path:
      - "https://www12.statcan.gc.ca/census-recensement/2021/dp-pd/prof/details/page.cfm?DGUIDlist=2021S0503825&GENDERlist=1&HEADERlist=0&Lang=E&STATISTIClist=1&SearchText=Calgary"
      - "https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=9810000501"
      - "https://www150.statcan.gc.ca/n1/pub/92-150-g/92-150-g2021001-eng.htm"
    geography_identifier: "2021S0503825 / CMAUID 825"
    population_field: "Population, 2021; equivalent GeoSuite 2021 population-count field after exact CSV extraction"
    vintage: "2021 Census of Population; Census Day 2021-05-11; standard geography reference date 2021-01-01"
    value_returned: do_not_return_value_unless_needed_for_source_identification
    verification_status: population_source_path_verified__exact_table_or_csv_row_not_downloaded

  building_blocks:
    census_subdivisions_or_municipalities:
      - Airdrie (City)
      - Beiseker (Village)
      - Calgary (City)
      - Chestermere (City)
      - Cochrane (Town)
      - Crossfield (Town)
      - Irricana (Town)
      - Rocky View County (Municipal district)
      - Tsuu T'ina Nation 145 (Indian reserve)
    source_url_or_access_path:
      - "https://www12.statcan.gc.ca/census-recensement/2021/as-sa/fogs-spg/alternative.cfm?dguid=2021S0503825&lang=e&objectId=9d&topic=3"
      - "https://www150.statcan.gc.ca/n1/pub/92-150-g/92-150-g2021001-eng.htm"
    uncertainty_notes:
      - "The listed CSDs were traced through official Statistics Canada Focus-on-Geography result paths/snippets and should be confirmed through GeoSuite or an official CMA-to-CSD relationship table before being admitted as a boundary record."
      - "Exact CSD UID/DGUID values were not extracted in this raw return."

  methodology_caveats:
    commuting_flow_vintage: "Statistics Canada preliminary 2021 CMA/CA delineation documentation says preliminary delineation used 2016 Census place-of-work commuting data and 2018 CSD boundaries."
    historical_comparability: "General CMA/CA historical-comparability rule exists. No Calgary-specific historical-comparability caveat was found in inspected sources."
    manual_adjustment: "General CMA/CA manual-adjustment rule exists. No Calgary-specific manual-adjustment caveat was found in inspected sources."
    merge_or_secondary_core: "General merge/secondary-core rule exists. Inspected preliminary 2021 merge examples did not identify Calgary. Calgary-specific final merge/secondary-core status remains unverified until exact GeoSuite/geography relationship notes are inspected."
    source_url_or_access_path:
      - "https://www150.statcan.gc.ca/n1/pub/92-195-x/2021001/geo/cma-rmr/cma-rmr-eng.htm"
      - "https://www150.statcan.gc.ca/n1/pub/92f0138m/92f0138m2019002-eng.htm"

  service_source_bundle:
    primary_service_source: Calgary Transit Scheduling Data
    source_authority: City of Calgary / Calgary Transit / Open Calgary
    source_url_or_access_path:
      - "https://data.calgary.ca/Transportation-Transit/Calgary-Transit-Scheduling-Data/npk7-z3bj"
      - "https://data.calgary.ca/Transportation-Transit/Calgary-Transit-Realtime-Vehicle-Positions-GTFS-RT/am7c-qe3u"
      - "https://data.calgary.ca/Transportation-Transit/Calgary-Transit-Realtime-Trip-Updates-GTFS-RT/gs4m-mdc2"
      - "https://data.calgary.ca/stories/s/Open-Calgary-Terms-of-Use/u45n-7awa/"
    format:
      - GTFS static schedule/routing files
      - GTFS-Realtime vehicle positions
      - GTFS-Realtime trip updates
    vintage_or_update_date: "Static feed vintage must be captured from the feed/Socrata metadata during raw-data acquisition. GTFS-RT source pages indicate very frequent update cadence, but exact observation window is not defined here."
    license_or_access_terms: "Open Calgary Terms of Use; terms path verified but exact license text should be archived during evidence-manifest intake."
    coverage_against_CMA: "Unresolved. Calgary Transit is a primary fixed-route source for the City of Calgary and includes YYC airport routes plus a Chestermere MAX Purple extension lead. It must not be assumed to cover the full Calgary CMA."
    missing_operators_or_modes:
      - "Airdrie Transit local, intercity, on-demand, and ACCESS Airdrie services are separate source leads."
      - "Cochrane Transit / COLT local fixed-route and on-request services are separate source leads."
      - "Chestermere Handi-Bus / Rocky View Regional Handi Bus demand-responsive or paratransit source lead."
      - "On-It / Cochrane-Calgary regional commuter service status requires timestamped verification; source lead indicated 2026 discontinuation for some Cochrane-Calgary services."
      - "Private/intercity/airport/mountain shuttles are quarantined unless Thesis 2 later includes private or intercity services."

  rejected_or_quarantined_material:
    - item: Calgary Transit GTFS extent, route buffers, stop buffers, fare zones, or agency coverage
      reason: Service-derived geography cannot define the MTR denominator and can hide unserved population.
    - item: Airdrie Transit, Cochrane Transit, Chestermere Transit Link, or handi-bus service areas as MTR boundaries
      reason: Governance/service areas are overlays or indicator-source leads only, not primary denominators.
    - item: YYC airport bus route pages as boundary evidence
      reason: Airport transit pages document service context only and cannot define MTR geography.
    - item: Private airport, Banff, Canmore, mountain, intercity, or tourism shuttles
      reason: Quarantined unless Thesis 2 scope later admits private/intercity services as material transport-source overlays.
    - item: Alberta Regional Dashboard municipality list
      reason: Potentially useful supporting pointer, but not primary enough for official boundary evidence where Statistics Canada source paths exist.
```

---

## 4. Exact geography row/code findings

### 4.1 Exact name and code

The exact reviewed geography identity is:

```yaml
exact_name: Calgary
exact_code: "825"
DGUID_or_equivalent: "2021S0503825"
geography_type: Census metropolitan area (CMA)
source_authority: Statistics Canada
```

The Statistics Canada 2021 Census reference-map table for southern Alberta CMAs/CAs maps `825` to `Calgary` with type `CMA`.

Source path:

```text
https://www12.statcan.gc.ca/census-recensement/2021/geo/maps-cartes/referencemaps-cartesdereference/sgc-cgt/map-eng.cfm?SGC=02_16
```

The Statistics Canada Census Profile path directly uses:

```text
DGUIDlist=2021S0503825
```

and identifies the geography as Calgary CMA.

Source path:

```text
https://www12.statcan.gc.ca/census-recensement/2021/dp-pd/prof/details/page.cfm?DGUIDlist=2021S0503825&GENDERlist=1&HEADERlist=0&Lang=E&STATISTIClist=1&SearchText=Calgary
```

The Focus on Geography path also uses:

```text
dguid=2021S0503825
```

Source path:

```text
https://www12.statcan.gc.ca/census-recensement/2021/as-sa/fogs-spg/alternative.cfm?dguid=2021S0503825&lang=e&objectId=1&topic=2
```

### 4.2 Exact feature row status

The exact code and DGUID are traceable from official source paths. The exact boundary-feature row itself was not downloaded or archived in this raw return.

Required later evidence-manifest action:

```yaml
required_later:
  - download_or_query_boundary_layer: "CMA - lcma000b21s_e / MapServer layer 6"
  - filter_identifier: "CMAUID = '825' or DGUID = '2021S0503825'"
  - archive_raw_geometry
  - record_geometry_download_url_or_query
  - record_retrieval_date
```

---

## 5. Boundary/population artifact findings

### 5.1 Boundary product and layer

The boundary artifact path is traceable to the Statistics Canada 2021 Census Boundary Files. The relevant feature layer is:

```yaml
product_title: 2021 Cartographic Boundary Files
service_name: 2021/Cartographic_boundary_files
layer_name: CMA - lcma000b21s_e
layer_id: 6
feature_type: polygon
identifier_fields:
  - CMAUID
  - CMAPUID
  - DGUID
  - CMANAME
  - CMATYPE
  - LANDAREA
  - PRUID
```

Product and layer access paths:

```text
https://app.geo.ca/en-ca/map-browser/record/ef70dc3b-1069-4037-9bce-61f47e628a1d
https://geo.statcan.gc.ca/geo_wa/rest/services/2021/Cartographic_boundary_files/MapServer
https://geo.statcan.gc.ca/geo_wa/rest/services/2021/Cartographic_boundary_files/MapServer/6
```

The product source says 2021 Census Boundary Files depict the boundaries of standard geographic areas for which 2021 Census data are disseminated and include identifiers/name/type/land area/PRUID fields with DGUID linkage.

The ArcGIS layer source identifies `CMA - lcma000b21s_e` as a polygon feature layer and exposes the fields required to filter Calgary by `CMAUID`, `DGUID`, or `CMANAME`.

### 5.2 Boundary vintage

Working vintage notes:

```yaml
boundary_vintage: 2021 Census boundary file
standard_geography_reference_date: 2021-01-01
service_publication_date: 2022-09-21
coordinate_reference_system: Statistics Canada service indicates Lambert Conformal Conic / NAD83 / EPSG 3347 in service metadata
```

These values should be re-read from the downloaded artifact metadata during evidence-manifest intake.

### 5.3 Population denominator

The same geography identifier can be used to obtain 2021 Census population from Statistics Canada sources.

Preferred source-family options:

```yaml
option_1:
  source: Census Profile, 2021 Census of Population
  use: direct profile row by DGUID
  geography_identifier: "2021S0503825"
  field: "Population, 2021"
  value: not_returned_by_instruction

option_2:
  source: Table 98-10-0005-01
  use: population and dwelling count table for CMA/CA
  geography_identifier: "Calgary CMA / 2021S0503825 / CMAUID 825"
  field: "Population, 2021"
  value: not_returned_by_instruction

option_3:
  source: 2021 GeoSuite Data Package
  use: tabular geography hierarchy, identifiers, names, population counts, dwelling counts, and links between geographies
  geography_identifier: "2021S0503825 / CMAUID 825"
  field: exact GeoSuite population field to be extracted later
  value: not_returned_by_instruction
```

Source paths:

```text
https://www12.statcan.gc.ca/census-recensement/2021/dp-pd/prof/details/page.cfm?DGUIDlist=2021S0503825&GENDERlist=1&HEADERlist=0&Lang=E&STATISTIClist=1&SearchText=Calgary
https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=9810000501
https://www150.statcan.gc.ca/n1/pub/92-150-g/92-150-g2021001-eng.htm
```

Use field:

```yaml
population_field: Population, 2021
census_vintage: 2021 Census of Population
census_day: 2021-05-11
```

### 5.4 Building blocks / included census subdivisions

The Calgary CMA building-block list found in official Statistics Canada Focus-on-Geography paths/snippets is:

```yaml
calgary_cma_csd_leads:
  - Airdrie (City)
  - Beiseker (Village)
  - Calgary (City)
  - Chestermere (City)
  - Cochrane (Town)
  - Crossfield (Town)
  - Irricana (Town)
  - Rocky View County (Municipal district)
  - Tsuu T'ina Nation 145 (Indian reserve)
```

Source path lead:

```text
https://www12.statcan.gc.ca/census-recensement/2021/as-sa/fogs-spg/alternative.cfm?dguid=2021S0503825&lang=e&objectId=9d&topic=3
```

Uncertainty:

```yaml
building_block_status: source_lead_only
reason: Exact CSD UID/DGUID rows and formal relationship-table extraction were not performed.
required_later:
  - extract GeoSuite CMA-to-CSD relationship or equivalent official hierarchy table
  - archive CSD list with CSDUID/DGUID/name/type/province
  - verify whether the list above is complete for 2021 geography
```

### 5.5 CMA/CA methodology caveats

Statistics Canada methodology sources identify these general CMA/CA rules:

```yaml
building_blocks: census_subdivisions
core_thresholds:
  CMA: total_population_at_least_100000_and_core_population_at_least_50000
integration_measure: commuting_flows_from_previous_Census
forward_commuting_rule: CSD included if at least 100 workers and at least 50% of employed labour force living in CSD works in delineation core
reverse_commuting_rule: CSD included if at least 100 workers and at least 50% of employed labour force working in CSD lives in delineation core
other_rules:
  - spatial contiguity
  - historical comparability
  - manual adjustments
  - merging adjacent CMA/CA where commuting interchange threshold is met
  - secondary core designation after merger
```

Source paths:

```text
https://www150.statcan.gc.ca/n1/pub/92-195-x/2021001/geo/cma-rmr/cma-rmr-eng.htm
https://www150.statcan.gc.ca/n1/pub/92f0138m/92f0138m2019002-eng.htm
```

Calgary-specific caveat status:

```yaml
calgary_specific_historical_comparability: not_found_in_inspected_sources
calgary_specific_manual_adjustment: not_found_in_inspected_sources
calgary_specific_merge_or_secondary_core: not_found_in_inspected_sources
unverified_note: Absence in inspected pages is not proof of absence in all Statistics Canada geography files. Codex should verify exact GeoSuite or CMA/CA relationship notes before treating this as evidence.
```

---

## 6. Service/operator coverage findings

### 6.1 Primary Calgary Transit source

The primary local fixed-route source path is:

```yaml
source_title: Calgary Transit Scheduling Data
source_authority: City of Calgary / Calgary Transit / Open Calgary
url: "https://data.calgary.ca/Transportation-Transit/Calgary-Transit-Scheduling-Data/npk7-z3bj"
format: GTFS static schedule/routing data
status: source_path_traceable__feed_not_downloaded
```

Related real-time source paths:

```yaml
vehicle_positions:
  title: Calgary Transit Realtime Vehicle Positions (GTFS-RT)
  url: "https://data.calgary.ca/Transportation-Transit/Calgary-Transit-Realtime-Vehicle-Positions-GTFS-RT/am7c-qe3u"
trip_updates:
  title: Calgary Transit Realtime Trip Updates (GTFS-RT)
  url: "https://data.calgary.ca/Transportation-Transit/Calgary-Transit-Realtime-Trip-Updates-GTFS-RT/gs4m-mdc2"
```

License/access path:

```text
https://data.calgary.ca/stories/s/Open-Calgary-Terms-of-Use/u45n-7awa/
```

Working notes:

```yaml
static_feed_vintage: must_be_captured_from_feed_or_Socrata_metadata_later
real_time_update_cadence: source snippets indicate frequent updates; exact metadata must be archived later
license_status: terms_path_traceable__exact_terms_text_not_archived_here
```

Boundary guardrail:

```yaml
service_extent_not_denominator: true
reason: Calgary Transit GTFS coverage is service-derived and may omit unserved population or other operators within the CMA.
```

### 6.2 Airdrie service-source leads

Airdrie is a CSD lead inside the Calgary CMA and appears to have separate local/intercity/on-demand service sources.

Source paths:

```text
https://www.airdrie.ca/index.cfm?serviceID=2196
https://www.airdrie.ca/index.cfm?serviceID=2221
https://services2.arcgis.com/1RNnEWcGdF9v8pNU/arcgis/rest/services/Transit_Bus_Routes/FeatureServer
```

Working service notes:

```yaml
airdrie_services_lead:
  - local routes
  - intercity express routes to Calgary leads
  - Hello To Go on-demand lead
  - ACCESS Airdrie paratransit lead
status: material_operator_or_service_lead__not_integrated_into_Calgary_Transit_GTFS_without_verification
```

### 6.3 Chestermere service-source leads

Chestermere is a CSD lead inside the Calgary CMA. Public sources indicate a Calgary Transit extension serving Chestermere and separate handi-bus/paratransit leads.

Source paths:

```text
https://thecityofchestermere.ca/cityservices/transit/
https://www.calgarytransit.com/content/transit/en/home/rider-information/regional-transit.html
https://thecityofchestermere.ca/cityservices/chestermere-handi-bus/
```

Working service notes:

```yaml
chestermere_services_lead:
  - Calgary Transit MAX Purple extension / Chestermere Transit Link lead
  - Chestermere Handi-Bus / Rocky View Regional Handi Bus lead
coverage_against_CMA: unresolved
GTFS_representation: likely_requires_feed_check
```

### 6.4 Cochrane service-source leads

Cochrane is a CSD lead inside the Calgary CMA. Public sources indicate local fixed-route and on-request service, plus regional service leads requiring time-stamped verification.

Source paths:

```text
https://www.cochrane.ca/145/Cochrane-Transit
https://www.cochrane.ca/1012/On-Request-Transit
https://www.onitregionaltransit.ca/
```

Working service notes:

```yaml
cochrane_services_lead:
  - local fixed-route transit
  - on-request transit
  - regional commuter-service leads
  - volunteer/handi-bus/regional support-service leads
coverage_against_CMA: unresolved
current_service_status: some regional Cochrane-Calgary service leads require timestamped verification because inspected source snippets indicated 2026 discontinuations
```

### 6.5 YYC airport service context

YYC airport public-transit pages document Calgary Transit bus routes to and from the airport. This appears to be Calgary Transit service context rather than a separate operator boundary source.

Source paths:

```text
https://www.yyc.com/en-us/navigatingyyc/transportation/publictransit.aspx
https://www.yyc.com/en-us/navigatingyyc/transportation/default.aspx
```

Working note:

```yaml
airport_service_context: Calgary Transit airport bus routes
operator_gap_implication: not a separate operator gap unless feed check shows missing airport services
```

### 6.6 Private/intercity/airport shuttle materiality

Private airport / mountain / intercity shuttle services appear in the broader Calgary mobility ecosystem but are not admitted here as MTR public-transport source inputs.

Quarantined source leads:

```text
https://banffairporter.com/
https://www.banffjaspercollection.com/brewster-express/
```

Working note:

```yaml
private_intercity_shuttles: quarantined
reason: These appear to serve airport/intercity/tourism markets rather than general CMA public transport. Include only if Thesis 2 later creates a specific private/intercity service overlay.
```

### 6.7 CMA service-source conclusion

Do not use Calgary Transit alone as the CMA service universe without a coverage reconciliation worksheet.

Required later checks:

```yaml
operator_completeness_required_later:
  - compare Calgary Transit static GTFS agencies/routes/stops against Calgary CMA polygon
  - identify whether Airdrie Transit is represented in Calgary Transit GTFS or separate feeds
  - identify whether Cochrane Transit/COLT is represented in Calgary Transit GTFS or separate feeds
  - identify Chestermere extension representation in Calgary Transit GTFS
  - decide whether on-demand/paratransit services are included, excluded, or documented as missing
  - decide whether private/intercity/airport shuttles are out-of-scope or overlay-only
  - do not calculate coverage until boundary and service-source universe are admitted
```

---

## 7. Rejected/quarantined material

| Item | Status | Reason |
|---|---|---|
| Calgary Transit GTFS extent as MTR denominator | Rejected as denominator | Service-derived geography can hide unserved populations and is not an eligible primary boundary. |
| Calgary Transit route buffers / stop buffers | Rejected as denominator | Indicator input only; cannot define the resident-population universe. |
| Calgary Transit fare zones or agency boundary | Rejected as denominator | Governance/fare/service area is not the CMA boundary. |
| Airdrie Transit service area as MTR boundary | Rejected as denominator | Service/governance overlay only. |
| Cochrane Transit / COLT service area as MTR boundary | Rejected as denominator | Service/governance overlay only. |
| Chestermere Transit Link service extent as MTR boundary | Rejected as denominator | Service-derived overlay only. |
| Chestermere Handi-Bus / Rocky View Regional Handi Bus service area | Rejected as denominator | Demand-responsive/paratransit overlay only unless later admitted as an indicator source. |
| YYC public-transit pages as boundary evidence | Quarantined as context only | Useful for airport service context; not boundary evidence. |
| Banff Airporter / Brewster Express / private mountain or airport shuttles | Quarantined | Private/intercity/tourism-oriented services; not admitted unless Thesis 2 later includes a private/intercity overlay. |
| Alberta Regional Dashboard component-municipality list | Quarantined as supporting pointer | Potentially adapted from Statistics Canada, but primary StatCan hierarchy/GeoSuite should be used instead. |

---

## 8. Open questions for Thesis 2

1. Should the exact Calgary boundary row remain unresolved until Codex archives the actual `CMAUID = 825` / `DGUID = 2021S0503825` polygon from `lcma000b21s_e`?
2. Should the evidence manifest prefer Census Profile, Table 98-10-0005-01, or GeoSuite as the canonical Calgary CMA population denominator?
3. Should GeoSuite become the required source for CMA-to-CSD membership and CSD UID/DGUID extraction?
4. Should Calgary-specific historical comparability/manual-adjustment/merge caveats be treated as unresolved until final 2021 GeoSuite/geography notes are searched directly?
5. Should a standard post-2020 commuting caveat apply to Canadian CMA boundaries based on previous-census commuting flows?
6. What is the minimum operator-completeness standard before Calgary Transit GTFS can support a first service-coverage method test?
7. Should Airdrie Transit, Cochrane Transit, Chestermere Transit Link, handi-bus, and on-demand services be included as separate source bundles, documented as missing, or excluded from the initial fixed-route test?
8. How should current service discontinuation or modification be timestamped for regional services such as On-It Cochrane-Calgary routes?
9. Should private/intercity airport and mountain shuttles be categorically excluded, or retained as a quarantined overlay for edge-case mobility context?
10. Should the Canadian Public Transit Network Database be used as a national service-source discovery overlay before local GTFS feed collection?
11. Should evidence intake require both official local feed source and StatCan national GTFS overlay when available?
12. Should demand-responsive and paratransit sources be represented in service-completeness notes even if they are excluded from GTFS-based fixed-route indicators?

---

## 9. Source URL list

```text
Statistics Canada — 2021 Census reference map / Southern Alberta CMAs and CAs
https://www12.statcan.gc.ca/census-recensement/2021/geo/maps-cartes/referencemaps-cartesdereference/sgc-cgt/map-eng.cfm?SGC=02_16

Statistics Canada — Census Profile, 2021 Census of Population, Calgary CMA DGUID path
https://www12.statcan.gc.ca/census-recensement/2021/dp-pd/prof/details/page.cfm?DGUIDlist=2021S0503825&GENDERlist=1&HEADERlist=0&Lang=E&STATISTIClist=1&SearchText=Calgary

Statistics Canada — Focus on Geography Series, Calgary CMA DGUID path
https://www12.statcan.gc.ca/census-recensement/2021/as-sa/fogs-spg/alternative.cfm?dguid=2021S0503825&lang=e&objectId=1&topic=2

Statistics Canada / Government of Canada — 2021 Census Boundary Files record
https://app.geo.ca/en-ca/map-browser/record/ef70dc3b-1069-4037-9bce-61f47e628a1d

Statistics Canada — 2021 Cartographic Boundary Files MapServer
https://geo.statcan.gc.ca/geo_wa/rest/services/2021/Cartographic_boundary_files/MapServer

Statistics Canada — 2021 Cartographic Boundary Files CMA layer / lcma000b21s_e
https://geo.statcan.gc.ca/geo_wa/rest/services/2021/Cartographic_boundary_files/MapServer/6

Statistics Canada — Table 98-10-0005-01 Population and dwelling counts
https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=9810000501

Statistics Canada — 2021 GeoSuite Data Package
https://www150.statcan.gc.ca/n1/pub/92-150-g/92-150-g2021001-eng.htm

Statistics Canada — CMA/CA illustrated glossary
https://www150.statcan.gc.ca/n1/pub/92-195-x/2021001/geo/cma-rmr/cma-rmr-eng.htm

Statistics Canada — Preliminary 2021 CMA/CA delineation rules
https://www150.statcan.gc.ca/n1/pub/92f0138m/92f0138m2019002-eng.htm

City of Calgary / Open Calgary — Calgary Transit Scheduling Data
https://data.calgary.ca/Transportation-Transit/Calgary-Transit-Scheduling-Data/npk7-z3bj

City of Calgary / Open Calgary — Calgary Transit Realtime Vehicle Positions GTFS-RT
https://data.calgary.ca/Transportation-Transit/Calgary-Transit-Realtime-Vehicle-Positions-GTFS-RT/am7c-qe3u

City of Calgary / Open Calgary — Calgary Transit Realtime Trip Updates GTFS-RT
https://data.calgary.ca/Transportation-Transit/Calgary-Transit-Realtime-Trip-Updates-GTFS-RT/gs4m-mdc2

City of Calgary / Open Calgary — Terms of Use
https://data.calgary.ca/stories/s/Open-Calgary-Terms-of-Use/u45n-7awa/

Statistics Canada — Canadian Public Transit Network Database
https://www150.statcan.gc.ca/n1/en/catalogue/23-26-0001

City of Airdrie — Transit services
https://www.airdrie.ca/index.cfm?serviceID=2196

City of Airdrie — Routes and schedules / Intercity Express lead
https://www.airdrie.ca/index.cfm?serviceID=2221

City of Airdrie — Airdrie Transit Bus Routes ArcGIS service lead
https://services2.arcgis.com/1RNnEWcGdF9v8pNU/arcgis/rest/services/Transit_Bus_Routes/FeatureServer

City of Chestermere — Transit
https://thecityofchestermere.ca/cityservices/transit/

City of Chestermere — Chestermere Handi-Bus
https://thecityofchestermere.ca/cityservices/chestermere-handi-bus/

Calgary Transit — Regional Transit / Chestermere lead
https://www.calgarytransit.com/content/transit/en/home/rider-information/regional-transit.html

Town of Cochrane — Cochrane Transit
https://www.cochrane.ca/145/Cochrane-Transit

Town of Cochrane — On-Request Transit
https://www.cochrane.ca/1012/On-Request-Transit

On-It Regional Transit — service-status lead
https://www.onitregionaltransit.ca/

YYC Calgary International Airport — public transit
https://www.yyc.com/en-us/navigatingyyc/transportation/publictransit.aspx

YYC Calgary International Airport — transportation
https://www.yyc.com/en-us/navigatingyyc/transportation/default.aspx

Banff Airporter — quarantined private/intercity shuttle lead
https://banffairporter.com/

Brewster Express — quarantined private/intercity shuttle lead
https://www.banffjaspercollection.com/brewster-express/
```

---

Suggested raw artifact path:

```text
theses/mobility-conversion/research-artifacts/raw/2026-07-05-calgary-cma-exact-row-source-bundle.md
```

Suggested follow-on source-note targets:

```text
theses/mobility-conversion/research/source_notes/statistics_canada_calgary_cma_2021_exact_row.md
theses/mobility-conversion/research/source_notes/statistics_canada_2021_cma_boundary_layer_lcma000b21s_e.md
theses/mobility-conversion/research/source_notes/statistics_canada_calgary_cma_population_denominator_2021.md
theses/mobility-conversion/research/source_notes/calgary_transit_gtfs_source_bundle.md
theses/mobility-conversion/research/source_notes/calgary_cma_regional_service_overlay_leads.md
```
