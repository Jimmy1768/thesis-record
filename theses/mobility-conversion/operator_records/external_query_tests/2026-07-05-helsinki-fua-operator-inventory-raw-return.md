# Raw Return: Helsinki FUA Operator Inventory / Coverage

Date: 2026-07-05

Status: raw research material only. Not evidence, not source truth, not an accepted MTR, not a candidate-universe record, not a boundary record, not a metric record, not a score, and not a ranking.

Thesis: Thesis 2 — Mobility Conversion

Reviewed lead: `mtr_src_001` / Helsinki FUA / `FI001F`

Scope followed: source-led operator inventory and coverage-risk scan only. No population coverage, access calculation, score, ranking, MTR admission, or methodology decision was produced.

---

## 1. Short method summary

This scan checked official or primary source families requested in the handoff:

- Eurostat/GISCO and OECD FUA source paths for `FI001F`;
- HSL open data, GTFS, GTFS-RT, Journey Planner, area/zones, U-line, and mode pages;
- Digitransit Routing API, Routing Data API, registration, realtime, and terms pages;
- Fintraffic/Digitraffic/FINAP public-transport information sources;
- Matkahuolto and Järvenpää public/service transport sources for possible non-HSL service inside or near the FI001F commuting catchment.

No raw polygon, GTFS package, GTFS-RT feed, routing-data endpoint, FINAP dataset, Matkahuolto dataset, or municipal timetable file was downloaded or archived.

Raw conclusion posture:

- HSL's own area is traceably limited to the HSL member municipalities: Helsinki, Espoo, Vantaa, Kauniainen, Siuntio, Kirkkonummi, Sipoo, Kerava and Tuusula.
- Secondary/non-official FUA crosswalk material suggests `FI001F` likely includes additional municipalities outside the HSL member area, including at least Porvoo/Borgå, Pornainen/Borgnäs, Inkoo/Ingå, Järvenpää/Träskända, Mäntsälä, Nurmijärvi and Vihti/Vichtis. This list must be verified from the official OECD municipality CSV or GISCO/Urban Audit attribute joins before it can become evidence.
- HSL static GTFS and HSL GTFS-RT are not sufficient by themselves to prove complete public-transport service coverage for all of `FI001F`.
- Digitransit as a broader platform has separate HSL, Waltti, Finland/Estonia, and Southwest Finland/ELY router datasets. The Finland/Estonia routing-data endpoint is explicitly described as containing cities, ELY-centres, and long-distance market-based coach connections sourced through FINAP. This makes the broader Digitransit/Fintraffic/FINAP stack a plausible recovery path for non-HSL operators, but not a verified complete operator inventory yet.
- Järvenpää is a clear coverage-risk example: HSL states Järvenpää is not an HSL member municipality; some Järvenpää journeys accept HSL or VR tickets, while Järvenpää internal bus routes 21–27 require Järvenpää's own ticket. The City of Järvenpää points local and regional bus users to Matkahuolto Reittiopas and separately describes service-transportation lines.

---

## 2. Source table

