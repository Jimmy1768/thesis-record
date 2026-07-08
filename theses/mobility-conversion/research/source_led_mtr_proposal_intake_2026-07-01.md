# Source-Led MTR Proposal Intake

Date: 2026-07-01

Raw return:

- `theses/mobility-conversion/operator_records/external_query_tests/2026-07-01-source-led-mtr-boundary-source-bundle-proposals-raw-return.md`
- SHA-256:
  `04f945db913fa58d83d0d71f1276a3f91f00a5822219223a4f81a847b50a9868`

Status: intake only. No MTR selected. No evidence accepted. No boundary record,
candidate-universe ledger, outcome metric record, score, ranking, or MTR
comparison is authorized.

## Scope Compliance

The return mostly follows the handoff discipline.

Compliant elements:

- explicitly labels itself raw research material;
- states that it is not evidence, source truth, an admitted MTR list, a score,
  or a ranking;
- proposes source-led boundary/source-bundle leads rather than final candidate
  MTRs;
- includes non-selection statements for all eight proposal leads;
- uses eligible primary boundary source-family classes for all eight proposal
  leads;
- explicitly rejects or quarantines service-derived and reputation-led
  denominators.

Recorded issues and caveats:

- The return suggests storage paths outside the current Thesis 2 convention,
  including `research-artifacts/raw/` and `source-notes/`. These paths are not
  adopted. Raw returns remain under `operator_records/external_query_tests/`,
  and verified source notes remain under `research/source_notes/`.
- All eight proposal leads still require exact boundary row, code, membership,
  or polygon extraction before any boundary record can be filled.
- Several local service/network source leads are named but not independently
  verified inside ThesisRecord.
- No returned proposal is admitted to the candidate universe by this intake.

No use of the prohibited transit-region expansion of MTR was found in the raw
return.

## Proposal Lead Table

| Lead | Country/countries | Boundary source family | Source authority | Intake status | Next allowed output |
| --- | --- | --- | --- | --- | --- |
| `mtr_src_001` Helsinki FUA | Finland | `observed_functional_region` | Eurostat GISCO / OECD | `municipality_membership_verified_service_completeness_blocked` | Reconcile non-HSL service-source coverage against official `FI001F` membership |
| `mtr_src_002` Lyon FUA | France | `observed_functional_region` | Eurostat GISCO / European Commission | `static_feed_and_siri_method_blocked` | Resolve authenticated TCL static-feed access, licence, SIRI Lite method, and non-TCL operators |
| `mtr_src_003` Bristol TTWA | United Kingdom | `national_commuting_zone` | ONS / ONS Open Geography Portal | `exact_row_verified_boundary_population_and_service_blocked` | Verify raw boundary geometry, population path, commute-vintage caveat, and service-source materiality |
| `mtr_src_004` Minneapolis-St. Paul ERS CZ | United States | `national_commuting_zone` | USDA ERS | `processed_tiger_geometry_created_quality_review_next` | Review processed geometry topology/visual sanity and tract sufficiency; no population values accepted |
| `mtr_src_005` Calgary CMA | Canada | `hybrid_functional_statistical_region` | Statistics Canada | `boundary_feature_verified_population_dguid_conflict` | Resolve Statistics Canada DGUID/profile relation, population path, CSD membership, and service-overlay caveats |
| `mtr_src_006` Greater Melbourne GCCSA | Australia | `hybrid_functional_statistical_region` | Australian Bureau of Statistics | `exact_row_verified_boundary_population_and_fit_blocked` | Verify ABS population path, SA4 membership, boundary-fit, and Victoria service overlay |
| `mtr_src_007` Portland-Vancouver-Hillsboro MSA | United States | `official_statistical_metro` | OMB / U.S. Census Bureau | `processed_tiger_geometry_created_quality_review_next` | Review processed geometry topology/visual sanity and tract sufficiency; no population values accepted |
| `mtr_src_008` Sao Paulo GHS-FUA | Brazil | `modelled_functional_region` | European Commission JRC / GHSL | `source_system_verified_exact_row_and_fallback_blocked` | Review IBGE alternatives or prepare manifest before GHS-FUA GeoPackage extraction |

## Lead Details

### Lead: `mtr_src_001` Helsinki FUA

- intake status: `helsinki_operator_inventory_handoff_ready`
- source-led reason: tests an observed Eurostat/OECD FUA boundary against a
  plausible official regional service-source bundle.
- non-selection test: passes at intake; the return explicitly rejects transit
  reputation, congestion reputation, walkability reputation, livability
  rankings, GDP, wealth, national reputation, personal familiarity, and
  expected performance.
- boundary source eligibility: eligible source family if the exact observed FUA
  row/code and polygon are independently verified.
- minimal source bundle: plausible, but exact FUA row, population denominator,
  HSL/Digitransit feed coverage, and operator completeness are not yet verified.
