# Raw Return: Sao Paulo GHS-FUA High-Burden Source Bundle

Thesis: Thesis 2 — Mobility Conversion  
Date: 2026-07-05  
Return status: raw research material only  
Reviewed lead: `mtr_src_008`  
Working name: Sao Paulo GHS-FUA  
Boundary source family: `modelled_functional_region`  
Boundary authority: European Commission JRC / GHSL  
Classification posture: high-burden modelled-boundary handoff material only  

This return is not evidence, not source truth, not an accepted Metropolitan Transport Region, not a candidate-universe record, not a boundary record, not a metric record, not a score, and not a ranking.

## 1. Short method summary

This source scan checked official or primary source families requested for the Sao Paulo GHS-FUA high-burden lead:

- GHSL/JRC GHS-FUA R2019A;
- GHSL/JRC GHS-POP R2023A;
- GHSL/JRC GHS-SMOD R2023A and GHS-UCDB R2024A/R2025 documentation;
- official Brazil national/statistical/metropolitan/planning geography sources;
- official population-denominator and boundary context sources;
- SPTrans source pages;
- EMTU / ARTESP source pages;
- rail, metro, demand-responsive, charter, paratransit, and weakly documented service-source leads.

The scan did not download raw datasets, did not inspect the official GHS-FUA GeoPackage row directly, did not calculate population, did not calculate service coverage, did not admit Sao Paulo as an MTR, and did not decide whether GHS-FUA is acceptable as a boundary.

Main finding: the GHS-FUA source system is verified, but the exact Sao Paulo GHS-FUA row identifier/name remains unresolved until the official GeoPackage is intentionally acquired and inspected. GHS-FUA is a modelled 2015 functional-region product. It must not be treated as an observed commuting-flow boundary.

## 2. Source table