| Source family | Source title | Authority | URL / access path | Relevant source-led finding | Raw use | Limit |
|---|---|---|---|---|---|---|
| FUA boundary source | Cities and functional urban areas geodata | Eurostat GISCO | https://ec.europa.eu/eurostat/web/gisco/geodata/statistical-units/cities-functional-urban-areas | GISCO provides Urban Audit cities/FUA downloads by year, format, geometry type, scale and CRS, and access through the GISCO data distribution API. | Boundary source path for `FI001F`. | Exact `FI001F` polygon and municipality join not downloaded in this return. |
| FUA metadata | Urban Audit 2021 Area management dataset metadata | Eurostat GISCO | https://gisco-services.ec.europa.eu/distribution/v2/urau/urau-2021-metadata.pdf | Dataset contains city, greater city and FUA boundaries as defined according to the EC-OECD city definition; FUA approximates the functional urban region; data based on Census 2021 and commuting data; `URAU_CATG = F` denotes FUA. | Confirms official boundary source family and category logic. | Does not list FI001F municipalities in the viewed metadata text. |
| FUA definition | OECD Definition of Cities and Functional Urban Areas | OECD | https://www.oecd.org/en/data/datasets/oecd-definition-of-cities-and-functional-urban-areas.html | OECD says FUAs capture city-surrounding-area connections; FUA expands city boundaries to workplace-commuting-connected areas and uses density plus travel-to-work flows. The page links to FUA boundaries and a “List of municipalities in FUAs and Cities.” | Official source path for exact municipality extraction. | CSV link was identified but not downloaded or parsed. |
| FUA method | Territorial typologies manual — cities, commuting zones and FUAs | Eurostat | https://ec.europa.eu/eurostat/statistics-explained/index.php?title=Territorial_typologies_manual_-_cities%2C_commuting_zones_and_functional_urban_areas | Eurostat defines FUA as city plus commuting zone; commuting zones use LAUs where at least 15% of employed residents commute to the city, with rules for enclaves/exclaves and polycentric FUAs. | Method context for `FI001F`. | General method only; not Helsinki-specific row extraction. |
| Secondary crosswalk | EU geography database / NUTS and LAU2 and cities/metros | tbed / DaDaBIK public database | https://tbed.org/eudemo/index.php?function=details&tablename=nuts3_vw&where_field=nuts_code&where_value=FI1B1 | Secondary page lists Helsinki/Helsingfors `FI001F` and LAUs associated with the FUA. Search result/page snippets show FI001F rows for Borgå, Borgnäs, Esbo, Grankulla, Helsingfors, Ingå, Kervo, Kyrkslätt, Mäntsälä, Nurmijärvi, Sibbo, Sjundeå, Träskända, Tusby, Vanda and Vichtis. | Candidate municipality list for verification queue only. | Not official; must not be used as evidence without official OECD/GISCO row extraction. |
| HSL service geography | HSL area and zones | HSL | https://www.hsl.fi/en/tickets-and-fares/hsl-area-and-zones | HSL area consists of Helsinki, Espoo, Vantaa, Kauniainen, Siuntio, Kirkkonummi, Sipoo, Kerava and Tuusula. It also describes neighboring municipalities, Järvenpää's non-member status, and ticket rules for Järvenpää. | Core HSL service-area reference and coverage-risk source. | Fare/service geography is not an MTR denominator. |
| HSL modes | Visitors / HSL public transport | HSL | https://www.hsl.fi/en/travelling/visitors | HSL states one ticket can be used for bus, tram, Metro, commuter train and ferry. | Mode inventory for HSL bundle. | Visitor page, not a data-feed manifest. |
| HSL open data | HSL's open data | HSL | https://www.hsl.fi/en/hsl/open-data | HSL offers APIs and data packages; Journey Planner APIs provide routing/geocoding/map/vehicle locations through Digitransit; HSL public-transport network data and OSM data are updated daily; HSL GTFS is parsed daily from the register and includes all public-transport routes with a valid timetable; HSL data generally CC BY 4.0, OSM geometry/address under ODbL. | Main HSL static/realtime/open-data source. | HSL source bundle describes HSL services, not all FI001F services. |
| HSL GTFS-RT | HSL GTFS-RT API documentation | HSL Developer Community | https://hsldevcom.github.io/gtfs_rt/ | HSL provides GTFS-RT service alerts, trip updates and vehicle positions complementing static GTFS. | HSL realtime source path. | Realtime coverage does not imply full service denominator coverage. |
| HSL U-line | U-line services | HSL | https://www.hsl.fi/en/travelling/u-line-services | U-line routes extend beyond the HSL area; U-line timetables are in Journey Planner; realtime location information is not available; most U-lines are commercial and some routes/services are procured by Uusimaa ELY Centre. | Coverage-risk source for services beyond HSL area. | Scheduled-only and operator-owned timetables; raw route list not extracted. |
| HSL route maps | Route maps and station maps | HSL | https://www.hsl.fi/en/travelling/route_and_station_maps | HSL route maps cover trunk routes, tram, metro, commuter trains; for Järvenpää, Ainola and Saunakallio station maps and stations outside the HSL area, HSL points to Finnish Transport Infrastructure Agency. | Supports rail/station boundary risk around Järvenpää/outside-HSL stations. | Map page only; not a feed completeness manifest. |
| Digitransit routing API | Routing API | Digitransit | https://digitransit.fi/en/developers/apis/1-routing-api/ | Digitransit Routing API supports itinerary planning and route/timetable queries with endpoints for HSL, Waltti, Finland/Estonia, and Southwest Finland/ELY. | Differentiates HSL router from broader Finland router. | Requires API registration/key for production use. |
| Digitransit routing data | Routing Data API | Digitransit | https://digitransit.fi/en/developers/apis/2-routing-data-api/ | Provides OTP router datasets for Finland/Estonia, HSL region, Southwest Finland and Waltti cities. HSL endpoint includes `HSL.zip` and `HSL-lautta.zip`. Finland/Estonia endpoint contains cities, ELY-centres and long-distance market-based coach connections; coach source is FINAP and operator-provided. | Key evidence that broader Digitransit may contain non-HSL operators. | Requires API key and raw endpoint inspection; no completeness guarantee. |
| Digitransit registration | API portal and registration | Digitransit | https://digitransit.fi/en/developers/api-registration | Production APIs require registration and API keys; keys can be passed as `digitransit-subscription-key`; rate/quota limiting enforced from 2024-01-31. | Access/reuse requirement. | No raw feed obtained. |
| Digitransit terms | Terms of use | Digitransit | https://digitransit.fi/en/developers/apis/7-terms-of-use/ | Digitransit is provided by HSL, Fintraffic and Waltti Solutions Oy; data are made available under JHS-189 and CC BY 4.0; OSM-based geographic/address data are under ODbL; Digitransit may change APIs and applies rate limiting. | License/access term source. | Terms do not certify coverage for FI001F. |
| Digitransit realtime | Realtime API / getting started | Digitransit | https://digitransit.fi/en/developers/apis/5-realtime-api/ and https://digitransit.fi/en/developers/apis/5-realtime-api/1-getting-started/ | HSL realtime is handled by Transitdata; not all vehicles produce realtime data, notably U-line buses; Fintraffic provides train realtime through Digitraffic with a GTFS-RT wrapper. | Missingness/reliability caveat. | Realtime != scheduled coverage; quality varies. |
| Fintraffic public-transport information | Public transport information services | Fintraffic | https://www.fintraffic.fi/en/digitalservices/Traffic-and-Public-Transport-Data-Services/public-transportation-information | Fintraffic compiles route and timetable data for ferries, trains and buses from authorities/operators and operates a national public-transport information pool used in the national journey planner and international journey-planner services. | National service-source recovery path. | Does not by itself identify all FI001F operators. |
| FINAP | FINAP instructions and terms | Fintraffic | https://www.fintraffic.fi/en/fintraffic-9/digitalservices/Traffic-and-Public-Transport-Data-Services/Finap-service/terms | FINAP publishes essential information on traffic services including public transport, taxi, train traffic and brokering services; content can include routes, timetables, stops, service areas, service hours, prices and developer interfaces. | Possible source path for non-HSL operator manifests. | Catalogue/source extraction not performed. |
| FINAP scheduled public transport | Public transport and regular scheduled traffic | Fintraffic | https://www.fintraffic.fi/en/digitalservices/Traffic-and-Public-Transport-Data-Services/Finap-service/public-transport | FINAP regular scheduled traffic includes local public transport, train traffic, seasonal ferry connections and similar services; operators/authorities can publish route/timetable/stop data by file or interface and RAE can publish data nationally for journey planners. | Non-HSL bus/rail/ferry source path. | Materiality inside FI001F unresolved. |
| FINAP DRT | Demand responsive traffic | Fintraffic | https://www.fintraffic.fi/en/digitalservices/Traffic-and-Public-Transport-Data-Services/Finap-service/drt | DRT can be submitted to FINAP; DRT can be flexible or regular-route/timetable upon order; described services are published in GTFS Flex and GeoJSON. | DRT/paratransit/source-family check. | No FI001F-specific DRT dataset extracted. |
| Digitraffic rail | Digitraffic open data and APIs | Fintraffic | https://www.digitraffic.fi/en/ | Digitraffic railway APIs provide timetables, dispatch advices, train locations, setups and metadata. | National rail/realtime source path. | Not an HSL route/feed manifest; raw railway query not run. |
| National journey planner | Matka.fi | Traficom | https://traficom.fi/en/transport-system/public-transport/matkafi | Matka.fi is a door-to-door journey planner combining transport modes; page points to ferry route/timetable channels and other journey-planning services. | National multi-modal journey-planner context. | User-facing service, not a raw feed manifest. |
| Fintraffic routing platform | Next-generation routing engine / route planners | Fintraffic | https://www.fintraffic.fi/en/news/next-generation-routing-engine-be-deployed-route-planners | Fintraffic states regional route planners including HSL and the national Matka.fi planner use Digitransit; Fintraffic collates public transport routes/timetables in the national planner, including long-distance and commuter services, buses, trams, metro, trains, ferries and air connections. | Supports broader Digitransit/Fintraffic integration path. | News item, not raw feed metadata. |
| Matkahuolto planner | Journey Planner | Matkahuolto | https://www.matkahuolto.fi/passengers/journey-planner | Matkahuolto says its planner works nationwide and includes nationwide long-distance bus services, plus local/regional transport operated by HSL, Turku, Tampere and other Waltti cities. | Interurban/local bus source path, especially outside HSL area. | User-facing service; raw data/API terms not verified. |
| Municipal source | Public and service transportation | City of Järvenpää | https://www.jarvenpaa.fi/en/housing-and-environment/streets-and-traffic/public-and-service-transportation | Järvenpää points local/regional bus routes and timetables to Matkahuolto Reittiopas, HSL routes/timetables to HSL, train timetables to VR/HSL, and describes two service-transportation lines with route deviations by phone. | Concrete possible missing-service example inside likely FI001F but outside HSL member area. | Does not prove all Järvenpää services are in or outside Digitransit. |

