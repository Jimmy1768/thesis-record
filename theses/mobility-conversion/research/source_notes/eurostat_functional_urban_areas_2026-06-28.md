# Source Note: Eurostat Functional Urban Areas

Date inspected: 2026-06-28

Verification status: directly inspected official Eurostat pages.

Sources:

- Eurostat, "Methodology - Cities"
- URL: `https://ec.europa.eu/eurostat/web/cities/methodology`
- Eurostat, "Glossary: Functional urban area"
- URL: `https://ec.europa.eu/eurostat/statistics-explained/index.php?title=Glossary:Functional_urban_area`
- Eurostat, "Territorial typologies manual - cities, commuting zones and functional urban areas"
- URL: `https://ec.europa.eu/eurostat/statistics-explained/index.php?title=Territorial_typologies_manual_-_cities,_commuting_zones_and_functional_urban_areas`

## Source Authority

Eurostat, official statistical office of the European Union.

## What The Source Defines

Eurostat defines a functional urban area as a city plus its commuting zone.

The Eurostat city methodology page states:

- a city is an LAU where most people live in an urban centre of at least 50,000
  inhabitants;
- a commuting zone covers surrounding travel-to-work areas where at least 15%
  of employed residents work in the city;
- a functional urban area consists of the city plus that commuting zone.

The glossary states that FUAs consist of a densely inhabited city and a less
dense commuting zone whose labour market is highly integrated with the city.

## Boundary Basis

Classification:

- boundary family: functional urban area;
- observed or modelled: observed/statistical, based on population grids, LAUs,
  and commuting patterns;
- basis type: population density, urban centres, LAUs, and work commuting;
- spatial unit: 1 km2 population grid cells and local administrative units;
- geographic coverage: European city statistics context.

## Method Details Verified

The Eurostat territorial typologies manual states:

- urban centres use 1 km2 grid cells;
- urban centres require at least 1,500 inhabitants per km2 and at least 50,000
  inhabitants after gap-filling;
- cities are classified at LAU level;
- commuting zones are based on commuting patterns;
- LAUs from which at least 15% of employed residents commute to the city are
  identified as commuting zones;
- enclaves are included and non-contiguous exclaves are excluded;
- connected cities may share a single commuting zone.

The manual also records rules for complex cases, including large/small LAUs,
polycentric city relationships, and cross-border commuting zones.

## Relevance To Mobility Conversion

Eurostat FUAs are currently the strongest inspected support for a
behavioral-validity-first MTR boundary in European contexts.

They fit the Mobility Conversion requirement better than city-proper boundaries
because they include the commuting zone around a city and explicitly address
polycentric and cross-border complications.

## Limitations

- The behavior measured is work commuting, not all daily access.
- The method depends on LAU structure and commuting data availability.
- Update cadence varies by country because commuting data availability varies.
- The method may be affected by post-2020 changes in commuting behavior.
- The European scope is not a global boundary solution.

## Suitability Judgment

Suitability: `candidate_primary_boundary` for European MTRs where Eurostat FUA
boundaries and source vintage are acceptable.

Boundary confidence class:

- `observed_functional_region`.

## Methodology Implication

Eurostat FUAs support behavioral-validity-first boundary design, but only as a
work-commuting-based functional boundary. They do not eliminate the need for
non-work access caveats, source-vintage checks, and regional fallback rules.
