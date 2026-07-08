# Raw Return: Lyon FUA Static Feed / SIRI Lite / Operator Recovery

Date: 2026-07-05  
Thesis: Thesis 2 — Mobility Conversion  
Working lead: `mtr_src_002`  
Return status: raw_research_material_only  
Evidence status: not evidence, not source truth, not accepted methodology, not accepted MTR selection, not score, not ranking  

## 1. Short method summary

This raw return follows the Lyon FUA service-source recovery request. It checks traceable official or primary source paths for:

- France National Access Point / `transport.data.gouv.fr`;
- data.gouv.fr / France NAP resource metadata for `Réseau urbain TCL`;
- SYTRAL Mobilités and TCL official pages;
- Grand Lyon authentication, access, and mobility-license support pages;
- French SIRI / SIRI Lite documentation;
- SNCF national GTFS / NeTEx / real-time source path;
- Rhônexpress official service source;
- Auvergne-Rhône-Alpes regional coach/interurban source leads;
- Eurostat / GISCO and INSEE FUA source paths only for boundary-source context.

No raw feeds were downloaded. No population coverage was calculated. No service geography was used as an MTR denominator. No claim is made about Lyon transport quality.

The main recovery finding is:

- The official France NAP `Réseau urbain TCL` page still lists TCL static GTFS and NeTEx resources as unavailable in unauthenticated NAP metadata, with historical 2022 modification dates.
- The same official NAP page states that the producer requires authentication, that TCL timetable data cover commercial-line schedules for 60 days plus network geography/topology, that the data are under `Licence Mobilité`, and that a Grand Lyon account is required.
- Official Grand Lyon documentation identifies Basic Auth HTTP as the access method for protected Data Grand Lyon data after account setup.
- Three official TCL SIRI Lite resources are listed on France NAP: `estimated-timetables`, `situation-exchange`, and `vehicle-monitoring`. Their endpoints exist and show live availability checks, but transport.data.gouv.fr notes that no validation report is available for these resources, and its availability method may count HTTP 401/405 responses as successful for SIRI/SIRI Lite.
- SIRI Lite `Estimated Timetable` is a dynamic real-time service, not a substitute for an archived static GTFS/NeTEx schedule unless a separate collection and archiving protocol is intentionally created.

## 2. Source table

| Source family | Source title / path | Authority | URL / access path | Verification status | Relevance | Limits |
|---|---|---|---|---|---|---|
| France NAP / TCL dataset | `Réseau urbain TCL` | transport.data.gouv.fr; data published/responsible by SYTRAL Mobilités | `https://transport.data.gouv.fr/datasets/horaires-theoriques-du-reseau-transports-en-commun-lyonnais` | Official source path verified; raw static feed not acquired | Primary catalog path for TCL GTFS, NeTEx, SIRI Lite, PDF metadata | Static GTFS/NeTEx listed unavailable in NAP metadata; authentication required; service coverage cannot define MTR denominator |
| France NAP / SIRI Lite ET | Resource `84026`, `SIRI Lite - Estimated Timetables` | transport.data.gouv.fr / SYTRAL Mobilités / Grand Lyon endpoint | `https://transport.data.gouv.fr/resources/84026`; endpoint `https://data.grandlyon.com/siri-lite/2.0/estimated-timetables.json` | Resource page verified; endpoint not acquired because authentication barrier remains | Real-time / estimated timetable source lead | No validation report; availability checks alone do not prove field completeness or reproducible schedule baseline |
| France NAP / SIRI Lite SX | Resource `84027`, `SIRI Lite - Situation Exchange` | transport.data.gouv.fr / SYTRAL Mobilités / Grand Lyon endpoint | `https://transport.data.gouv.fr/resources/84027`; endpoint `https://data.grandlyon.com/siri-lite/2.0/situation-exchange.json` | Resource page verified; endpoint not acquired because authentication barrier remains | Disruption / situation source lead | No payload inspection; cannot prove full disruption fields for TCL without authenticated sample |
| France NAP / SIRI Lite VM | Resource `84028`, `SIRI Lite - Vehicle Monitoring` | transport.data.gouv.fr / SYTRAL Mobilités / Grand Lyon endpoint | `https://transport.data.gouv.fr/resources/84028`; endpoint `https://data.grandlyon.com/siri-lite/2.0/vehicle-monitoring.json` | Resource page verified; endpoint not acquired because authentication barrier remains | Vehicle monitoring source lead | Operational feed, not static schedule baseline; no payload inspection |
| France SIRI profile | `SIRI - Profil France v1.8` | French national transport-data standards portal | `https://normes.transport.data.gouv.fr/normes/siri/profil-france/` | Official documentation verified | Defines SIRI/SIRI Lite services and implementation expectations | Does not certify TCL endpoint payload completeness |
| France NAP real-time documentation | `Temps réel des transports en commun` | transport.data.gouv.fr documentation | `https://doc.transport.data.gouv.fr/producteurs/publier-des-donnees/temps-reel-des-transports-en-commun` | Official documentation path verified | Explains SIRI Lite, GTFS-RT, ET/SX/VM/SM positioning | Documentation is general; not TCL-specific |
| Grand Lyon auth docs | `Authentification — Documentation Data Grand Lyon` | Data Grand Lyon docs | `https://rdata-grandlyon.readthedocs.io/fr/latest/authentification.html` | Official/producer documentation verified | Explains account and Basic Auth HTTP path for protected data | Does not by itself authorize storage, redistribution, or automated archiving |
| Grand Lyon support | `Data GrandLyon` support page | Métropole de Lyon support | `https://support.grandlyon.com/data-grand-lyon/` | Official support path verified | Explains mobility-license account requirement and API/data-access posture | General support page; not TCL feed-specific schema |
| Eurostat GISCO FUA | Cities and functional urban areas geodata | Eurostat GISCO | `https://ec.europa.eu/eurostat/web/gisco/geodata/statistical-units/cities-functional-urban-areas` | Source system verified; exact FR002F row not re-extracted here | Boundary-source context only | Not service coverage; do not use TCL source extent as boundary |
| INSEE FUA base | `Base des cities et des aires urbaines fonctionnelles (FUA) - Eurostat` | INSEE | `https://www.insee.fr/fr/information/3642744` | Source path verified | France-specific FUA composition / shapefile source lead | Exact FR002F row not re-extracted in this raw return |
| SNCF national schedules | `Réseau SNCF TGV, Intercités et TER` | transport.data.gouv.fr / SNCF Voyageurs | `https://transport.data.gouv.fr/datasets/horaires-sncf` | Official source path verified | Possible non-TCL rail feed source for FR002F overlay | National feed not filtered to FR002F; SNCF page warns perimeter/authority caveats for real-time flows |
| SYTRAL network page | `Le réseau TCL` | SYTRAL Mobilités | `https://sytral-mobilites.fr/fr/le-reseau-tcl.html` | Official source verified | Confirms TCL / Cars du Rhône / Libellule unification as of 2025-09-01 and unified passenger info/fare posture | Network geography is not MTR boundary |
| TCL unified network page | `Le réseau TCL unifié` | TCL / SYTRAL Mobilités | `https://www.tcl.fr/a-propos/le-reseau-tcl-unifie` | Official source verified | Lists modes/network elements and operators under TCL unified network | Service information is not denominator; future feed coverage still must be verified |
| Rhônexpress official page | `Rhônexpress` | Rhônexpress / SYTRAL-linked official service page | `https://www.rhonexpress.fr/fr_FR/` | Official source verified | Possible material airport rail/link mode needing separate source treatment | Source page is service information, not feed metadata or FR002F coverage proof |
| Transitland TCL feed page | `GTFS feed: Transports en Commun Lyonnais (TCL)` | Transitland / Interline, third-party aggregator | `https://www.transit.land/feeds/f-u05-tcl~systral` | Secondary source lead only | Suggests current GTFS path may be fetchable with Basic Auth and provides archived-version clues | Not official evidence of producer availability; quarantine for source-note support only |
| Transitland archived version | `GTFS feed version ... f-u05-tcl~systral` | Transitland / Interline, third-party aggregator | `https://www.transit.land/feeds/f-u05-tcl~systral/versions/9757c2698220bae0fa549c9a70f4a532a52b2e23` | Secondary source lead only | Indicates one current 2026 feed archive existed in Transitland | Not official; do not use as substitute for official acquisition or license review |