---

## 3. YAML-style raw source bundle

```yaml
helsinki_operator_inventory_return:
  return_status: raw_research_material_only
  reviewed_boundary:
    fua_code: FI001F
    boundary_source:
      primary_source_family:
        - Eurostat GISCO Urban Audit cities and functional urban areas geodata
        - OECD Functional Urban Areas / list of municipalities in FUAs and Cities
      method_context:
        - Eurostat FUA method: city plus commuting zone; commuting zone based on LAU workplace commuting threshold
        - OECD FUA method: city plus surrounding areas economically connected through workplace commuting; density and travel-to-work flows
    source_url_or_access_path:
      - https://ec.europa.eu/eurostat/web/gisco/geodata/statistical-units/cities-functional-urban-areas
      - https://gisco-services.ec.europa.eu/distribution/v2/urau/urau-2021-metadata.pdf
      - https://www.oecd.org/en/data/datasets/oecd-definition-of-cities-and-functional-urban-areas.html
      - https://www.oecd.org/content/dam/oecd/en/data/datasets/oecd-definition-of-cities-and-functional-urban-areas/list_of_municipalities_in_FUAs_and_Cities.csv
      - https://ec.europa.eu/eurostat/statistics-explained/index.php?title=Territorial_typologies_manual_-_cities%2C_commuting_zones_and_functional_urban_areas
    municipalities_or_subareas_found:
      official_status: exact_official_FI001F_municipality_extraction_not_performed
      official_source_that_can_identify_membership:
        - OECD list_of_municipalities_in_FUAs_and_Cities.csv
        - Eurostat GISCO Urban Audit area management geodata / related attribute table joinable on URAU code
      secondary_unofficial_crosswalk_for_verification_queue:
        source: tbed EU geography database / NUTS and LAU2 and cities/metros
        candidate_FI001F_LAUs_from_viewed_snippets:
          - Borgå / Porvoo
          - Borgnäs / Pornainen
          - Esbo / Espoo
          - Grankulla / Kauniainen
          - Helsingfors / Helsinki
          - Ingå / Inkoo
          - Kervo / Kerava
          - Kyrkslätt / Kirkkonummi
          - Mäntsälä
          - Nurmijärvi
          - Sibbo / Sipoo
          - Sjundeå / Siuntio
          - Träskända / Järvenpää
          - Tusby / Tuusula
          - Vanda / Vantaa
          - Vichtis / Vihti
        verification_status: secondary_only__must_verify_against_official_OECD_or_GISCO_source_before_use
    uncertainty_notes:
      - FI001F exact row is stated by handoff as verified_not_archived; this return did not archive it.
      - Municipality membership list above is not admitted as evidence because it relies on secondary snippets; official OECD/GISCO extraction is required.
      - FUA boundary cannot be replaced by HSL service area, fare zones, GTFS extents, stop buffers or Journey Planner coverage.

  hsl_digitransit_coverage:
    - source_name: HSL area and zones
      source_authority: HSL
      source_url_or_access_path:
        - https://www.hsl.fi/en/tickets-and-fares/hsl-area-and-zones
      modes_or_operators_claimed:
        - HSL area / ticket geography; not a feed manifest
      municipalities_or_geography_claimed:
        HSL_member_municipalities:
          - Helsinki
          - Espoo
          - Vantaa
          - Kauniainen
          - Siuntio
          - Kirkkonummi
          - Sipoo
          - Kerava
          - Tuusula
        neighboring_or_special_cases:
          - Järvenpää is not an HSL member municipality but HSL tickets apply for some journeys through/from/to Järvenpää
          - Neighboring municipalities listed for resident season-ticket or commuter-ticket relationships include Askola, Hanko, Hausjärvi, Inkoo, Karkkila, Lohja, Loppi, Mäntsälä, Nurmijärvi, Pornainen, Porvoo, Pukkila, Raasepori and Vihti
      feed_or_api_format: not_applicable
      vintage_or_update_date: current_web_page_as_of_2026_07_05_scan
      access_or_license_terms: public HSL website
      verification_status: source_claim_verified__not_a_boundary_source

    - source_name: HSL open data / Journey Planner APIs / GTFS / GTFS-RT
      source_authority: HSL
      source_url_or_access_path:
        - https://www.hsl.fi/en/hsl/open-data
        - https://hsldevcom.github.io/gtfs_rt/
      modes_or_operators_claimed:
        - HSL public transport routes with valid timetables in HSL public transport register
        - HSL GTFS-RT service alerts
        - HSL GTFS-RT trip updates
        - HSL GTFS-RT vehicle positions
      municipalities_or_geography_claimed:
        - HSL region / HSL service context
      feed_or_api_format:
        - GTFS static
        - GTFS-RT
        - GraphQL/REST Journey Planner APIs via Digitransit
        - MQTT / realtime interfaces noted by HSL
        - OSM PBF for routing/geocoding/background map
      vintage_or_update_date:
        - HSL network data updated daily to Journey Planner APIs
        - HSL GTFS parsed daily from HSL register
        - HSL GTFS extraction window: two months from extraction start per HSL open-data page
        - OSM data updated daily into HSL Journey Planner
      access_or_license_terms:
        - HSL open data generally CC BY 4.0
        - Journey Planner OSM geometry/address data under ODbL
        - cite Licensee and time when HSL delivered data
      verification_status: source_claim_verified__operator_completeness_against_FI001F_unresolved

    - source_name: HSL public transport modes
      source_authority: HSL
      source_url_or_access_path:
        - https://www.hsl.fi/en/travelling/visitors
      modes_or_operators_claimed:
        - bus
        - tram
        - Metro
        - commuter train
        - ferry
      municipalities_or_geography_claimed:
        - Helsinki region / HSL services
      feed_or_api_format: not_applicable
      vintage_or_update_date: current_web_page_as_of_2026_07_05_scan
      access_or_license_terms: public HSL website
      verification_status: source_claim_verified__not_a_feed_manifest

    - source_name: HSL U-line services
      source_authority: HSL
      source_url_or_access_path:
        - https://www.hsl.fi/en/travelling/u-line-services
      modes_or_operators_claimed:
        - U-line bus services extending beyond HSL area
        - mostly commercial operator services
        - some routes/services procured by Uusimaa ELY Centre
      municipalities_or_geography_claimed:
        - routes extend beyond HSL area
      feed_or_api_format:
        - Journey Planner scheduled timetable visibility
        - no realtime vehicle location information for U-line buses per HSL page
      vintage_or_update_date: current_web_page_as_of_2026_07_05_scan
      access_or_license_terms: public HSL website; operator ticket rules may apply outside HSL area
      verification_status: source_claim_verified__route_level_and_FI001F_overlap_not_extracted

    - source_name: Digitransit Routing API
      source_authority:
        - HSL
        - Fintraffic
        - Waltti Solutions Oy
      source_url_or_access_path:
        - https://digitransit.fi/en/developers/apis/1-routing-api/
        - https://digitransit.fi/en/developers/api-registration
      modes_or_operators_claimed:
        - route and timetable information queryable through GraphQL/OTP-derived APIs
      municipalities_or_geography_claimed:
        router_endpoints:
          - Helsinki region: https://api.digitransit.fi/routing/v2/hsl/gtfs/v1
          - Waltti regions: https://api.digitransit.fi/routing/v2/waltti/gtfs/v1
          - Finland and Estonia: https://api.digitransit.fi/routing/v2/finland/gtfs/v1
          - Varsinais-Suomen ELY: https://api.digitransit.fi/routing/v2/varely/gtfs/v1
      feed_or_api_format:
        - GraphQL Routing API
        - OpenTripPlanner router datasets
      vintage_or_update_date: current_docs_as_of_2026_07_05_scan
      access_or_license_terms:
        - production APIs require registration and API keys
        - `digitransit-subscription-key` URL parameter or header
        - rate/quota limiting enforced from 2024-01-31
      verification_status: source_claim_verified__raw_endpoint_query_not_performed

    - source_name: Digitransit Routing Data API
      source_authority:
        - HSL
        - Fintraffic
        - Waltti Solutions Oy
      source_url_or_access_path:
        - https://digitransit.fi/en/developers/apis/2-routing-data-api/
      modes_or_operators_claimed:
        - HSL endpoint contains HSL GTFS and ferry GTFS build files (`HSL.zip`, `HSL-lautta.zip`)
        - Finland/Estonia endpoint contains public transport services by cities and ELY-centres and long-distance market-based coach connections
        - coach data source is FINAP and is operator-provided
      municipalities_or_geography_claimed:
        - HSL router dataset
        - Finland/Estonia router dataset
        - Waltti city router dataset
        - Southwest Finland/ELY router dataset
      feed_or_api_format:
        - OpenTripPlanner routing-data endpoint
        - GTFS files within router build inputs
        - OSM PBF inputs
      vintage_or_update_date:
        - endpoint contains version timestamp files in routing data packages; not accessed in this return
      access_or_license_terms:
        - API key required
        - FINAP coach data licensed CC BY 4.0 per Digitransit Routing Data API page
      verification_status: source_claim_verified__operator_manifest_not_extracted

    - source_name: Digitransit realtime / terms
      source_authority:
        - HSL
        - Fintraffic
        - Waltti Solutions Oy
      source_url_or_access_path:
        - https://digitransit.fi/en/developers/apis/5-realtime-api/
        - https://digitransit.fi/en/developers/apis/5-realtime-api/1-getting-started/
        - https://digitransit.fi/en/developers/apis/7-terms-of-use/
      modes_or_operators_claimed:
        - HSL realtime through Transitdata into GTFS-RT
        - train realtime from Fintraffic/Digitraffic with GTFS-RT wrapper
        - Waltti realtime for many cities
      municipalities_or_geography_claimed:
        - HSL region
        - broader Finnish rail and other-city context
      feed_or_api_format:
        - GTFS-RT service alerts
        - GTFS-RT trip updates
        - GTFS-RT vehicle positions
        - custom JSON vehicle positions in some APIs
      vintage_or_update_date: current_docs_as_of_2026_07_05_scan
      access_or_license_terms:
        - Digitransit registered usage terms
        - CC BY 4.0 for Digitransit data
        - OSM-based data under ODbL
        - API may change; rate limiting may apply
      verification_status: source_claim_verified__realtime_completeness_against_FI001F_unresolved

  possible_missing_operators_or_modes:
    - operator_or_mode: Non-HSL local/regional bus services in candidate FI001F municipalities outside HSL member area
      reason_it_may_matter: Secondary FUA crosswalk suggests FI001F includes municipalities outside HSL member area; HSL static GTFS likely cannot be assumed to cover all local/regional bus service in those areas.
      source_url_or_access_path:
        - https://tbed.org/eudemo/index.php?function=details&tablename=nuts3_vw&where_field=nuts_code&where_value=FI1B1
        - https://www.hsl.fi/en/tickets-and-fares/hsl-area-and-zones
        - https://digitransit.fi/en/developers/apis/2-routing-data-api/
        - https://www.fintraffic.fi/en/digitalservices/Traffic-and-Public-Transport-Data-Services/public-transportation-information
      geography_relevance_to_FI001F: possible_outside_HSL_inside_FI001F__requires_official_FI001F_LAU_extraction
      verification_status: plausible_missingness_risk__not_operator_inventory

    - operator_or_mode: Järvenpää internal bus routes 21-27 and Järvenpää local/regional bus services
      reason_it_may_matter: HSL states Järvenpää is not an HSL member and HSL tickets are not accepted on Järvenpää internal bus routes 21-27; City of Järvenpää points to Matkahuolto Reittiopas for local/regional bus routes and timetables.
      source_url_or_access_path:
        - https://www.hsl.fi/en/tickets-and-fares/hsl-area-and-zones
        - https://www.jarvenpaa.fi/en/housing-and-environment/streets-and-traffic/public-and-service-transportation
        - https://www.matkahuolto.fi/passengers/journey-planner
      geography_relevance_to_FI001F: likely_inside_candidate_FI001F_from_secondary_crosswalk__official_extraction_required
      verification_status: concrete_missingness_risk_for_HSL_static_GTFS__Digitransit_Finland_or_Matkahuolto_coverage_unverified

    - operator_or_mode: U-line buses extending beyond HSL area
      reason_it_may_matter: HSL says U-lines extend beyond HSL area; timetables are in Journey Planner but no realtime location information is available, and most are commercial operators with some Uusimaa ELY-procured services.
      source_url_or_access_path:
        - https://www.hsl.fi/en/travelling/u-line-services
      geography_relevance_to_FI001F: potentially_connects_HSL_area_to_neighboring_FI001F_or_commuting_zone_municipalities
      verification_status: scheduled_timetable_presence_verified__route_level_overlap_not_extracted

    - operator_or_mode: Regional rail / VR / Fintraffic railway data
      reason_it_may_matter: HSL includes commuter trains in its modes and some Järvenpää-area stations accept HSL or VR tickets; Fintraffic/Digitraffic railway APIs provide timetables, train locations and metadata.
      source_url_or_access_path:
        - https://www.hsl.fi/en/tickets-and-fares/hsl-area-and-zones
        - https://www.digitraffic.fi/en/
        - https://digitransit.fi/en/developers/apis/5-realtime-api/1-getting-started/
      geography_relevance_to_FI001F: rail corridors likely cross HSL and non-HSL FI001F areas; exact station/operator manifest not extracted
      verification_status: source_family_verified__FI001F_service_manifest_unresolved

    - operator_or_mode: Matkahuolto / interurban coach / national long-distance bus
      reason_it_may_matter: Matkahuolto says its Journey Planner includes nationwide long-distance bus and local/regional services; Digitransit Finland routing-data endpoint contains long-distance market-based coach connections sourced from FINAP.
      source_url_or_access_path:
        - https://www.matkahuolto.fi/passengers/journey-planner
        - https://digitransit.fi/en/developers/apis/2-routing-data-api/
      geography_relevance_to_FI001F: relevant_to_FI001F_neighboring_municipality_commute_and_interurban_service_candidates
      verification_status: source_family_verified__raw_feed_or_operator_manifest_not_extracted

    - operator_or_mode: Demand-responsive transport / service lines / paratransit-like services
      reason_it_may_matter: Järvenpää describes service transportation lines with route deviations; FINAP supports DRT publication in GTFS Flex and GeoJSON. HSL/EMTA supplemental material also suggests on-demand buses may exist in the wider PTA context, but EMTA was not treated as primary proof.
      source_url_or_access_path:
        - https://www.jarvenpaa.fi/en/housing-and-environment/streets-and-traffic/public-and-service-transportation
        - https://www.fintraffic.fi/en/digitalservices/Traffic-and-Public-Transport-Data-Services/Finap-service/drt
      geography_relevance_to_FI001F: possible_in_municipal_subareas_inside_FI001F; materiality unresolved
      verification_status: source_family_verified__materiality_and_Digitransit_inclusion_unresolved

    - operator_or_mode: Ferry / waterborne scheduled services beyond HSL Suomenlinna ferry
      reason_it_may_matter: HSL includes ferry in its mode bundle and `HSL-lautta.zip` appears in HSL routing-data build inputs; FINAP supports regular scheduled seasonal ferry and waterborne traffic publication. Other municipal/regional ferry materiality inside FI001F not verified.
      source_url_or_access_path:
        - https://www.hsl.fi/en/travelling/visitors
        - https://digitransit.fi/en/developers/apis/2-routing-data-api/
        - https://www.fintraffic.fi/en/digitalservices/Traffic-and-Public-Transport-Data-Services/Finap-service/public-transport
        - https://traficom.fi/en/transport-system/public-transport/matkafi
      geography_relevance_to_FI001F: possible_coastal_archipelago_context; likely low but unresolved without operator scan
      verification_status: HSL_ferry_verified__non_HSL_ferry_materiality_unverified

  coverage_risk_assessment:
    likely_inside_hsl_digitransit:
      - HSL member municipalities and services represented in the HSL public-transport register with valid timetables.
      - HSL bus, tram, Metro, commuter train and ferry services published through HSL GTFS/Journey Planner source paths.
      - U-line scheduled timetables in HSL Journey Planner, but without realtime vehicle-location information.
      - Broader non-HSL scheduled services may be inside Digitransit Finland endpoint if submitted through FINAP/city/ELY/operator paths, but this is not verified at FI001F level.
    likely_outside_hsl_digitransit:
      - Not proven. However HSL static GTFS alone should be treated as likely incomplete for FI001F if official FI001F membership includes non-HSL municipalities shown in secondary crosswalk snippets.
      - Järvenpää internal bus routes 21-27 are explicitly outside HSL ticket acceptance; whether they appear in Digitransit Finland or Matkahuolto-only paths requires feed inspection.
      - Municipal service-transportation lines, DRT, paratransit-like services, school services, private shuttles or airport coaches are not proven to be present in HSL/Digitransit and require source-by-source treatment.
    unclear:
      - Exact official FI001F LAU membership and all municipalities/subareas.
      - Whether the HSL router endpoint, as distinct from the Finland/Estonia router endpoint, contains Järvenpää, U-line, VR-only, ELY-procured, Matkahuolto, or other non-HSL services relevant to FI001F.
      - Whether Digitransit Finland endpoint contains complete local/regional bus coverage for all FI001F municipalities.
      - Whether FINAP, Matkahuolto and municipal service data can be acquired as reusable raw feeds rather than only user-facing journey-planner views.
      - Whether regional rail and long-distance rail should be counted as material inside FI001F for the first service-coverage method test.
    high_risk_missingness:
      - FI001F official municipality list not archived.
      - HSL member-area mismatch against likely FI001F non-HSL municipalities.
      - HSL-only GTFS versus broader Digitransit Finland router divergence.
      - U-line scheduled-only / no realtime caveat.
      - Järvenpää internal/local/service transport example.
      - DRT/GTFS Flex/GeoJSON publication existence but FI001F materiality unresolved.
      - API-key/rate-limit requirements for Digitransit production APIs.

  recommended_next_source_notes:
    - source_name: Eurostat/OECD Helsinki FI001F boundary and municipality membership
      reason: Need exact official FI001F LAU membership, not secondary crosswalk snippets.
      source_url_or_access_path:
        - https://www.oecd.org/content/dam/oecd/en/data/datasets/oecd-definition-of-cities-and-functional-urban-areas/list_of_municipalities_in_FUAs_and_Cities.csv
        - https://ec.europa.eu/eurostat/web/gisco/geodata/statistical-units/cities-functional-urban-areas
    - source_name: HSL open data / static GTFS / GTFS-RT
      reason: HSL is the primary service-source family but likely not complete for full FI001F alone.
      source_url_or_access_path:
        - https://www.hsl.fi/en/hsl/open-data
        - https://hsldevcom.github.io/gtfs_rt/
    - source_name: HSL area, zones, neighboring municipalities and Järvenpää rules
      reason: Key evidence of HSL geography and special Järvenpää/non-HSL service issues.
      source_url_or_access_path:
        - https://www.hsl.fi/en/tickets-and-fares/hsl-area-and-zones
    - source_name: HSL U-line services
      reason: U-lines extend beyond HSL area and expose scheduled/realtime and operator-control caveats.
      source_url_or_access_path:
        - https://www.hsl.fi/en/travelling/u-line-services
    - source_name: Digitransit routing data and terms
      reason: Need to distinguish HSL router, Finland/Estonia router, Waltti router and FINAP-sourced coach data.
      source_url_or_access_path:
        - https://digitransit.fi/en/developers/apis/1-routing-api/
        - https://digitransit.fi/en/developers/apis/2-routing-data-api/
        - https://digitransit.fi/en/developers/api-registration
        - https://digitransit.fi/en/developers/apis/7-terms-of-use/
    - source_name: Fintraffic public-transport information / FINAP / Digitraffic rail
      reason: National source-recovery path for non-HSL bus, rail, ferry, DRT and operator-published interfaces.
      source_url_or_access_path:
        - https://www.fintraffic.fi/en/digitalservices/Traffic-and-Public-Transport-Data-Services/public-transportation-information
        - https://www.fintraffic.fi/en/fintraffic-9/digitalservices/Traffic-and-Public-Transport-Data-Services/Finap-service/terms
        - https://www.digitraffic.fi/en/
    - source_name: Järvenpää public and service transportation
      reason: Concrete local bus/service-transportation risk in a likely FI001F municipality outside HSL member area.
      source_url_or_access_path:
        - https://www.jarvenpaa.fi/en/housing-and-environment/streets-and-traffic/public-and-service-transportation
    - source_name: Matkahuolto Journey Planner
      reason: Candidate path for local/regional/interurban bus timetables outside HSL area.
      source_url_or_access_path:
        - https://www.matkahuolto.fi/passengers/journey-planner

  rejected_or_quarantined_material:
    - item: HSL service area as MTR denominator
      reason: HSL service geography is an overlay/input, not FI001F boundary; using it would hide unserved or non-HSL-served areas.
    - item: HSL fare zones as MTR boundary
      reason: Fare zones are operational/fare geography, not a functional commuting-region denominator.
    - item: GTFS extent, route buffers, stop buffers, Journey Planner coverage or realtime-availability polygons as MTR denominator
      reason: Service-derived geographies can erase unserved population from the denominator.
    - item: HSL reputation or Helsinki reputation
      reason: Outcome-adjacent and prohibited by source-led guardrails.
    - item: tbed EU geography database as accepted evidence
      reason: Useful secondary crosswalk only; official OECD/GISCO extraction required.
    - item: Matkahuolto or Matka.fi user-facing journey-planner coverage as proof of raw data completeness
      reason: Useful source lead, but not a raw feed manifest or reproducible operator inventory.
    - item: EMTA Helsinki profile as primary source
      reason: Useful supplemental governance/operator context, but this raw return prioritized official HSL/Fintraffic/source-family documents.
```

