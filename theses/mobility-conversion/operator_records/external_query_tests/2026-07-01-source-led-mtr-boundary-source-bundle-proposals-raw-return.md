# Raw process return — Source-led MTR boundary/source-bundle proposals

**Thesis:** Thesis 2 — Mobility Conversion  
**Date:** 2026-07-01  
**Status:** raw research material only  
**Not evidence, not source truth, not an admitted MTR list, not a score, not a ranking**

This return follows the source-led MTR proposal request. The unit of work is to identify **source-led boundary/source-bundle proposals** that can later be evaluated through the Thesis 2 readiness checklist, not to pick cities, decide methodology, score, or rank.

---

## 1. Short method summary

I looked for proposals where the **primary MTR denominator** could plausibly come from an eligible boundary family:

- `observed_functional_region`
- `national_commuting_zone`
- `hybrid_functional_statistical_region`
- `official_statistical_metro`
- `modelled_functional_region`

I did **not** use built-up urban cores, GTFS catchments, transport authority regions, fare zones, accessibility-dataset geographies, or city administrative boundaries as primary denominators. Those appear only as overlays or indicator inputs where relevant.

The proposal mix below intentionally starts from **source systems**:

- Eurostat/OECD Functional Urban Areas
- ONS Travel to Work Areas
- USDA ERS Commuting Zones
- Statistics Canada CMA/CA
- ABS ASGS/GCCSA
- U.S. OMB/Census CBSAs
- JRC/GHSL GHS-FUA

These source systems differ in behavioral validity, statistical compatibility, vintage, and automation risk. OECD/Eurostat FUAs are based on dense urban cores plus commuting zones; Eurostat GISCO provides downloadable FUA geodata; GHS-FUA is a modelled 2015 functional-region product rather than observed commuting-flow data.

No metrics were calculated. No data were downloaded. Exact polygon rows, feed URLs, and population denominators still need later source-note verification and evidence manifests.

---

## 2. Proposal table

| Proposal ID | Working MTR proposal | Boundary source family | Source-led reason for testing | First plausible outcome/source bundle | Main risk posture |
|---|---|---|---|---|---|
| `mtr_src_001` | Helsinki FUA | `observed_functional_region` | Tests Eurostat/OECD FUA boundary with official regional open-data transport sources | HSL / Digitransit GTFS, GTFS-RT, OSM routing inputs | Boundary-to-operator-area alignment |
| `mtr_src_002` | Lyon FUA | `observed_functional_region` | Tests Eurostat FUA plus France national access point source discovery | France NAP transit datasets, GTFS/NeTEx/SIRI source family | Specific local feed extraction not yet verified |
| `mtr_src_003` | Bristol Travel to Work Area | `national_commuting_zone` | Tests ONS TTWA labor-market boundary plus GB-wide stop/timetable systems | NaPTAN stops, Bus Open Data timetables, rail/ferry overlays if needed | 2011 commuting vintage and post-2020 caveat |
| `mtr_src_004` | Minneapolis–St. Paul ERS Commuting Zone | `national_commuting_zone` | Tests U.S. national county-based labor-market area with NTD GTFS inventory | FTA/NTD GTFS weblinks, Census/ACS county data | County coarseness and labor-market overreach |
| `mtr_src_005` | Calgary CMA | `hybrid_functional_statistical_region` | Tests Statistics Canada CMA/CA commuting-rule metro geography | StatCan boundary/population data, Calgary Transit GTFS | CMA versus service/operator coverage alignment |
| `mtr_src_006` | Greater Melbourne GCCSA | `hybrid_functional_statistical_region` | Tests ABS GCCSA/SA4 functional-statistical geography with state transport GTFS | ABS boundaries/population, Victoria DTP GTFS | GCCSA may be broader than transport catchment |
| `mtr_src_007` | Portland–Vancouver–Hillsboro MSA | `official_statistical_metro` | Tests OMB/Census CBSA/MSA as official statistical metro container | TIGER/CBSA boundaries, ACS, FTA/NTD GTFS weblinks | County-based statistical metro, cross-state alignment |
| `mtr_src_008` | São Paulo GHS-FUA | `modelled_functional_region` | Tests global modelled FUA where observed harmonized FUA may be unavailable | GHS-FUA, GHS-POP, SPTrans/EMTU GTFS/API leads | Modelled 2015 boundary and service-source completeness |

---

## 3. Full YAML-style proposal blocks

### Proposal `mtr_src_001` — Helsinki FUA