| Source family | Source title | Source authority | URL / access path | What this scan verified | Limits / unresolved items |
|---|---|---|---|---|---|
| GHS-FUA | GHS Functional Urban Areas R2019A | European Commission JRC / GHSL | `https://human-settlement.emergency.copernicus.eu/ghs_fua.php` | Product is derived from GHS-UCDB R2019A 2015 urban centres; model estimates commuting areas using travel time, urban-centre area, local population, and country GDP per capita. | Exact Sao Paulo row was not verified without raw GeoPackage extraction. |
| GHS-FUA catalogue | GHS-FUA R2019A — GHS functional urban areas | European Commission JRC / Data Catalogue | `https://data.jrc.ec.europa.eu/dataset/347f0337-f2da-4592-87b3-e25975ec2c95` | Catalogue describes modelled FUA boundaries, data access, DOI, anonymous access, and reuse terms. | Catalogue page does not by itself identify the Sao Paulo row. |
| GHS-FUA data access | GHS_FUA_UCDB2015_GLOBE_R2019A | European Commission JRC / GHSL FTP | `https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_FUA_UCDB2015_GLOBE_R2019A/` | Official file tree exposes `V1-0/` directory. | Raw download and row extraction intentionally not performed. |
| GHS-FUA V1-0 file | `GHS_FUA_UCDB2015_GLOBE_R2019A_54009_1K_V1_0.zip` | European Commission JRC / GHSL FTP | `https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_FUA_UCDB2015_GLOBE_R2019A/V1-0/` | Official ZIP path, product naming, modification listing, and GeoPackage packaging path were identified. | Exact row requires later archive acquisition and inspection. |
| GHS-FUA terms | Copyright / license notice | European Commission JRC | `https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_FUA_UCDB2015_GLOBE_R2019A/V1-0/copyright.txt` | Reuse is under Creative Commons Attribution 4.0 International, with source acknowledgement and indication of changes. | Later evidence manifest should archive the exact copyright file alongside data. |
| GHS-FUA documentation | GHS-FUA product specification / technical documentation | European Commission JRC / GHSL | `https://human-settlement.emergency.copernicus.eu/documents/GHSL_FUA_2019.pdf?t=1583246033` | Documentation gives product name, CRS, resolution, method inputs, terms, and GeoPackage feature packaging. | Exact Sao Paulo row still requires dataset inspection. |
| GHS-POP | GHS-POP R2023A — GHS population grid multitemporal | European Commission JRC / GHSL | `https://data.jrc.ec.europa.eu/dataset/2ff68a52-5b5b-4a22-8f40-c41da8332cfe` | Provides gridded population estimates for 1975–2020 and projections for 2025/2030; 100 m Mollweide and 3 arcsec WGS84 are available. | Pairing with 2015 GHS-FUA creates vintage/method mismatch unless explicitly documented. |
| GHS-SMOD | GHS-SMOD R2023A — settlement layers / Degree of Urbanisation | European Commission JRC / GHSL | `https://human-settlement.emergency.copernicus.eu/ghs_smod2023.php` | Useful settlement-class / built-form overlay based on GHS-POP and GHS-BUILT-S. | Overlay only; not a full MTR boundary. |
| GHS-UCDB | GHS Urban Centre Database R2024A / 2025 documentation | European Commission JRC / GHSL | `https://human-settlement.emergency.copernicus.eu/ghs_ucdb2024.php` | Provides urban-centre context and multidimensional urban-centre attributes. | Urban centre is not a full modelled functional region or MTR denominator. |
| IBGE functional/statistical context | Population Arrangements and Urban Concentrations in Brazil | IBGE | `https://www.ibge.gov.br/en/geosciences/territorial-organization/territorial-divisions/18354-population-arrangements-and-urban-concentrations-in-brazil.html` | Official Brazil source family for population arrangements and urban concentrations; includes maps/databases and São Paulo-related materials. | Exact São Paulo composition must be extracted from official annex/database later. |
| IBGE 2022 context | 2022 Census: Population Arrangements and Urban Concentrations | IBGE | `https://www.ibge.gov.br/en/geosciences/territorial-organization/territorial-divisions/18354-population-arrangements-and-urban-concentrations-in-brazil.html?edicao=41477&t=downloads` | Defines urban concentrations and population arrangements using work/study pendular movement and/or urbanized-patch contiguity. | Needs later annex/database acquisition for exact geography and denominator compatibility. |
| IBGE municipal boundaries | Malha Municipal | IBGE | `https://www.ibge.gov.br/geociencias/organizacao-do-territorio/malhas-territoriais/15774-malhas.html` | Official municipal boundary source for potential official population aggregation and overlays. | Municipal aggregation would not automatically match GHS-FUA; alignment rules required. |
| Mobility survey / planning context | Pesquisa Origem e Destino 2023 | São Paulo Metrô | `https://transparencia.metrosp.com.br/dataset/pesquisa-origem-e-destino-2023` | Official origin-destination mobility survey for RMSP; fieldwork and data/report access documented. | Planning/mobility context only; not a GHS-FUA row and not a primary boundary decision. |
| SPTrans static/dynamic data | SPTrans Desenvolvedores | SPTrans | `https://www.sptrans.com.br/desenvolvedores/` | SPTrans provides GTFS static data and Olho Vivo real-time API for the City of São Paulo bus fleet. | City bus service source only; registration/API key constraints; not full GHS-FUA coverage. |
| SPTrans API | Olho Vivo API reference | SPTrans | `https://www.sptrans.com.br/desenvolvedores/api-do-olho-vivo-guia-de-referencia/documentacao-api/` | API uses HTTP/REST and JSON; requires developer account/app token. | Operational API, not a denominator. Reproducibility depends on access token and observation window. |
| EMTU open data | EMTU open data announcement / API-GTFS source lead | EMTU/SP | `https://www.emtu.sp.gov.br/emtu/noticias/noticia/emtu-lanca-dados-abertos-para-consulta-de-transportes-coletivos.fss` | EMTU describes open data for metropolitan regions of São Paulo State, including GTFS/API and update patterns. | Requires registration/terms; exact FUA coverage and operator completeness unresolved. |
| ARTESP/EMTU GTFS | GTFS — Regiões Metropolitanas | ARTESP / EMTU | `https://dados.transportes.sp.gov.br/dataset/gtfs` | GTFS source for metropolitan regions supervised/fiscalized by ARTESP; includes documented data limitations and update metadata. | Known GTFS limitations; intermunicipal bus only; not all formal/informal modes. |
| EMTU itineraries/fares | Itinerários e Tarifas | EMTU/SP | `https://www.emtu.sp.gov.br/emtu/itinerarios-e-tarifas.fss` | Official intermunicipal bus information source for state metropolitan regions. | Service information source only; not downloadable boundary/denominator. |
| Charter / school / private transport | Fretamento / registered providers | EMTU/SP / ARTESP | `https://www.emtu.sp.gov.br/emtu/servicos/fretamento.fss` and `https://dados.transportes.sp.gov.br/dataset/consulta-de-prestadores-de-servico-de-fretamento-e-escolar` | Confirms existence of registered charter/school/private service families that may be material but outside ordinary fixed-route GTFS. | Not a conventional public schedule bundle; likely difficult for reproducible access metrics. |
| Paratransit / demand-responsive | Atende+ | SPTrans | `https://www.sptrans.com.br/atende/` | Official adapted door-to-door service source for eligible users in the City of São Paulo. | Demand-responsive/paratransit; not represented by ordinary fixed-route GTFS denominator. |
| Rail | CPTM institutional/service context | São Paulo State Government / CPTM | `https://www.saopaulo.sp.gov.br/conhecasp/servicos/companhia-paulista-de-trens-metropolitanos-cptm/` | CPTM rail service is material in the São Paulo metropolitan transport context. | Schedule/feed source not verified in this pass; not part of SPTrans bus GTFS. |
| Metro demand/statistics | Metrô demand transparency datasets | São Paulo Metrô | `https://transparencia.metrosp.com.br/dataset/demanda` | Official demand/statistics source for metro use. | Demand/statistics only; not a schedule feed or denominator. |

## 3. YAML-style raw source bundle