## 3. YAML-style raw source bundle

```yaml
lyon_source_recovery_return:
  return_status: raw_research_material_only
  reviewed_boundary:
    fua_code: FR002F
    boundary_source:
      - source_name: Eurostat GISCO Cities and Functional Urban Areas
        source_authority: Eurostat GISCO
        source_url_or_access_path: https://ec.europa.eu/eurostat/web/gisco/geodata/statistical-units/cities-functional-urban-areas
      - source_name: INSEE Base des cities et des aires urbaines fonctionnelles FUA - Eurostat
        source_authority: INSEE
        source_url_or_access_path: https://www.insee.fr/fr/information/3642744
    service_coverage_relevance: >
      FR002F is retained only as the reviewed FUA code supplied by the Thesis 2 gate.
      This raw return did not re-extract or archive the exact official FR002F boundary row.
      TCL/SYTRAL service geography, SIRI endpoint coverage, GTFS extent, route buffers,
      stop buffers, fare zones, and catalog covered areas must not define the MTR
      denominator.
    uncertainty_notes:
      - exact_FR002F_boundary_row_not_re_extracted_in_this_return
      - service_coverage_against_FR002F_unresolved
      - France_NAP_covered_area_list_does_not_equal_verified_FR002F_boundary

  static_feed_recovery:
    gtfs:
      source_found: source_path_found_but_current_official_public_fetch_not_verified
      source_authority:
        - transport.data.gouv.fr
        - SYTRAL Mobilités
        - Grand Lyon data endpoint
      source_url_or_access_path:
        catalog_page: https://transport.data.gouv.fr/datasets/horaires-theoriques-du-reseau-transports-en-commun-lyonnais
        producer_connection_page: https://data.grandlyon.com/portail/fr/connexion
        probable_download_path_from_catalog: https://download.data.grandlyon.com/files/rdata/tcl_sytral.tcltheorique/GTFS_TCL.ZIP
        third_party_secondary_lead: https://www.transit.land/feeds/f-u05-tcl~systral
      current_or_stale: >
        Official France NAP catalog metadata lists GTFS as unavailable with latest
        content modification in April 2022 and 0 percent availability. The same
        catalog page says data require authentication through Grand Lyon and that
        the timetable data cover commercial-line schedules for 60 days plus network
        geography/topology. A third-party Transitland page reports a recent successful
        GTFS fetch from the same Grand Lyon URL with Basic Auth, but this is not an
        official producer verification.
      authentication_or_license:
        license: Licence Mobilité
        access: Grand Lyon account required; Basic Auth HTTP documented for protected Data Grand Lyon data
        source_paths:
          - https://rdata-grandlyon.readthedocs.io/fr/latest/authentification.html
          - https://support.grandlyon.com/data-grand-lyon/
      verification_status: >
        Official source path verified. Current static GTFS not acquired. Treat as
        blocked_pending_authenticated_producer_fetch_and_license_review.

    netex:
      source_found: source_path_found_but_current_feed_not_verified
      source_authority:
        - transport.data.gouv.fr
        - SYTRAL Mobilités
        - Grand Lyon data endpoint
      source_url_or_access_path:
        catalog_page: https://transport.data.gouv.fr/datasets/horaires-theoriques-du-reseau-transports-en-commun-lyonnais
        producer_connection_page: https://data.grandlyon.com/portail/fr/connexion
        probable_download_path_from_catalog: https://download.data.grandlyon.com/files/rdata/tcl_sytral.tcltheorique/NETEX_TCL.ZIP
      current_or_stale: >
        Official France NAP catalog metadata lists NeTEx as unavailable with latest
        content modification in September 2022 and 0 percent availability. No current
        official unauthenticated NeTEx feed was verified in this return.
      authentication_or_license:
        license: Licence Mobilité
        access: Grand Lyon account required; Basic Auth HTTP documented for protected Data Grand Lyon data
      verification_status: >
        Official source path verified. Current NeTEx not acquired. Treat as
        blocked_pending_authenticated_producer_fetch_and_license_review.

  siri_lite_feasibility:
    source_name: TCL SIRI Lite resources
    source_authority:
      - transport.data.gouv.fr
      - SYTRAL Mobilités
      - Grand Lyon data endpoint
    source_url_or_access_path:
      estimated_timetables_resource: https://transport.data.gouv.fr/resources/84026
      estimated_timetables_endpoint: https://data.grandlyon.com/siri-lite/2.0/estimated-timetables.json
      situation_exchange_resource: https://transport.data.gouv.fr/resources/84027
      situation_exchange_endpoint: https://data.grandlyon.com/siri-lite/2.0/situation-exchange.json
      vehicle_monitoring_resource: https://transport.data.gouv.fr/resources/84028
      vehicle_monitoring_endpoint: https://data.grandlyon.com/siri-lite/2.0/vehicle-monitoring.json
      france_siri_profile: https://normes.transport.data.gouv.fr/normes/siri/profil-france/
      france_realtime_docs: https://doc.transport.data.gouv.fr/producteurs/publier-des-donnees/temps-reel-des-transports-en-commun
    schema_documentation:
      general_profile: >
        France SIRI profile identifies Estimated Timetable, Vehicle Monitoring,
        Situation Exchange, Facility Monitoring and other SIRI services, and states
        that SIRI Lite can use XML or JSON through REST APIs.
      tcl_specific_schema: >
        No TCL-specific payload schema, field inventory, or validation report was
        verified from the public NAP pages in this return.
    snapshot_or_dynamic: >
      Dynamic/operational real-time view. Estimated Timetable is the closest listed
      SIRI Lite service to a network snapshot for real-time requirements, but it is
      not a static scheduled-service baseline unless an evidence-manifest process
      intentionally captures timestamped raw responses and confirms fields.
    fields_available:
      general_SIRI_service_implications:
        estimated_timetables: estimated departure/arrival timetable information
        situation_exchange: disruptions, incidents, real-time status/contextual messages
        vehicle_monitoring: vehicle progress/monitoring information
      TCL_endpoint_payload_fields_verified: false
      unverified_fields:
        - stops
        - routes
        - trips
        - calendar_or_validity
        - operators
        - modes
        - accessibility
        - service_disruptions_payload_completeness
    archive_reproducibility: >
      Not reproducible as a static schedule source without an acquisition protocol.
      A future protocol would need authenticated access, query parameters, response
      timestamps, request cadence, retention rules, license review, and comparison
      with a static GTFS/NeTEx baseline if available.
    license_or_authentication_terms:
      license: Licence Mobilité per France NAP TCL dataset page
      access: Grand Lyon account required for mobility-license data; Basic Auth HTTP documented
      unauthenticated_endpoint_status: >
        Public resource endpoints are discoverable, but raw endpoint acquisition was
        not verified without credentials. France NAP availability checks for SIRI/SIRI
        Lite may consider HTTP 401 or 405 successful, so availability percentage alone
        is not proof of public unauthenticated payload access.
    verification_status: >
      Resource pages and endpoint paths verified. TCL-specific raw payloads not acquired.
      Feasibility remains unresolved pending authenticated sample capture and schema
      inspection.

  possible_missing_operators_or_modes:
    - operator_or_mode: SNCF Voyageurs / TER / Intercités / TGV
      reason_it_may_matter: >
        SNCF provides official GTFS, NeTEx, GTFS-RT, and SIRI Lite source paths for
        TER, Intercités, and TGV. Rail services and stations may intersect FR002F
        and may not be represented in the TCL source bundle.
      source_url_or_access_path: https://transport.data.gouv.fr/datasets/horaires-sncf
      geography_relevance_to_FR002F: overlay_required
      verification_status: official_source_path_verified; FR002F_intersection_unresolved

    - operator_or_mode: Rhônexpress
      reason_it_may_matter: >
        Rhônexpress is an official Lyon centre to Lyon-Saint-Exupéry airport/gare
        link. It appears operationally distinct enough to require a separate source
        note unless later proven fully represented in TCL/SYTRAL data.
      source_url_or_access_path:
        - https://www.rhonexpress.fr/fr_FR/
        - https://www.tcl.fr/en/help/tcl-network/what-rhonexpress
      geography_relevance_to_FR002F: likely_material_but_boundary_overlay_required
      verification_status: official_service_source_verified; data_feed_source_unresolved

    - operator_or_mode: Auvergne-Rhône-Alpes Cars Région Express
      reason_it_may_matter: >
        Regional coach/interurban lines may run into or through the Lyon FUA and
        may sit outside the TCL feed bundle. France NAP source leads exist for
        Cars Région Express.
      source_url_or_access_path: https://transport.data.gouv.fr/datasets/reseau-interurbain-cars-region-express
      geography_relevance_to_FR002F: overlay_required
      verification_status: source_lead_found; FR002F_materiality_unresolved

    - operator_or_mode: Cars Région departmental/interurban networks near Lyon FUA
      reason_it_may_matter: >
        Source leads exist for Ain, Isère, Loire, and other Auvergne-Rhône-Alpes
        regional/interurban datasets. Some may intersect FR002F depending on boundary
        and route geography.
      source_url_or_access_path:
        - https://transport.data.gouv.fr/datasets/reseau-interurbain-cars-region-ain-01
        - https://transport.data.gouv.fr/datasets/reseau-interurbain-cars-region-isere-38-1
        - https://transport.data.gouv.fr/datasets/reseau-interurbain-cars-region-loire-42
        - https://transport.data.gouv.fr/datasets/region/84?type=public-transit
      geography_relevance_to_FR002F: overlay_required
      verification_status: source_leads_found; materiality_unresolved

    - operator_or_mode: TCL Transport à la demande
      reason_it_may_matter: >
        TCL lists on-demand transport services. Representation in GTFS/NeTEx or
        SIRI Lite was not verified. V1 needs an inclusion rule for demand-responsive
        service.
      source_url_or_access_path: https://www.tcl.fr/se-deplacer/transport-a-la-demande
      geography_relevance_to_FR002F: within_TCL_network_but_feed_representation_unresolved
      verification_status: official_service_page_lead; raw_schedule_representation_unverified

    - operator_or_mode: Optibus / paratransit
      reason_it_may_matter: >
        TCL lists Optibus as transport for people with mobility impairment. It may
        matter for universal access notes but may not belong in ordinary scheduled
        fixed-route coverage.
      source_url_or_access_path: https://www.tcl.fr/se-deplacer/optibus-transport-a-la-demande-de-personne-a-mobilite-reduite
      geography_relevance_to_FR002F: within_TCL_or_SYTRAL_mobility_ecosystem_but_scope_rule_needed
      verification_status: official_service_page_lead; V1_scope_unresolved

    - operator_or_mode: Junior Direct / school services
      reason_it_may_matter: >
        TCL lists school transport / Junior Direct services. V1 needs a rule on
        whether school-only services count in general resident access indicators.
      source_url_or_access_path:
        - https://www.tcl.fr/se-deplacer/junior-direct-le-reseau-de-transport-scolaire
        - https://www.tcl.fr/se-deplacer/lignes-scolaires-junior-direct
      geography_relevance_to_FR002F: likely_inside_TCL_network_but_inclusion_scope_unresolved
      verification_status: official_service_page_lead; raw_feed_representation_unverified

    - operator_or_mode: Navigône / Saône river shuttle
      reason_it_may_matter: >
        TCL official unified-network page lists Navigône as part of the network.
        The mode may need to be included if it has material scheduled service.
      source_url_or_access_path: https://www.tcl.fr/a-propos/le-reseau-tcl-unifie
      geography_relevance_to_FR002F: within_TCL_network_but_materiality_unresolved
      verification_status: official_page_verified; raw_feed_representation_unverified

  coverage_risk_assessment:
    likely_inside_TCL_SYTRAL:
      - metro
      - funicular
      - tram_or_trambus
      - bus_or_trolleybus
      - unified_former_TCL_Cars_du_Rhône_Libellule_scope_after_2025_09_01
      - some_TCL_on_demand_services
      - some_school_services
      - Navigône_if_represented_in_TCL_feed
    likely_outside_TCL_SYTRAL:
      - national_or_regional_rail_services_in_SNCF_dataset
      - Auvergne_Rhône_Alpes_regional_coach_or_interurban_datasets_not_integrated_into_TCL
      - possible_private_or_airport_services_not_in_TCL_feed
    unclear:
      - Rhônexpress_governance_and_feed_inclusion
      - exact_TCL_unified_feed_coverage_after_2025_network_unification
      - whether_GTFSTCL_or_NETEXTCL_current_authenticated_exports_include_all_modes_listed_on_TCL_site
      - whether_on_demand_school_and_paratransit_services_have_schedule_or_service_area records suitable for V1 indicators
      - coverage_against_FR002F
    high_risk_missingness:
      - authenticated_static_GTFS_or_NeTEx_access_not_acquired
      - TCL_SIRI_Lite_payload_fields_not_inspected
      - operator_inventory_against_FR002F_not_performed
      - non_TCL_rail_and_coach_intersections_not_overlaid

  recommended_next_source_notes:
    - source_name: France NAP / Réseau urbain TCL
      reason: Primary catalog source for official TCL GTFS, NeTEx, SIRI Lite paths and license/access posture.
      source_url_or_access_path: https://transport.data.gouv.fr/datasets/horaires-theoriques-du-reseau-transports-en-commun-lyonnais
    - source_name: Grand Lyon mobility data authentication and licence access
      reason: Needed before infrastructure can legally and reproducibly acquire static TCL feeds.
      source_url_or_access_path:
        - https://rdata-grandlyon.readthedocs.io/fr/latest/authentification.html
        - https://support.grandlyon.com/data-grand-lyon/
    - source_name: TCL SIRI Lite ET/SX/VM resources
      reason: Needed to resolve whether operational endpoints can support any reproducible observation protocol.
      source_url_or_access_path:
        - https://transport.data.gouv.fr/resources/84026
        - https://transport.data.gouv.fr/resources/84027
        - https://transport.data.gouv.fr/resources/84028
    - source_name: France SIRI / SIRI Lite profile
      reason: Needed to define generic SIRI service expectations and local-payload verification limits.
      source_url_or_access_path: https://normes.transport.data.gouv.fr/normes/siri/profil-france/
    - source_name: TCL unified network scope
      reason: Needed because the 2025 TCL / Cars du Rhône / Libellule unification may change feed/operator interpretation.
      source_url_or_access_path:
        - https://sytral-mobilites.fr/fr/le-reseau-tcl.html
        - https://www.tcl.fr/a-propos/le-reseau-tcl-unifie
    - source_name: SNCF national rail source bundle
      reason: Possible material rail source inside FR002F outside TCL/SYTRAL static feed.
      source_url_or_access_path: https://transport.data.gouv.fr/datasets/horaires-sncf
    - source_name: Rhônexpress source bundle
      reason: Possible material airport rail/link service requiring separate source treatment.
      source_url_or_access_path: https://www.rhonexpress.fr/fr_FR/
    - source_name: Auvergne-Rhône-Alpes regional coach/interurban datasets
      reason: Possible missing interurban services inside or crossing FR002F.
      source_url_or_access_path: https://transport.data.gouv.fr/datasets/region/84?type=public-transit

  rejected_or_quarantined_material:
    - item: Transitland current TCL GTFS fetch and archived versions
      reason: Secondary aggregator evidence only; useful as a source lead but not official producer evidence or license proof.
    - item: Google Maps modified GTFS community resource listed on France NAP
      reason: Community/reuser resource; not official source truth for current TCL static feed.
    - item: Data Grand Lyon JavaScript-only pages without extracted metadata
      reason: Must be processed later through official API/page extraction before source-note admission.
    - item: TCL/SYTRAL service geography, fare zones, route buffers, stop buffers, SIRI endpoint coverage
      reason: Service-derived geographies can hide unserved populations and cannot define the MTR denominator.
    - item: Any city reputation, travel guide, ranking, or livability material
      reason: Violates Thesis 2 source-led and non-outcome-selection guardrails.
```