```yaml
proposal_id: mtr_src_001
proposal_status: research_lead_only

working_mtr:
  working_name: Helsinki Functional Urban Area
  country_or_countries:
    - Finland
  source_led_reason_for_testing: >
    Test an observed Eurostat/OECD-style Functional Urban Area boundary with
    a plausible official regional public-transport data bundle. The exact FUA
    row/code must be extracted from the Eurostat/OECD boundary source before
    this can become a boundary record.
  non_selection_statement: >
    This proposal is source-led. It is not proposed because of transit reputation,
    congestion reputation, walkability reputation, livability rankings, GDP,
    wealth, national reputation, personal familiarity, expected outcome
    performance, or "good city" intuition.

boundary_lead:
  source_family: observed_functional_region
  confidence_class: source_system_verified__exact_boundary_row_extraction_required
  source_name: Eurostat GISCO Cities and Functional Urban Areas / OECD FUA method
  source_authority:
    - Eurostat GISCO
    - OECD
  source_url_or_access_path:
    - https://ec.europa.eu/eurostat/web/gisco/geodata/statistical-units/cities-functional-urban-areas
    - https://www.oecd.org/en/data/datasets/oecd-definition-of-cities-and-functional-urban-areas.html
  source_vintage: "Eurostat GISCO provides multiple downloadable FUA vintages, including 2024; exact selected vintage not yet chosen."
  geography_type: city_plus_commuting_zone_functional_region
  source_note_candidate: source-notes/eurostat-oecd-functional-urban-areas.md

minimal_source_bundle:
  boundary_source: Eurostat/OECD FUA polygon and FUA code
  population_denominator_source: Eurostat/FUA-compatible population or gridded population reconciled to FUA boundary
  first_outcome_source_family: scheduled public transport access or stop/service coverage test
  service_or_network_source:
    - HSL open data packages and APIs
    - Digitransit static GTFS / GTFS-RT / OSM routing stack
  expected_vintage_fields:
    - boundary_vintage
    - FUA_code
    - population_vintage
    - GTFS_static_feed_date
    - GTFS_RT_observation_window
    - OSM_extract_date
    - operator_coverage_notes

readiness_gate_preview:
  boundary_source_eligibility: eligible_if_exact_observed_FUA_row_is_verified
  source_verification: source_system_verified; exact row not extracted
  boundary_fit: requires FUA polygon versus HSL/Digitransit service-area overlay
  data_bundle_plausibility: plausible
  evidence_manifest_need:
    - FUA polygon archive
    - FUA population denominator
    - HSL/Digitransit feed references
    - OSM extract reference
    - operator-completeness note
  candidate_universe_guardrail: >
    Keep only if the proposal remains justified by FUA/source-bundle compatibility,
    not by Helsinki's transport reputation.

risk_notes:
  boundary_risks:
    - FUA boundary may not match HSL operating area.
    - Commuting-zone vintage may differ from transport feed vintage.
  data_alignment_risks:
    - Need alignment between FUA population denominator and service-source geography.
    - Need operator coverage beyond the main regional authority if relevant.
  reputation_selection_risks:
    - Quarantine if future notes cite reputation or expected performance as justification.
  missingness_risks:
    - Exact FUA row/code not yet extracted.
    - Full operator completeness not yet audited.
  source_rich_region_bias_risks:
    - Strong open-data infrastructure may make this proposal easier than less source-rich regions.

recommended_next_action: >
  Extract exact Eurostat/OECD FUA code and polygon; then compare the FUA polygon
  with HSL/Digitransit feed coverage before admitting as a boundary/source-bundle
  candidate.
```

Source support:

- OECD — Definition of Cities and Functional Urban Areas: https://www.oecd.org/en/data/datasets/oecd-definition-of-cities-and-functional-urban-areas.html
- Eurostat GISCO — Cities and Functional Urban Areas geodata: https://ec.europa.eu/eurostat/web/gisco/geodata/statistical-units/cities-functional-urban-areas
- HSL Open Data: https://www.hsl.fi/en/hsl/open-data
- HSL / Digitransit GTFS-RT documentation: https://digitransit.fi/en/developers/apis/4-realtime-api/

---

### Proposal `mtr_src_002` — Lyon FUA

```yaml
proposal_id: mtr_src_002
proposal_status: research_lead_only

working_mtr:
  working_name: Lyon Functional Urban Area
  country_or_countries:
    - France
  source_led_reason_for_testing: >
    Test an observed Eurostat FUA boundary with a national transport-data access
    point model. This is useful for checking whether national access-point
    discovery can support MTR source-bundle construction without relying on
    local reputation or hand-picked agency familiarity.
  non_selection_statement: >
    This proposal is source-led. It is not proposed because of transit reputation,
    congestion reputation, walkability reputation, livability rankings, GDP,
    wealth, national reputation, personal familiarity, expected outcome
    performance, or "good city" intuition.

boundary_lead:
  source_family: observed_functional_region
  confidence_class: source_system_verified__exact_boundary_row_extraction_required
  source_name: Eurostat GISCO Cities and Functional Urban Areas
  source_authority:
    - Eurostat GISCO
    - European Commission
  source_url_or_access_path:
    - https://ec.europa.eu/eurostat/web/gisco/geodata/statistical-units/cities-functional-urban-areas
  source_vintage: "Eurostat GISCO provides multiple downloadable FUA vintages, including 2024; exact selected vintage not yet chosen."
  geography_type: city_plus_commuting_zone_functional_region
  source_note_candidate: source-notes/eurostat-gisco-fua-france.md

minimal_source_bundle:
  boundary_source: Eurostat GISCO FUA polygon and FUA code
  population_denominator_source: Eurostat/FUA-compatible population or gridded population reconciled to FUA boundary
  first_outcome_source_family: public-transport service coverage or scheduled access method test
  service_or_network_source:
    - France National Access Point for transport open data
    - GTFS / NeTEx / SIRI datasets discovered through national access point
    - OSM street network if scheduled-access test is run
  expected_vintage_fields:
    - boundary_vintage
    - FUA_code
    - population_vintage
    - dataset_publication_date
    - GTFS_or_NeTEx_feed_date
    - OSM_extract_date
    - local_operator_coverage_notes

readiness_gate_preview:
  boundary_source_eligibility: eligible_if_exact_observed_FUA_row_is_verified
  source_verification: FUA source system verified; local dataset row not yet extracted
  boundary_fit: requires FUA polygon versus discovered operator/feed coverage
  data_bundle_plausibility: plausible_but_feed_specificity_unverified
  evidence_manifest_need:
    - FUA polygon archive
    - national-access-point dataset records
    - local feed URLs and licenses
    - operator-completeness note
  candidate_universe_guardrail: >
    Keep only if national-access-point and FUA source-bundle logic remains the
    reason for testing.

risk_notes:
  boundary_risks:
    - Exact FUA row/code must be extracted.
    - FUA commuting-zone vintage may differ from national-access-point feed vintage.
  data_alignment_risks:
    - France NAP may list multiple operators and formats; full MTR coverage must be audited.
    - GTFS/NeTEx/SIRI availability for the complete FUA is unverified.
  reputation_selection_risks:
    - Quarantine if future justification shifts to Lyon reputation, urbanism, or expected performance.
  missingness_risks:
    - Specific local feed record not yet verified.
    - Feed completeness for the full FUA unknown.
  source_rich_region_bias_risks:
    - National access-point maturity may bias proposals toward countries with strong open-data mandates.

recommended_next_action: >
  Extract exact FUA row and run a national-access-point search for all relevant
  transit feeds intersecting the FUA. Do not admit until feed/source coverage is
  documented.
```

