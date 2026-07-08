# Source Note: OECD Functional Urban Areas

Date inspected: 2026-06-28

Verification status: directly inspected official OECD page.

Source:

- OECD, "OECD Definition of Cities and Functional Urban Areas"
- URL: `https://www.oecd.org/en/data/datasets/oecd-definition-of-cities-and-functional-urban-areas.html`

## Source Authority

Organisation for Economic Co-operation and Development.

## What The Source Defines

The OECD page defines cities and functional urban areas for cross-country city
comparison.

The page says comparing cities across countries requires geographical
definitions that account for city areas of influence. It describes FUAs as
capturing meaningful connections between cities and surrounding areas.

## Boundary Basis

Classification:

- boundary family: functional urban area;
- observed or modelled: mixed family; OECD FUAs use density and travel-to-work
  flows, while estimated FUAs are a separate modelled global product;
- basis type: population density, cell contiguity, and workplace commuting;
- spatial unit: cities and FUAs, with downloadable boundaries indicated by the
  OECD page;
- geographic coverage: OECD FUA dataset plus separate worldwide estimated FUA
  discussion.

The OECD page states that the degree of urbanisation defines cities based on
population density and cell contiguity, while the FUA definition expands city
boundaries to include areas economically connected by workplace commuting.

## Geometry / Data Availability

The page links to:

- the OECD cities and functional urban areas database;
- a list of FUAs by country;
- boundary shapefiles for cities;
- boundary shapefiles for FUAs.

## Relevance To Mobility Conversion

OECD FUAs are a strong source family for a behavioral-validity-first MTR
boundary because they include the area of influence around a city rather than
only the city-proper administrative unit.

They support the thesis position that the MTR unit should begin from functional
travel geography where source quality allows.

## Limitations

- The primary behavior captured is workplace commuting, not all-purpose daily
  mobility.
- OECD coverage is not global.
- The OECD page distinguishes estimated FUAs for countries without commuting
  data; those should not be treated as equivalent to observed FUA boundaries.
- The page itself is a dataset landing page; detailed methodology for estimated
  FUAs points to separate sources that still require inspection.

## Suitability Judgment

Suitability: `candidate_primary_boundary` where OECD observed FUA boundaries
exist and are current enough for the research purpose.

Boundary confidence class:

- `observed_functional_region` for OECD observed FUAs;
- `modelled_functional_region` for estimated FUAs, pending separate inspection.

## Methodology Implication

OECD FUAs support the current behavioral-validity-first stance, but only with a
confidence split between observed FUAs and estimated/modelled FUAs.