## 4. Static GTFS/NeTEx recovery findings

### 4.1 Official static source path exists, but public verification remains blocked

The official France NAP `Réseau urbain TCL` page gives a current catalog path for TCL data and explicitly says:

- the producer requires authentication to access the data;
- some France NAP features such as availability, validations, and metadata are unavailable due to that authentication;
- timetable data correspond to all TCL service, with commercial-line schedules for 60 days and network geography/topology;
- the page's data are under `Licence Mobilité`;
- users must create a Grand Lyon account to retrieve the data.

The same France NAP page lists static resources as unavailable:

- GTFS:
  - probable download path: `https://download.data.grandlyon.com/files/rdata/tcl_sytral.tcltheorique/GTFS_TCL.ZIP`
  - NAP status: unavailable
  - latest content modification shown in catalog: April 2022
  - availability shown in catalog: 0%
- NeTEx:
  - probable download path: `https://download.data.grandlyon.com/files/rdata/tcl_sytral.tcltheorique/NETEX_TCL.ZIP`
  - NAP status: unavailable
  - latest content modification shown in catalog: September 2022
  - availability shown in catalog: 0%

Interpretation for raw intake:

- `static_source_path_found`: yes
- `official_current_static_feed_publicly_verified`: no
- `current feed acquired`: no
- `blocking factor`: authentication/license/acquisition path
- `admissible next step`: producer-authenticated fetch test and license review, if the infra thread is allowed to hold credentials and archive raw feed artifacts.