Source support:

- Eurostat GISCO — Cities and Functional Urban Areas geodata: https://ec.europa.eu/eurostat/web/gisco/geodata/statistical-units/cities-functional-urban-areas
- France National Access Point for transport open data: https://transport.data.gouv.fr/

---

### Proposal `mtr_src_003` — Bristol Travel to Work Area

```yaml
proposal_id: mtr_src_003
proposal_status: research_lead_only

working_mtr:
  working_name: Bristol Travel to Work Area
  country_or_countries:
    - United Kingdom
  source_led_reason_for_testing: >
    Test a national commuting-zone / labour-market boundary family outside the
    OECD/Eurostat FUA system, paired with Great Britain-wide stop and bus
    timetable datasets. Exact TTWA geometry and code must be extracted before
    any readiness decision.
  non_selection_statement: >
    This proposal is source-led. It is not proposed because of transit reputation,
    congestion reputation, walkability reputation, livability rankings, GDP,
    wealth, national reputation, personal familiarity, expected outcome
    performance, or "good city" intuition.

boundary_lead:
  source_family: national_commuting_zone
  confidence_class: source_system_verified__exact_TTWA_row_extraction_required
  source_name: Travel to Work Areas, December 2011
  source_authority:
    - UK Office for National Statistics
    - ONS Open Geography Portal
  source_url_or_access_path:
    - https://geoportal.statistics.gov.uk/datasets/ons::travel-to-work-areas-december-2011-boundaries-uk-bsc-v3
    - https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/articles/traveltoworkareaanalysisingreatbritain/2016
  source_vintage: "2011 Census commuting-flow basis; December 2011 boundary release."
  geography_type: travel_to_work_area_labour_market_region
  source_note_candidate: source-notes/uk-ons-travel-to-work-areas.md

minimal_source_bundle:
  boundary_source: ONS TTWA boundary polygon and TTWA code
  population_denominator_source: ONS Census / small-area population aggregated to TTWA
  first_outcome_source_family: public-transport stop access or scheduled bus/transit coverage
  service_or_network_source:
    - NaPTAN public transport access points
    - Bus Open Data Service timetable data
    - rail/ferry sources if required for complete MTR service coverage
  expected_vintage_fields:
    - TTWA_boundary_vintage
    - commuting_data_vintage
    - population_vintage
    - NaPTAN_extract_date
    - BODS_feed_date
    - rail_feed_or_timetable_vintage
    - OSM_extract_date

readiness_gate_preview:
  boundary_source_eligibility: eligible_as_national_commuting_zone_if_exact_TTWA_row_verified
  source_verification: source system verified; exact row not extracted
  boundary_fit: must test whether TTWA over-includes rural labour-market hinterland for MTR use
  data_bundle_plausibility: plausible
  evidence_manifest_need:
    - TTWA polygon archive
    - population aggregation method
    - NaPTAN extract
    - BODS feed manifest
    - non-bus mode source notes
  candidate_universe_guardrail: >
    Keep only if justified as a TTWA/source-system test, not as a city-interest case.

risk_notes:
  boundary_risks:
    - TTWA is labour-market based, not all-purpose daily-access based.
    - 2011 commute data are stale and require a post-2020 commuting caveat.
  data_alignment_risks:
    - BODS and NaPTAN may not fully cover all relevant modes without additional sources.
    - TTWA population aggregation may require lookup tables.
  reputation_selection_risks:
    - Quarantine if future justification shifts to Bristol reputation or expected outcomes.
  missingness_risks:
    - Exact TTWA polygon/code not yet extracted.
    - Complete multimodal feed coverage not yet verified.
  source_rich_region_bias_risks:
    - GB-wide open-data systems may make this easier than less digitized jurisdictions.

recommended_next_action: >
  Extract Bristol TTWA polygon/code from ONS boundary data, then build a source
  manifest for NaPTAN, BODS, and any non-bus public-transport datasets required
  to avoid bus-only bias.
```

Source support:

- ONS Travel to Work Area analysis in Great Britain: https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/articles/traveltoworkareaanalysisingreatbritain/2016
- ONS Open Geography Portal — Travel to Work Areas boundaries: https://geoportal.statistics.gov.uk/datasets/ons::travel-to-work-areas-december-2011-boundaries-uk-bsc-v3
- NaPTAN: https://naptan.dft.gov.uk/
- DfT Bus Open Data Service: https://www.bus-data.dft.gov.uk/

---

### Proposal `mtr_src_004` — Minneapolis–St. Paul ERS Commuting Zone

