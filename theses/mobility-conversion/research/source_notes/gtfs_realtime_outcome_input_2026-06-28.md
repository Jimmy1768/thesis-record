# Source Note: GTFS Realtime As Outcome Input

Date inspected: 2026-06-28

Verification status: directly inspected official GTFS Realtime documentation.

Sources:

- MobilityData / GTFS, "GTFS Realtime Reference"
- URL: `https://gtfs.org/documentation/realtime/reference/`
- Existing Thesis 2 source note:
  `theses/mobility-conversion/research/source_notes/mobilitydata_gtfs_2026-06-28.md`

## Source Authority

MobilityData-maintained GTFS Realtime documentation.

## What The Source Defines

GTFS Realtime defines a structured format for real-time public transport
information.

For Thesis 2 outcome work, relevant entities include:

- trip updates;
- vehicle positions;
- service alerts;
- feed headers and timestamps;
- entity identifiers that connect real-time records to scheduled service.

## Outcome Dimension Fit

Primary fit:

- travel time and reliability.

Secondary fit:

- network coverage and service availability, where cancellations and alerts
  indicate unavailable scheduled service;
- asset condition and resilience, where disruption records can be linked to
  infrastructure or shock events;
- access to opportunities, only when real-time conditions affect modeled access.

## Usefulness For Mobility Conversion

GTFS Realtime can help distinguish scheduled access from delivered or disrupted
access.

It can support later proposed metrics such as:

- delay frequency;
- cancellation signals;
- service-alert burden;
- real-time disruption exposure;
- difference between scheduled and observed service;
- reliability by corridor, route, mode, or subarea.

## Limitations

- GTFS Realtime availability is uneven and often optional.
- Live feeds do not automatically provide historical archives.
- Feed quality, update cadence, timestamp accuracy, and entity consistency must
  be validated.
- Some feeds publish limited entities, incomplete alerts, or no vehicle
  positions.
- Reliability analysis requires a collection window and an archival method.
- Real-time data can overrepresent source-rich formal operators.

## Suitability Judgment

Suitability: `indicator_source_family`.

Candidate outcome dimensions:

- `travel_time_and_reliability`;
- `network_coverage_and_service_availability`, as a delivered-service modifier;
- `asset_condition_and_resilience`, as a disruption input only.

Not suitable as:

- MTR denominator;
- complete reliability metric without an archive;
- complete access outcome.

## Methodology Implication

GTFS Realtime should not be required for every candidate MTR during formation,
because that would bias the universe toward source-rich operators. It should be
treated as a high-value reliability source where archival quality and feed
coverage can be documented.
