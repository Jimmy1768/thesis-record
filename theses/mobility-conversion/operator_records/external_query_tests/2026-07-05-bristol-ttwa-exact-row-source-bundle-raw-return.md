# Raw Return: Bristol TTWA Exact Row / Source Bundle

Date: 2026-07-05

Return status: raw_research_material_only

Thesis: Thesis 2 — Mobility Conversion

Working lead: mtr_src_003 — Bristol TTWA

Status warning: this file is not evidence, not source truth, not an accepted MTR, not a boundary record, not a metric record, not a score, and not a ranking. It is raw process material for Codex intake.

Terminology rule followed: this file uses Metropolitan Transport Region or MTR. It does not use the prohibited alternative term except in this negative statement.

## 1. Short method summary

This pass checked official or primary source families for the Bristol TTWA source bundle. It did not download, archive, or process raw datasets. It did not calculate population, stop coverage, accessibility, service coverage, scores, or rankings.

The strongest current code finding is:

```yaml
exact_name: Bristol
exact_code: E30000180
identifier_fields:
  - TTWA11CD
  - TTWA11NM
```

The canonical source family for TTWA names and codes is the ONS / data.gov.uk **Travel to Work Areas (December 2011) Names and Codes in the UK** table, which exposes the fields `TTWA11CD` and `TTWA11NM`. The web preview did not display the Bristol row because it only previews the first four rows. The code-to-name mapping `E30000180 = Bristol` was verified from ONS-hosted data snippets that include `TTWA11CD` and `TTWA11NM`, but the exact row from the canonical names-and-codes table still needs raw extraction by the Codex/infrastructure process. citeturn799109view0turn352426search0turn352426search3

Primary geometry lead: ONS / data.gov.uk **Travel to Work Areas (December 2011) Boundaries UK BFC (V2)**. It is a full-resolution clipped boundary product for UK TTWAs as at December 2011 and includes GDB, GPKG, XLSX, TXT, ZIP, KML, shapefile, GeoJSON, CSV, WMS, WFS, and ArcGIS GeoService access paths. citeturn799109view1

Primary population-denominator path: no current direct TTWA population table for Bristol was verified in this pass. The verified path is to aggregate ONS LSOA population estimates through an official ONS 2011 LSOA-to-2011 TTWA exact-fit lookup. The ONS TTWA article also confirms that annual mid-year population estimates for output areas in England and Wales were used to compare TTWA resident population in the original analysis. citeturn201764view0turn566042search0turn799109view2

Primary service-source leads: NaPTAN for stop/access-point inventory; Bus Open Data Service for registered local bus timetable data in England; National Rail / Rail Delivery Group / Network Rail data families for rail timetables and rail running information; Travelwest / West of England Combined Authority pages for local bus, rail, community transport, WESTlink, and ferry service-source discovery. These are service overlays or indicator inputs only. They must not define the MTR denominator. citeturn564822view0turn564822view2turn738482view1turn738482view2turn841176view3

## 2. Source table

