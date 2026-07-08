# Source Note: Statistics Canada CMA / CA / MIZ

Date inspected: 2026-06-28

Verification status: directly inspected Statistics Canada glossary and
dictionary pages. One current 2021 CMA/CA dictionary link surfaced from the
Statistics Canada A-Z index returned a file-not-found page, so the detailed
CMA/CA rules below rely on the archived Statistics Canada illustrated glossary
page plus the current 2021 MIZ dictionary page.

Sources:

- Statistics Canada, "Census metropolitan area and Census agglomeration"
  archived illustrated glossary
- URL: `https://www150.statcan.gc.ca/n1/pub/92-195-x/2011001/geo/cma-rmr/cma-rmr-eng.htm`
- Statistics Canada, "CMA and CA: Detailed definition" archived illustrated
  glossary
- URL: `https://www150.statcan.gc.ca/n1/pub/92-195-x/2011001/geo/cma-rmr/def-eng.htm`
- Statistics Canada, "Dictionary, Census of Population, 2021 - Census
  metropolitan influenced zone (MIZ)"
- URL: `https://www12.statcan.gc.ca/census-recensement/2021/ref/dict/az/Definition-eng.cfm?ID=geo010`

## Source Authority

Statistics Canada.

## What The Sources Define

Statistics Canada Census Metropolitan Areas (CMAs) and Census Agglomerations
(CAs) are official statistical geographies built from adjacent municipalities
around a population centre core.

The archived detailed definition states that adjacent municipalities are
included when they have a high degree of integration with the core, measured by
commuting flows from previous census place-of-work data.

The MIZ concept classifies census subdivisions outside CMAs and CAs by the
degree of commuting influence from CMA/CA cores.

## Boundary Basis

Classification:

- boundary family: official metropolitan statistical boundary;
- observed or modelled: observed/statistical hybrid;
- basis type: population-centre core, census subdivisions, adjacency,
  commuting-flow inclusion rules, historical comparability, manual adjustment,
  and merge rules;
- spatial unit: census subdivisions / municipalities;
- geographic coverage: Canada;
- source vintage inspected: archived CMA/CA detailed definition, current 2021
  MIZ dictionary page.

The archived detailed definition includes forward commuting, reverse commuting,
spatial contiguity, historical comparability, manual adjustment, and adjacent
CMA/CA merge rules.

The current MIZ page verifies that commuting-flow relationships remain central
to Statistics Canada's treatment of metropolitan influence outside CMA/CA
boundaries.

## Relevance To Mobility Conversion

Canada's system is useful because it is official, municipality-based, and
explicitly functional/statistical rather than merely administrative.

It is also a good example of why `official_statistical_metro` and
`observed_functional_region` should remain separate confidence classes. The
system uses commuting flows, but also includes stability, contiguity,
population-core, and manual-adjustment rules.

## Limitations

- The current 2021 CMA/CA dictionary link from the A-Z index returned a
  file-not-found response during inspection.
- The detailed CMA/CA methodology inspected here is archived, so a current
  direct methodology source should be found before acceptance.
- CMA/CA boundaries are built from municipal/statistical units, not transport
  networks or all-purpose access geography.
- Historical comparability and manual adjustments can preserve boundaries even
  where observed commuting relationships have changed.
- MIZ is an influence classification outside CMAs/CAs, not itself a primary
  MTR boundary.

## Suitability Judgment

Suitability: `candidate_fallback_boundary` pending current-methodology
verification.

Boundary confidence class:

- `official_statistical_metro`;
- MIZ as `candidate_validation_layer`.

## Methodology Implication

Statistics Canada supports the idea that an official statistical metro can be
functionally informed without being equivalent to an observed FUA.

Before Canadian MTRs are admitted, the project should locate and archive the
current CMA/CA detailed methodology and record:

- commuting-data vintage;
- geography-release vintage;
- source-authority caveat;
- whether historical comparability or manual adjustments affect the boundary.