```yaml
proposal_id: mtr_src_004
proposal_status: research_lead_only

working_mtr:
  working_name: Minneapolis–St. Paul ERS 2020 Commuting Zone
  country_or_countries:
    - United States
  source_led_reason_for_testing: >
    Test a national commuting-zone source family based on U.S. county-to-county
    labour-market flows, paired with the FTA/NTD public GTFS feed-link inventory.
    Exact ERS CZ code and county membership must be extracted before readiness
    evaluation.
  non_selection_statement: >
    This proposal is source-led. It is not proposed because of transit reputation,
    congestion reputation, walkability reputation, livability rankings, GDP,
    wealth, national reputation, personal familiarity, expected outcome
    performance, or "good city" intuition.

boundary_lead:
  source_family: national_commuting_zone
  confidence_class: source_system_verified__exact_CZ_membership_extraction_required
  source_name: USDA ERS 2020 Commuting Zones
  source_authority:
    - United States Department of Agriculture
    - Economic Research Service
  source_url_or_access_path:
    - https://www.ers.usda.gov/data-products/commuting-zones-and-labor-market-areas
  source_vintage: "2020 Commuting Zones; ERS page updated 2026-01-09."
  geography_type: county_based_commuting_zone_labour_market
  source_note_candidate: source-notes/usda-ers-commuting-zones.md

minimal_source_bundle:
  boundary_source: USDA ERS 2020 CZ county membership and geometry generated from county boundaries
  population_denominator_source: U.S. Census / ACS county population aggregated to CZ membership
  first_outcome_source_family: fixed-route public-transport service coverage or scheduled-access method test
  service_or_network_source:
    - FTA/NTD General Transit Feed Specification Weblinks
    - agency GTFS feeds discovered through NTD
    - Census TIGER/Line or cartographic county boundaries
    - OSM street network if routing is tested
  expected_vintage_fields:
    - CZ_vintage
    - county_boundary_vintage
    - ACS_population_period
    - NTD_report_year
    - GTFS_feed_date
    - OSM_extract_date
    - agency_coverage_notes

readiness_gate_preview:
  boundary_source_eligibility: eligible_as_national_commuting_zone_if_CZ_membership_verified
  source_verification: source system verified; exact CZ membership not extracted
  boundary_fit: must test whether county-based CZ is too broad for MTR denominator
  data_bundle_plausibility: plausible_but_county_coarseness_high
  evidence_manifest_need:
    - CZ county membership file
    - county boundary vintage
    - ACS population table
    - GTFS weblink inventory snapshot
    - agency inclusion/exclusion rationale
  candidate_universe_guardrail: >
    Keep only as a USDA CZ/NTD source-system test; do not justify by local reputation.

risk_notes:
  boundary_risks:
    - County-based labour markets may over-include rural territory.
    - Commuting-zone boundaries are work-trip based, not full everyday-access regions.
  data_alignment_risks:
    - FTA/NTD GTFS feeds are agency/service-derived and cannot define the denominator.
    - Need complete agency list for all fixed-route operators intersecting the CZ.
  reputation_selection_risks:
    - Quarantine if future rationale references expected transport quality.
  missingness_risks:
    - Exact CZ code/membership not yet extracted.
    - Feed validity and live reachability not yet tested.
  source_rich_region_bias_risks:
    - U.S. federal data availability may make this appear easier than equivalent non-U.S. regions.

recommended_next_action: >
  Extract ERS CZ membership and aggregate county population. Separately snapshot
  the current FTA/NTD GTFS weblinks for all relevant agencies; do not use those
  feeds to define the denominator.
```

Source support:

- USDA ERS — Commuting Zones and Labor Market Areas: https://www.ers.usda.gov/data-products/commuting-zones-and-labor-market-areas
- FTA/NTD — GTFS Weblinks: https://catalog.data.gov/dataset/2023-ntd-annual-data-general-transit-feed-specification-gtfs-weblinks

---

### Proposal `mtr_src_005` — Calgary CMA

```yaml
proposal_id: mtr_src_005
proposal_status: research_lead_only

working_mtr:
  working_name: Calgary Census Metropolitan Area
  country_or_countries:
    - Canada
  source_led_reason_for_testing: >
    Test a hybrid functional/statistical metropolitan geography with explicit
    Statistics Canada CMA/CA commuting-flow inclusion rules, annual population
    tables, and an official municipal GTFS source for first service tests.
  non_selection_statement: >
    This proposal is source-led. It is not proposed because of transit reputation,
    congestion reputation, walkability reputation, livability rankings, GDP,
    wealth, national reputation, personal familiarity, expected outcome
    performance, or "good city" intuition.

boundary_lead:
  source_family: hybrid_functional_statistical_region
  confidence_class: official_method_verified__exact_CMA_boundary_file_extraction_required
  source_name: Statistics Canada Census Metropolitan Area / Census Agglomeration
  source_authority:
    - Statistics Canada
  source_url_or_access_path:
    - https://www150.statcan.gc.ca/n1/pub/92-195-x/2021001/geo/cma-rmr/cma-rmr-eng.htm
    - https://www150.statcan.gc.ca/n1/en/type/data?text=boundary%20files
  source_vintage: "Census-linked CMA/CA boundary system; exact boundary vintage to select during intake."
  geography_type: municipality_based_official_metro_region_with_commuting_rules
  source_note_candidate: source-notes/statcan-cma-ca-boundaries.md

minimal_source_bundle:
  boundary_source: Statistics Canada CMA boundary file and CMA code
  population_denominator_source: Statistics Canada CMA population estimates or Census population
  first_outcome_source_family: scheduled fixed-route public-transport coverage or access method test
  service_or_network_source:
    - Calgary Transit Scheduling Data in GTFS format
    - Calgary Transit GTFS-RT vehicle positions if reliability or live-observation tests are later considered
    - OSM street network if routing is tested
  expected_vintage_fields:
    - CMA_boundary_vintage
    - CMA_code
    - population_table_vintage
    - GTFS_static_feed_date
    - GTFS_RT_observation_window
    - OSM_extract_date
    - operator_coverage_notes

readiness_gate_preview:
  boundary_source_eligibility: eligible_as_hybrid_functional_statistical_region_if_CMA_boundary_verified
  source_verification: CMA method verified; exact boundary file not extracted
  boundary_fit: must test CMA extent against actual MTR service/operator coverage
  data_bundle_plausibility: plausible
  evidence_manifest_need:
    - CMA boundary file
    - CMA population source
    - Calgary Transit GTFS source snapshot
    - intermunicipal/regional operator coverage note
  candidate_universe_guardrail: >
    Keep only as a StatCan CMA/source-bundle test; do not admit based on reputation.

risk_notes:
  boundary_risks:
    - CMA boundaries are official statistical geographies, not pure transport-service regions.
    - CMA may include municipalities with limited or no fixed-route transit.
  data_alignment_risks:
    - Calgary Transit GTFS may not cover the full CMA if other operators or regional services are material.
  reputation_selection_risks:
    - Quarantine if future justification cites expected transport quality.
  missingness_risks:
    - Exact CMA boundary vintage and code not yet extracted.
    - Full operator completeness not yet audited.
  source_rich_region_bias_risks:
    - Canadian statistical and municipal open-data availability may bias source-led proposals.

recommended_next_action: >
  Extract the Calgary CMA boundary and population source, then audit whether
  Calgary Transit GTFS alone covers enough of the CMA for a first method test
  or whether additional regional operators must be added.
```

