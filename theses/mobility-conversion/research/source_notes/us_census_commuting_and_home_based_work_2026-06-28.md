# Source Note: U.S. Census Commuting And Home-Based Work

Date inspected: 2026-06-28

Verification status: directly inspected official U.S. Census Bureau pages.

Sources:

- U.S. Census Bureau, "Commuting (Journey to Work)"
- URL: `https://www.census.gov/topics/employment/commuting.html`
- U.S. Census Bureau, "2016-2020 5-Year ACS Commuting Flows"
- URL: `https://www.census.gov/data/tables/2020/demo/metro-micro/commuting-flows-2020.html`
- U.S. Census Bureau, "Commuting in the United States: 2022"
- URL: `https://www.census.gov/library/publications/2024/acs/acsbr-018.html`
- U.S. Census Bureau, "Home-Based Workers: 2019-2021"
- URL: `https://www.census.gov/library/publications/2023/demo/p70br-184.html`

## Source Authority

U.S. Census Bureau.

## What The Sources Define

The Census commuting topic page describes commuting data as including workplace
location, work from home, trip start time, travel mode, and travel time.

The Census commuting-flow page provides residence-county to workplace-county and
workplace-county to residence-county tables for the 2016-2020 ACS 5-year period.

The 2022 commuting brief describes pandemic-era changes in U.S. commuting
behavior, especially home-based work.

The home-based workers brief describes changes in home-based work using Survey
of Income and Program Participation data for 2019-2021.

## Boundary Basis

Classification:

- boundary family: commuting-flow source and commuting-boundary caveat source;
- observed or modelled: observed survey estimates;
- basis type: residence-to-workplace flow, journey-to-work, work-from-home, and
  home-based work reporting;
- spatial unit: Census/ACS geographies, including county-to-county commuting
  flows for the 2016-2020 ACS 5-year tables;
- geographic coverage: United States and Puerto Rico for the inspected
  commuting-flow tables.

## Relevance To Mobility Conversion

These sources support two points:

- commuting-flow data can support functional-region validation in U.S. contexts;
- post-2020 commute-derived boundaries require explicit caveats because
  workplace location, work-from-home, and commuting behavior changed sharply
  during and after the COVID-19 pandemic.

The Census commuting topic page is also useful because it explicitly frames
commuting data as work-trip data. That reinforces the limitation that commute
flows do not represent all everyday access.

## Limitations

- Commuting is work-trip focused, not all-purpose mobility.
- County-to-county flows can be too coarse for detailed MTR access analysis.
- The 2016-2020 ACS tables include pandemic-period 2020 data.
- The 2022 commuting brief documents post-disruption adjustment, not a boundary
  method.
- The home-based work brief is a caveat source, not a boundary source.

## Suitability Judgment

Suitability: `candidate_validation_layer` and boundary-caveat source.

Boundary confidence class:

- supports `observed_functional_region` where used in a boundary method;
- requires `commuting_data_vintage` and `pandemic_or_remote_work_caveat`.

## Methodology Implication

U.S. commute-derived boundary sources should record commuting-data vintage and
pandemic/remote-work caveats. These sources support caution, not rejection, of
commuting-flow methods.
