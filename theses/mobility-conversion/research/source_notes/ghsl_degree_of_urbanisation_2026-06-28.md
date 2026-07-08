# Source Note: GHSL Degree Of Urbanisation / Settlement Classification

Date inspected: 2026-06-28

Verification status: directly inspected official GHSL and Eurostat pages.

Sources:

- European Commission, GHSL datasets page, "GHS-SMOD R2023A"
- URL: `https://human-settlement.emergency.copernicus.eu/datasets.php`
- European Commission / Eurostat, "Applying the degree of urbanisation manual"
- URL: `https://ec.europa.eu/eurostat/statistics-explained/index.php?title=Applying_the_degree_of_urbanisation_manual`
- European Commission / Eurostat, "Methodology for applying level 1 of the degree of urbanisation classification"
- URL: `https://ec.europa.eu/eurostat/statistics-explained/index.php?title=Applying_the_degree_of_urbanisation_manual_-_Methodology_for_applying_level_1_of_the_degree_of_urbanisation_classification`

## Source Authority

European Commission / Joint Research Centre, Eurostat, and partner
organisations involved in the Degree of Urbanisation manual.

## What The Source Defines

GHS-SMOD R2023A applies the Degree of Urbanisation stage I methodology to GHSL
population and built-up surface data.

The GHSL datasets page describes it as a settlement classification by the
UN-recommended Degree of Urbanisation methodology for 1975-2030 at 1 km
resolution.

The Degree of Urbanisation manual defines a harmonized method to classify
territory along an urban-rural continuum.

## Boundary Basis

Classification:

- boundary family: built-up / settlement classification;
- observed or modelled: gridded classification from population and built-up
  datasets;
- basis type: population density, population size, contiguity, and built-up
  information;
- spatial unit: 1 km grid cells;
- epochs: 1975-2030 in 5-year intervals for GHS-SMOD R2023A;
- geographic coverage: global.

The methodology identifies urban centres from contiguous 1 km grid cells with
population density of at least 1,500 inhabitants per km2 and at least 50,000
inhabitants before gap-filling.

## Data Availability

The GHSL datasets page provides:

- dataset description;
- datasheet link;
- download link;
- DOI / PID;
- methodology references.

## Relevance To Mobility Conversion

GHS-SMOD / Degree of Urbanisation is highly relevant as a globally comparable
urban-form and settlement overlay.

It can support:

- built-up urban-core identification;
- density and urban-form context;
- comparability checks;
- denominator checks for accessibility products that use urban-centre
  geographies.

## Limitations

- It is not an MTR boundary by itself.
- It does not observe travel behavior or commuting flows.
- Urban centres can omit functional commuting suburbs.
- Built-form contiguity and population density do not equal usable access.
- It is better suited to the urban-form axis and core overlays than to primary
  MTR delineation.

## Suitability Judgment

Suitability: `candidate_overlay` and `candidate_validation_layer`.

Boundary confidence class:

- `built_up_urban_core`.

## Methodology Implication

Degree of Urbanisation products should be required or preferred overlays where
available, but they should not replace functional travel boundaries for MTR
delineation.
