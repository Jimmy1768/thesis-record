# Tier 1 Outcome Source-Family Scan

Date: 2026-06-28

Status: formation-stage source-family scan. No outcome metric is accepted. No
metric record is filled. No score, ranking, or comparison is authorized.

## Purpose

Identify candidate source families for the five Tier 1 usable-access outcome
dimensions:

1. access to opportunities;
2. network coverage and service availability;
3. travel time and reliability;
4. transportation safety;
5. affordability.

This scan prepares source verification work. It does not create evidence,
accepted metrics, weights, or metric records.

## Sources Inspected

Initial direct inspection covered:

- UN SDG indicator 11.2.1 metadata, custodian UN-Habitat;
- GTFS Schedule reference;
- GTFS Realtime reference;
- U.S. Census LEHD / LODES data pages;
- WHO Global status report on road safety 2023 page;
- NHTSA FARS Encyclopedia page;
- U.S. BLS Consumer Expenditure Surveys page;
- Eurostat Household Budget Surveys page.

Relevant existing Thesis 2 source notes:

- `theses/mobility-conversion/research/source_notes/mobilitydata_gtfs_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/fta_ntd_gtfs_weblinks_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/bts_national_transit_map_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/transitland_feed_registry_2026-06-28.md`

## Cross-Dimension Finding

No single source family can measure usable access.

Tier 1 outcome measurement will require linked source families:

- opportunity inventories;
- population denominators;
- transport network and service supply;
- travel-time or reliability data;
- safety events and exposure denominators;
- fare and household cost data;
- income or distribution data;
- MTR boundary crosswalks.

This reinforces the broad-framework decision: missingness and boundary
alignment must be visible.

## Dimension Scan

### 1. Access To Opportunities

Candidate source families:

- employment-location datasets;
- education, healthcare, grocery, public-service, and civic destination
  registries;
- land-use or point-of-interest datasets;
- transport network models using GTFS, road/street networks, and walking or
  cycling networks;
- accessibility model outputs from official, academic, or public-sector
  methods.

Inspected source lead:

- U.S. Census LEHD / LODES for U.S. job-location and residence-workplace data.

Initial suitability:

- strong for U.S. job access and worker-flow context;
- not globally comparable;
- job access should not become the whole opportunity dimension;
- administrative job data may miss informal work and non-work opportunities.

Likely metric concepts to test later:

- jobs reachable within time thresholds by mode;
- essential services reachable within time thresholds;
- opportunity bundle reachable within time, cost, and physical-access
  constraints.

Immediate verification need:

- identify source families for non-job opportunities;
- decide whether first access-to-opportunities verification starts with jobs or
  with a broader opportunity bundle;
- inspect at least one official or authoritative multi-opportunity
  accessibility method before filling metric records.

### 2. Network Coverage And Service Availability

Candidate source families:

- UN-Habitat / SDG 11.2.1 public transport access methodology;
- GTFS Schedule feeds;
- national GTFS inventories and processed service catalogs;
- agency schedules and route/stop data;
- OpenStreetMap or official street-network data for walking catchments;
- population grid or census denominator data.

Inspected source leads:

- SDG indicator 11.2.1 metadata;
- GTFS Schedule reference;
- existing GTFS / Transitland / FTA / BTS source notes.

Initial suitability:

- SDG 11.2.1 is a strong source-family precedent for public-transport access
  coverage;
- GTFS Schedule can support service presence, frequency, span, stops, routes,
  transfers, and scheduled travel-time inputs;
- GTFS and service catalogs remain indicator inputs, not MTR denominators;
- stop-distance coverage alone is insufficient for "usable" access.

Likely metric concepts to test later:

- population within network walking distance of public transport;
- population near frequent service;
- service span and frequency by MTR subarea;
- mode-specific service availability.

Immediate verification need:

- create a direct source note for SDG 11.2.1;
- decide whether SDG 11.2.1 is coverage/service only or also a partial access
  indicator;
- preserve the limitation that "convenient access" needs quality criteria
  beyond stop distance.

### 3. Travel Time And Reliability

Candidate source families:

- GTFS Schedule for scheduled travel times, transfers, service calendars, and
  headway-based service;
- GTFS Realtime for trip updates, vehicle positions, service alerts, delay, and
  cancellation signals;
- agency AVL/APC and operations data;
- household or travel surveys for experienced travel time;
- census commuting data for work-trip travel time;
- road speed or probe datasets, where source and method are inspectable.

Inspected source leads:

- GTFS Schedule reference;
- GTFS Realtime reference;
- existing Census commuting source notes.

Initial suitability:

- GTFS Schedule is strong for scheduled public transport analysis where feeds
  are complete and current;
- GTFS Realtime can support delay and disruption analysis where feed quality is
  stable;
- census commute-time data is useful but work-trip-only and subject to
  post-2020 caveats;