Source support:

- Statistics Canada — CMA/CA illustrated glossary: https://www150.statcan.gc.ca/n1/pub/92-195-x/2021001/geo/cma-rmr/cma-rmr-eng.htm
- Statistics Canada — CMA/CA delineation rules: https://www150.statcan.gc.ca/n1/pub/92f0138m/92f0138m2019002-eng.htm
- Statistics Canada — CMA/CA population estimates table: https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1710014801
- Calgary Transit Scheduling Data: https://data.calgary.ca/Transportation-Transit/Calgary-Transit-Scheduling-Data-GTFS-Static/npk7-z3bj

---

### Proposal `mtr_src_006` — Greater Melbourne GCCSA

```yaml
proposal_id: mtr_src_006
proposal_status: research_lead_only

working_mtr:
  working_name: Greater Melbourne Greater Capital City Statistical Area
  country_or_countries:
    - Australia
  source_led_reason_for_testing: >
    Test the Australian ASGS/GCCSA hybrid functional/statistical geography,
    where capital-city regions are designed around functional socio-economic
    extent and SA4 labour-market structures, paired with a state-level GTFS
    transport data source.
  non_selection_statement: >
    This proposal is source-led. It is not proposed because of transit reputation,
    congestion reputation, walkability reputation, livability rankings, GDP,
    wealth, national reputation, personal familiarity, expected outcome
    performance, or "good city" intuition.

boundary_lead:
  source_family: hybrid_functional_statistical_region
  confidence_class: official_method_verified__exact_GCCSA_boundary_file_extraction_required
  source_name: Australian Statistical Geography Standard Greater Capital City Statistical Areas
  source_authority:
    - Australian Bureau of Statistics
  source_url_or_access_path:
    - https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/latest-release
    - https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/main-structure-and-greater-capital-city-statistical-areas/greater-capital-city-statistical-areas
  source_vintage: "ASGS Edition 3, July 2021 to June 2026; Edition 4 scheduled progressively from 2026."
  geography_type: capital_city_functional_statistical_region
  source_note_candidate: source-notes/abs-gccsa-asgs-functional-regions.md

minimal_source_bundle:
  boundary_source: ABS ASGS GCCSA digital boundary file and GCCSA code
  population_denominator_source: ABS Regional Population / Data by Region for GCCSA or aggregable units
  first_outcome_source_family: scheduled public transport coverage or access method test
  service_or_network_source:
    - Victoria Department of Transport and Planning GTFS schedule dataset
    - Victoria GTFS-RT if later reliability or live-operation tests are considered
    - OSM street network if routing is tested
  expected_vintage_fields:
    - ASGS_edition
    - GCCSA_code
    - boundary_file_release_date
    - population_reference_year
    - GTFS_static_feed_date
    - GTFS_RT_observation_window
    - OSM_extract_date
    - statewide_operator_coverage_notes

readiness_gate_preview:
  boundary_source_eligibility: eligible_as_hybrid_functional_statistical_region_if_GCCSA_boundary_verified
  source_verification: ASGS/GCCSA method verified; exact boundary file not extracted
  boundary_fit: must test whether GCCSA is too broad for MTR denominator
  data_bundle_plausibility: plausible
  evidence_manifest_need:
    - ASGS boundary file
    - GCCSA population denominator
    - DTP GTFS source snapshot
    - statewide mode/operator completeness note
  candidate_universe_guardrail: >
    Keep only as an ABS GCCSA/source-bundle test; do not justify by reputation.

risk_notes:
  boundary_risks:
    - GCCSA may include a broader socio-economic region than a contiguous daily transport catchment.
    - SA4/GCCSA design is not a pure observed commuting-flow boundary.
  data_alignment_risks:
    - Statewide GTFS coverage must be clipped or assessed against the GCCSA denominator.
    - Need to verify whether all relevant regional bus/rail services are included.
  reputation_selection_risks:
    - Quarantine if future justification cites expected transport quality or city reputation.
  missingness_risks:
    - Exact boundary file and code not yet extracted.
    - Feed completeness within GCCSA not yet audited.
  source_rich_region_bias_risks:
    - Strong state-level open-data source may bias this proposal toward easier data collection.

recommended_next_action: >
  Extract the Greater Melbourne GCCSA boundary and corresponding population
  denominator, then test whether the Victoria DTP GTFS dataset covers all
  public-transport services needed for a first source-bundle readiness check.
```

Source support:

- ABS — Australian Statistical Geography Standard: https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/latest-release
- ABS — Greater Capital City Statistical Areas: https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/main-structure-and-greater-capital-city-statistical-areas/greater-capital-city-statistical-areas
- ABS — Digital boundary files: https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/latest-release/digital-boundary-files
- Victoria DTP — GTFS schedule data: https://discover.data.vic.gov.au/dataset/ptv-timetable-and-geographic-information-2015-gtfs

---