| Source ID | Source title | Authority | Role in this raw bundle | Verified finding | Status |
|---|---|---|---|---|---|
| S01 | Travel to Work Areas (December 2011) Names and Codes in the UK | ONS / data.gov.uk | Exact TTWA name/code source family | The preview exposes `TTWA11CD` and `TTWA11NM`; first four rows only are visible in web preview. | Source family verified; Bristol row extraction still required. citeturn799109view0 |
| S02 | ONS-hosted TTWA datasets containing `TTWA11CD` and `TTWA11NM` | ONS | Cross-check for exact code/name mapping | Search snippets from ONS-hosted XLSX files map `E30000180` to `Bristol`. | Exact code/name supported; not a replacement for canonical row extraction. citeturn352426search0turn352426search3turn352426search4 |
| S03 | Travel to Work Areas (December 2011) Boundaries UK BFC (V2) | ONS / data.gov.uk | Primary geometry artifact lead | Full-resolution clipped digital vector boundaries for UK TTWAs as at December 2011; multiple download/API formats. | Boundary source verified; raw geometry not downloaded. citeturn799109view1 |
| S04 | LSOA (2011) to Travel to Work Area (December 2011) Exact Fit Lookup in the UK | ONS / data.gov.uk | Population aggregation support | Lookup between 2011 LSOAs and 2011 TTWAs; FeatureServer path exposed; file updated to correct LSOA names while LSOA codes unaffected. | Aggregation path verified; raw lookup not downloaded. citeturn566042search0 |
| S05 | Travel to Work Area analysis in Great Britain: 2016 | ONS | TTWA method, building blocks, historical population note | TTWAs approximate self-contained labour markets; 2011 TTWAs use 2011 Census commuting-flow matrix and LSOA/DZ/SOA building blocks. | Method source verified. citeturn201764view0 |
| S06 | Lower layer Super Output Area population estimates | ONS | Population denominator source family | ONS publishes mid-year usual resident population estimates for LSOAs in England and Wales, with editions through mid-2024. | Population source family verified; aggregation still required. citeturn799109view2 |
| S07 | Travel to work quality information for Census 2021 | ONS | Post-2020 commute-flow caveat | ONS says Census 2021 travel-to-work data were affected by COVID, furlough, work-from-home guidance, and hybrid work; ONS advises continued use of 2011 TTWAs for now. | Caveat source verified. citeturn459442view0 |
| S08 | National Public Transport Access Nodes (NaPTAN) | DfT / data.gov.uk | Stop/access-point service overlay | NaPTAN is Great Britain’s dataset of public-transport access points, including bus, rail, tram, metro, underground, air, and ferry; data.gov says daily updated. | Stop-source family verified; not a boundary. citeturn564822view0 |
| S09 | NaPTAN user guide and beta download page | DfT / GOV.UK | NaPTAN access, format, licensing | Download is available in CSV/XML, including national or local-authority extracts; GOV.UK page indicates OGL where otherwise not stated. | Access path verified. citeturn564822view4turn564822view5 |
| S10 | Bus Open Data — download all timetable data | DfT Find Transport Data | Bus timetable source | Daily national England bus timetable data; formats include TransXChange XML and GTFS; licence shown as UK OGL. | Bus timetable source verified; not a boundary. citeturn564822view2 |
| S11 | Bus open data implementation guide | DfT / GOV.UK | Bus-source scope and limits | Registered local bus services in England outside London are required to publish timetable/fare/location/performance data via BODS rules. | Scope source verified. citeturn564822view3 |
| S12 | Rail Delivery Group timetable data | Rail Delivery Group | Rail timetable source family | Passenger timetable feed data are sourced from Network Rail CIF and weekly proof-of-concept/development timetable data are available through the National Rail Data Portal. | Rail source family verified; Bristol-specific extraction not done. citeturn738482view1 |
| S13 | National Rail Darwin data feeds | National Rail | Rail real-time/reliability source family | Darwin is the GB rail industry’s official train-running information engine and provides predictions, platforms, delays, schedule changes, and cancellations. | Rail real-time source family verified. citeturn738482view2 |
| S14 | Network Rail open data feeds | Network Rail | Rail operational feed source family | Network Rail provides operational data feeds to the public, subject to account and terms; no guarantee of total availability. | Rail source family verified; access constraints noted. citeturn738482view0 |
| S15 | West of England Combined Authority bus page | West of England Combined Authority | Local transport source discovery | WECA describes cross-boundary public-transport planning, WEST journey planning/live updates, metrobus, bus information, and community transport. | Local service context verified; not a denominator. citeturn841176view3 |
| S16 | Travelwest local bus service registrations | Travelwest / WECA | Local bus-operator and registration overlay | WECA handles registrations for services wholly in the West of England EP area; cross-boundary services remain with the Traffic Commissioner. | Local service-registration source verified; not a denominator. citeturn841176view4 |
| S17 | WESTlink | Travelwest | Demand-responsive transport source lead | WESTlink has zone-based operating hours, including Bristol-related zones. | DRT source lead verified; no schedule-feed verification. citeturn841176view1 |
| S18 | Community Transport | Travelwest | Paratransit/community transport source lead | Community transport includes door-to-door services, voluntary car schemes, group hire, regular local trips, and shopmobility. | Source family verified; completeness unknown. citeturn841176view0 |
| S19 | Bristol Ferries | Travelwest | Ferry source lead | Travelwest lists Bristol Ferry Boats and Number Seven Boats routes, including cross-harbour commuter service and seasonal/restricted routes. | Ferry source lead verified; materiality not quantified. citeturn841176view2 |

## 3. YAML-style raw source bundle