- major risks: boundary-to-operator-area mismatch; source-rich-region bias;
  service coverage outside the principal regional authority.
- next allowed output: source-note review, followed by lead review if source
  notes produce a traceable boundary/source bundle.
- prohibited outputs: admitted MTR, candidate list, candidate-universe ledger,
  metric record, score, ranking, or raw archive without manifest.
- coverage update, 2026-07-03: Helsinki is blocked on operator inventory and
  FUA coverage reconciliation against `FI001F`; an operator-inventory research
  handoff is ready. See
  `theses/mobility-conversion/research/helsinki_fua_coverage_reconciliation_worksheet_2026-07-03.md`
  and
  `theses/mobility-conversion/operator_records/handoffs/2026-07-03-helsinki-fua-operator-inventory-request.md`.
- raw-return intake update, 2026-07-05: ChatGPT return was preserved and
  classified. HSL/Digitransit is a core source family but not proof of full
  `FI001F` coverage; official municipality membership and non-HSL operator
  completeness remain unresolved. See
  `theses/mobility-conversion/research/helsinki_fua_operator_inventory_raw_return_intake_2026-07-05.md`.
- municipality-membership source-note update, 2026-07-05: official OECD CSV
  inspection verifies `FI001F` as Helsinki/Helsingfors with 16 municipality
  rows. Seven official FUA municipalities are outside documented HSL membership,
  so service-source completeness and unserved-population visibility remain
  blocked. See
  `theses/mobility-conversion/research/source_notes/oecd_helsinki_fua_municipality_membership_2026-07-05.md`.

### Lead: `mtr_src_002` Lyon FUA

- intake status: `source_trace_found_static_feed_unresolved`
- source-led reason: tests whether Eurostat FUA plus France national transport
  access-point discovery can produce a source bundle without relying on local
  familiarity.
- non-selection test: passes at intake.
- boundary source eligibility: eligible source family if the exact observed FUA
  row/code and polygon are independently verified.
- minimal source bundle: incomplete because the relevant local France NAP
  records, feed formats, operators, and coverage have not been traced.
- major risks: national access point may expose many heterogeneous datasets;
  local feed extraction and FUA-wide operator coverage are unverified.
- next allowed output: source trace for FUA row plus France NAP local feed
  records.
- prohibited outputs: readiness promotion before local source trace; admitted
  MTR; candidate list; scoring or ranking.
- extraction update, 2026-07-01: official GISCO label inspection corrected the
  Lyon FUA unit code to `FR002F`; `FR003F` is Lille, not Lyon. See
  `theses/mobility-conversion/research/eurostat_oecd_fua_exact_row_extraction_note_2026-07-01.md`.
- service-source trace update, 2026-07-01: France NAP identifies an official
  `Réseau urbain TCL` dataset for Lyon under SYTRAL Mobilités, but static
  GTFS/NeTEx availability is unresolved. Service status moves from
  `needs_source_trace` to `source_trace_found_static_feed_unresolved`. See
  `theses/mobility-conversion/research/lyon_fua_service_source_trace_note_2026-07-01.md`.
- raw-return intake update, 2026-07-05: ChatGPT return was preserved and
  classified. TCL static GTFS/NeTEx remains blocked by authenticated access and
  license review; SIRI Lite is not accepted as a substitute. See
  `theses/mobility-conversion/research/lyon_fua_source_recovery_raw_return_intake_2026-07-05.md`.
- static-feed recovery source-note update, 2026-07-05: official France NAP API
  inspection confirms the TCL dataset, SYTRAL authority, `mobility-licence`,
  authentication tag, unavailable GTFS/NeTEx resources, and SIRI Lite resources
  behind Grand Lyon Basic Auth. Current static-feed use and SIRI Lite method
  remain blocked. See
  `theses/mobility-conversion/research/source_notes/france_nap_lyon_tcl_static_feed_recovery_2026-07-05.md`.

### Lead: `mtr_src_003` Bristol TTWA

- intake status: `bristol_ttwa_exact_row_handoff_ready`
- source-led reason: tests a national commuting-zone/labour-market boundary
  outside the OECD/Eurostat FUA source family.
- non-selection test: passes at intake.
- boundary source eligibility: eligible source family if exact TTWA row/code and
  polygon are independently verified.
- minimal source bundle: plausible, but TTWA population aggregation, NaPTAN,
  BODS, rail/ferry coverage, and post-2020 commuting caveats require review.
- major risks: 2011 commuting-flow vintage; labour-market boundary may
  over-include rural hinterland; bus-only service bundle risk.
- next allowed output: source-note review for TTWA row, NaPTAN, BODS, and
  non-bus mode coverage.
- prohibited outputs: boundary record before exact TTWA extraction; candidate
  admission; score or ranking.