---

## 4. Possible missing operators/modes

### 4.1 Non-HSL municipalities likely inside FI001F

The strongest unresolved coverage issue is not whether HSL covers the HSL area. It is whether the HSL/Digitransit source bundle covers all material public-transport service inside the **FI001F denominator**.

The official source path that should answer exact membership is OECD's `list_of_municipalities_in_FUAs_and_Cities.csv` or equivalent GISCO/Urban Audit attribute extraction. This return did not download that file. Secondary/non-official crosswalk snippets suggest that `FI001F` includes HSL member municipalities plus additional municipalities such as Inkoo, Järvenpää, Mäntsälä, Nurmijärvi, Pornainen, Porvoo and Vihti. Those additional municipalities create the primary HSL-only coverage risk.

### 4.2 Järvenpää local buses and service transportation

Järvenpää is a concrete source-led risk case:

- HSL says Järvenpää is not an HSL member municipality.
- HSL tickets can be used for some Järvenpää-related rail and bus journeys, but not for Järvenpää internal bus routes 21–27.
- City of Järvenpää points local/regional bus timetables to Matkahuolto Reittiopas.
- City of Järvenpää describes two service-transportation lines, with route deviations by phone.

Raw implication: HSL static GTFS alone should be assumed insufficient for Järvenpää. Whether broader Digitransit Finland, Matkahuolto, FINAP or municipal sources cover the routes requires raw feed/source acquisition.