```yaml
bristol_ttwa_exact_row_return:
  return_status: raw_research_material_only

  reviewed_boundary:
    working_name: Bristol TTWA
    source_authority: Office for National Statistics
    exact_name: Bristol
    exact_code: E30000180
    geography_type: Travel to Work Area, 2011; national_commuting_zone / self-contained labour-market geography
    source_url_or_access_path:
      - https://www.data.gov.uk/dataset/f6da11df-4e4d-4beb-92fc-3b4939f1b4d9/travel-to-work-areas-december-2011-names-and-codes-in-the-uk
      - https://www.data.gov.uk/dataset/f6da11df-4e4d-4beb-92fc-3b4939f1b4d9/travel-to-work-areas-december-2011-names-and-codes-in-the-uk/datafile/68a68d3d-82cb-44f7-9c2f-b4dc502dce65/preview
      - https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/TTWA_2011_UK_NC_V4/FeatureServer
    verification_status: >
      exact_code_supported_by_ONS_hosted_TTWA_data_snippets_and_canonical_ONS_names_codes_source_family;
      exact_Bristol_row_not_extracted_from_canonical_raw_names_codes_table_in_this_pass;
      infrastructure_or_Codex_should_extract_and_archive_the_exact_row_before_boundary_record_admission

  boundary_artifact:
    product_title: Travel to Work Areas (December 2011) Boundaries UK BFC (V2)
    catalogue_or_download_path:
      - https://www.data.gov.uk/dataset/abff04be-da8f-4439-8833-e5fe64d28d28/travel-to-work-areas-december-2011-boundaries-uk-bfc-v21
      - https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Travel_to_Work_Areas_Dec_2011_FCB_in_United_Kingdom_2022/FeatureServer
      - https://dservices1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/services/Travel_to_Work_Areas_Dec_2011_FCB_in_United_Kingdom/WFSServer?service=wfs&request=getcapabilities
    file_or_layer: full_resolution_clipped_to_coastline_boundary_product; exact_feature_layer_and_Bristol_geometry_row_to_be_extracted_later
    vintage: TTWA boundaries as at December 2011; data.gov page last updated 2024-11-24
    identifier_field: TTWA11CD
    license_or_reuse_terms: >
      data.gov page shows dataset licence field as 'None' while page footer states OGL v3 except where otherwise stated;
      product contains Ordnance Survey and ONS intellectual property;
      raw metadata and reuse terms require verification before redistribution
    raw_download_required_later: true

  population_denominator:
    source_title:
      - Lower layer Super Output Area population estimates
      - LSOA (2011) to Travel to Work Area (December 2011) Exact Fit Lookup in the UK
      - Travel to Work Area analysis in Great Britain: 2016
    source_url_or_access_path:
      - https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/lowersuperoutputareamidyearpopulationestimates
      - https://www.data.gov.uk/dataset/42472c45-76ad-4bcf-9b96-c91d8ae097f5/lsoa-2011-to-travel-to-work-area-december-2011-exact-fit-lookup-in-the-uk
      - https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/articles/traveltoworkareaanalysisingreatbritain/2016
    geography_identifier: TTWA11CD = E30000180; likely aggregation through LSOA11CD to TTWA11CD lookup or later best-fit lookup if 2021 LSOA/OA population is used
    population_field: usual resident population, summed from official small-area population estimates
    vintage: >
      direct ONS TTWA article uses 2014 mid-year population estimates for historical comparison;
      ONS LSOA population dataset includes editions through mid-2024 in the inspected page;
      exact scoring vintage not selected in this raw return
    aggregation_method: >
      no current direct Bristol TTWA population table verified in this pass;
      aggregate ONS small-area population estimates to TTWA11CD through official ONS lookup;
      if 2021 lower-layer geographies are used, document best-fit or exact-fit bridge and boundary-vintage mismatch
    value_returned: do_not_return_value_unless_needed_for_source_identification
    verification_status: source_path_verified_for_aggregation; current_Bristol_total_population_not_calculated

  methodology_caveats:
    commuting_flow_vintage: 2011 Census commuting-flow matrix, origin-destination for workers aged 16 and over
    delineation_method: algorithmic definition of self-contained labour-market areas; relatively few commuters should cross a TTWA boundary
    self_containment_rule: >
      standard criterion is at least 75 percent of resident workforce works in the area and at least 75 percent of people working in the area live there;
      minimum economically active population is 3500;
      for working population above 25000, self-containment may be as low as 66.7 percent as a limited trade-off
    building_blocks:
      England_and_Wales: Lower layer Super Output Areas (LSOAs)
      Scotland: Data Zones (DZs)
      Northern_Ireland: Super Output Areas (SOAs)
    pandemic_or_remote_work_caveat: >
      ONS says Census 2021 travel-to-work data were collected during COVID disruption;
      hybrid/home working remain common;
      ONS advises continued use of 2011 TTWAs for analytical and statistical work while future methods are researched
    rural_hinterland_or_overinclusion_risk: >
      TTWAs are labour-market geographies, not transport-service areas;
      Bristol TTWA may include rural or weakly served hinterland that must remain inside any denominator if this boundary is tested;
      this is a feature for denominator discipline, but a risk for interpreting fixed-route-only service overlays
    source_url_or_access_path:
      - https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/articles/traveltoworkareaanalysisingreatbritain/2016
      - https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/methodologies/traveltoworkqualityinformationforcensus2021

  service_source_bundle:
    naptan_source:
      source_authority: Department for Transport
      source_url_or_access_path:
        - https://www.data.gov.uk/dataset/ff93ffc1-6656-47d8-9155-85ea0b8f2251/naptan
        - https://www.gov.uk/government/publications/national-public-transport-access-node-schema
        - https://beta-naptan.dft.gov.uk/download
      format:
        - CSV
        - XML
        - API access path
      vintage_or_update_date: data.gov page says NaPTAN data are updated daily; exact raw snapshot date required later
      license_or_access_terms: OGL shown on data.gov/GOV.UK pages, with ordinary caveat for third-party rights where specified
      coverage_against_TTWA: >
        GB-wide stop/access-point dataset, not TTWA-specific;
        must be clipped/filtered against Bristol TTWA geometry;
        includes stop/access nodes for bus, rail, tram, metro, underground, air, ferry, coach-related access points;
        does not provide service frequency or timetable coverage by itself;
        must not define denominator

    bus_open_data_source:
      source_authority: Department for Transport
      source_url_or_access_path:
        - https://findtransportdata.dft.gov.uk/dataset/bus-open-data---download-all-timetable-data--18335fb19c4
        - https://data.bus-data.dft.gov.uk/timetable/download/
        - https://www.gov.uk/government/publications/bus-open-data-implementation-guide/bus-open-data-implementation-guide
      format:
        - TransXChange XML
        - GTFS
      vintage_or_update_date: Find Transport Data page lists update frequency as daily; exact feed snapshot date required later
      license_or_access_terms: UK Open Government Licence shown on Find Transport Data page
      coverage_against_TTWA: >
        England national bus timetable data source;
        needs filtering to routes/stops intersecting Bristol TTWA;
        BODS rules cover registered local bus services in England outside London;
        quality and completeness must be audited and cannot be assumed from the existence of a national feed;
        must not define denominator

    rail_or_other_modes:
      material_sources:
        rail_timetable:
          source_authority:
            - Rail Delivery Group
            - Network Rail
          source_url_or_access_path:
            - https://www.raildeliverygroup.com/our-services/essential-services/rail-data/timetable-data.html
            - https://www.networkrail.co.uk/who-we-are/transparency-and-ethics/transparency/open-data-feeds/
          coverage_against_TTWA: >
            GB passenger-rail schedule source family, not TTWA-specific;
            needed if scheduled public-transport access is tested beyond bus-only coverage
        rail_realtime:
          source_authority: National Rail
          source_url_or_access_path:
            - https://www.nationalrail.co.uk/developers/darwin-data-feeds/
          coverage_against_TTWA: >
            national rail real-time/running-information source family;
            access requires Rail Data Marketplace subscription/click-through terms; not a denominator
        west_of_england_local_sources:
          source_authority:
            - West of England Combined Authority
            - Travelwest
          source_url_or_access_path:
            - https://www.westofengland-ca.gov.uk/what-we-do/transport/bus/
            - https://travelwest.info/bus/registrations/
          coverage_against_TTWA: >
            useful for local bus registration, journey-planning, live-arrivals, supported-service, metrobus and community-transport source discovery;
            governance/service geography may differ from TTWA and must not define the denominator
        westlink_demand_responsive_transport:
          source_authority: Travelwest
          source_url_or_access_path:
            - https://travelwest.info/westlink/
          coverage_against_TTWA: >
            demand-responsive service lead for parts of the West of England;
            not a fixed-route GTFS/BODS timetable substitute;
            exact TTWA overlap and data availability unresolved
        community_transport:
          source_authority: Travelwest
          source_url_or_access_path:
            - https://travelwest.info/community-transport/
          coverage_against_TTWA: >
            includes door-to-door services, voluntary car schemes, group hire, regular local trips and shopmobility;
            may be important for universal-access interpretation but does not define denominator
        ferry:
          source_authority: Travelwest and private ferry operators as linked source leads
          source_url_or_access_path:
            - https://travelwest.info/bristol-ferries/
          coverage_against_TTWA: >
            Bristol harbour ferry source family exists, including daily, seasonal, and restricted routes;
            materiality for TTWA-wide transport-access measurement unresolved
        coach:
          source_authority: unresolved
          source_url_or_access_path: source_family_not_verified_in_this_pass
          coverage_against_TTWA: >
            coach source family remains unresolved;
            likely not captured by local-bus-only source bundle unless represented in NaPTAN/BODS/other feed families
      missing_operators_or_modes:
        - rail services and rail station access if only BODS is used
        - WESTlink or other demand-responsive transport
        - community transport, dial-a-ride, voluntary car schemes, shopmobility
        - ferry services in Bristol harbour
        - coach and interurban services unless separately verified
        - school/event/private or exempt services outside BODS scope
      bus_only_bundle_assessment: >
        bus-only_service_bundle_would_be_incomplete_for_source_discovery;
        exact materiality not quantified;
        rail, DRT, community transport and ferry source families require at least a coverage-reconciliation note

  rejected_or_quarantined_material:
    - item: NaPTAN stop coverage as MTR boundary or denominator
      reason: service/access-point dataset can hide unserved population; valid only as stop overlay or indicator input
    - item: BODS route/timetable coverage as MTR boundary or denominator
      reason: service-derived geography can hide unserved population; valid only as service source
    - item: WECA, Travelwest, fare, registration or journey-planner geography as MTR denominator
      reason: governance/service region may differ from TTWA; valid only as governance or service overlay
    - item: Bristol City Council administrative boundary as MTR denominator
      reason: city administrative boundary is not the national commuting-zone source under review
    - item: metrobus/First Bus/operator service areas as MTR denominator
      reason: operator/service area is outcome-adjacent and can exclude unserved or non-operator-served populations
    - item: ferry routes or harbour catchment as MTR denominator
      reason: route geography is service-derived and mode-specific
    - item: Wikipedia, travel guides, livability rankings, city reputation and congestion reputation
      reason: prohibited source types or outcome-adjacent selection logic
```