- source-path review update, 2026-07-05: existing ONS TTWA notes verify
  source-family relevance and commute-vintage caveat needs, but exact Bristol
  TTWA row/code, boundary product, population denominator path, and
  service-overlay coverage remain unresolved. See
  `theses/mobility-conversion/research/bristol_ttwa_boundary_population_source_path_review_2026-07-05.md`.
- extraction workflow update, 2026-07-05: exact Bristol TTWA extraction gates
  are defined and a research handoff is ready. See
  `theses/mobility-conversion/research/bristol_ttwa_exact_row_extraction_workflow_2026-07-05.md`
  and
  `theses/mobility-conversion/operator_records/handoffs/2026-07-05-bristol-ttwa-exact-row-source-bundle-request.md`.
- raw-return intake update, 2026-07-05: ChatGPT return was preserved and
  classified. `E30000180` is a raw exact-code lead only; canonical ONS row
  extraction, boundary artifact choice, population aggregation, and service
  materiality remain unresolved. See
  `theses/mobility-conversion/research/bristol_ttwa_exact_row_raw_return_intake_2026-07-05.md`.
- exact-row source-note update, 2026-07-05: official ONS boundary FeatureServer
  inspection verifies Bristol as `TTWA11CD = E30000180` and `TTWA11NM =
  Bristol` without geometry. Canonical names/codes raw-file extraction, raw
  boundary geometry, population denominator, commute-vintage caveat, and
  service-overlay materiality remain unresolved. See
  `theses/mobility-conversion/research/source_notes/ons_bristol_ttwa_exact_row_2026-07-05.md`.

### Lead: `mtr_src_004` Minneapolis-St. Paul ERS CZ

- intake status: `minneapolis_ers_cz_exact_membership_handoff_ready`
- source-led reason: tests U.S. county-based national commuting zones with
  federal transit-feed discovery through FTA/NTD.
- non-selection test: passes at intake.
- boundary source eligibility: eligible source family if exact ERS CZ
  membership is independently extracted and verified.
- minimal source bundle: plausible because USDA ERS, Census/ACS, county
  boundaries, and FTA/NTD GTFS source families are already known Thesis 2 source
  families.
- major risks: county coarseness; labour-market overreach; rural
  over-inclusion; GTFS source-derived denominator risk.
- next allowed output: readiness checklist review. Any later boundary record
  must remain `not_admitted` until exact CZ membership, population aggregation,
  agency coverage, and boundary-fit risks are documented.
- prohibited outputs: use of GTFS or agency service area as denominator;
  candidate admission; scoring or ranking.
- source-path review update, 2026-07-05: ERS CZ, ACS denominator, and FTA/NTD
  GTFS Weblinks source families are verified, but exact local CZ code,
  county membership, ACS aggregation, county-coarseness risk, and service
  coverage remain unresolved. See
  `theses/mobility-conversion/research/minneapolis_ers_cz_boundary_population_source_path_review_2026-07-05.md`.
- extraction workflow update, 2026-07-05: exact Minneapolis-St. Paul ERS CZ
  membership extraction gates are defined and a research handoff is ready. See
  `theses/mobility-conversion/research/minneapolis_ers_cz_exact_membership_extraction_workflow_2026-07-05.md`
  and
  `theses/mobility-conversion/operator_records/handoffs/2026-07-05-minneapolis-ers-cz-exact-membership-source-bundle-request.md`.
- raw-return intake update, 2026-07-05: ChatGPT return was preserved and
  classified. `CZ2020 = 258` and county membership are raw leads only;
  independent ERS re-extraction, county coarseness, ACS aggregation, and
  service-overlay review remain unresolved. See
  `theses/mobility-conversion/research/minneapolis_ers_cz_exact_membership_raw_return_intake_2026-07-05.md`.
- exact-membership source-note update, 2026-07-05: official USDA ERS CSV
  inspection verifies `CZ2020 = 258`, `CZName = Minneapolis city, MN`, and 13
  county rows across Minnesota and Wisconsin. County geometry, ACS aggregation,
  county-coarseness, and service-overlay review remain unresolved. See
  `theses/mobility-conversion/research/source_notes/usda_ers_minneapolis_cz_exact_membership_2026-07-05.md`.
- county-coarseness method update, 2026-07-06: Minneapolis-St. Paul ERS CZ is
  classified as a high-risk county-coarseness case. Boundary record,
  denominator acquisition, evidence manifest, and metric testing remain blocked
  until a subcounty overlay or sensitivity plan exists. See
  `theses/mobility-conversion/research/county_coarseness_method_note_2026-07-06.md`.
- overlay-plan update, 2026-07-06: ACS tract or block-group population
  sensitivity is selected as the first subcounty overlay for Minneapolis-St.
  Paul. Raw ACS/TIGER acquisition remains blocked until a source-note follow-up
  or draft manifest decision. See
  `theses/mobility-conversion/research/county_coarseness_overlay_plan_2026-07-06.md`.
