# Source Note: GHS Functional Urban Areas

Date inspected: 2026-06-28

Verification status: directly inspected official GHSL / European Commission
page.

Source:

- European Commission, Global Human Settlement Layer, "GHS-FUA R2019A"
- URL: `https://human-settlement.emergency.copernicus.eu/ghs_fua.php`

## Source Authority

European Commission / Joint Research Centre, Global Human Settlement Layer.

## What The Source Defines

GHS-FUA R2019A defines global functional urban areas for epoch 2015.

The source describes the product as functional urban areas derived from
GHS-UCDB R2019A urban centres and says the areas represent the commuting areas
of 2015 urban centres.

## Boundary Basis

Classification:

- boundary family: functional urban area;
- observed or modelled: modelled / estimated;
- basis type: travel time to urban centres, urban-centre area, local population,
  and country GDP per capita;
- spatial unit: 1 km grid;
- coordinate system: World Mollweide;
- epoch: 2015;
- geographic coverage: global.

The source states that the 2015 FUAs are estimated through an automated
classification procedure developed with the OECD, not directly observed from
global commuting-flow data.

## Data Availability

The source provides:

- product page;
- JRC data catalogue link;
- download link;
- detailed information link;
- DOI / PID listed through the GHSL datasets page.

## Relevance To Mobility Conversion

GHS-FUA is useful because it offers global functional-region coverage where
observed commuting-flow FUAs may not exist.

It may help avoid using only built-up urban cores as a fallback, especially in
countries without harmonized observed FUA systems.

## Limitations

- It is modelled, not observed commuting-flow geography.
- It represents epoch 2015, which may be stale for fast-growth regions.
- Inputs include country GDP per capita, which creates a special risk for
  Mobility Conversion because economic capacity is an explanatory axis.
- It is tied to urban centres, so it may inherit urban-core delineation issues.
- It should not be treated as equivalent to OECD/Eurostat observed FUAs.

## Suitability Judgment

Suitability: `candidate_fallback_boundary` and `candidate_validation_layer`.

Boundary confidence class:

- `modelled_functional_region`.

## Methodology Implication

GHS-FUA should remain separate from observed functional regions. It may be used
as a fallback or validation layer where observed commuting-flow boundaries are
unavailable, but it should carry lower boundary confidence and explicit vintage
and model-input caveats.
