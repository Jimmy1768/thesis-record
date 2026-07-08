# Source Note: Eurostat Metropolitan Regions

Date inspected: 2026-06-28

Verification status: directly inspected official Eurostat page.

Source:

- Eurostat, "Territorial typologies manual - metropolitan regions"
- URL: `https://ec.europa.eu/eurostat/statistics-explained/index.php?title=Territorial_typologies_manual_-_metropolitan_regions`

## Source Authority

Eurostat, official statistical office of the European Union.

## What The Source Defines

Eurostat metropolitan regions are NUTS level 3 regions, or groups of NUTS level
3 regions, used to approximate functional urban areas with at least 250,000
inhabitants.

The typology identifies metropolitan regions where at least 50% of the
population lives inside a functional urban area of at least 250,000 people.

## Boundary Basis

Classification:

- boundary family: official/statistical metropolitan region;
- observed or modelled: statistical approximation derived from FUAs and NUTS 3
  units;
- basis type: NUTS 3 approximation of FUA population shares;
- spatial unit: NUTS level 3 regions;
- geographic coverage: European Union context, with page noting lists for EU
  Member States, Norway, and Switzerland.

## Method Details Verified

The Eurostat manual states:

- metropolitan regions are NUTS level 3 approximations of FUAs;
- each metropolitan region consists of one or more NUTS level 3 regions;
- FUAs with at least 250,000 inhabitants are selected;
- NUTS 3 regions are identified as metropolitan when at least 50% of their
  population lives in such an FUA;
- in some cases the metropolitan region may be larger or smaller than the
  underlying FUA;
- metropolitan regions should not cross international borders.

The manual also notes that updates may follow changes in population grids,
LAUs, FUA commuting data, or the NUTS classification.

## Relevance To Mobility Conversion

Eurostat metropolitan regions are useful as a statistical-data container and
fallback boundary. They can align with data published at NUTS 3 level and may
help reduce numerator/denominator distortions in regional statistics.

## Limitations

- They are approximations of FUAs, not the FUA itself.
- The NUTS 3 unit can be larger or smaller than the functional area.
- They do not cross international borders even when commuting regions do.
- Their purpose is statistical reporting, not direct transport-access
  geography.

## Suitability Judgment

Suitability: `candidate_fallback_boundary` and `candidate_validation_layer`.

Boundary confidence class:

- `official_statistical_metro`.

## Methodology Implication

Eurostat metropolitan regions should not be the default primary MTR boundary
when inspected FUA boundaries are available. They are better treated as a
fallback, statistical container, or comparison layer.
