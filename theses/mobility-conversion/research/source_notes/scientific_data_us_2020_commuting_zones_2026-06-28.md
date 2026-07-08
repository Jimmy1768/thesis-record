# Source Note: Scientific Data 2020 U.S. Commuting Zones

Date inspected: 2026-06-28

Verification status: directly inspected peer-reviewed open-access article.

Source:

- Christopher S. Fowler, "New Commuting Zone delineation for the U.S. based on 2020 data"
- Journal: Scientific Data
- URL: `https://www.nature.com/articles/s41597-024-03829-5`

## Source Authority

Peer-reviewed article in Scientific Data. Not an official government boundary
standard.

## What The Source Defines

The article documents a 2020 U.S. commuting-zone delineation based on 2020
geographies and county-to-county commuting data.

It updates 2010-era definitions and provides quality measures for comparing
commuting-zone delineations.

## Boundary Basis

Classification:

- boundary family: commuting zone / functional region research source;
- observed or modelled: observed commuting-flow data processed through a
  clustering method;
- basis type: county-to-county commuting flows and hierarchical clustering;
- spatial unit: U.S. counties and county equivalents;
- geographic coverage: United States and Puerto Rico;
- vintage: 2020-based delineation, published 2024.

## Relevance To Mobility Conversion

This article is useful for methodology caveats because it explicitly discusses
how remote work and changing residence-work patterns affect the quality of
commuting-based delineations.

It also supports the idea that commute-based regions should carry quality
metrics and confidence metadata rather than being treated as uniformly valid.

## Limitations

- This is not an official U.S. government boundary standard.
- It is county-based and may be too coarse for detailed MTR access analysis.
- It focuses on labor-market/commuting regions, not all-purpose access.
- It is useful as a caveat and validation source, not as a default global
  boundary rule.

## Suitability Judgment

Suitability: `candidate_validation_layer` and boundary-caveat source.

Boundary confidence implication:

- supports `commuting_data_vintage`;
- supports quality/confidence metadata for commute-derived regions;
- does not replace official FUA/statistical sources.

## Methodology Implication

This article reinforces the need to store confidence and caveat metadata for
commuting-derived boundaries, especially in post-2020 contexts.
