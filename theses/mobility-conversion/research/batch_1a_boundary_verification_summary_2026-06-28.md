# Batch 1A Boundary Verification Summary

Date: 2026-06-28

Status: source-family verification summary. No MTRs selected. No final boundary
methodology accepted.

## Sources Inspected

- OECD Functional Urban Areas
- Eurostat Functional Urban Areas
- Eurostat Metropolitan Regions

Source notes:

- `theses/mobility-conversion/research/source_notes/oecd_functional_urban_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/eurostat_functional_urban_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/eurostat_metropolitan_regions_2026-06-28.md`

## Core Finding

Batch 1A supports the current behavioral-validity-first boundary stance, with
important constraints.

Observed OECD/Eurostat FUAs are better aligned with Mobility Conversion than
city-proper, agency-only, or broad administrative regions because they include a
city and commuting zone. However, they remain work-commuting-based
approximations, not complete all-purpose access geographies.

## Verified Position Updates

### Functional Urban Areas

Observed FUAs are valid candidate primary MTR boundaries where:

- source authority is OECD, Eurostat, or a comparable national statistical
  authority;
- the FUA is based on observed commuting or travel-to-work data;
- source vintage is recorded;
- geographic scope and limitations are recorded;
- non-work access limitations are explicitly carried forward.

### Metropolitan Regions

Eurostat metropolitan regions are NUTS 3 approximations of FUAs. They are useful
fallbacks and statistical containers, but should not replace directly inspected
FUA boundaries when those are available and suitable.

### Modelled FUAs

OECD references estimated FUAs for countries without commuting-flow data.
Because those are modelled and do not follow administrative borders, they should
remain a separate confidence class pending Batch 1B verification.

## Boundary Confidence Implications

Batch 1A supports keeping these classes separate:

- `observed_functional_region`
- `official_statistical_metro`
- `modelled_functional_region`

Do not collapse observed FUAs and modelled FUAs into one class.

## Remaining Risks

- Work commuting does not equal all daily access.
- Commuting data may be stale or census-linked.
- Remote work may weaken commuting-based boundaries for current access.
- FUA coverage is strong in OECD/European contexts but is not a full global
  solution.
- Administrative units can distort boundaries at the edge.
- Cross-border handling remains complex.

## Formation-Stage Decision

Keep the current stance:

- primary candidate boundary: observed FUA or comparable commuting-flow
  functional region;
- fallback: official statistical metropolitan boundary;
- separate pending class: modelled functional region;
- overlays still needed: built-up urban core, governance/service region, and
  service coverage.

This is not final methodology. It is a stronger candidate position after direct
inspection of Batch 1A sources.
