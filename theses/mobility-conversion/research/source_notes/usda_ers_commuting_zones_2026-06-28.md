# Source Note: USDA ERS Commuting Zones

Date inspected: 2026-06-28

Verification status: directly inspected official USDA ERS data product and
documentation.

Sources:

- USDA Economic Research Service, "Commuting Zones and Labor Market Areas"
- URL: `https://www.ers.usda.gov/data-products/commuting-zones-and-labor-market-areas/`
- USDA Economic Research Service, "Commuting Zones and Labor Market Areas -
  Documentation"
- URL: `https://www.ers.usda.gov/data-products/commuting-zones-and-labor-market-areas/documentation`

## Source Authority

U.S. Department of Agriculture, Economic Research Service.

## What The Source Defines

USDA ERS Commuting Zones are county-based labour-market geographies intended to
identify functional rural labour markets and local economies.

The inspected 2020 product groups U.S. and Puerto Rico counties and
county-equivalents into distinct labour markets based on commuting flows.

## Boundary Basis

Classification:

- boundary family: commuting zone / labour-market area;
- observed or modelled: observed/statistical clustering;
- basis type: county-to-county commuting flows, proportional flow metric,
  hierarchical clustering, and contiguity constraint;
- spatial unit: counties and county-equivalents;
- geographic coverage: United States and Puerto Rico for 2020 product;
- source vintage: 2020 Commuting Zones, updated by ERS in 2026;
- input data: 2016-2020 ACS commuting flows, 2020 Census DHC, and county
  adjacency files.

ERS states that the 2020 product groups 3,222 counties and county-equivalents
into 598 commuting zones.

## Relevance To Mobility Conversion

ERS Commuting Zones are strong evidence that nationally produced
commuting-derived regions can be more behaviorally meaningful than county or
metro statistical boundaries, especially outside large metropolitan cores.

They also provide quality-oriented metadata through containment measures,
which is directly useful for Mobility Conversion's boundary confidence design.

## Limitations

- The product is designed around labour markets, not full all-purpose transport
  access.
- County building blocks are coarse for urban transport access.
- ERS documents that real labour markets overlap, while CZs force a discrete
  partition.
- The clustering threshold inherits methodological choices from prior work
  rather than a universal transport-access principle.
- ACS commuting-flow estimates can carry sampling error, especially in small
  counties.
- The 2020 product uses 2016-2020 ACS commuting data and therefore requires the
  pandemic/remote-work caveat created in Batch 2B.

## Suitability Judgment

Suitability: `candidate_validation_layer` or `candidate_fallback_boundary`.

Boundary confidence class:

- `national_commuting_zone`;
- with commute-derived caveat metadata required.

## Methodology Implication

ERS Commuting Zones should not replace metropolitan MTR boundaries wholesale.
They are better used to test whether an official metro boundary is too narrow,
too broad, or badly aligned with labour-market integration.

For U.S. cases, they can also help identify rural or exurban portions of the
transport region that a CBSA or transit-service boundary may miss.
