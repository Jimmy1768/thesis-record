# Source Note: FTA / NTD GTFS Weblinks

Date inspected: 2026-06-28

Verification status: directly inspected official Data.gov / U.S. DOT data
catalog page and related FTA / Federal Register sources.

Sources:

- Data.gov, "2023 NTD Annual Data - General Transit Feed Specification (GTFS) Weblinks"
- URL: `https://catalog.data.gov/dataset/2023-ntd-annual-data-general-transit-feed-specification-gtfs-weblinks`
- DOT Data Portal, "General Transit Feed Specification Weblinks"
- URL: `https://data.transportation.gov/Public-Transit/General-Transit-Feed-Specification-Weblinks/2u7n-ub22/about_data`
- Federal Register, "National Transit Database: Reporting Changes and Clarifications"
- URL: `https://www.federalregister.gov/documents/2023/03/03/2023-04379/national-transit-database-reporting-changes-and-clarifications`
- FTA, "Recent NTD Developments - Frequently Asked Questions"
- URL: `https://www.transit.dot.gov/ntd/recent-ntd-developments-frequently-asked-questions-0`

## Source Authority

Federal Transit Administration / National Transit Database, distributed through
U.S. DOT / Data.gov and supported by FTA reporting requirements.

## What The Source Defines

The Data.gov page identifies the dataset as the 2023 NTD Annual Data - General
Transit Feed Specification Weblinks dataset.

The page says that as of Report Year 2023, FTA requires reporters with
fixed-route modes to create and maintain a public-domain GTFS dataset reflecting
their fixed-route service.

The page also identifies the most up-to-date weblinks dataset as a monthly
refreshed DOT data portal dataset.

## Boundary Basis

Classification:

- boundary family: GTFS/feed inventory;
- observed or modelled: observed agency-reported feed links;
- basis type: NTD reporter / mode / GTFS feed URL;
- spatial unit: agency, NTD reporter, fixed-route mode, GTFS feed;
- geographic coverage: United States NTD fixed-route reporting context;
- update cadence: catalog page says the current weblinks dataset is refreshed
  monthly; annual reporting certification also applies.

## Coverage Verified

The Data.gov page states that at least one GTFS weblink is provided by the
transit agency for each fixed-route bus mode and type of service, including rail
modes and bus, bus rapid transit, commuter bus, ferryboat, and trolleybus.

The same page states that demand response, vanpool, and other non-fixed-route
modes are excluded.

## Reporting Requirement Verified

The Federal Register final notice states that FTA adopted GTFS reporting as a
mandatory requirement for fixed-route service. It links the requirement to
geographic service area coverage reporting.

The FTA FAQ states that:

- only static GTFS links are required;
- GTFS Realtime feeds may be provided but are optional;
- regional GTFS feeds can satisfy the requirement if all services are
  represented for each NTD reporting agency;
- agencies certify annually that GTFS feeds are up to date.

The Federal Register notice also states that FTA expects agencies to maintain
accurate and up-to-date feeds throughout the year, while not requiring archival
or historical service information.

## Relevance To Mobility Conversion

This source is useful for:

- finding official U.S. GTFS feed links;
- authenticating U.S. fixed-route feed sources;
- service-completeness checks;
- identifying fixed-route coverage gaps and non-fixed-route exclusions;
- supporting service availability, frequency, span, and route/stop analysis
  inside independently defined MTRs.

## Limitations

- This is not an MTR boundary source.
- It is limited to U.S. NTD reporting.
- It excludes demand response, vanpool, and other non-fixed-route modes.
- Publicly hosted links can stop working.
- FTA does not manage the agency websites hosting many feeds.
- Annual certification and monthly data refresh do not guarantee real-time
  service accuracy.
- The current row count, live reachability, validation status, and complete
  current field list require a data/API fetch and archive step outside this
  source note.

## Suitability Judgment

Suitability: `indicator_input_only` and `candidate_overlay`.

Boundary confidence class:

- `service_derived_boundary`.

Not suitable as:

- `candidate_primary_boundary`;
- `candidate_fallback_boundary`;
- MTR denominator.

## Methodology Implication

The FTA / NTD GTFS Weblinks dataset closes the Batch 1C open item as the
authoritative U.S. GTFS feed-inventory source for fixed-route NTD reporters.

It should be stored separately from BTS National Transit Map because one is a
feed-link inventory and the other is a geospatial service catalog derived from
GTFS Schedule data.
