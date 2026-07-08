# Batch 1B Boundary Verification Summary

Date: 2026-06-28

Status: source-family verification summary. No MTRs selected. No final boundary
methodology accepted.

## Sources Inspected

- GHS Functional Urban Areas
- GHSL Degree of Urbanisation / GHS-SMOD
- GHSL Urban Centre Database

Source notes:

- `theses/mobility-conversion/research/source_notes/ghs_functional_urban_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ghsl_degree_of_urbanisation_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ghsl_urban_centre_database_2026-06-28.md`

## Core Finding

Batch 1B confirms that GHSL products are valuable for global comparability,
urban-form overlays, and fallback/validation contexts, but they should not
override observed functional travel boundaries.

GHS-FUA is a modelled functional-region product. It should remain separate from
observed OECD/Eurostat FUAs.

GHS-SMOD / Degree of Urbanisation and UCDB are built-form / settlement /
urban-centre products. They are strong urban-core overlays but weak primary MTR
boundaries.

## Verified Position Updates

### GHS-FUA

GHS-FUA can be used as:

- candidate fallback boundary;
- candidate validation layer;
- global coverage reference.

It should not be treated as an observed commuting-flow boundary.

### GHS-SMOD / Degree Of Urbanisation

GHS-SMOD can be used as:

- candidate urban-form overlay;
- built-up urban-core reference;
- global comparability layer;
- settlement classification support.

It should not define the MTR boundary by itself.

### GHSL Urban Centre Database

UCDB can be used as:

- candidate urban-core overlay;
- source for urban-centre attributes;
- validation layer for built-form context.

It should not be treated as full MTR geography.

## Boundary Confidence Implications

Batch 1B supports keeping these classes separate:

- `observed_functional_region`
- `modelled_functional_region`
- `built_up_urban_core`

The result strengthens the rule that global comparability does not equal
boundary validity.

## Remaining Risks

- Modelled FUAs may embed variables that overlap with explanatory axes,
  including economic capacity.
- GHS-FUA is tied to epoch 2015.
- Built-form products can omit functional commuter sheds.
- Urban-centre products can split or simplify cross-border or polycentric
  systems.
- High-quality global data can create legibility bias if mistaken for better
  access evidence.

## Formation-Stage Decision

Keep the current hierarchy:

- primary: observed functional travel boundary where available;
- fallback: official statistical metropolitan boundary or modelled functional
  region, depending on source fit;
- overlay: built-up urban core from GHSL / UCDB where useful;
- validation/context: GHSL global products and urban-form measures.

This is not final methodology. It is a stronger candidate position after direct
inspection of Batch 1B sources.

## Next Verification Batch

Proceed to Batch 1C: service-derived boundary guardrail.

Purpose:

- verify GTFS / service data as indicator inputs;
- confirm why service-derived boundaries should not define the MTR denominator;
- identify what service completeness metadata will be needed later.