```yaml
sao_paulo_ghs_fua_high_burden_return:
  return_status: raw_research_material_only

  reviewed_boundary:
    working_name: Sao Paulo GHS-FUA
    source_authority: European Commission JRC / GHSL
    exact_ghs_fua_identifier: unresolved__requires_official_GeoPackage_row_extraction
    exact_ghs_fua_name: unresolved__requires_official_GeoPackage_row_extraction
    geography_type: modelled_functional_region_for_2015_urban_centre
    source_url_or_access_path:
      - https://human-settlement.emergency.copernicus.eu/ghs_fua.php
      - https://data.jrc.ec.europa.eu/dataset/347f0337-f2da-4592-87b3-e25975ec2c95
      - https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_FUA_UCDB2015_GLOBE_R2019A/V1-0/
    verification_status: source_system_verified__exact_sao_paulo_row_unverified

  ghs_fua_artifact:
    product_title: GHS-FUA R2019A - GHS functional urban areas, derived from GHS-UCDB R2019A (2015)
    catalogue_or_download_path:
      - https://data.jrc.ec.europa.eu/dataset/347f0337-f2da-4592-87b3-e25975ec2c95
      - https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_FUA_UCDB2015_GLOBE_R2019A/V1-0/GHS_FUA_UCDB2015_GLOBE_R2019A_54009_1K_V1_0.zip
    release: R2019A_V1_0
    epoch: 2015_urban_centres_and_2015_model_inputs
    coordinate_system: World_Mollweide_EPSG_54009
    resolution: 1_km_grid_basis
    identifier_field: unresolved__requires_schema_and_row_inspection_after_raw_download
    license_or_reuse_terms: Creative_Commons_Attribution_4_0_International_with_source_acknowledgement_and_change_indication
    raw_download_required_later: true

  fallback_and_context:
    stronger_boundary_sources_checked:
      observed_functional_region:
        status: no_verified_observed_OECD_or_Eurostat_FUA_for_Sao_Paulo_found_in_this_pass
        note: GHS-FUA documentation says observed OECD/EU FUA methods rely on observed commuting data and local administrative units but have limited country coverage; Brazil-specific observed OECD/Eurostat FUA was not verified here.
      national_commuting_zone:
        status: official_Brazil_population_arrangement_and_urban_concentration_source_family_verified_as_context
        source_authority: IBGE
        note: IBGE population arrangements use work/study pendular movements and/or urbanized-patch contiguity. This appears stronger than GHS-FUA for official Brazil context if exact São Paulo composition can be extracted and aligned, but this return did not extract it.
      hybrid_functional_statistical_region:
        status: IBGE_population_arrangements_and_urban_concentrations_verified_as_possible_stronger_context_or_candidate_boundary_family
        note: Exact São Paulo row/composition and denominator compatibility remain unresolved.
      official_statistical_metro:
        status: partially_verified_context_only
        note: São Paulo metropolitan/planning region context appears in official mobility and state-transport sources, but this return did not verify a current official statistical metro boundary artifact suitable as a primary denominator.
      official_population_geography:
        status: verified_source_family_available
        note: IBGE municipal boundaries and population/census products can likely support official population denominators if a selected boundary is expressible through municipalities or official statistical units.
      planning_or_governance_region_overlay:
        status: verified_context_sources_available
        examples:
          - Região Metropolitana de São Paulo context through São Paulo Metrô OD survey
          - SPTrans municipal bus service geography
          - EMTU/ARTESP metropolitan intermunicipal bus service geography
          - CPTM metropolitan rail context
    fallback_justification: >
      GHS-FUA remains useful only as a modelled global fallback, modelled-boundary
      stress test, or validation/context layer if a stronger observed or official
      Brazil functional/statistical boundary cannot be aligned with the Thesis 2
      denominator rules. If IBGE population arrangement / urban concentration or
      another official metropolitan geography is later verified as an admissible
      MTR boundary, GHS-FUA should not outrank it as a primary denominator.
    official_or_national_context_sources:
      - https://www.ibge.gov.br/en/geosciences/territorial-organization/territorial-divisions/18354-population-arrangements-and-urban-concentrations-in-brazil.html
      - https://www.ibge.gov.br/geociencias/organizacao-do-territorio/malhas-territoriais/15774-malhas.html
      - https://transparencia.metrosp.com.br/dataset/pesquisa-origem-e-destino-2023

  model_caveats:
    model_input_disclosure:
      - GHS-UCDB R2019A 2015 urban centres
      - GHS-POP R2019A 2015 population grid
      - global friction matrix / travel-time inputs
      - World Bank country GDP per capita input
      - automated classification / probabilistic modelling rather than observed commuting-flow delineation
    economic_capacity_input_overlap_caveat: >
      GHS-FUA uses country GDP per capita as a model input. Because Mobility
      Conversion separately studies economic capacity as an explanatory axis,
      GHS-FUA may embed an economic-capacity variable into the boundary
      construction process. This must be disclosed if GHS-FUA is used as a
      fallback denominator or validation layer.
    travel_time_or_friction_input_caveat: >
      The GHS-FUA method uses global travel-time/friction inputs. These are not
      equivalent to observed local commuting, observed transit service, observed
      road congestion, or current multimodal accessibility.
    urban_centre_inheritance_risk: >
      The FUA is inherited from the 2015 GHSL urban-centre model. Any error in
      urban-centre delineation, population grid allocation, or built-up extent
      may propagate into the modelled functional area.
    boundary_epoch: 2015
    growth_or_staleness_risk: >
      Sao Paulo's current population, built-up extent, and service patterns may
      differ from the 2015 modelled functional area. Any pairing with 2020 or
      2025 population grids or 2026 service feeds creates a vintage mismatch.
    source_url_or_access_path:
      - https://human-settlement.emergency.copernicus.eu/ghs_fua.php
      - https://human-settlement.emergency.copernicus.eu/documents/GHSL_FUA_2019.pdf?t=1583246033

  population_denominator:
    ghs_pop_source_title: GHS-POP R2023A - GHS population grid multitemporal 1975-2030
    ghs_pop_source_url_or_access_path:
      - https://data.jrc.ec.europa.eu/dataset/2ff68a52-5b5b-4a22-8f40-c41da8332cfe
      - https://human-settlement.emergency.copernicus.eu/ghs_pop2023.php
    ghs_pop_release: R2023A
    ghs_pop_target_year: >
      candidate_years_2020_estimate_or_2025_projection; select_later_based_on_denominator_protocol
    estimate_or_projection_status: >
      1975_to_2020_are_estimates; 2025_and_2030_are_projections.
    summarization_method: >
      If used later, summarize gridded population within the selected boundary
      polygon using a documented raster/vector overlay. Do not calculate in this
      raw return.
    official_population_alternative:
      - IBGE official census/population products by municipality or official statistical geography
      - IBGE population-arrangement / urban-concentration composition if extractable
      - official municipal boundary files from IBGE Malha Municipal for denominator alignment
    value_returned: do_not_return_value_unless_needed_for_source_identification
    verification_status: GHS_POP_source_verified__official_population_alternative_source_family_verified__no_population_value_calculated

  built_form_overlay:
    selected_overlay_source:
      - GHS-SMOD R2023A for settlement-class / Degree-of-Urbanisation context
      - GHS-UCDB R2024A/R2025 for urban-centre attribute context
      - IBGE population-arrangement / urban-concentration maps and municipal boundaries as stronger official context where aligned
    source_url_or_access_path:
      - https://human-settlement.emergency.copernicus.eu/ghs_smod2023.php
      - https://human-settlement.emergency.copernicus.eu/ghs_ucdb2024.php
      - https://www.ibge.gov.br/en/geosciences/territorial-organization/territorial-divisions/18354-population-arrangements-and-urban-concentrations-in-brazil.html
    release_or_epoch:
      - GHS-SMOD_R2023A_multitemporal_1975_2030
      - GHS-UCDB_R2024A_V1_1_released_2025
      - IBGE_2022_context_available_for_population_arrangements_and_urban_concentrations
    role: validation_or_context_only

  service_source_bundle:
    sptrans_source:
      source_authority: SPTrans / São Paulo Transporte S/A
      source_url_or_access_path:
        - https://www.sptrans.com.br/desenvolvedores/
        - https://www.sptrans.com.br/desenvolvedores/api-do-olho-vivo-guia-de-referencia/documentacao-api/
      format:
        - GTFS_static
        - Olho_Vivo_HTTP_REST_JSON_API
      vintage_or_update_date: currentness_unverified__requires_feed_snapshot_later
      license_or_access_terms: license_terms_unresolved__developer_registration_required_for_API_token
      access_or_registration_constraints:
        - Olho_Vivo_requires_developer_account_app_and_access_token
        - GTFS_download_path_and_license_require_later_manifest_capture
      coverage_against_GHS_FUA: >
        City_of_Sao_Paulo_bus_service_source_only. It cannot be assumed to cover
        the whole modelled GHS-FUA or all formal public-transport modes inside it.

    emtu_source:
      source_authority:
        - EMTU/SP
        - ARTESP / dados.transportes.sp.gov.br
      source_url_or_access_path:
        - https://www.emtu.sp.gov.br/emtu/noticias/noticia/emtu-lanca-dados-abertos-para-consulta-de-transportes-coletivos.fss
        - https://dados.transportes.sp.gov.br/dataset/gtfs
        - https://www.emtu.sp.gov.br/emtu/itinerarios-e-tarifas.fss
      format:
        - GTFS
        - API
        - CSV
        - Excel
        - PDF
        - web itinerary/fare search
      vintage_or_update_date: >
        ARTESP_GTFS_source_seen_with_2026_06_10_version_and_monthly_update_metadata;
        EMTU_announcement_says_API_updates_automatic_and_GTFS_as_needed.
      license_or_access_terms: >
        ARTESP_GTFS_source_seen_with_Creative_Commons_Attribution_metadata;
        EMTU_developer/API_access_may_require_registration_and_acceptance_terms.
      access_or_registration_constraints:
        - EMTU_API_and_developer_access_may_require_prior_registration_and_terms_acceptance
        - ARTESP_GTFS_static_download_requires_later_manifest_capture
      coverage_against_GHS_FUA: >
        Intermunicipal/metropolitan bus source family for São Paulo State
        metropolitan regions. Exact coverage against the modelled Sao Paulo
        GHS-FUA is unresolved.

    rail_metro_or_other_formal_sources:
      - source_family: CPTM_metropolitan_rail
        source_authority: São Paulo State Government / CPTM
        source_url_or_access_path: https://www.saopaulo.sp.gov.br/conhecasp/servicos/companhia-paulista-de-trens-metropolitanos-cptm/
        note: CPTM is material rail context; schedule/feed source not verified in this pass.
      - source_family: São_Paulo_Metrô_origin_destination_and_demand_sources
        source_authority: Metrô de São Paulo
        source_url_or_access_path:
          - https://transparencia.metrosp.com.br/dataset/pesquisa-origem-e-destino-2023
          - https://transparencia.metrosp.com.br/dataset/demanda
        note: OD survey and demand/statistics are official context; they are not schedule feeds or MTR denominators.
      - source_family: concession_or_private_rail_operators
        source_authority: unresolved
        source_url_or_access_path: unresolved_in_this_pass
        note: ViaQuatro/ViaMobilidade and other rail concessions may be material; official source coverage requires separate verification.

    informal_or_weakly_documented_service_gaps:
      - SPTrans_Atende_plus_paratransit_or_demand_responsive_service
      - EMTU_or_ARTESP_fretamento_charter_and_school_registered_provider_services
      - airport_bus_or_intercity_coach_services
      - private_employer_shuttle_or_contract_transport_if_material
      - informal_or_semiformal_services_not_visible_in_GTFS_if_present
      - demand_responsive_or_accessibility_services_outside_static_GTFS
    reproducibility_limits:
      - no_single_unified_verified_feed_for_all_modes_inside_modelled_GHS_FUA
      - SPTrans_API_requires_registration_token_and_observation_window
      - EMTU_API_may_require_registration_and_acceptance_terms
      - ARTESP_GTFS_has_documented_calendar_stop_times_and_shape_distance_limitations
      - rail_metro_static_schedule_feed_paths_not_verified_in_this_pass
      - service_geographies_cannot_define_the_denominator
      - formal_feeds_may_hide unserved_population_or_unrepresented_services_inside_the_modelled_FUA

  rejected_or_quarantined_material:
    - item: SPTrans_service_area_or_GTFS_extent_as_primary_MTR_boundary
      reason: service-derived geography can hide unserved populations and is prohibited as denominator.
    - item: EMTU_ARTESP_service_area_or_GTFS_extent_as_primary_MTR_boundary
      reason: service-derived geography can be an overlay/input only.
    - item: GHS_SMOD_or_GHS_UCDB_as_primary_boundary
      reason: built-form/urban-centre overlays are not full MTR functional regions.
    - item: GHS_FUA_as_observed_commuting_boundary
      reason: GHS-FUA is modelled and uses proxy inputs; it is not observed commuting-flow geography.
    - item: Região_Metropolitana_de_São_Paulo_as_primary_boundary_without_readiness_review
      reason: official/planning context may be useful, but exact boundary, denominator, and MTR fit require separate source-note verification.
    - item: unofficial_web_extracts_or_nonofficial_convenience_pages_for_exact_GHS_FUA_ID
      reason: exact row must be verified from official JRC/GHSL data artifact.
    - item: reputation_or_megacity_status_as_selection_justification
      reason: outcome-adjacent and forbidden by source-led guardrail.
```