### 4.3 U-line buses

HSL U-lines extend beyond HSL area and are shown in Journey Planner as scheduled timetables. HSL states realtime location data is not available for U-line buses and that most U-lines are commercially operated, with some Uusimaa ELY-procured routes/services.

Raw implication: U-lines may appear in HSL Journey Planner but should receive a realtime-missingness caveat. They also blur HSL/operator/ELY source responsibility.

### 4.4 Regional rail and VR / Digitraffic

HSL includes commuter train service in its modes, and Järvenpää-related stations can accept HSL or VR tickets in some circumstances. Digitraffic railway APIs provide national rail timetable/location/dispatch metadata, and Digitransit realtime docs point to Fintraffic train realtime and a GTFS-RT wrapper.

Raw implication: rail should not be treated as missing, but the split among HSL commuter rail, VR ticketing, Digitraffic realtime, and possible long-distance/regional services requires a dedicated source note.

### 4.5 Matkahuolto / interurban coach / FINAP

Matkahuolto says its journey planner includes nationwide long-distance bus services and local/regional services from HSL, Turku, Tampere and other Waltti cities. Digitransit Routing Data API says the Finland/Estonia endpoint includes city, ELY-centre and long-distance market-based coach data, with coach data sourced from FINAP and provided by operators.

Raw implication: the broader Digitransit/Fintraffic/FINAP/Matkahuolto ecosystem is likely required for FI001F service coverage beyond HSL. Raw endpoint and operator-list inspection remains unresolved.

