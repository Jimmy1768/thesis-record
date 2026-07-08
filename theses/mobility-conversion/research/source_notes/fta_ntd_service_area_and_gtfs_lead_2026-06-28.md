# Source Note: FTA NTD Service Area And GTFS Lead

Date inspected: 2026-06-28

Verification status: partial. Directly inspected official FTA NTD glossary for
service-area, fixed-route, demand-response, and service-supplied definitions.
The specific "NTD GTFS weblinks" dataset remains a source lead requiring later
inspection.

Source:

- Federal Transit Administration, "National Transit Database (NTD) Glossary"
- URL: `https://www.transit.dot.gov/ntd/national-transit-database-ntd-glossary`

## Source Authority

U.S. Federal Transit Administration.

## What The Source Defines

The inspected NTD glossary defines service concepts relevant to the
service-derived boundary guardrail:

- fixed route services;
- demand response;
- service area;
- service area for bus;
- service area for demand response;
- service area for rail;
- service supplied.

The glossary treats service area as a measure of access to transit service in
terms of population served and area coverage. It also states that reporting
transit agencies determine service area boundaries and population for most
services using ADA-derived definitions.

## Boundary Basis

Classification:

- boundary family: service area / reporting geography;
- observed or modelled: reporter-defined service geography;
- basis type: agency-reported access/service area definitions;
- spatial unit: service area, route corridor, station radius, or demand-response
  area depending on service type;
- geographic coverage: U.S. NTD reporting context.

## Relevance To Mobility Conversion

The NTD glossary is useful because it shows why service areas must be handled
carefully:

- service area is an access/service measure, not a metropolitan boundary;
- service area rules vary by mode;
- demand-response service areas are not route corridors;
- agency reporting boundaries may not match functional travel regions.

## Limitations

- This note does not verify a specific NTD GTFS weblinks dataset.
- NTD service area is U.S.-specific.
- Service area is reporter-defined and mode-specific.
- Service area can be narrower than the MTR and can exclude unserved
  populations.
- It should not be used as a general MTR denominator.

## Suitability Judgment

Suitability: `indicator_input_only` and `candidate_overlay`.

Boundary confidence class:

- `service_derived_boundary` if used as a service-area geography;
- not acceptable as primary MTR boundary.

## Methodology Implication

FTA NTD service-area definitions strengthen the guardrail that service-derived
or agency-reported service areas should not define the MTR denominator. They can
support service coverage and service-completeness checks inside a separately
defined MTR.

## Open Verification Item

Locate and inspect the specific FTA or BTS source for public GTFS web links /
National Transit Map feed inventory before relying on claims about GTFS web link
coverage, reporting requirements, or update cadence.