## 4. Exact GHS-FUA row findings

The GHS-FUA source system is verified. The official source path is:

```text
https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_FUA_UCDB2015_GLOBE_R2019A/V1-0/GHS_FUA_UCDB2015_GLOBE_R2019A_54009_1K_V1_0.zip
```

The product documentation identifies the official file naming convention:

```text
GHS_FUA_UCDB2015_GLOBE_R2019A_54009_1K_V1_0.gpkg
```

The product is a 1 km World Mollweide GeoPackage of modelled functional urban areas derived from 2015 urban centres.

Unresolved:

```yaml
exact_ghs_fua_identifier: unresolved
exact_ghs_fua_name: unresolved
identifier_field: unresolved
row_mapping_source: official_GeoPackage_required
```

Reason unresolved: this scan did not download or inspect the raw official GeoPackage, and no official web page was verified that directly maps the Sao Paulo row to a GHS-FUA identifier/name. A later evidence-manifest step must acquire the official ZIP, inspect the GeoPackage schema, extract the row matching Sao Paulo, and archive both raw and extracted artifacts.

## 5. Fallback/official-context source findings

### Observed FUA

No observed OECD/Eurostat FUA row for Sao Paulo was verified in this pass. The GHS-FUA documentation itself distinguishes observed OECD/EU FUA methods from the global modelled GHS-FUA method, noting that observed FUA delineation depends on observed commuting data and local administrative units with limited coverage.

