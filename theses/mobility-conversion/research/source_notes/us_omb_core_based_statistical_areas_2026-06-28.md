# Source Note: U.S. OMB Core Based Statistical Areas

Date inspected: 2026-06-28

Verification status: directly inspected Federal Register notice for 2020
standards.

Source:

- Federal Register, Office of Management and Budget, "2020 Standards for
  Delineating Core Based Statistical Areas"
- URL: `https://www.federalregister.gov/documents/2021/07/16/2021-15159/2020-standards-for-delineating-core-based-statistical-areas`

## Source Authority

Office of Management and Budget, Executive Office of the President, published
through the Federal Register.

## What The Source Defines

The source defines U.S. Core Based Statistical Areas (CBSAs), including
Metropolitan Statistical Areas and Micropolitan Statistical Areas, for federal
statistical use.

The standards define a CBSA as a county-based statistical geography associated
with at least one urban core of 10,000 or more people plus adjacent counties
with social and economic integration measured through commuting ties.

## Boundary Basis

Classification:

- boundary family: official metropolitan statistical boundary;
- observed or modelled: observed/statistical hybrid;
- basis type: Census Bureau urban areas, counties or county equivalents, ACS
  commuting and employment estimates, contiguity, and update rules;
- spatial unit: counties and county-equivalent entities;
- geographic coverage: United States and Puerto Rico;
- vintage inspected: 2020 standards published in 2021, with delineations
  planned for 2023 and later updates.

Outlying counties qualify by commuting thresholds: at least 25 percent of
resident workers commute to central counties, or at least 25 percent of local
employment is held by workers residing in central counties.

## Relevance To Mobility Conversion

CBSAs are strong fallback candidates for U.S. MTR boundaries because they are
official, traceable, county-based, and explicitly use commuting integration.

They are not pure observed functional regions. They begin with urban-area cores
and county building blocks, then add adjacent counties based on commuting ties.

## Limitations

- OMB states that CBSAs are for statistical purposes, not general program
  administration or funding formulas.
- CBSAs are not an urban-rural classification.
- County building blocks may be too coarse for transport-access analysis.
- The standards use ACS commuting data, which OMB itself flags as vulnerable to
  pandemic-era changes in commuting behavior.
- Nonstatistical use requires caution.

## Suitability Judgment

Suitability: `candidate_fallback_boundary`.

Boundary confidence class:

- `official_statistical_metro`;
- with commute-derived caveat metadata required.

## Methodology Implication

For U.S. MTRs, OMB CBSAs should not outrank a better functional transport
boundary by default, but they are a defensible fallback and statistical-data
container.

Any use must record:

- `commuting_data_vintage`;
- `geography_release_vintage`;
- `pandemic_or_remote_work_caveat`;
- `source_authority_caveat`;
- `boundary_quality_notes`.
