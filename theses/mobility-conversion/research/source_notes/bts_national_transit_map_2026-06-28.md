# Source Note: BTS National Transit Map

Date inspected: 2026-06-28

Verification status: directly inspected official BTS and ROSA P pages.

Sources:

- Bureau of Transportation Statistics, "National Transit Map"
- URL: `https://www.bts.gov/national-transit-map`
- ROSA P, "National Transportation Atlas Database (NTAD): National Transit Map 2018-Present Dataset"
- URL: `https://rosap.ntl.bts.gov/view/dot/75925`

## Source Authority

U.S. Department of Transportation, Bureau of Transportation Statistics.

## What The Source Defines

The BTS page defines the National Transit Map as a nationwide catalog of
fixed-guideway and fixed-route transit service in the United States built from
GTFS Schedule data.

BTS states that the National Transit Map is a National Geospatial Data Asset
within the National Transportation Atlas Database.

## Boundary Basis

Classification:

- boundary family: service-derived geospatial catalog;
- observed or modelled: processed GTFS Schedule submissions;
- basis type: agencies, stops, routes, route geometries, GTFS Schedule files;
- spatial unit: agency, route, stop, and route geometry datasets;
- geographic coverage: United States fixed-guideway and fixed-route transit
  represented in BTS NTM data;
- update cadence: BTS page states quarterly updates.

## Data Products Verified

The BTS page identifies:

- NTM Agencies;
- NTM Routes;
- NTM Stops.

The page states that route data combine GTFS `routes.txt`, `trips.txt`, and
`shapes.txt`, while stop data use GTFS `stops.txt`.

The ROSA P archive page identifies the 2018-present NTM dataset and states that
it is compiled using GTFS Schedule data. The ROSA P page also says BTS adjusts
route spatial accuracy using submitted GTFS source data and/or other public
information.

## Relevance To Mobility Conversion

The NTM is useful for:

- U.S. service coverage overlays;
- stops and route geography;
- service-completeness checks;
- fixed-route transit inventory;
- historical comparison where archived releases are available.

## Limitations

- The NTM is not an MTR boundary source.
- It is a U.S. service-derived product.
- It is not intended for real-time trip planning or navigation.
- BTS warns that coverage and update frequency changed over time.
- Agencies can be missing from NTM releases if data are submitted between
  updates or are invalid for inclusion.
- Fixed-route and fixed-guideway transit data do not define the whole
  metropolitan access denominator.

## Suitability Judgment

Suitability: `indicator_input_only` and `candidate_overlay`.

Boundary confidence class:

- `service_derived_boundary`.

Not suitable as:

- `candidate_primary_boundary`;
- `candidate_fallback_boundary`;
- MTR denominator.

## Methodology Implication

The National Transit Map should be treated as a U.S. geospatial service catalog
derived from GTFS Schedule data. It should be separated from the FTA / NTD GTFS
Weblinks feed inventory in any source registry.

It can support service coverage and completeness analysis inside an
independently defined MTR.