Status:

```yaml
observed_functional_region_for_sao_paulo:
  verification_status: not_verified
  note: no_official_observed_OECD_or_Eurostat_Sao_Paulo_FUA_was_verified_in_this_pass
```

### National commuting / labour-market / hybrid functional-statistical context

IBGE’s population-arrangement and urban-concentration source family is a potentially stronger official Brazil context. The official source defines urban concentrations and population arrangements using work/study pendular movement and/or contiguous urbanized patches.

Status:

```yaml
ibge_population_arrangements_urban_concentrations:
  verification_status: source_family_verified
  exact_sao_paulo_composition: unresolved
  possible_role:
    - stronger_official_context
    - possible_candidate_boundary_family_after_readiness_review
    - validation_layer_for_GHS_FUA
```

This source family should be checked before relying on GHS-FUA as a primary boundary. If IBGE’s São Paulo urban concentration / population arrangement can be aligned with a population denominator and transport-source coverage, it may outrank GHS-FUA because it is official national context and uses work/study pendular movement and/or contiguity logic.

### Official statistical metro / planning region context

The São Paulo Metrô OD 2023 source verifies a current official planning/mobility context for the Região Metropolitana de São Paulo. It is useful for context and possibly for later planning-region overlay work.

Status:

```yaml
rmsa_or_planning_region_context:
  verification_status: partially_verified_context
  exact_boundary_record: not_created
  role: planning_or_governance_overlay
  caveat: do_not_use_as_primary_MTR_boundary_without_separate_boundary_source_review
```

