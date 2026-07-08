# Source Note: GTFS Schedule As Outcome Input

Date inspected: 2026-06-28

Verification status: directly inspected official GTFS Schedule documentation.

Sources:

- MobilityData / GTFS, "GTFS Schedule Reference"
- URL: `https://gtfs.org/documentation/schedule/reference/`
- Existing Thesis 2 source note:
  `theses/mobility-conversion/research/source_notes/mobilitydata_gtfs_2026-06-28.md`

## Source Authority

MobilityData-maintained GTFS Schedule documentation.

## What The Source Defines

GTFS Schedule defines a structured format for public transport schedule and
network data.

For Thesis 2 outcome work, the relevant file families include:

- agencies;
- stops and stations;
- routes;
- trips;
- stop times;
- service calendars and calendar exceptions;
- shapes;
- frequencies;
- transfers;
- pathways and accessibility-related station navigation where supplied;
- fare files where supplied.

## Outcome Dimension Fit

Primary fit:

- network coverage and service availability;
- travel time and reliability, for scheduled travel time and wait-time
  modelling.

Secondary fit:

- access to opportunities, when paired with destinations and population data;
- affordability, where fare files are complete enough;
- walking, cycling, and universal access, where pathways, location types, and
  accessibility fields are present.

## Usefulness For Mobility Conversion

GTFS Schedule is a core source family for scheduled public transport
availability inside an independently defined MTR boundary.

It can support later proposed metrics such as:

- stop and route availability;
- service span;
- scheduled frequency;
- scheduled travel time;
- transfer burden;
- headway-based waiting burden;
- service calendars and day-type availability;
- feed completeness checks.

## Limitations

- GTFS Schedule is not an MTR boundary source.
- Feed publication is uneven by agency, country, operator, and mode.
- Feeds may omit informal transport, paratransit, demand response, walking,
  cycling, roads, private vehicle access, and unpublished operators.
- Schedules are planned service, not necessarily delivered service.
- Feed validity, freshness, licensing, and archival availability must be
  checked before metric use.
- Accessibility and fare fields are optional or unevenly populated.

## Suitability Judgment

Suitability: `indicator_source_family`.

Candidate outcome dimensions:

- `network_coverage_and_service_availability`;
- `travel_time_and_reliability`;
- `access_to_opportunities`, only when linked to destinations and population;
- `affordability`, only where fare fields are usable.

Not suitable as:

- MTR denominator;
- complete access outcome;
- direct service-quality proof without delivered-service or reliability checks.

## Methodology Implication

GTFS Schedule should become a high-priority source family for outcome metric
testing, but every use must carry feed completeness, freshness, geography,
mode-coverage, and formal-service-bias metadata.
