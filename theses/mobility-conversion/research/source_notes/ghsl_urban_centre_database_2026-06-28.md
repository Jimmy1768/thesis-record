# Source Note: GHSL Urban Centre Database

Date inspected: 2026-06-28

Verification status: directly inspected official GHSL / European Commission
pages.

Sources:

- European Commission, GHSL datasets page, "Urban Centre Database UCDB R2024A"
- URL: `https://human-settlement.emergency.copernicus.eu/datasets.php`
- European Commission, GHSL, "GHS-UCDB R2024A"
- URL: `https://human-settlement.emergency.copernicus.eu/ghs_ucdb_2024.php`

## Source Authority

European Commission / Joint Research Centre, Global Human Settlement Layer.

## What The Source Defines

GHS-UCDB R2024A describes spatial entities called Urban Centres through
multi-temporal and thematic attributes.

The official product page describes UCDB R2024A as an updated global dataset of
over 10,000 urban centres, built using GHS-SMOD R2023A and split by country.

## Boundary Basis

Classification:

- boundary family: built-up urban centre / urban-core database;
- observed or modelled: harmonized gridded / derived settlement product;
- basis type: Degree of Urbanisation urban centres plus GHSL and other open
  datasets;
- spatial unit: rasterised 1 km, with CSV, Excel, and GeoPackage formats;
- coordinate system: World Mollweide;
- epoch: 2025 product page / R2024A release;
- geographic coverage: global.

## Data Availability

The source provides:

- JRC data catalogue link;
- interactive visualization;
- download link;
- multi-temporal boundaries visualization;
- CSV, Excel, and GeoPackage formats.

The GHSL datasets page lists UCDB R2024A as version 1.1 with last update
2025-07-31 and describes 15 thematic domains.

## Relevance To Mobility Conversion

UCDB is useful for:

- identifying urban centres;
- building urban-form overlays;
- comparing urban-core attributes;
- validating whether a proposed MTR boundary includes or exceeds the urban
  core;
- connecting to GHSL thematic indicators.

## Limitations

- Urban centres are not full Metropolitan Transport Regions.
- UCDB is built from settlement / urban-centre logic, not observed travel
  regions.
- Splitting by country may complicate cross-border urban systems.
- Urban-centre attributes should not be interpreted as complete MTR access
  performance.
- It may be data-rich and globally consistent, but that does not make it a
  primary mobility-region boundary.

## Suitability Judgment

Suitability: `candidate_overlay` and `candidate_validation_layer`.

Boundary confidence class:

- `built_up_urban_core`.

## Methodology Implication

UCDB should be treated as urban-core and urban-form context. It is not suitable
as the primary MTR boundary unless the thesis explicitly narrows to urban-core
analysis.