### Official population geography

IBGE municipal boundaries and census/population products are official population-denominator source families. They should outrank GHS-POP when a selected boundary can be expressed through official municipal/statistical units and when the target question requires official population denominators.

Status:

```yaml
official_population_denominator:
  source_family_verified: true
  exact_denominator_for_GHS_FUA: unresolved
  note: GHS-FUA is a modelled polygon; direct IBGE population alignment would require overlay or a different official boundary.
```

## 6. GHS-POP and built-form overlay findings

### GHS-POP

GHS-POP R2023A provides gridded population estimates and projections:

- 1975–2020: estimates;
- 2025 and 2030: projections;
- available in 100 m Mollweide and 3 arcsec WGS84 forms.

Potential pairing options:

```yaml
population_pairing_options:
  vintage_consistent_model_context:
    boundary: GHS-FUA_R2019A_2015_modelled_FUA
    population: GHS-POP_R2019A_2015_population_grid_if_historical_model_consistency_is_required
    status: not_requested_as_current_denominator_but_relevant_for_method_traceability
  currentish_denominator_option_1:
    boundary: GHS-FUA_R2019A_2015_modelled_FUA
    population: GHS-POP_R2023A_2020_estimate
    caveat: boundary_is_2015_modelled; population_is_updated_estimate
  currentish_denominator_option_2:
    boundary: GHS-FUA_R2019A_2015_modelled_FUA
    population: GHS-POP_R2023A_2025_projection
    caveat: boundary_is_2015_modelled; population_is_projection_not_observed_census_count
```

No population value was calculated.

### Built-form overlay

Recommended built-form overlays for context only:

```yaml
built_form_context:
  primary_global_overlay: GHS-SMOD_R2023A
  urban_centre_context: GHS-UCDB_R2024A_or_2025_documentation
  official_context_overlay: IBGE_population_arrangements_and_urban_concentration_maps_or_municipal_boundaries
  role: validation_or_context_only
```

GHS-SMOD and GHS-UCDB must not be used as full MTR boundaries. They can help test whether the modelled GHS-FUA polygon includes or excludes built-up areas, satellite centres, or urbanized corridors that matter for the boundary burden review.

## 7. Model-input/vintage/growth caveat findings

The GHS-FUA method must carry these caveats if it remains in review:

1. **Modelled, not observed.**  
   GHS-FUA is based on modelled probability of cells belonging to the commuting area of a 2015 urban centre. It is not an observed commuting-flow boundary.

2. **2015 urban-centre inheritance.**  
   The FUA is derived from GHS-UCDB R2019A 2015 urban centres. Any urban-centre classification or population-allocation error can propagate into the FUA.

3. **GDP per capita input.**  
   The model uses country GDP per capita as an input. Because Mobility Conversion separately studies economic capacity, this creates an economic-capacity input overlap caveat.

4. **Global friction/travel-time input.**  
   The travel-time/friction surface is global and modelled. It is not local GTFS service, observed traffic, observed commuting, or current multimodal accessibility.

5. **Population-grid vintage mismatch.**  
   GHS-FUA used 2015 population inputs. Pairing it with GHS-POP R2023A 2020 estimates or 2025 projections introduces a mismatch between boundary epoch and denominator epoch.

6. **Service-source vintage mismatch.**  
   SPTrans, EMTU/ARTESP, rail, and other service data are current or near-current operational sources. Overlaying them on a 2015 modelled boundary requires explicit vintage notes.

7. **Growth/staleness risk.**  
   São Paulo’s urban extent, regional commuting, and service patterns may have changed since 2015. This is a high-burden issue because GHS-FUA is the proposed primary denominator in the current lead, not merely an overlay.

## 8. Service/operator/formal-informal coverage findings

### SPTrans

SPTrans provides static GTFS and Olho Vivo real-time API documentation for São Paulo municipal bus service.

Verified source posture:

```yaml
sptrans:
  role: municipal_bus_service_source
  formats:
    - GTFS_static
    - Olho_Vivo_HTTP_REST_JSON_API
  access_constraints:
    - developer_account_required_for_API
    - access_token_required_for_API
  coverage_limit: City_of_Sao_Paulo_bus_fleet_context_only
  denominator_status: forbidden_as_boundary_or_denominator
```

Unresolved:

- current GTFS feed URL and exact license terms require later feed-manifest capture;
- GTFS currentness requires later snapshot;
- SPTrans does not cover all municipalities or all modes inside a potential Sao Paulo GHS-FUA.

### EMTU / ARTESP

EMTU/SP and ARTESP provide data-source leads for metropolitan/intermunicipal bus services, including GTFS/API/open-data sources.

Verified source posture:

```yaml
emtu_artesp:
  role: metropolitan_intermunicipal_bus_service_source
  formats:
    - GTFS
    - API
    - CSV
    - Excel
    - PDF
  update_notes:
    - API_updates_automatic_according_to_EMTU_announcement
    - GTFS_updates_as_needed_according_to_EMTU_announcement
    - ARTESP_GTFS_source_seen_with_monthly_update_metadata
  access_constraints:
    - registration_or_terms_may_apply_to_API
  documented_GTFS_limitations:
    - calendar_reduced_to_weekday_saturday_sunday_current_year_without_holidays
    - stop_times_may_be_interpolated
    - shape_dist_traveled_blank
    - some_trips_may_lack_stop_times
  denominator_status: forbidden_as_boundary_or_denominator
```

Unresolved:

- exact operator list inside the modelled GHS-FUA;
- whether ARTESP/EMTU GTFS includes every relevant intermunicipal fixed-route service inside the modelled GHS-FUA;
- relation of EMTU metropolitan regions to the GHS-FUA polygon.

### Rail / metro / concessions

Material formal rail and metro sources likely include CPTM, São Paulo Metrô, and rail concessions such as ViaQuatro/ViaMobilidade. This pass verified CPTM and Metrô official context sources but did not verify a complete static schedule feed bundle for all rail/metro modes.

Status:

```yaml
rail_metro_bundle:
  CPTM: material_context_verified__schedule_feed_unresolved
  Metro_SP: official_OD_and_demand_context_verified__schedule_feed_unresolved
  ViaQuatro_ViaMobilidade_or_other_concessions: materiality_possible__source_verification_unresolved
```

### Demand-responsive, paratransit, charter, school, private, and weakly documented services

Potential material gaps include:

- SPTrans Atende+ adapted door-to-door service;
- EMTU Serviço Ligado or similar accessibility services if in scope;
- registered charter / `fretamento` services;
- school transport;
- airport buses and intercity coaches;
- private employer shuttles;
- demand-responsive or non-fixed-route services not represented in GTFS;
- informal or semi-formal services if present and material.

These should not define the MTR denominator. They should be recorded as coverage risks if the later indicator pipeline relies on formal fixed-route GTFS only.

### Could formal service feeds hide major service or population gaps?

Yes, but only as a risk statement, not a measured result.

Formal feeds could hide gaps because:

- SPTrans is a municipal bus source, not a full modelled-FUA source.
- EMTU/ARTESP covers intermunicipal/metropolitan bus, not necessarily metro/rail or all private/demand-responsive services.
- Rail/metro/concession feeds were not verified as a unified reproducible bundle.
- Demand-responsive, paratransit, charter, school, airport, and private services may sit outside static GTFS coverage.
- A modelled GHS-FUA denominator may include areas beyond formal service feeds or beyond the service geographies of major agencies.
- Service geography cannot be used as the denominator because that would erase unserved populations from the analysis.

No population gap or service gap was calculated.

## 9. Rejected/quarantined material

| Item | Status | Reason |
|---|---|---|
| SPTrans service area as MTR boundary | Rejected as denominator | Service geography can hide unserved populations and covers municipal bus service, not the full modelled FUA. |
| SPTrans GTFS extent, stop buffers, route buffers, or Olho Vivo coverage as denominator | Rejected | Service-derived denominator is prohibited. |
| EMTU/ARTESP service area, GTFS extent, or route coverage as denominator | Rejected | Service-derived geography can only be an overlay/input. |
| CPTM, Metrô, ViaQuatro/ViaMobilidade rail corridors as denominator | Rejected | Network corridors are outcome/service inputs, not primary MTR boundaries. |
| GHS-SMOD as primary MTR boundary | Rejected | Settlement/built-form layer, not a functional transport region denominator. |
| GHS-UCDB urban centre as primary MTR boundary | Rejected | Urban-centre database is core/context; not the full functional region. |
| GHS-FUA treated as observed commuting geography | Rejected | GHS-FUA is modelled from proxy inputs and must be labelled modelled. |
| IBGE/RMSP planning region as accepted replacement without separate review | Quarantined | Potentially stronger official context, but exact boundary/denominator/readiness must be processed separately. |
| Non-official web extract claiming Sao Paulo GHS-FUA row | Quarantined | Exact row must come from official JRC/GHSL data artifact. |
| Any reputation-based justification | Rejected | Megacity fame, congestion reputation, or perceived transit quality cannot justify source-led admission. |
| Wikipedia, blogs, travel guides, livability rankings, best-transit articles | Rejected | Not acceptable source families for this raw bundle. |

## 10. Open questions for Thesis 2

1. Should São Paulo remain in the source-led queue if the exact GHS-FUA row cannot be verified without raw GeoPackage acquisition?

2. What evidence burden is required to use a modelled GHS-FUA as a primary denominator when official Brazil functional/statistical geography may exist?