## 4. Exact geography row/code findings

### 4.1 Exact identifier returned

```yaml
exact_name: Bristol
exact_code: E30000180
identifier_field: TTWA11CD
name_field: TTWA11NM
```

The ONS / data.gov.uk names-and-codes preview confirms the canonical field structure for the 2011 TTWA code and name table: `TTWA11CD`, `TTWA11NM`, and `FID`. The preview does not show Bristol because only the first four rows are rendered. citeturn799109view0

The code-to-name pair `E30000180 = Bristol` appears in ONS-hosted datasets that expose `TTWA11CD` and `TTWA11NM`; this supports the exact identifier but does not replace the need to extract the official row from the canonical names-and-codes source during intake. citeturn352426search0turn352426search3turn352426search4

### 4.2 Official source directly mapping name to code

Best current official path:

```text
Travel to Work Areas (December 2011) Names and Codes in the UK
Publisher: Office for National Statistics
Fields: TTWA11CD, TTWA11NM, FID
Canonical row to extract later: TTWA11CD = E30000180; TTWA11NM = Bristol
```

Verification status:

```yaml
source_family: verified
field_names: verified
exact_code_name_pair: supported_by_ONS_hosted_data_snippets
canonical_raw_row: not_extracted_in_this_pass
```

### 4.3 Action required before source-note admission