- ACS/TIGER source-note update, 2026-07-06: the U.S. Census ACS/TIGER source
  family is suitable for the selected subcounty overlay, and representative
  Oregon TIGER paths were verified. Later verification confirmed Minnesota,
  Wisconsin, Oregon, and Washington TIGER 2024 tract/block-group paths by HEAD.
  Additional 2026-07-07 verification found ACS API access still blocked across
  curl, Python urllib, and HTTP redirect probes. Draft manifest decision is now
  the next local step before raw overlay acquisition.
  See
  `theses/mobility-conversion/research/source_notes/us_census_acs_tiger_subcounty_overlay_sources_2026-07-06.md`.
- TIGER/ACS manifest-decision update, 2026-07-07: TIGER geometry and ACS
  population-table acquisition are split into separate manifest tracks. A draft
  evidence manifest may be prepared for TIGER 2024 tract/block-group geometry
  only; ACS tables remain deferred until live API row verification succeeds.
  See
  `theses/mobility-conversion/research/census_tiger_acs_overlay_manifest_decision_2026-07-07.md`.
- TIGER geometry draft-manifest update, 2026-07-07: a draft evidence manifest
  now records official TIGER 2024 tract/block-group URLs and HEAD metadata for
  Minnesota, Wisconsin, Oregon, and Washington. No raw geometry was downloaded
  or accepted. Next gate is TIGER license/storage review before raw acquisition.
  See
  `theses/mobility-conversion/evidence/manifests/tiger_2024_subcounty_geometry_overlay_manifest_2026-07-07.md`.
- TIGER raw-acquisition update, 2026-07-07: Census license/storage review
  allowed the controlled TIGER ZIP snapshot. The eight raw ZIPs were archived
  under the manifest, SHA-256 checksums were recorded, and ZIP integrity tests
  passed. No processed geometry, boundary record, metric record, population
  value, score, or ranking is authorized. Next gate is shapefile schema,
  geography-key, feature-count, and CRS review. See
  `theses/mobility-conversion/research/tiger_2024_raw_geometry_acquisition_log_2026-07-07.md`.
- TIGER quality-review update, 2026-07-07: raw ZIP schema, feature-count, and
  CRS review passed at archive level. The manifest now requires boundary review
  before any processed extraction or overlay method step. See
  `theses/mobility-conversion/research/tiger_2024_raw_geometry_quality_review_2026-07-07.md`.
- TIGER boundary-alignment update, 2026-07-07: a geometry-only plan now defines
  county FIPS filters, tract-first handling, and block-group escalation rules.
  No processed geometry or population overlay is authorized by the plan. See
  `theses/mobility-conversion/research/tiger_2024_geometry_boundary_alignment_plan_2026-07-07.md`.
- tooling/API blocker update, 2026-07-07: local geometry extraction tooling is
  unavailable in both system and bundled runtimes, and ACS API access remains
  blocked locally with curl TLS code 35. Next progress requires extraction
  tooling or external ACS row verification. See
  `theses/mobility-conversion/research/tiger_2024_geometry_extraction_tooling_check_2026-07-07.md`
  and `theses/mobility-conversion/research/acs_api_access_recheck_2026-07-07.md`.
- pyshp extraction update, 2026-07-08: a branch tooling spike confirmed pyshp
  as adequate for county-FIPS filtering and created processed tract and
  block-group geometry outputs for the Minneapolis and Portland filters. No
  population values, denominators, boundary records, metrics, scores, or
  rankings are authorized. See
  `theses/mobility-conversion/research/tiger_2024_processed_geometry_extraction_log_2026-07-08.md`.

### Lead: `mtr_src_005` Calgary CMA

- intake status: `ready_for_source_note_review`
- source-led reason: tests Statistics Canada CMA/CA hybrid
  functional-statistical geography with population tables and a municipal GTFS
  source.
- non-selection test: passes at intake.
- boundary source eligibility: eligible source family if exact CMA boundary
  file, code, vintage, and population source are verified.
- minimal source bundle: plausible, but Calgary Transit alone may not cover the
  full CMA if regional services or municipalities are material.
- major risks: CMA is official statistical geography rather than pure transport
  service geography; service/operator coverage alignment uncertain.
- next allowed output: source-note review for CMA boundary/population and
  Calgary/regional service-source completeness.
- prohibited outputs: treating Calgary Transit service geography as the MTR
  denominator; candidate admission; scoring or ranking.
- source-path update, 2026-07-03: Statistics Canada boundary/profile source
  paths were identified, but exact Calgary CMA code/DGUID, boundary artifact,
  population field, and service coverage remain unresolved. See
  `theses/mobility-conversion/research/calgary_cma_boundary_population_source_path_review_2026-07-03.md`.