3. Should the IBGE population-arrangement / urban-concentration source family trigger a stronger-boundary-source review before any GHS-FUA readiness review?

4. Should GHS-POP 2020 estimate or 2025 projection be preferred if GHS-FUA remains under review, or should the project require a 2015-consistent population test first?

5. Should official IBGE municipality-based population denominators outrank GHS-POP even when the candidate boundary is a modelled GHS-FUA polygon?

6. Should the GDP-per-capita model input in GHS-FUA disqualify it from economic-capacity-axis tests, or merely require disclosure?

7. What formal overlay test should compare GHS-FUA against IBGE urban concentrations, municipal boundaries, GHS-SMOD, and GHS-UCDB?

8. What minimum service-source bundle would be required for a São Paulo public-transport coverage test: SPTrans + EMTU/ARTESP + CPTM + Metrô + concession operators?

9. Are rail/metro schedule feeds available in an official, reproducible, and licence-compatible form for São Paulo, CPTM, ViaQuatro, and ViaMobilidade?

10. Should demand-responsive, charter, school, airport, and intercity coach services be included only as missingness caveats, or as separate indicator-exclusion categories?

11. Can formal GTFS/API sources be considered sufficiently complete for fixed-route public transport if they exclude private/fretamento and paratransit services?

12. Should source-richness bias be explicitly heightened for São Paulo because multiple formal operators have partial datasets but no verified single integrated denominator-to-service bundle?

13. If IBGE official functional/statistical context is selected later, should GHS-FUA become a validation layer rather than a candidate primary boundary?

## 11. Source URL list

```text
GHSL / JRC GHS-FUA product page
https://human-settlement.emergency.copernicus.eu/ghs_fua.php

JRC Data Catalogue — GHS-FUA R2019A
https://data.jrc.ec.europa.eu/dataset/347f0337-f2da-4592-87b3-e25975ec2c95

GHSL FTP — GHS-FUA R2019A
https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_FUA_UCDB2015_GLOBE_R2019A/

GHSL FTP — GHS-FUA R2019A V1-0
https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_FUA_UCDB2015_GLOBE_R2019A/V1-0/

GHS-FUA ZIP path
https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_FUA_UCDB2015_GLOBE_R2019A/V1-0/GHS_FUA_UCDB2015_GLOBE_R2019A_54009_1K_V1_0.zip

GHS-FUA copyright / license note
https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_FUA_UCDB2015_GLOBE_R2019A/V1-0/copyright.txt

GHS-FUA documentation PDF
https://human-settlement.emergency.copernicus.eu/documents/GHSL_FUA_2019.pdf?t=1583246033

JRC Data Catalogue — GHS-POP R2023A
https://data.jrc.ec.europa.eu/dataset/2ff68a52-5b5b-4a22-8f40-c41da8332cfe

GHSL — GHS-POP R2023A
https://human-settlement.emergency.copernicus.eu/ghs_pop2023.php

GHSL — GHS-SMOD R2023A
https://human-settlement.emergency.copernicus.eu/ghs_smod2023.php

GHSL — GHS Urban Centre Database R2024A / 2025 documentation
https://human-settlement.emergency.copernicus.eu/ghs_ucdb2024.php

IBGE — Population Arrangements and Urban Concentrations in Brazil
https://www.ibge.gov.br/en/geosciences/territorial-organization/territorial-divisions/18354-population-arrangements-and-urban-concentrations-in-brazil.html

IBGE — Malha Municipal
https://www.ibge.gov.br/geociencias/organizacao-do-territorio/malhas-territoriais/15774-malhas.html

São Paulo Metrô — Pesquisa Origem e Destino 2023
https://transparencia.metrosp.com.br/dataset/pesquisa-origem-e-destino-2023

SPTrans — Desenvolvedores
https://www.sptrans.com.br/desenvolvedores/

SPTrans — Olho Vivo API reference
https://www.sptrans.com.br/desenvolvedores/api-do-olho-vivo-guia-de-referencia/documentacao-api/

EMTU — Open data / API-GTFS announcement
https://www.emtu.sp.gov.br/emtu/noticias/noticia/emtu-lanca-dados-abertos-para-consulta-de-transportes-coletivos.fss

ARTESP / dados.transportes.sp.gov.br — GTFS
https://dados.transportes.sp.gov.br/dataset/gtfs

EMTU — Itinerários e Tarifas
https://www.emtu.sp.gov.br/emtu/itinerarios-e-tarifas.fss

EMTU — Fretamento
https://www.emtu.sp.gov.br/emtu/servicos/fretamento.fss

ARTESP / dados.transportes.sp.gov.br — Consulta de Prestadores de Serviço de Fretamento e Escolar
https://dados.transportes.sp.gov.br/dataset/consulta-de-prestadores-de-servico-de-fretamento-e-escolar

SPTrans — Atende+
https://www.sptrans.com.br/atende/

São Paulo State Government — CPTM
https://www.saopaulo.sp.gov.br/conhecasp/servicos/companhia-paulista-de-trens-metropolitanos-cptm/

Metrô de São Paulo — Demanda
https://transparencia.metrosp.com.br/dataset/demanda
```