Codex or infrastructure should acquire the names-and-codes table and extract exactly one row where:

```sql
TTWA11CD = 'E30000180'
```

or:

```sql
TTWA11NM = 'Bristol'
```

The extracted row should be archived with retrieval date, source URL, file hash, field names, and the exact row content.

## 5. Boundary/population artifact findings

### 5.1 Boundary geometry product

Primary artifact lead:

```yaml
product_title: Travel to Work Areas (December 2011) Boundaries UK BFC (V2)
publisher: Office for National Statistics
geometry_type: digital vector boundaries
boundary_vintage: December 2011
resolution: full resolution, clipped to coastline / Mean High Water mark
main_identifier_field: TTWA11CD
formats:
  - GDB
  - GPKG
  - XLSX
  - TXT
  - ZIP/File Geodatabase
  - KML
  - Shapefile
  - GeoJSON
  - CSV
  - WMS
  - WFS
  - ArcGIS GeoService
```

The BFC product is the best geometry lead because it is full-resolution and clipped to the coastline. The ONS/data.gov page says it contains digital vector boundaries for UK TTWAs as at December 2011 and lists direct service/download formats. citeturn799109view1

Boundary artifact caveat:

```yaml
license_status: requires_raw_metadata_review
reason: data.gov page shows licence field 'None', but footer says OGL v3 except where otherwise stated, and the dataset contains OS and ONS intellectual property.
```