- raw-return intake update, 2026-07-05: ChatGPT return was preserved and
  classified. `825` and `2021S0503825` are raw exact-row leads only until
  independently re-extracted; CSD membership, population fields, and regional
  service-overlay completeness remain unresolved. See
  `theses/mobility-conversion/research/calgary_cma_exact_row_raw_return_intake_2026-07-05.md`.
- exact-row source-note update, 2026-07-05: official Statistics Canada sources
  verify Calgary as CMA code `825` and verify a queryable 2021 cartographic
  boundary feature row with boundary-layer DGUID `2021S050548825`. The raw
  return's `2021S0503825` profile/focus identifier remains in conflict or
  unreconciled with the boundary-layer DGUID; population denominator and CSD
  membership remain unresolved. See
  `theses/mobility-conversion/research/source_notes/statistics_canada_calgary_cma_exact_row_2026-07-05.md`.

### Lead: `mtr_src_006` Greater Melbourne GCCSA

- intake status: `ready_for_source_note_review`
- source-led reason: tests ABS ASGS/GCCSA hybrid functional-statistical
  geography against a state-level GTFS data source.
- non-selection test: passes at intake.
- boundary source eligibility: eligible source family if exact GCCSA code,
  boundary file, ASGS edition, and population denominator are verified.
- minimal source bundle: plausible, but GCCSA breadth and statewide feed
  completeness require review.
- major risks: GCCSA may be broader than a daily transport catchment; service
  bundle must be clipped or evaluated against the denominator.
- next allowed output: source-note review for GCCSA boundary/population and
  Victoria DTP GTFS coverage.
- prohibited outputs: assuming statewide GTFS coverage solves boundary fit;
  candidate admission; scoring or ranking.
- source-path update, 2026-07-04: ABS ASGS/GCCSA source family and source paths
  were identified, but exact Greater Melbourne GCCSA code, boundary artifact,
  population field, SA4 membership, and Victoria service coverage remain
  unresolved. See
  `theses/mobility-conversion/research/melbourne_gccsa_boundary_population_source_path_review_2026-07-04.md`.
- raw-return intake update, 2026-07-05: ChatGPT return was preserved and
  classified. `2GMEL` is a raw exact-code lead only; ABS geometry, SA4
  membership, population field, GCCSA boundary-fit, and Victoria service-source
  completeness remain unresolved. See
  `theses/mobility-conversion/research/melbourne_gccsa_exact_row_raw_return_intake_2026-07-05.md`.
- exact-row source-note update, 2026-07-05: official ABS allocation workbook
  inspection verifies `2GMEL` as Greater Melbourne. The official boundary ZIP
  path responds from ABS, but raw geometry, population denominator, SA4
  membership, boundary-fit, and Victoria service-overlay coverage remain
  unresolved. See
  `theses/mobility-conversion/research/source_notes/abs_greater_melbourne_gccsa_exact_row_2026-07-05.md`.

### Lead: `mtr_src_007` Portland-Vancouver-Hillsboro MSA

- intake status: `portland_cbsa_exact_boundary_handoff_ready`
- source-led reason: tests U.S. OMB/Census CBSA/MSA as an official
  statistical-metro container with ACS and FTA/NTD source compatibility.
- non-selection test: passes at intake.
- boundary source eligibility: eligible source family if exact CBSA boundary
  and delineation vintage are verified.
- minimal source bundle: plausible because OMB/Census, ACS, and FTA/NTD source
  families are already known Thesis 2 source families.
- major risks: county-based official metro may be too coarse; cross-state
  geography complicates agency and denominator alignment.
- next allowed output: readiness checklist review focused on CBSA boundary fit,
  population denominator, and multi-agency source coverage.
- prohibited outputs: using NTD/GTFS feed inventory as denominator; candidate
  admission; scoring or ranking.
- source-path review update, 2026-07-05: OMB CBSA, ACS denominator, FTA/NTD
  GTFS Weblinks, and BTS National Transit Map source families are verified, but
  exact CBSA code, delineation vintage, county membership, boundary artifact,
  ACS denominator path, and cross-state service coverage remain unresolved. See
  `theses/mobility-conversion/research/portland_cbsa_boundary_population_source_path_review_2026-07-05.md`.
- extraction workflow update, 2026-07-05: exact
  Portland-Vancouver-Hillsboro CBSA boundary extraction gates are defined and a
  research handoff is ready. See
  `theses/mobility-conversion/research/portland_cbsa_exact_boundary_extraction_workflow_2026-07-05.md`
  and
  `theses/mobility-conversion/operator_records/handoffs/2026-07-05-portland-cbsa-exact-boundary-source-bundle-request.md`.
- raw-return intake update, 2026-07-05: ChatGPT return was preserved and
  classified. `CBSA = 38900` is a raw boundary lead only; county membership,
  county-coarseness, ACS denominator choice, and cross-state service coverage
  remain unresolved. See
  `theses/mobility-conversion/research/portland_cbsa_exact_boundary_raw_return_intake_2026-07-05.md`.