- road probe datasets may be useful but many are proprietary or opaque.

Likely metric concepts to test later:

- scheduled travel time to opportunity classes;
- wait-time burden from headways;
- transfer burden;
- service disruption frequency;
- schedule adherence or delay where GTFS Realtime is archived.

Immediate verification need:

- inspect GTFS Realtime as a reliability source family;
- define minimum feed quality for reliability analysis;
- decide how to handle car travel-time sources without turning the outcome into
  congestion reputation.

### 4. Transportation Safety

Candidate source families:

- national and local crash databases;
- road fatality and serious-injury databases;
- transit safety incident databases;
- police-reported collision data;
- road safety observatories;
- exposure denominators such as population, trips, vehicle-km, walking/cycling
  volume, or mode share.

Inspected source leads:

- WHO Global status report on road safety 2023;
- NHTSA FARS;
- ITF / IRTAD lead identified but not directly inspected because the ITF page
  blocked direct fetch during this scan.

Initial suitability:

- WHO is useful for national context and global comparability, not direct MTR
  outcome measurement;
- FARS is strong for U.S. fatal-crash data but fatality-only and U.S.-specific;
- MTR safety measurement requires local or regional geocoded crash and exposure
  data where possible;
- safety sources often miss perceived safety, harassment, gendered constraints,
  and suppressed walking/cycling demand.

Likely metric concepts to test later:

- fatalities and serious injuries per population;
- pedestrian/cyclist fatalities and injuries per population or exposure;
- transit safety incidents per passenger or vehicle-km;
- safety events mapped to MTR boundary.

Immediate verification need:

- inspect source families for city/regional road-safety data, not only national
  data;
- inspect transit safety reporting sources separately from road crash sources;
- decide how to treat perceived safety and underreporting.

### 5. Affordability

Candidate source families:

- household budget and expenditure surveys;
- agency fare tables and fare policy documents;
- GTFS Fares / Fares v2 where implemented;
- income distribution data;
- car ownership and operating-cost datasets;
- housing plus transportation cost datasets, where methods are inspectable.

Inspected source leads:

- U.S. BLS Consumer Expenditure Surveys;
- Eurostat Household Budget Surveys;
- GTFS Schedule fare tables.

Initial suitability:

- household expenditure surveys are strong for transport-cost burden but may not
  align with MTR boundaries;
- fare tables measure nominal prices but not affordability by income;
- GTFS fare data can support fare calculation where implemented, but fare
  coverage is optional and uneven;
- car-dependency costs are essential for some MTRs but harder to compare.

Likely metric concepts to test later:

- transport expenditure as share of household income;
- public transport fare burden by income group;
- cost of access to opportunity bundle;
- car-dependency cost burden where car travel is structurally necessary.

Immediate verification need:

- inspect household expenditure survey comparability and geography;
- inspect fare-data completeness in GTFS Fares / Fares v2;
- decide whether affordability must include car costs from the first candidate
  methodology.

## Formation-Stage Source-Family Priorities

Priority 1: SDG 11.2.1 / UN-Habitat public transport access.

Reason:

- directly relevant to coverage/service availability;
- official global monitoring framework;
- includes vulnerable population language, informal transport caveats, and
  quality limitations;
- provides a useful warning that stop-distance access is not enough.

Priority 2: GTFS Schedule and GTFS Realtime as service/travel-time source
families.

Reason:

- already relevant to coverage, service availability, travel time, reliability,
  and fares;
- strong source family where feeds are complete;
- high risk of source-rich and formal-service bias.

Priority 3: safety source families.

Reason:

- safety is Tier 1 but data are fragmented;
- national data may not map to MTRs;
- local crash and exposure denominators require early standards.

Priority 4: affordability source families.

Reason:

- affordability is central to usable access but cannot be inferred from fares
  alone;
- expenditure and income geographies may not align with MTRs.

Priority 5: access-to-opportunities source families.

Reason:

- conceptually central but source composition is complex;
- a good metric requires opportunity data, network data, travel-time modeling,
  denominator choices, and distributional treatment.

## What This Scan Does Not Authorize

This scan does not authorize:

- filling metric records;
- accepting metrics;
- calculating scores;
- comparing MTRs;
- using transit service coverage as the full outcome;
- treating road safety national data as MTR safety performance;
- treating household transport expenditure as MTR affordability without
  boundary review.

## Verification Follow-Up

Batch O1 inspected:

- UN SDG 11.2.1 metadata;
- GTFS Schedule as outcome input;
- GTFS Realtime as outcome input;
- GTFS Fares / Fares v2 as affordability input.

Batch O1 output:

- `theses/mobility-conversion/research/batch_o1_outcome_source_verification_summary_2026-06-28.md`

Next verification batch:

- Batch O2 source verification for safety, affordability, and
  access-to-opportunities source families.
