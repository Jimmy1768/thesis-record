# Source Note: MobilityData GTFS

Date inspected: 2026-06-28

Verification status: directly inspected official GTFS / MobilityData
documentation.

Sources:

- MobilityData / GTFS, "What is GTFS?"
- URL: `https://gtfs.org/getting-started/what-is-gtfs/`
- MobilityData / GTFS, "GTFS Schedule Reference"
- URL: `https://gtfs.org/documentation/schedule/reference/`

## Source Authority

MobilityData-maintained GTFS documentation.

## What The Source Defines

GTFS is a standardized data format for public transit agencies to describe
service details, including schedules, stops, fares, routes, and geographic
transit details.

GTFS has two main parts:

- GTFS Schedule;
- GTFS Realtime.

GTFS Schedule contains service, fare, schedule, route, and geographic transit
details in text files. GTFS Realtime adds trip updates, vehicle positions, and
service alerts.

## Boundary Basis

Classification:

- boundary family: service-derived data source;
- observed or modelled: agency-published schedule and service data;
- basis type: stops, routes, trips, stop times, calendars, fares, shapes,
  frequencies, pathways, service alerts, vehicle positions, and related transit
  service files;
- spatial unit: stops, shapes, route geometries, service calendars, and feed
  records;
- geographic coverage: wherever agencies publish GTFS;
- update cadence: agency/feed specific.

## Data Availability

GTFS data availability depends on agency publication. The specification defines
file structures, not regional completeness.

## Relevance To Mobility Conversion

GTFS is highly relevant for usable-access indicators:

- service coverage;
- service span;
- route and stop geography;
- frequency and scheduled availability;
- transfer and pathway data where supplied;
- fare data where supplied;
- accessibility-related feed fields where supplied;
- disruption/reliability context when paired with GTFS Realtime.

## Limitations

- GTFS is not an MTR boundary definition.
- GTFS coverage depends on agencies publishing feeds.
- A feed can omit operators, modes, informal services, paratransit, roads,
  walking, cycling, private vehicle access, or non-fixed-route services.
- Feed presence can reflect data publication capacity, not actual access.
- Deriving a boundary from stops, routes, or service catchments can hide
  unserved populations by excluding them from the denominator.

## Suitability Judgment

Suitability: `indicator_input_only`.

Boundary confidence class:

- `service_derived_boundary` if someone derives a catchment from GTFS, but this
  class should not be accepted as an MTR denominator.

## Methodology Implication

GTFS should be used to measure service availability and completeness inside a
separately defined MTR boundary. It should not define the MTR boundary itself.