- exact-boundary source-note update, 2026-07-05: official Census `list1_2023`
  inspection verifies CBSA `38900`, title, MSA class, CSA affiliation, and seven
  county rows with central/outlying status. TIGER geometry path is live, but
  raw geometry, ACS denominator, county-coarseness review, and cross-state
  service overlay remain unresolved. See
  `theses/mobility-conversion/research/source_notes/us_census_portland_cbsa_exact_boundary_2026-07-05.md`.
- county-coarseness method update, 2026-07-06: Portland-Vancouver-Hillsboro
  CBSA is classified as a high-risk county-coarseness case. Boundary record,
  denominator acquisition, evidence manifest, and metric testing remain blocked
  until a subcounty overlay or sensitivity plan exists. See
  `theses/mobility-conversion/research/county_coarseness_method_note_2026-07-06.md`.
- overlay-plan update, 2026-07-06: ACS tract or block-group population
  sensitivity is selected as the first subcounty overlay for
  Portland-Vancouver-Hillsboro. Raw ACS/TIGER acquisition remains blocked until
  a source-note follow-up or draft manifest decision. See
  `theses/mobility-conversion/research/county_coarseness_overlay_plan_2026-07-06.md`.
- ACS/TIGER source-note update, 2026-07-06: the U.S. Census ACS/TIGER source
  family is suitable for the selected subcounty overlay, and representative
  Oregon TIGER paths were verified. Later verification confirmed Minnesota,
  Wisconsin, Oregon, and Washington TIGER 2024 tract/block-group paths by HEAD.
  Additional 2026-07-07 verification found ACS API access still blocked across
  curl, Python urllib, and HTTP redirect probes. Draft manifest decision is now
  the next local step before raw overlay acquisition.
  See
  `theses/mobility-conversion/research/source_notes/us_census_acs_tiger_subcounty_overlay_sources_2026-07-06.md`.
- TIGER/ACS manifest-decision update, 2026-07-07: TIGER geometry and ACS
  population-table acquisition are split into separate manifest tracks. A draft
  evidence manifest may be prepared for TIGER 2024 tract/block-group geometry
  only; ACS tables remain deferred until live API row verification succeeds.
  See
  `theses/mobility-conversion/research/census_tiger_acs_overlay_manifest_decision_2026-07-07.md`.
- TIGER geometry draft-manifest update, 2026-07-07: a draft evidence manifest
  now records official TIGER 2024 tract/block-group URLs and HEAD metadata for
  Minnesota, Wisconsin, Oregon, and Washington. No raw geometry was downloaded
  or accepted. Next gate is TIGER license/storage review before raw acquisition.
  See
  `theses/mobility-conversion/evidence/manifests/tiger_2024_subcounty_geometry_overlay_manifest_2026-07-07.md`.
- TIGER raw-acquisition update, 2026-07-07: Census license/storage review
  allowed the controlled TIGER ZIP snapshot. The eight raw ZIPs were archived
  under the manifest, SHA-256 checksums were recorded, and ZIP integrity tests
  passed. No processed geometry, boundary record, metric record, population
  value, score, or ranking is authorized. Next gate is shapefile schema,
  geography-key, feature-count, and CRS review. See
  `theses/mobility-conversion/research/tiger_2024_raw_geometry_acquisition_log_2026-07-07.md`.
- TIGER quality-review update, 2026-07-07: raw ZIP schema, feature-count, and
  CRS review passed at archive level. The manifest now requires boundary review
  before any processed extraction or overlay method step. See
  `theses/mobility-conversion/research/tiger_2024_raw_geometry_quality_review_2026-07-07.md`.
- TIGER boundary-alignment update, 2026-07-07: a geometry-only plan now defines
  county FIPS filters, tract-first handling, and block-group escalation rules.
  No processed geometry or population overlay is authorized by the plan. See
  `theses/mobility-conversion/research/tiger_2024_geometry_boundary_alignment_plan_2026-07-07.md`.
- tooling/API blocker update, 2026-07-07: local geometry extraction tooling is
  unavailable in both system and bundled runtimes, and ACS API access remains
  blocked locally with curl TLS code 35. Next progress requires extraction
  tooling or external ACS row verification. See
  `theses/mobility-conversion/research/tiger_2024_geometry_extraction_tooling_check_2026-07-07.md`
  and `theses/mobility-conversion/research/acs_api_access_recheck_2026-07-07.md`.
- pyshp extraction update, 2026-07-08: a branch tooling spike confirmed pyshp
  as adequate for county-FIPS filtering and created processed tract and
  block-group geometry outputs for the Minneapolis and Portland filters. No
  population values, denominators, boundary records, metrics, scores, or
  rankings are authorized. See
  `theses/mobility-conversion/research/tiger_2024_processed_geometry_extraction_log_2026-07-08.md`.

### Lead: `mtr_src_008` Sao Paulo GHS-FUA