### Proposal `mtr_src_007` — Portland–Vancouver–Hillsboro MSA

```yaml
proposal_id: mtr_src_007
proposal_status: research_lead_only

working_mtr:
  working_name: Portland–Vancouver–Hillsboro Metropolitan Statistical Area
  country_or_countries:
    - United States
  source_led_reason_for_testing: >
    Test an official statistical metro boundary with transparent OMB/Census
    CBSA rules, county-based TIGER boundary availability, ACS denominator
    compatibility, and FTA/NTD GTFS feed-link discovery.
  non_selection_statement: >
    This proposal is source-led. It is not proposed because of transit reputation,
    congestion reputation, walkability reputation, livability rankings, GDP,
    wealth, national reputation, personal familiarity, expected outcome
    performance, or "good city" intuition.

boundary_lead:
  source_family: official_statistical_metro
  confidence_class: official_statistical_system_verified__exact_CBSA_boundary_extraction_required
  source_name: OMB Core Based Statistical Area / Metropolitan Statistical Area
  source_authority:
    - U.S. Office of Management and Budget
    - U.S. Census Bureau
  source_url_or_access_path:
    - https://www.federalregister.gov/documents/2021/07/16/2021-15159/2020-standards-for-delineating-core-based-statistical-areas
    - https://www.census.gov/programs-surveys/geography/guidance/geo-areas/metro-micro.html
    - https://www2.census.gov/geo/tiger/GENZ2023/shp/cb_2023_us_cbsa_5m.zip
  source_vintage: "2020 CBSA standards; 2023 delineations/boundary products available through OMB/Census."
  geography_type: county_based_official_statistical_metro_area
  source_note_candidate: source-notes/us-omb-cbsa-msa-boundaries.md

minimal_source_bundle:
  boundary_source: Census CBSA cartographic or TIGER/Line boundary file and CBSA code
  population_denominator_source: U.S. Census ACS / Population Estimates by CBSA or county aggregation
  first_outcome_source_family: fixed-route public-transport service coverage or scheduled-access method test
  service_or_network_source:
    - FTA/NTD General Transit Feed Specification Weblinks
    - agency GTFS feeds discovered through NTD
    - OSM street network if routing is tested
  expected_vintage_fields:
    - CBSA_standard_vintage
    - CBSA_delineation_vintage
    - boundary_file_vintage
    - ACS_population_period
    - NTD_report_year
    - GTFS_feed_date
    - OSM_extract_date
    - agency_coverage_notes

readiness_gate_preview:
  boundary_source_eligibility: eligible_as_official_statistical_metro_if_CBSA_boundary_verified
  source_verification: CBSA method/source verified; exact boundary file not extracted
  boundary_fit: must test whether county-based MSA is too coarse for MTR denominator
  data_bundle_plausibility: plausible
  evidence_manifest_need:
    - CBSA boundary archive
    - CBSA/county population denominator
    - NTD GTFS weblink snapshot
    - agency inclusion/exclusion notes
  candidate_universe_guardrail: >
    Keep only as an OMB/Census official-statistical-boundary test, not because
    of local familiarity or expected outcomes.

risk_notes:
  boundary_risks:
    - County-based MSA may include territory not functionally part of daily transport region.
    - Cross-state geography may complicate agency and denominator alignment.
  data_alignment_risks:
    - NTD GTFS weblinks are service-derived and cannot define denominator.
    - Need all material fixed-route operators, not only a primary agency.
  reputation_selection_risks:
    - Quarantine if future justification references transport reputation.
  missingness_risks:
    - Exact CBSA polygon and current delineation must be archived.
    - Current GTFS feed reachability and validation not yet tested.
  source_rich_region_bias_risks:
    - U.S. federal statistical and transit-feed systems may bias this toward easy-source regions.

recommended_next_action: >
  Extract the CBSA boundary and population denominator, then produce an agency
  manifest from the FTA/NTD GTFS weblink inventory. Evaluate boundary fit before
  any candidate-universe admission.
```

Source support:

- OMB — 2020 standards for Core Based Statistical Areas: https://www.federalregister.gov/documents/2021/07/16/2021-15159/2020-standards-for-delineating-core-based-statistical-areas
- U.S. Census — Metropolitan and micropolitan areas: https://www.census.gov/programs-surveys/geography/guidance/geo-areas/metro-micro.html
- U.S. Census — CBSA boundary file: https://www2.census.gov/geo/tiger/GENZ2023/shp/cb_2023_us_cbsa_5m.zip
- FTA/NTD — GTFS Weblinks: https://catalog.data.gov/dataset/2023-ntd-annual-data-general-transit-feed-specification-gtfs-weblinks

---

### Proposal `mtr_src_008` — São Paulo GHS-FUA