### 4.2 Grand Lyon authentication path

Grand Lyon documentation states that some data require authorization and that users must open a GrandLyon Connect account, connect to the data platform, and define a data-platform password. It identifies Basic Auth HTTP as the method for protected API/data access.

Grand Lyon support also states that mobility data are under `Licence Mobilité`, require a user account, and that reuse must respect local public policies.

Interpretation for raw intake:

- `authentication_path`: Grand Lyon account + Basic Auth HTTP
- `license_path`: `Licence Mobilité`
- `repository implication`: do not store credentials in thesis repo
- `infra implication`: any scheduled acquisition must use secrets management, source registry metadata, and license notes before raw feed archiving

### 4.3 Third-party recovery lead: Transitland

Transitland reports a TCL feed using:

- Onestop ID: `f-u05-tcl~systral`
- current static GTFS URL: `https://download.data.grandlyon.com/files/rdata/tcl_sytral.tcltheorique/GTFS_TCL.ZIP`
- authorization type: `basic_auth`
- info URL: `https://data.grandlyon.com/portail/fr/connexion`
- a recent successful fetch date, and archived feed versions.

This should be quarantined as secondary source material:

- It is useful to confirm that the static URL and Basic Auth path are plausible.
- It is not official producer evidence.
- It must not be used as a substitute for a direct official acquisition, producer metadata, or license review.
- It may support a future “source recovery lead” note if clearly labeled as third-party.