- intake status: `raw_return_buffered_modelled_boundary_high_burden_review_required`
- source-led reason: stress-tests modelled global functional-region boundaries
  where observed harmonized FUA or national commuting-zone data may be
  unavailable.
- non-selection test: passes at intake, but the lead has high quarantine risk
  if future rationale shifts to megacity size, fame, congestion, or expected
  performance.
- boundary source eligibility: potentially eligible only as
  `modelled_functional_region`; must not be treated as observed commuting-flow
  geography.
- minimal source bundle: incomplete and high risk. GHS-FUA/GHS-POP sources are
  plausible, but SPTrans/EMTU access, licensing, coverage, and formal/informal
  service limits are unverified.
- major risks: modelled 2015 boundary vintage; rapid growth; formal-service
  source incompleteness; API/registration reproducibility; informal or weakly
  documented transport.
- next allowed output: boundary classification review before any readiness
  promotion.
- prohibited outputs: treating the modelled boundary as equivalent to observed
  commuting geography; candidate admission; scoring or ranking.
- boundary classification update, 2026-07-05: the lead may proceed only as a
  high-burden `modelled_functional_region` fallback or validation lead. Exact
  GHS-FUA row, fallback justification, GHS-POP vintage pairing,
  official/national context search, built-form overlay, and service-source
  completeness remain unresolved. See
  `theses/mobility-conversion/research/sao_paulo_ghs_fua_boundary_classification_review_2026-07-05.md`.
- extraction workflow update, 2026-07-05: high-burden extraction gates are
  defined and a research handoff is ready. See
  `theses/mobility-conversion/research/sao_paulo_ghs_fua_high_burden_extraction_workflow_2026-07-05.md`
  and
  `theses/mobility-conversion/operator_records/handoffs/2026-07-05-sao-paulo-ghs-fua-high-burden-source-bundle-request.md`.
- raw-return intake update, 2026-07-05: ChatGPT return was preserved and
  classified. Exact GHS-FUA row/name remains unresolved; IBGE official-context
  alternatives, GHS-FUA model-input caveats, GHS-POP vintage pairing, and
  formal/informal service coverage require high-burden review before any
  boundary use. See
  `theses/mobility-conversion/research/sao_paulo_ghs_fua_raw_return_intake_2026-07-05.md`.
- source-system source-note update, 2026-07-05: official JRC/GHSL source-system
  inspection verifies the GHS-FUA R2019A V1-0 directory, ZIP path, ZIP response
  metadata, and CC BY 4.0 copyright text. The exact Sao Paulo row, IBGE
  stronger-source review, population pairing, and service-source coverage
  remain unresolved. See
  `theses/mobility-conversion/research/source_notes/jrc_ghsl_sao_paulo_ghs_fua_source_system_2026-07-05.md`.

## Rejected Or Quarantined Leads

The raw return already rejected or quarantined the following denominator ideas.
This intake accepts those dispositions as process classifications, not as final
methodology claims.

| Lead | Status | Reason | Future reconsideration condition |
| --- | --- | --- | --- |
| HSL operating area as primary boundary | `rejected_service_derived_denominator` | Transport authority/service geography is not an eligible primary MTR denominator. | May be used only as service overlay after a separate eligible FUA or other MTR boundary is verified. |
| France national access point dataset geography as primary boundary | `rejected_service_derived_denominator` | A transport data catalog is not a functional-region boundary. | May support service/network source discovery only. |
| NaPTAN stop coverage or BODS feed coverage as primary boundary | `rejected_service_derived_denominator` | Stop and timetable coverage is service-derived and may hide unserved populations. | May support coverage indicators only. |
| FTA/NTD GTFS Weblinks or National Transit Map as primary boundary | `rejected_service_derived_denominator` | Feed inventory is service-derived, not an MTR denominator. | May support service-source completeness and agency discovery only. |
| GHSL Urban Centre Database or GHS-SMOD urban centre alone | `rejected_boundary_basis` | Built-up urban cores are overlays, not full MTR commuting catchments. | May support urban-form overlay or validation if paired with eligible MTR boundary. |
| NASA/SEDAC SDG 11.2.1 urban-access geography | `rejected_boundary_basis` | Accessibility-dataset geography is an indicator method, not a primary MTR boundary. | May support external validation or indicator-method review only. |
| Transport for London or fare-zone boundary as standalone denominator | `rejected_service_derived_denominator` | Governance/fare/service boundary is not automatically a functional MTR. | Requires separate eligible FUA, commuting, statistical, or modelled boundary source. |
| Dubai-Sharjah-Ajman from service/governance sources only | `quarantined_insufficient_source` | The return did not provide a verified eligible primary boundary source row. | Reconsider only with verified modelled FUA, official statistical, or other eligible boundary source. |
| Any best-transit or most-congested lead | `rejected_reputation_led` | Outcome-adjacent selection violates the source-led guardrail. | No reconsideration unless reformulated from source-system grounds. |

