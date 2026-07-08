# Source Note: HSL / Digitransit Service Sources

Date inspected: 2026-07-01

Verification status: `directly_inspected_source_documentation`

Source:

- Title or dataset:
  - HSL Open data
  - Digitransit APIs
  - HSL GTFS-RT feeds
- Authority or publisher:
  - Helsinki Region Transport (HSL)
  - Digitransit, provided by HSL, Fintraffic, and Waltti Solutions Oy
- URL, DOI, document identifier, archive path, API endpoint, or access path:
  - `https://www.hsl.fi/en/hsl/open-data`
  - `https://digitransit.fi/en/developers/`
  - `https://digitransit.fi/en/developers/apis/`
  - `https://digitransit.fi/en/developers/apis/2-routing-data-api/`
  - `https://digitransit.fi/en/developers/apis/7-terms-of-use/`
  - `https://hsldevcom.github.io/gtfs_rt/`
- Release date, source vintage, or version:
  - HSL open-data page inspected 2026-07-01
  - Digitransit developer documentation inspected 2026-07-01
  - HSL GTFS-RT documentation inspected 2026-07-01

Status: independently inspected source note. This note does not admit an MTR,
accept an outcome metric, create an evidence manifest, authorize raw data
archiving, calculate scores, rank MTRs, or make final paper claims.

## Source Authority

HSL publishes open-data documentation and service data for its public transport
network. Digitransit documentation states that Digitransit is provided by HSL,
Fintraffic, and Waltti Solutions Oy.

## What The Source Defines

The inspected HSL and Digitransit documentation identifies these source
families:

- Journey Planner APIs for routing, geocoding, map data, and vehicle locations;
- static GTFS packages for HSL public transport network and timetables;
- GTFS-RT service alerts, trip updates, and vehicle positions;
- routing-data API files for OpenTripPlanner graph construction, including HSL
  GTFS and OSM-derived inputs;
- GIS portal cross-section datasets for stops, routes, fare zones, boardings,
  and related public-transport layers.

## Source Function For Mobility Conversion

- `service_or_network_source`
- `outcome_indicator_source_family`, only after a metric-specific method note
- `methodology_reference`

## Boundary / Denominator Role

- MTR boundary source: no.
- Resident-population denominator source: no.
- Overlay or input only: yes, service/network overlay after an independent MTR
  boundary is defined.
- Service-derived denominator risk: high if HSL service area, GTFS extent,
  route buffers, stop coverage, or fare zones are used to define the MTR.

## Outcome / Axis Role

- Outcome dimensions supported:
  - network coverage and service availability;
  - travel time and reliability, if routing and realtime sources are archived
    under a method note;
  - walking, cycling, and universal access only where fields are explicit and
    independently validated.
- Explanatory axes supported: governance fit only as context if HSL
  institutional coverage is separately documented; not from service data alone.
- Risk of confusing outcome with explanatory axis: high. HSL source richness
  should not be treated as proof of transport quality.

## Data Availability

- Geography: HSL region / Journey Planner deployment, not automatically the
  Eurostat/GISCO Helsinki FUA.
- Spatial unit:
  - GTFS routes, stops, trips, calendars, and stop times;
  - realtime feed entities;
  - OTP router datasets and graph inputs;
  - GIS portal point/line/polygon layers.
- Time period or release vintage:
  - HSL states public-transport-register data is parsed into GTFS format daily;
  - HSL states the GTFS extraction window is two months from extraction start;
  - HSL GTFS-RT documentation lists update intervals of 5 minutes or new alert
    publication for service alerts, 15 seconds for trip updates, and 1 second
    for vehicle positions;
  - GIS portal layers are cross-sections at a given point in time, with route
    network data aimed to update at least once a year around the summer/autumn
    service transition.
- Update frequency:
  - static GTFS: daily extraction per HSL open-data documentation;
  - GTFS-RT: high-frequency updates per HSL GTFS-RT documentation;
  - GIS portal: cross-sectional, less current than Journey Planner and API
    sources for some uses.
- Access method:
  - HSL open-data downloads and documentation;
  - Digitransit APIs, with registration and subscription key requirements for
    hosted APIs;
  - HSL GTFS-RT HTTP endpoints.