### 5.2 Population denominator source path

No current direct official Bristol TTWA population denominator was verified in this pass. The verified support path is:

```yaml
path_a_historical_direct_context:
  source: ONS Travel to Work Area analysis in Great Britain: 2016
  status: contains historical TTWA resident-population comparisons using 2014 mid-year population estimates
  use: method/source precedent only; not current denominator

path_b_current_or_selected_vintage_aggregation:
  source_1: ONS Lower layer Super Output Area population estimates
  source_2: ONS LSOA 2011 to TTWA 2011 exact-fit lookup
  method: sum small-area usual resident population estimates for LSOAs mapped to TTWA11CD = E30000180
  status: source path verified; actual population not calculated
```

The ONS TTWA article states that annual mid-year population estimates for output areas in England and Wales and data zones in Scotland were used to compare resident population of TTWAs. The same article reports a 2014 table for large TTWAs, but this raw return does not use or update that value. citeturn201764view0

The ONS LSOA population dataset publishes mid-year usual-resident population estimates for LSOAs in England and Wales, including recent editions through mid-2024 in the inspected page. citeturn799109view2

The ONS/data.gov exact-fit lookup source describes a lookup between 2011 LSOAs and 2011 TTWAs as at 31 December 2011 and exposes a FeatureServer path. citeturn566042search0

### 5.3 Population denominator risk

If using 2011 LSOA-to-2011 TTWA exact fit, denominator alignment is cleaner with 2011-boundary population estimates. If using 2021 LSOA/OA population estimates, Codex must document whether a 2011-to-2021 best-fit bridge or another official lookup is used. Boundary-vintage mismatch should be explicit in the evidence manifest.

## 6. Service/operator coverage findings

### 6.1 NaPTAN

NaPTAN is a verified official stop/access-point source family. DfT/data.gov describes it as Great Britain’s public-transport access-point dataset and says it includes bus, rail, tram, metro, underground, air, and ferry services. The data.gov page states that NaPTAN data are updated daily. citeturn564822view0

The GOV.UK NaPTAN page says the dataset lists GB public-transport access points and can be downloaded in XML or CSV. The beta NaPTAN download page says national stop data and local-authority extracts are available in CSV or XML. citeturn564822view1turn564822view4

NaPTAN coverage against Bristol TTWA:

```yaml
coverage_status: national_GB_source_requires_spatial_filter
use_as_boundary: prohibited
use_as_denominator: prohibited
use_as_overlay: valid
known_limit: stop/access-point inventory, not timetable/frequency/reliability source
```

### 6.2 Bus Open Data Service

The DfT Find Transport Data page for all bus timetable data states that timetable data include route/day/date/time details, are updated daily, are national for England, are licensed under the UK OGL, and are available as TransXChange XML and GTFS. citeturn564822view2

The DfT implementation guide states that operators of registered local bus services in England outside London are required to publish timetable, fare, vehicle-location, and historic-performance data, with the first timetable requirement from 31 December 2020. citeturn564822view3

BODS coverage against Bristol TTWA:

```yaml
coverage_status: England_national_bus_source_requires_TTWA_filter_and_operator_completeness_audit
use_as_boundary: prohibited
use_as_denominator: prohibited
use_as_indicator_input: valid_after_feed_snapshot_and_quality_check
known_limits:
  - local_bus_only_unless_other_modes_represented_elsewhere
  - data quality not guaranteed solely by publication
  - cross-boundary and exempt services need reconciliation
```

### 6.3 Rail

Rail should not be skipped in a Bristol TTWA source-bundle audit. The Rail Delivery Group timetable page states that passenger timetable data are sourced from Network Rail CIF, with weekly timetable data available for proof-of-concept or development work through the National Rail Data Portal. citeturn738482view1

National Rail Darwin is the official GB rail running-information engine and provides real-time predictions, platform numbers, delay estimates, schedule changes, and cancellations. citeturn738482view2

Network Rail provides public operational data feeds but requires an account, applies terms and conditions, and states that availability is not guaranteed. citeturn738482view0

Rail coverage against Bristol TTWA:

```yaml
coverage_status: national_GB_rail_source_family_verified; Bristol_TTWA_specific_extraction_not_done
materiality_status: likely_material_for_public_transport_bundle_but_not_quantified
required_next_step: identify rail stations/services intersecting TTWA geometry using NaPTAN and rail timetable/station data
```