## Source Leads To Verify

These are not evidence. They are source-note or source-trace targets.

| Lead | Source artifact | Claimed authority | Needed verification |
| --- | --- | --- | --- |
| `mtr_src_001`, `mtr_src_002` | Eurostat GISCO Cities and Functional Urban Areas geodata | Eurostat GISCO / European Commission | Exact FUA row/code, vintage, polygon, license, population denominator compatibility |
| `mtr_src_001` | HSL open data and Digitransit GTFS / GTFS-RT / OSM routing stack | HSL / Digitransit | Feed URLs, feed vintage, license, coverage relative to FUA, operator completeness |
| `mtr_src_002` | France National Access Point local transport datasets | transport.data.gouv.fr | Relevant Lyon-area feed records, format, license, operator coverage, publication date |
| `mtr_src_003` | ONS TTWA boundary row for Bristol | ONS / ONS Open Geography Portal | Exact TTWA code, polygon, vintage, commuting caveat, population aggregation path |
| `mtr_src_003` | NaPTAN and Bus Open Data Service | UK DfT | Extract date, timetable coverage, mode limitations, non-bus source needs |
| `mtr_src_004` | USDA ERS 2020 CZ membership for Minneapolis-St. Paul | USDA ERS | Exact CZ code, county membership, county-boundary vintage, ACS denominator aggregation |
| `mtr_src_004`, `mtr_src_007` | FTA/NTD GTFS Weblinks | FTA / NTD | Current relevant agency list, feed validity, feed freshness, coverage gaps |
| `mtr_src_005` | Statistics Canada CMA boundary and population sources for Calgary | Statistics Canada | Exact CMA code, boundary vintage, population table vintage, method caveats |
| `mtr_src_005` | Calgary Transit Scheduling Data | City of Calgary / Calgary Transit | Feed vintage, license, GTFS completeness, regional operator gaps |
| `mtr_src_006` | ABS GCCSA boundary and population denominator for Greater Melbourne | Australian Bureau of Statistics | Exact GCCSA code, ASGS edition, boundary file, population denominator |
| `mtr_src_006` | Victoria DTP GTFS schedule data | Victoria Department of Transport and Planning | Feed vintage, license, statewide coverage, clipping/alignment to GCCSA |
| `mtr_src_007` | OMB/Census CBSA/MSA boundary for Portland-Vancouver-Hillsboro | OMB / U.S. Census Bureau | Exact CBSA code, delineation vintage, boundary file, ACS denominator path |
| `mtr_src_008` | GHS-FUA and GHS-POP for Sao Paulo | European Commission JRC / GHSL | Exact GHS-FUA row, modelled boundary caveats, GHS-POP reconciliation, vintage alignment |
| `mtr_src_008` | SPTrans and EMTU feed/API leads | SPTrans / EMTU | Public access, registration constraints, license, coverage, reproducibility, formal/informal service limits |

## Open Questions

- Should exact boundary row/code extraction be required before a lead can move
  from source-note review to readiness checklist review?
- What maximum vintage gap is acceptable for 2011 TTWA boundaries and 2015
  GHS-FUA modelled boundaries?
- Should all commuting-flow boundaries receive a standard post-2020 remote-work
  caveat, or only sources whose flow data were collected around 2020-2021?
- What overlay checks are mandatory before official statistical metros,
  county-based CBSAs, CMAs, GCCSAs, or CZs can become MTR denominators?
- What service-source completeness threshold is required before a feed bundle
  is plausible for a first method test?
- Are registration-gated APIs admissible if documentation is public but raw
  feed access is gated?
- Should `modelled_functional_region` leads carry a stronger evidence burden
  than observed FUAs or national commuting zones?
- How should Thesis 2 prevent source-rich-region bias from becoming hidden
  candidate selection?
- Should resident-population denominators prefer official statistical
  population, gridded population, or both with reconciliation notes?

## Intake Decision

The return is useful as a source-led proposal set. It should be accepted into
the Thesis 2 process as raw research material and intake classification, not as
evidence or candidate selection.

Recommended next work order:

1. Run source-note review for one source-family cluster rather than one famous
   region. The cleanest first cluster is Eurostat/OECD FUA plus Eurostat GISCO
   exact-row extraction, because it affects two returned leads and tests an
   already preferred boundary family.
2. In parallel or next, run a readiness-checklist review on one U.S. source
   system lead (`mtr_src_004` or `mtr_src_007`) only if the review stays focused
   on boundary/source-system mechanics rather than region selection.
3. Keep `mtr_src_008` out of readiness review until the modelled-boundary burden
   is clarified.

## Closing Guardrail

This intake does not admit or select any MTR. It only classifies raw proposal
leads and identifies next allowed review, rejection, quarantine, or source-note
actions.