```yaml
proposal_id: mtr_src_008
proposal_status: research_lead_only

working_mtr:
  working_name: São Paulo GHS Functional Urban Area
  country_or_countries:
    - Brazil
  source_led_reason_for_testing: >
    Test a modelled global functional-region boundary where observed OECD/Eurostat
    or national commuting-zone equivalents may not be available for Thesis 2.
    This should stress-test whether modelled FUA boundaries can support a
    source-led readiness proposal without pretending they are observed commute
    geographies.
  non_selection_statement: >
    This proposal is source-led. It is not proposed because of transit reputation,
    congestion reputation, walkability reputation, livability rankings, GDP,
    wealth, national reputation, personal familiarity, expected outcome
    performance, or "good city" intuition.

boundary_lead:
  source_family: modelled_functional_region
  confidence_class: modelled_global_boundary_system_verified__exact_GHS_FUA_row_extraction_required
  source_name: GHS Functional Urban Areas
  source_authority:
    - European Commission Joint Research Centre
    - Global Human Settlement Layer
  source_url_or_access_path:
    - https://data.europa.eu/data/datasets/jrc-ghsl-ghs_fua_r2019a
    - https://human-settlement.emergency.copernicus.eu/ghs_fua.php
  source_vintage: "GHS-FUA R2019A, functional areas of 2015 Urban Centres."
  geography_type: modelled_functional_area_for_2015_urban_centre
  source_note_candidate: source-notes/ghs-fua-modelled-functional-regions.md

minimal_source_bundle:
  boundary_source: GHS-FUA polygon and FUA identifier
  population_denominator_source: GHS-POP gridded population reconciled to GHS-FUA polygon
  first_outcome_source_family: basic scheduled public-transport source discovery or non-transit network/accessibility smoke test
  service_or_network_source:
    - SPTrans developer GTFS / Olho Vivo API leads
    - EMTU open-data API / GTFS leads
    - OSM street network
  expected_vintage_fields:
    - GHS_FUA_vintage
    - urban_centre_reference_year
    - GHS_POP_release
    - GHS_POP_target_year
    - SPTrans_feed_or_API_date
    - EMTU_feed_or_API_date
    - OSM_extract_date
    - formal_operator_coverage_notes
    - registration_or_access_constraints

readiness_gate_preview:
  boundary_source_eligibility: eligible_only_as_modelled_functional_region_if_exact_GHS_FUA_row_verified
  source_verification: GHS-FUA system verified; exact row not extracted
  boundary_fit: high-risk; must compare modelled 2015 boundary with current built-up and official statistical context
  data_bundle_plausibility: plausible_but_high_missingness_and_access_risk
  evidence_manifest_need:
    - GHS-FUA polygon archive
    - GHS-POP raster/version note
    - SPTrans/EMTU feed/API evidence
    - registration/access notes
    - formal/informal service coverage caveat
  candidate_universe_guardrail: >
    Keep only as a modelled-boundary source-system stress test; reject if future
    rationale depends on São Paulo's size, fame, congestion, or expected outcomes.

risk_notes:
  boundary_risks:
    - GHS-FUA is modelled, not observed commuting-flow geometry.
    - Boundary is anchored to 2015 urban-centre functional-area modelling.
    - Rapid urban growth may make boundary-vintage risk material.
  data_alignment_risks:
    - Formal GTFS/API sources may not cover all relevant public-transport services.
    - Registration or API-access constraints may block reproducibility.
    - Population grid vintage must be reconciled with boundary vintage.
  reputation_selection_risks:
    - High quarantine risk if justified by megacity status, congestion reputation, or perceived transport performance.
  missingness_risks:
    - Exact GHS-FUA row not yet extracted.
    - Full service-source coverage unknown.
    - Feed access and licensing not fully verified.
  source_rich_region_bias_risks:
    - Modelled global boundaries may be easier to obtain than observed local functional boundaries but less behaviorally valid.

recommended_next_action: >
  Extract the exact GHS-FUA row and GHS-POP denominator; separately verify SPTrans
  and EMTU feed/API access, licensing, and coverage before any readiness admission.
```

Source support:

- GHS-FUA R2019A — Functional Urban Areas: https://data.europa.eu/data/datasets/jrc-ghsl-ghs_fua_r2019a
- GHS-FUA info page: https://human-settlement.emergency.copernicus.eu/ghs_fua.php
- GHS-POP R2023A — Gridded population: https://data.jrc.ec.europa.eu/dataset/2ff68a52-5b5b-4a22-8f40-c41da8332cfe
- SPTrans Developer Area: https://www.sptrans.com.br/desenvolvedores/
- EMTU open-data / API-GTFS lead: https://www.emtu.sp.gov.br/emtu/noticias/noticia/emtu-lanca-dados-abertos-para-consulta-de-transportes-coletivos.fss

---

## 4. Rejected / quarantined leads and why

| Lead | Status | Reason |
|---|---|---|
| HSL operating area as primary boundary | Rejected as primary denominator | Transport authority/service geography is not an eligible primary MTR boundary under the prompt. It may be used as an overlay or service-source layer only. |
| France national access point dataset geography as primary boundary | Rejected as primary denominator | A transport data catalog or service dataset is not a functional-region boundary. It can support the service/network bundle only. |
| NaPTAN stop coverage area or BODS feed coverage as MTR boundary | Rejected as primary denominator | Stop/timetable coverage is service-derived and can hide unserved populations. It is an indicator input only. |
| FTA/NTD GTFS Weblinks or National Transit Map as MTR boundary | Rejected as primary denominator | GTFS/feed inventory is service-derived. It is suitable for service-completeness overlays and indicator inputs, not denominators. |
| GHSL Urban Centre Database or GHS-SMOD urban centre alone | Quarantined | Built-up urban cores are useful urban-form overlays but are not full MTR commuting catchments. |
| NASA/SEDAC SDG 11.2.1 urban-access geography | Quarantined | Accessibility dataset geography is an external validation or indicator-method source, not a primary MTR boundary. |
| Transport for London / fare-zone boundary as standalone MTR denominator | Quarantined | Governance/fare/service boundary may be important context but is not automatically the functional MTR. It would need an eligible FUA/commuting/statistical boundary lead. |
| Dubai–Sharjah–Ajman from service/governance sources only | Quarantined | Potentially important later, but this return does not have a verified eligible primary boundary source row. A modelled GHS-FUA or official statistical source would need separate verification. |
| Any “best transit city” or “most congested city” lead | Rejected | Outcome-adjacent selection violates the source-led guardrail in the prompt. |

---

## 5. Source list with URLs