### 6.4 WECA / Travelwest local service context

WECA says Bath & North East Somerset, Bristol and South Gloucestershire combined some operational transport functions under the West of England Combined Authority, and that this supports public-transport planning across council boundaries. WECA also describes WEST journey planning/live updates, metrobus, bus timetable data to journey planners/apps, and community transport support. citeturn841176view3

Travelwest says WECA acts as Bus Services Registration Authority for local services wholly within the West of England Enhanced Partnership area, while cross-boundary services continue with the Traffic Commissioner. It also lists active and historical local bus registration-data sources. citeturn841176view4

WECA/Travelwest coverage against Bristol TTWA:

```yaml
coverage_status: useful_local_service_and_governance_overlay
use_as_boundary: prohibited
fit_issue: WECA/Travelwest geography is not the same as the TTWA by default
```

### 6.5 Demand-responsive, community, ferry, and other sources

WESTlink is a Travelwest demand-responsive source lead with Bristol-related zones and published operating hours. It does not behave like a fixed-route timetable source. citeturn841176view1

Travelwest community-transport pages list door-to-door services, voluntary car schemes, group vehicle hire, regular local trips, and shopmobility, and note that the directory covers financially supported operators while other providers may exist. citeturn841176view0

Travelwest Bristol Ferries lists Bristol Ferry Boats and Number Seven Boats routes, including Hotwells–City Centre, Temple Meads–City Centre, Netham Lock–City Centre seasonal service, a daily cross-harbour commuter service, and additional restricted/seasonal routes. citeturn841176view2

Source-bundle implication:

```yaml
bus_only_bundle_would_miss_material_source_families: true
materiality_not_quantified: true
reason: bus-only ignores rail, DRT, community/paratransit, and ferry source families that exist in or around the Bristol transport ecosystem
```

This does not mean these modes are large enough to affect final access metrics. It means they are sufficiently material as source families that a bus-only bundle would be incomplete as a research-source bundle.

## 7. Rejected/quarantined material

| Item | Status | Reason |
|---|---|---|
| NaPTAN stop extent as MTR boundary | Rejected as denominator | Stop datasets are service/access-point geographies and can hide unserved populations. |
| BODS route/timetable extent as MTR boundary | Rejected as denominator | Service-derived geography is outcome-adjacent and cannot define the population denominator. |
| WECA / Travelwest service or governance region as primary MTR denominator | Quarantined | It is governance/service context; it may not equal Bristol TTWA. |
| Bristol City Council boundary | Rejected for this lead | The current source family is national commuting-zone / TTWA, not city administrative boundary. |
| First Bus, metrobus, operator or fare-zone geographies | Rejected as denominator | Operator and service areas can hide non-served populations and non-operator modes. |
| Ferry routes / harbour catchment | Rejected as denominator | Mode-specific route geography cannot define an MTR. |
| MapIt, Doogal, postcode tools, blogs, travel guides, Wikipedia | Quarantined or rejected | Useful only as casual corroboration if at all; not official source truth for this intake. |
| Coach source family | Unresolved | No authoritative coach open-data source was verified in this pass; should remain an open source-family check. |

## 8. Open questions for Thesis 2

1. Should a source note accept `E30000180 = Bristol` before the canonical ONS names-and-codes row is extracted and archived, or keep exact-row status unresolved until row-level acquisition?
2. Should the BFC full-resolution clipped product be the default TTWA geometry artifact, with BGC/BSC products limited to preview/generalized mapping?
3. What exact license language should be stored for ONS boundary products that show `Licence: None` in data.gov but OGL in the site footer and contain OS/ONS intellectual property?
4. Which denominator vintage is acceptable for testing: 2011-boundary-aligned population, latest ONS small-area estimates, or both as separate fields?
5. If latest LSOA/OA estimates are used, should the pipeline use a 2011-to-2021 best-fit bridge, a gridded population overlay, or a separate official lookup path?
6. Should every TTWA boundary record carry a standard caveat: `commuting_data_vintage = 2011; post_2020_remote_work_caveat = required`?
7. What service-bundle completeness threshold is required before a first Bristol method test can proceed?
8. Should rail be mandatory in the first Bristol source bundle because fixed-route bus-only access would omit national rail services?
9. Should WESTlink and community transport be represented as descriptive overlays only, or as a special non-fixed-route service layer in later indicators?
10. Should ferry services be tracked as a material mode only inside the Bristol urban core, or ignored for TTWA-wide first-pass coverage unless their ridership or service span is verified?
11. What official coach/open-data source should be checked before deciding whether coach services matter inside Bristol TTWA?
12. How should service-source geography be reconciled when the WECA/Travelwest governance region and Bristol TTWA do not match?