### 4.6 Demand-responsive, paratransit-like, service-line, ferry and school services

FINAP supports DRT publication in GTFS Flex and GeoJSON; Järvenpää describes service transportation. FINAP also supports regular scheduled seasonal ferry and waterborne traffic. HSL includes ferry service and HSL routing-data docs list a ferry GTFS build file (`HSL-lautta.zip`).

Raw implication: these sources should be listed as possible missingness categories, not automatically scored or included. Materiality inside FI001F must be established before data acquisition.

---

## 5. Rejected/quarantined material

| Item | Status | Reason |
|---|---|---|
| HSL service area as MTR denominator | Rejected | The task is coverage against FI001F, not redefining FI001F as HSL's service area. |
| HSL fare zones A-E as MTR denominator | Rejected | Fare zones are operational/fare geography and can include or exclude areas for fare reasons, not functional-region definition. |
| HSL GTFS route/stops extent as denominator | Rejected | Service-derived denominators hide unserved or non-HSL-served populations. |
| HSL Journey Planner coverage as denominator | Rejected | Journey Planner coverage is a service/discovery layer, not an observed FUA boundary. |
| HSL reputation / Helsinki reputation | Rejected | The handoff forbids reputation-based selection or claims. |
| tbed municipality crosswalk as accepted evidence | Quarantined | Useful to seed an extraction checklist, but not official enough for a boundary record. |
| Matkahuolto user-facing journey planner as raw feed evidence | Quarantined | Useful source lead, but raw API/feed/license path unresolved. |
| Fintraffic news page as full data manifest | Quarantined | Useful ecosystem context, but not a raw endpoint inventory. |
| Wikipedia/travel guides/blogs/livability content | Rejected | Outside allowed source families. |