## 5. SIRI Lite schema/licence findings

### 5.1 Official TCL SIRI Lite resources

The France NAP `Réseau urbain TCL` page lists three SIRI Lite resources:

| Resource | France NAP resource page | Endpoint path | Status from public page |
|---|---|---|---|
| Estimated Timetables | `https://transport.data.gouv.fr/resources/84026` | `https://data.grandlyon.com/siri-lite/2.0/estimated-timetables.json` | Listed as SIRI Lite with recent availability checks; no validation report |
| Situation Exchange | `https://transport.data.gouv.fr/resources/84027` | `https://data.grandlyon.com/siri-lite/2.0/situation-exchange.json` | Listed as SIRI Lite with recent availability checks; no validation report |
| Vehicle Monitoring | `https://transport.data.gouv.fr/resources/84028` | `https://data.grandlyon.com/siri-lite/2.0/vehicle-monitoring.json` | Listed as SIRI Lite with recent availability checks; no validation report |

Important caveat:

France NAP resource pages explain that for SIRI/SIRI Lite resources, availability checks may be based on GET and may count HTTP 401 or 405 responses as successful. Therefore, a high availability percentage does not prove that a usable unauthenticated payload was acquired.

### 5.2 What the general SIRI documentation supports

The French SIRI profile supports the following generic service interpretations:

- `Estimated Timetable` is used for estimated / calculated timetable information and is the service that can give a fuller arrival/departure view.
- `Situation Exchange` supports disruptions, events, status, and contextual messages.
- `Vehicle Monitoring` supports vehicle monitoring / vehicle-progress information.
- SIRI Lite can expose XML or JSON through REST APIs.
- SIRI requires reference identifiers for objects such as participants, lines, routes, journeys, stop points, connections, and value lists, but implementation-specific field choices may remain local.

### 5.3 What remains unverified for TCL

No public TCL-specific SIRI Lite payload was acquired. Therefore, this raw return does **not** verify TCL-specific fields for:

- stops;
- routes;
- trips;
- calendars or service validity windows;
- operator identifiers;
- mode identifiers;
- accessibility fields;
- complete disruption fields;
- stop/line discovery support;
- facility monitoring support;
- full-network query capability.

The France NAP TCL resource set includes ET, SX, and VM only in the inspected public pages. It does not by itself verify `StopDiscovery`, `LineDiscovery`, `StopMonitoring`, `ProductionTimetable`, or `FacilityMonitoring` resources for TCL.

### 5.4 Can SIRI Lite ET provide a reproducible scheduled-service snapshot?

Working answer for raw intake:

- It can potentially support a **timestamped operational snapshot** if authenticated raw responses are deliberately acquired, archived, and documented.
- It should **not** be treated as a replacement for static GTFS/NeTEx in V1 source-bundle evaluation unless a collection protocol proves:
  - full-network query availability;
  - stable request parameters;
  - response timestamp and validity fields;
  - line/trip/stop identifiers;
  - mode/operator mapping;
  - coverage equivalence to the static schedule scope;
  - legal permission to archive/reuse raw responses.
- It is not, by itself, a reproducible static scheduled-service denominator or baseline.

Suggested verification step:

```text
Acquire one authenticated ET response for a controlled timestamp, record the exact URL, parameters, status code, response headers, response body hash, and schema fields, then compare with authenticated GTFS/NeTEx if acquired.
```

## 6. Possible missing operators/modes

### 6.1 SNCF / TER / TGV / Intercités

Official source path:

```text
https://transport.data.gouv.fr/datasets/horaires-sncf
```

Reason it may matter:

- SNCF provides official GTFS, NeTEx, GTFS-RT, and SIRI Lite source paths for TER, Intercités, and TGV.
- Regional rail stations and services may lie inside or connect through the Lyon FUA.
- These services are not proven to be included in the TCL static feed.

Current status:

```yaml
verification_status: official_source_path_verified
FR002F_materiality: unresolved_pending_boundary_overlay
source_bundle_role: possible_non_TCL_rail_source
```

### 6.2 Rhônexpress

Official source paths:

```text
https://www.rhonexpress.fr/fr_FR/
https://www.tcl.fr/en/help/tcl-network/what-rhonexpress
```

Reason it may matter:

- Rhônexpress is an airport/gare link between Lyon centre and Lyon-Saint-Exupéry.
- It may be material for some access indicators and source completeness.
- Its feed/source treatment is unresolved.
- It should not be assumed included in TCL static feed without evidence.

Current status:

```yaml
verification_status: official_service_source_verified; data_feed_source_unresolved
FR002F_materiality: likely_but_overlay_required
source_bundle_role: possible_separate_mode_or_operator_source
```

### 6.3 Auvergne-Rhône-Alpes regional coaches / interurban buses

Source leads:

```text
https://transport.data.gouv.fr/datasets/region/84?type=public-transit
https://transport.data.gouv.fr/datasets/reseau-interurbain-cars-region-express
https://transport.data.gouv.fr/datasets/reseau-interurbain-cars-region-ain-01
https://transport.data.gouv.fr/datasets/reseau-interurbain-cars-region-isere-38-1
https://transport.data.gouv.fr/datasets/reseau-interurbain-cars-region-loire-42
https://transport.data.gouv.fr/datasets/agregat-oura
```

Reason it may matter:

- Regional/interurban coach datasets may cross FR002F or serve municipalities inside the FUA.
- The TCL feed may not include all regional coach services.
- AuRA aggregate and departmental feeds may overlap or duplicate, requiring careful manifest design.

Current status:

```yaml
verification_status: source_leads_found
FR002F_materiality: unresolved_pending_spatial_overlay
source_bundle_role: possible_non_TCL_coach_or_interurban_source
```

### 6.4 TCL Transport à la demande

Source lead:

```text
https://www.tcl.fr/se-deplacer/transport-a-la-demande
```

Reason it may matter:

- On-demand TCL services exist in sectors such as Vallée de la Chimie, Mi-Plaine, Techlid, and Villefranche-sur-Saône according to TCL source leads.
- GTFS/NeTEx representation was not verified.
- V1 needs a rule for demand-responsive service: whether it belongs in general coverage, universal-access module, or descriptive notes only.

Current status:

```yaml
verification_status: official_service_page_lead
FR002F_materiality: likely_inside_TCL_scope_but_feed_representation_unresolved
source_bundle_role: scope_rule_required
```

### 6.5 Optibus / paratransit

Source lead:

```text
https://www.tcl.fr/se-deplacer/optibus-transport-a-la-demande-de-personne-a-mobilite-reduite
```

Reason it may matter:

- Optibus appears to serve mobility-impaired passengers and may matter for universal access.
- It may not belong in a general scheduled fixed-route coverage measure.
- It should probably be handled as universal-access context unless the scoring protocol explicitly includes paratransit operations.

Current status:

```yaml
verification_status: official_service_page_lead
FR002F_materiality: likely_within_mobility_ecosystem_but_V1_scope_unresolved
source_bundle_role: universal_access_or_descriptive_context
```

### 6.6 Junior Direct / school services

Source leads:

```text
https://www.tcl.fr/se-deplacer/junior-direct-le-reseau-de-transport-scolaire
https://www.tcl.fr/se-deplacer/lignes-scolaires-junior-direct
```

Reason it may matter:

- School services may be in the TCL ecosystem.
- They may be restricted-use or school-oriented.
- V1 needs an inclusion/exclusion rule for school-only services before treating them as ordinary resident-access service.

Current status:

```yaml
verification_status: official_service_page_lead
FR002F_materiality: unresolved
source_bundle_role: scope_rule_required
```

### 6.7 Navigône / Saône river shuttle

Source lead:

```text
https://www.tcl.fr/a-propos/le-reseau-tcl-unifie
```

Reason it may matter:

- TCL lists `Navigône` in the unified network.
- Ferry/river-shuttle service may be relevant if scheduled and open to ordinary riders.
- Raw feed representation was not verified.

Current status:

```yaml
verification_status: official_TCL_page_verified
FR002F_materiality: unresolved
source_bundle_role: possible_mode_inside_TCL_feed_or_separate_mode_note
```

## 7. Rejected/quarantined material

| Item | Status | Reason |
|---|---|---|
| Transitland recent TCL GTFS fetch | Quarantined | Secondary aggregator; useful as source-recovery lead only; not official producer evidence or license proof |
| Transitland archived GTFS versions | Quarantined | Could help diagnose whether current authenticated GTFS exists, but raw archive is not official source truth |
| Google Maps modified GTFS community resource listed on NAP | Rejected as primary | Community/reuser resource; not official static TCL source |
| Data Grand Lyon JS-only catalog pages not extracted through official metadata/API | Quarantined | Page presence is useful, but source-note admission requires traceable official metadata extraction |
| TCL service geography / 6 fare zones | Rejected as MTR boundary | Governance/service/fare geography cannot define FR002F denominator |
| GTFS route/stop extent or SIRI endpoint reach | Rejected as denominator | Service-derived geometry can hide unserved population |
| Any travel-guide, Wikipedia, ranking, livability, or reputation source | Rejected | Violates Thesis 2 source-led guardrails |
| 2022 France NAP backup GTFS/NeTEx resources | Quarantined for current use | Useful historical trace, but not current static feed evidence |

## 8. Open questions for Thesis 2

1. Should authenticated Grand Lyon static GTFS/NeTEx acquisition be allowed under the project’s raw evidence manifest process?
2. If acquisition is allowed, where should credentials live? Suggested answer: infrastructure secrets manager only, never thesis repo.
3. Does `Licence Mobilité` permit long-term raw feed archiving inside the project, or only derived analysis?
4. Should static TCL feed recovery be required before any Lyon source-bundle readiness gate can advance, or can a SIRI Lite snapshot protocol be tested as a separate experimental path?
5. What minimum SIRI Lite fields would be required before `Estimated Timetables` can support any reproducible scheduled-service test?
6. Does TCL SIRI Lite ET allow a complete-network request, or only filtered requests by stop/line/operator?
7. Do the TCL SIRI Lite endpoints expose sufficient route, stop, operator, mode, and validity metadata, or must they be joined to static GTFS/NeTEx?
8. Does the authenticated GTFS/NeTEx feed reflect the post-2025 unified TCL/Cars du Rhône/Libellule network?
9. Are Rhônexpress, TER/SNCF, and AuRA regional coach feeds in scope for the first Lyon service-source bundle?
10. How should on-demand transport, paratransit, and school-only services be classified in V1?
11. Should the first Lyon operator inventory start from FR002F boundary overlay against NAP feed stop/route geometries, or from the France NAP covered-area metadata?
12. What is the required threshold for “operator/source completeness” before any Lyon method test is allowed?