## 9. Source URL list

```text
ONS / data.gov.uk — Travel to Work Areas (December 2011) Names and Codes in the UK
https://www.data.gov.uk/dataset/f6da11df-4e4d-4beb-92fc-3b4939f1b4d9/travel-to-work-areas-december-2011-names-and-codes-in-the-uk

ONS / data.gov.uk — TTWA Names and Codes CSV preview
https://www.data.gov.uk/dataset/f6da11df-4e4d-4beb-92fc-3b4939f1b4d9/travel-to-work-areas-december-2011-names-and-codes-in-the-uk/datafile/68a68d3d-82cb-44f7-9c2f-b4dc502dce65/preview

ONS — Travel to Work Area analysis in Great Britain: 2016
https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/articles/traveltoworkareaanalysisingreatbritain/2016

ONS / data.gov.uk — Travel to Work Area analysis in Great Britain metadata
https://www.data.gov.uk/dataset/f51465dd-ae51-438a-ade2-f68bf1626586/travel-to-work-area-analysis-in-great-britain

ONS / data.gov.uk — Travel to Work Areas (December 2011) Boundaries UK BFC (V2)
https://www.data.gov.uk/dataset/abff04be-da8f-4439-8833-e5fe64d28d28/travel-to-work-areas-december-2011-boundaries-uk-bfc-v21

ONS / data.gov.uk — LSOA (2011) to Travel to Work Area (December 2011) Exact Fit Lookup in the UK
https://www.data.gov.uk/dataset/42472c45-76ad-4bcf-9b96-c91d8ae097f5/lsoa-2011-to-travel-to-work-area-december-2011-exact-fit-lookup-in-the-uk

ONS — Lower layer Super Output Area population estimates
https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/datasets/lowersuperoutputareamidyearpopulationestimates

ONS — Travel to work quality information for Census 2021
https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/methodologies/traveltoworkqualityinformationforcensus2021

DfT / data.gov.uk — National Public Transport Access Nodes (NaPTAN)
https://www.data.gov.uk/dataset/ff93ffc1-6656-47d8-9155-85ea0b8f2251/naptan

GOV.UK — National public transport access nodes
https://www.gov.uk/government/publications/national-public-transport-access-node-schema

DfT NaPTAN beta download
https://beta-naptan.dft.gov.uk/download

DfT Find Transport Data — Bus Open Data, download all timetable data
https://findtransportdata.dft.gov.uk/dataset/bus-open-data---download-all-timetable-data--18335fb19c4

DfT — Bus Open Data Service timetable download
https://data.bus-data.dft.gov.uk/timetable/download/

GOV.UK / DfT — Bus open data implementation guide
https://www.gov.uk/government/publications/bus-open-data-implementation-guide/bus-open-data-implementation-guide

Rail Delivery Group — Timetable data
https://www.raildeliverygroup.com/our-services/essential-services/rail-data/timetable-data.html

Network Rail — Open data feeds
https://www.networkrail.co.uk/who-we-are/transparency-and-ethics/transparency/open-data-feeds/

National Rail — Darwin data feeds
https://www.nationalrail.co.uk/developers/darwin-data-feeds/

West of England Combined Authority — Bus
https://www.westofengland-ca.gov.uk/what-we-do/transport/bus/

Travelwest — Local bus service registrations within the West of England
https://travelwest.info/bus/registrations/

Travelwest — WESTlink
https://travelwest.info/westlink/

Travelwest — Community Transport
https://travelwest.info/community-transport/

Travelwest — Bristol Ferries
https://travelwest.info/bristol-ferries/
```

## Suggested Codex intake target

```text
theses/mobility-conversion/research-artifacts/raw/2026-07-05-bristol-ttwa-exact-row-source-bundle.md
```

## Suggested follow-on artifacts

```text
theses/mobility-conversion/research/source_notes/ons_travel_to_work_areas_bristol_exact_row_2026-07-05.md
theses/mobility-conversion/research/source_notes/bristol_ttwa_boundary_population_source_bundle_2026-07-05.md
theses/mobility-conversion/research/source_notes/bristol_ttwa_service_source_bundle_2026-07-05.md
theses/mobility-conversion/research/bristol_ttwa_coverage_reconciliation_queue_2026-07-05.md
```