---

## 6. Open questions for Thesis 2

1. Can Codex or the infrastructure thread archive the official OECD `list_of_municipalities_in_FUAs_and_Cities.csv` and extract all rows where `FUA ID = FI001F`?
2. Should the FI001F boundary artifact use Eurostat/GISCO Urban Audit 2021 or 2024 geometry for this source-bundle test, given the current population posture is a short-window 2023 candidate?
3. After official FI001F municipalities are extracted, which municipalities fall outside HSL member area?
4. Should HSL source coverage be tested as:
   - HSL-only bundle, or
   - HSL plus Digitransit Finland endpoint plus FINAP/Digitraffic/Matkahuolto recovery paths?
5. Does the HSL router endpoint include any non-member-area services, or are those visible only through HSL Journey Planner UI / Finland router / Matkahuolto / FINAP?
6. Do U-line services appear in HSL static GTFS, HSL Journey Planner only, broader Digitransit routing data, FINAP, or operator-owned feed paths?
7. How should scheduled-only U-line service be handled if later reliability indicators depend on GTFS-RT or observed vehicle positions?
8. Are Järvenpää internal bus routes 21-27 present in any reusable feed: Matkahuolto, FINAP, Digitransit Finland, municipal PDF only, or operator feed?
9. Should Järvenpää service transportation be considered public-transport service material for FI001F coverage, or only a paratransit/service-line caveat?
10. Which rail source should be primary for regional rail inside FI001F: HSL GTFS, Digitransit routing data, Digitraffic rail APIs, VR sources, or a merged rail source note?
11. Are Porvoo, Mäntsälä, Nurmijärvi, Vihti, Inkoo and Pornainen local/regional bus feeds available through FINAP/Digitransit/Matkahuolto, or only through operator/ELY timetable sources?
12. What evidence-manifest fields are needed to compare HSL `hsl` router coverage against Digitransit `finland` router coverage inside FI001F?
13. Should source-rich regions like Helsinki be required to pass the same operator-completeness test as less source-rich regions, to avoid data-availability bias?
14. What threshold defines “material” missing service for an operator/mode inventory: share of population, route volume, boardings, trips, geographic area, or presence in specific FUA municipalities?