- License or usage constraint:
  - HSL open-data page states most listed HSL datasets/APIs are CC BY 4.0,
    with exceptions including OSM-derived data under ODbL and city-bike OD data
    owned by City Bike Finland;
  - Digitransit terms state Digitransit data is provided under CC BY 4.0, with
    OSM geography/address data controlled by ODbL;
  - registration/API-key requirements apply to hosted Digitransit APIs.

## Relevance To Mobility Conversion

This source family is suitable for a later Helsinki FUA service-overlay test
because it provides official static schedule, realtime, routing, and supporting
network-source paths.

It is not sufficient to establish the MTR denominator. The independent boundary
candidate is Eurostat/GISCO Helsinki FUA `FI001F`; HSL service sources must be
compared against that boundary rather than defining it.

## Service Source Review

```yaml
service_source_review:
  source_name: HSL / Digitransit service-source family
  source_authority: HSL; Digitransit providers HSL, Fintraffic, Waltti Solutions Oy
  source_url_or_access_path:
    - https://www.hsl.fi/en/hsl/open-data
    - https://digitransit.fi/en/developers/apis/
    - https://digitransit.fi/en/developers/apis/2-routing-data-api/
    - https://hsldevcom.github.io/gtfs_rt/
  format:
    - GTFS
    - GTFS-RT
    - GraphQL / API
    - OTP routing data files
    - GIS portal layers
  static_or_realtime: both
  publication_or_feed_date: unresolved until feed archive
  feed_validity_window: HSL GTFS documentation states two months from extraction start
  retrieval_or_inspection_date: 2026-07-01
  license_or_reuse_terms: CC BY 4.0 for listed HSL/Digitransit data, with OSM ODbL caveat
  registration_required: true for hosted Digitransit APIs
  authentication_required: true for hosted Digitransit APIs
  archive_required: true before metric use
  evidence_manifest_required: true before raw feed/archive use
  modes_covered: unresolved until GTFS/feed inspection
  operators_covered: unresolved until GTFS/feed inspection
  operators_missing_or_unknown: unresolved
  geography_covered: HSL service/Journey Planner geography, not accepted as FUA
  coverage_against_independent_mtr_boundary: unresolved
  unserved_population_visibility: unresolved
  non_fixed_route_or_informal_service_gaps: unresolved
  accessibility_fields_available: unresolved
  fare_fields_available: unresolved
  realtime_fields_available: documented for alerts, trip updates, vehicle positions
  validation_status: source_family_verified_not_evidence
  source_limitations:
    - service geography cannot define MTR denominator
    - API registration/key requirements affect reproducibility
    - OSM-derived routing inputs have separate ODbL licensing
    - feed validity and coverage require archive-stage inspection
  denominator_prohibited: true
```

## Limitations

- The source family is official and rich, but not equivalent to complete FUA
  service coverage.
- HSL service geography may be smaller than or differently shaped from the
  Eurostat/GISCO Helsinki FUA.
- Hosted Digitransit APIs require registration/API keys.
- Realtime data is current/volatile and cannot be reconstructed later unless
  archived under a manifest.
- GTFS schedule coverage does not reveal unserved populations unless compared
  to an independent boundary and population surface.
- OSM-derived routing inputs require ODbL handling.
- City-bike OD data has separate ownership and should not be folded into HSL
  service evidence without a separate source note.

## Suitability Judgment

Suitability: `candidate_indicator_source_family`

Rationale:

HSL/Digitransit is suitable as a candidate service/network source family for a
later Helsinki FUA method test. It remains unsuitable as a boundary or
population-denominator source.

## Methodology Implication

The Helsinki FUA lead can move from service `source_lead_only` to
`source_family_verified_not_evidence`, but not to readiness promotion.

Before any metric or boundary-record use, a later worker must:

- archive the relevant static GTFS package under an evidence manifest;
- record the feed extraction date and validity window;
- list modes and operators found in the feed;
- compare feed coverage against `FI001F`, not against HSL service geography;
- decide whether realtime feeds are needed or whether scheduled service is
  enough for the proposed metric;
- record license and attribution requirements.

## Next Allowed Output

Allowed:

- Helsinki lead service-trace decision note;
- evidence manifest draft if a raw GTFS or GTFS-RT archive is acquired later;
- service-coverage method test after independent boundary and denominator
  gates are satisfied.

## Prohibited Outputs

This source note does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- raw data archive without manifest.