```text
OECD — Definition of Cities and Functional Urban Areas
https://www.oecd.org/en/data/datasets/oecd-definition-of-cities-and-functional-urban-areas.html

Eurostat GISCO — Cities and Functional Urban Areas geodata
https://ec.europa.eu/eurostat/web/gisco/geodata/statistical-units/cities-functional-urban-areas

GHS-FUA R2019A — Functional Urban Areas
https://data.europa.eu/data/datasets/jrc-ghsl-ghs_fua_r2019a
https://human-settlement.emergency.copernicus.eu/ghs_fua.php

GHS-POP R2023A — Gridded population
https://data.jrc.ec.europa.eu/dataset/2ff68a52-5b5b-4a22-8f40-c41da8332cfe

HSL Open Data
https://www.hsl.fi/en/hsl/open-data

HSL / Digitransit GTFS-RT documentation
https://digitransit.fi/en/developers/apis/4-realtime-api/

France National Access Point for transport open data
https://transport.data.gouv.fr/

ONS Travel to Work Area analysis in Great Britain
https://www.ons.gov.uk/employmentandlabourmarket/peopleinwork/employmentandemployeetypes/articles/traveltoworkareaanalysisingreatbritain/2016

ONS Open Geography Portal — Travel to Work Areas boundaries
https://geoportal.statistics.gov.uk/datasets/ons::travel-to-work-areas-december-2011-boundaries-uk-bsc-v3

NaPTAN
https://naptan.dft.gov.uk/

DfT Bus Open Data Service
https://www.bus-data.dft.gov.uk/

USDA ERS — Commuting Zones and Labor Market Areas
https://www.ers.usda.gov/data-products/commuting-zones-and-labor-market-areas

FTA/NTD — GTFS Weblinks
https://catalog.data.gov/dataset/2023-ntd-annual-data-general-transit-feed-specification-gtfs-weblinks

Statistics Canada — CMA/CA illustrated glossary
https://www150.statcan.gc.ca/n1/pub/92-195-x/2021001/geo/cma-rmr/cma-rmr-eng.htm

Statistics Canada — CMA/CA delineation rules
https://www150.statcan.gc.ca/n1/pub/92f0138m/92f0138m2019002-eng.htm

Statistics Canada — CMA/CA population estimates table
https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1710014801

Calgary Transit Scheduling Data
https://data.calgary.ca/Transportation-Transit/Calgary-Transit-Scheduling-Data-GTFS-Static/npk7-z3bj

ABS — Australian Statistical Geography Standard
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/latest-release

ABS — Greater Capital City Statistical Areas
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/main-structure-and-greater-capital-city-statistical-areas/greater-capital-city-statistical-areas

ABS — Digital boundary files
https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/latest-release/digital-boundary-files

Victoria DTP — GTFS schedule data
https://discover.data.vic.gov.au/dataset/ptv-timetable-and-geographic-information-2015-gtfs

OMB — 2020 standards for Core Based Statistical Areas
https://www.federalregister.gov/documents/2021/07/16/2021-15159/2020-standards-for-delineating-core-based-statistical-areas

U.S. Census — Metropolitan and micropolitan areas
https://www.census.gov/programs-surveys/geography/guidance/geo-areas/metro-micro.html

U.S. Census — CBSA boundary file
https://www2.census.gov/geo/tiger/GENZ2023/shp/cb_2023_us_cbsa_5m.zip

SPTrans Developer Area
https://www.sptrans.com.br/desenvolvedores/

EMTU open-data / API-GTFS lead
https://www.emtu.sp.gov.br/emtu/noticias/noticia/emtu-lanca-dados-abertos-para-consulta-de-transportes-coletivos.fss
```

---

## 6. Open questions for Thesis 2

1. **Exact row extraction standard:** Should a proposal remain `research_lead_only` until the exact boundary row/code is extracted and archived, even if the source system is verified?
2. **Vintage threshold:** What is the maximum allowable vintage gap for observed commuting boundaries, especially ONS TTWAs based on 2011 flows and GHS-FUA based on 2015 modelling?
3. **Post-2020 commuting caveat:** Should every commuting-flow boundary receive a standard remote-work/post-pandemic caveat, or only boundaries whose source data are from 2020–2021?
4. **Boundary fit test:** What formal overlay checks should be required before admitting official statistical metros, county-based CBSAs, CMAs, GCCSAs, or CZs as MTR denominators?
5. **Service-source completeness threshold:** What minimum operator/service coverage is required before a public-transport feed bundle is considered plausible for a first method test?
6. **Registration-limited data:** Should sources requiring API registration, such as some developer portals, be admissible if documentation is public but raw feed access is gated?
7. **Modelled-boundary admissibility:** Should GHS-FUA proposals require a stronger evidence burden than observed FUAs, such as comparison with GHSL built-up extents, national statistics, and service-source coverage?
8. **Source-rich-region bias:** How should the project prevent data availability from becoming a proxy for transport quality or candidate importance?
9. **Population denominator hierarchy:** Should population denominators prefer official statistical population where available, gridded population for cross-boundary harmonization, or both with reconciliation notes?
10. **Next intake step:** Should Codex process this return first into source notes, or first into a proposal-readiness matrix using the boundary candidate readiness checklist?

---

## Suggested raw artifact path

```text
theses/mobility-conversion/research-artifacts/raw/2026-07-01-source-led-mtr-boundary-source-bundle-proposals.md
```

## Suggested follow-on artifacts

```text
theses/mobility-conversion/source-notes/eurostat-oecd-functional-urban-areas.md
theses/mobility-conversion/source-notes/uk-ons-travel-to-work-areas.md
theses/mobility-conversion/source-notes/usda-ers-commuting-zones.md
theses/mobility-conversion/source-notes/statcan-cma-ca-boundaries.md
theses/mobility-conversion/source-notes/abs-gccsa-asgs-functional-regions.md
theses/mobility-conversion/source-notes/us-omb-cbsa-msa-boundaries.md
theses/mobility-conversion/source-notes/ghs-fua-modelled-functional-regions.md
theses/mobility-conversion/research/source-led-proposal-readiness-matrix.md
```