---

## 7. Source URL list

```text
Eurostat GISCO — Cities and functional urban areas geodata
https://ec.europa.eu/eurostat/web/gisco/geodata/statistical-units/cities-functional-urban-areas

Eurostat GISCO — Urban Audit 2021 Area management metadata PDF
https://gisco-services.ec.europa.eu/distribution/v2/urau/urau-2021-metadata.pdf

OECD — Definition of Cities and Functional Urban Areas
https://www.oecd.org/en/data/datasets/oecd-definition-of-cities-and-functional-urban-areas.html

OECD — List of municipalities in FUAs and Cities CSV
https://www.oecd.org/content/dam/oecd/en/data/datasets/oecd-definition-of-cities-and-functional-urban-areas/list_of_municipalities_in_FUAs_and_Cities.csv

Eurostat — Territorial typologies manual: cities, commuting zones and FUAs
https://ec.europa.eu/eurostat/statistics-explained/index.php?title=Territorial_typologies_manual_-_cities%2C_commuting_zones_and_functional_urban_areas

tbed secondary EU geography database — Helsinki-Uusimaa / FI001F source lead
https://tbed.org/eudemo/index.php?function=details&tablename=nuts3_vw&where_field=nuts_code&where_value=FI1B1

HSL — HSL area and zones
https://www.hsl.fi/en/tickets-and-fares/hsl-area-and-zones

HSL — U-line services
https://www.hsl.fi/en/travelling/u-line-services

HSL — Route maps and station maps
https://www.hsl.fi/en/travelling/route_and_station_maps

HSL — Visitors / public transport modes
https://www.hsl.fi/en/travelling/visitors

HSL — Open data
https://www.hsl.fi/en/hsl/open-data

HSL Developer Community — GTFS-RT API documentation
https://hsldevcom.github.io/gtfs_rt/

Digitransit — Routing API
https://digitransit.fi/en/developers/apis/1-routing-api/

Digitransit — Routing Data API
https://digitransit.fi/en/developers/apis/2-routing-data-api/

Digitransit — API portal and registration
https://digitransit.fi/en/developers/api-registration

Digitransit — Realtime APIs
https://digitransit.fi/en/developers/apis/5-realtime-api/

Digitransit — Realtime getting started
https://digitransit.fi/en/developers/apis/5-realtime-api/1-getting-started/

Digitransit — Terms of use
https://digitransit.fi/en/developers/apis/7-terms-of-use/

Waltti — Open data
https://waltti.fi/en/open-data/

Fintraffic — Digitransit
https://www.fintraffic.fi/en/digitransit-en

Fintraffic — Public transport information services
https://www.fintraffic.fi/en/digitalservices/Traffic-and-Public-Transport-Data-Services/public-transportation-information

Fintraffic — FINAP terms/instructions
https://www.fintraffic.fi/en/fintraffic-9/digitalservices/Traffic-and-Public-Transport-Data-Services/Finap-service/terms

Fintraffic — FINAP public transport and regular scheduled traffic
https://www.fintraffic.fi/en/digitalservices/Traffic-and-Public-Transport-Data-Services/Finap-service/public-transport

Fintraffic — FINAP demand-responsive traffic
https://www.fintraffic.fi/en/digitalservices/Traffic-and-Public-Transport-Data-Services/Finap-service/drt

Digitraffic — Open data and APIs for traffic
https://www.digitraffic.fi/en/

Traficom — Matka.fi
https://traficom.fi/en/transport-system/public-transport/matkafi

Fintraffic — Next-generation routing engine to be deployed in route planners
https://www.fintraffic.fi/en/news/next-generation-routing-engine-be-deployed-route-planners

Matkahuolto — Journey Planner
https://www.matkahuolto.fi/passengers/journey-planner

City of Järvenpää — Public and service transportation
https://www.jarvenpaa.fi/en/housing-and-environment/streets-and-traffic/public-and-service-transportation
```