## 9. Source URL list

### Boundary context only

```text
https://ec.europa.eu/eurostat/web/gisco/geodata/statistical-units/cities-functional-urban-areas
https://www.insee.fr/fr/information/3642744
```

### France NAP / TCL catalog and SIRI Lite resources

```text
https://transport.data.gouv.fr/datasets/horaires-theoriques-du-reseau-transports-en-commun-lyonnais
https://transport.data.gouv.fr/resources/84026
https://transport.data.gouv.fr/resources/84027
https://transport.data.gouv.fr/resources/84028
https://data.grandlyon.com/siri-lite/2.0/estimated-timetables.json
https://data.grandlyon.com/siri-lite/2.0/situation-exchange.json
https://data.grandlyon.com/siri-lite/2.0/vehicle-monitoring.json
https://download.data.grandlyon.com/files/rdata/tcl_sytral.tcltheorique/GTFS_TCL.ZIP
https://download.data.grandlyon.com/files/rdata/tcl_sytral.tcltheorique/NETEX_TCL.ZIP
```

### Grand Lyon access / license support

```text
https://data.grandlyon.com/portail/fr/connexion
https://data.grandlyon.com/portail/fr/cgu
https://rdata-grandlyon.readthedocs.io/fr/latest/authentification.html
https://support.grandlyon.com/data-grand-lyon/
```

### French SIRI / real-time documentation

```text
https://doc.transport.data.gouv.fr/producteurs/publier-des-donnees/temps-reel-des-transports-en-commun
https://normes.transport.data.gouv.fr/normes/siri/profil-france/
https://www.transmodel-cen.eu/standards/siri/
```

### SYTRAL / TCL service source leads

```text
https://sytral-mobilites.fr/fr/le-reseau-tcl.html
https://www.tcl.fr/a-propos/le-reseau-tcl-unifie
https://www.tcl.fr/se-deplacer/transport-a-la-demande
https://www.tcl.fr/se-deplacer/optibus-transport-a-la-demande-de-personne-a-mobilite-reduite
https://www.tcl.fr/se-deplacer/junior-direct-le-reseau-de-transport-scolaire
https://www.tcl.fr/se-deplacer/lignes-scolaires-junior-direct
https://www.tcl.fr/en
```

### Rail / regional / interurban / airport service source leads

```text
https://transport.data.gouv.fr/datasets/horaires-sncf
https://www.rhonexpress.fr/fr_FR/
https://www.tcl.fr/en/help/tcl-network/what-rhonexpress
https://transport.data.gouv.fr/datasets/region/84?type=public-transit
https://transport.data.gouv.fr/datasets/reseau-interurbain-cars-region-express
https://transport.data.gouv.fr/datasets/reseau-interurbain-cars-region-ain-01
https://transport.data.gouv.fr/datasets/reseau-interurbain-cars-region-isere-38-1
https://transport.data.gouv.fr/datasets/reseau-interurbain-cars-region-loire-42
https://transport.data.gouv.fr/datasets/agregat-oura
```

### Third-party / quarantined source-recovery leads

```text
https://www.transit.land/feeds/f-u05-tcl~systral
https://www.transit.land/feeds/f-u05-tcl~systral/versions/9757c2698220bae0fa549c9a70f4a532a52b2e23
https://github.com/transitland/transitland-atlas/blob/master/feeds/grandlyon.com.dmfr.json
```

## Suggested Codex intake path

```text
theses/mobility-conversion/research-artifacts/raw/2026-07-05-raw-return-lyon-fua-static-feed-siri-lite-operator-recovery.md
```

## Suggested follow-on source notes

```text
theses/mobility-conversion/research/source_notes/france_nap_tcl_static_feed_recovery_2026-07-05.md
theses/mobility-conversion/research/source_notes/grand_lyon_mobility_data_auth_license_2026-07-05.md
theses/mobility-conversion/research/source_notes/tcl_siri_lite_et_sx_vm_feasibility_2026-07-05.md
theses/mobility-conversion/research/source_notes/lyon_possible_non_tcl_operator_inventory_leads_2026-07-05.md
theses/mobility-conversion/research/source_notes/sncf_source_bundle_for_lyon_overlay_2026-07-05.md
theses/mobility-conversion/research/source_notes/rhonexpress_source_bundle_lead_2026-07-05.md
```

## Suggested infrastructure implications

```yaml
infra_implications:
  no_raw_feed_download_performed: true
  credential_storage_needed_if_acquisition_proceeds: true
  credential_storage_location: infrastructure_secrets_manager_only
  feed_acquisition_before_scoring: required_if_Lyon_advances
  minimum_manifest_fields:
    - source_id
    - source_authority
    - endpoint_url
    - auth_type
    - credential_storage_reference
    - license_terms
    - acquisition_timestamp_utc
    - request_method
    - request_parameters
    - response_status
    - response_headers_hash
    - raw_body_hash
    - raw_archive_path
    - parsed_schema_summary_path
    - operator_or_mode_scope
    - boundary_overlay_status
    - reuse_restriction_notes
```
