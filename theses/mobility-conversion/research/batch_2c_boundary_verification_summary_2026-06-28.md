# Batch 2C Boundary Verification Summary

Date: 2026-06-28

Status: source-family verification summary. No MTRs selected. No final boundary
methodology accepted.

## Sources Inspected

- U.S. OMB / Federal Register 2020 CBSA standards
- USDA ERS Commuting Zones and Labor Market Areas
- Statistics Canada CMA / CA / MIZ glossary and dictionary material
- Australian Bureau of Statistics ASGS Edition 3, SA4, and GCCSA material
- ONS Travel to Work Areas caveat/method-position sources

Source notes:

- `theses/mobility-conversion/research/source_notes/us_omb_core_based_statistical_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/usda_ers_commuting_zones_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/statistics_canada_cma_ca_miz_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/abs_asgs_sa4_gccsa_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ons_travel_to_work_areas_national_method_2026-06-28.md`

## Core Finding

Batch 2C verifies that national functional/statistical systems are useful but
not interchangeable.

They should not be collapsed into a single "functional boundary" class.

## Verified Position Updates

### U.S. OMB CBSAs

OMB CBSAs are official statistical metro regions built from counties and
urban-area cores, with outlying counties added through commuting ties.

Methodology implication:

- candidate fallback boundary for U.S. MTRs;
- good statistical-data container;
- not equivalent to an observed FUA or transport boundary;
- requires commuting-vintage and pandemic/remote-work caveats.

### USDA ERS Commuting Zones

ERS Commuting Zones are national commuting/labour-market regions using
county-to-county commuting flows, clustering, contiguity, and containment
metrics.

Methodology implication:

- strong validation layer for U.S. labour-market geography;
- possible fallback where the question is labour-market reach;
- not a default metropolitan transport denominator because it is county-based
  and labour-market oriented.

### Statistics Canada CMA / CA / MIZ

Statistics Canada's CMA/CA system is an official statistical metropolitan
system informed by commuting integration, core population, contiguity,
historical comparability, and manual adjustments.

MIZ confirms that commuting influence is also used to classify municipalities
outside CMAs/CAs.

Methodology implication:

- candidate fallback boundary for Canadian MTRs;
- MIZ can help test whether CMA/CA boundaries omit relevant commuter influence;
- current CMA/CA methodology must still be archived before acceptance.

### ABS ASGS SA4 / GCCSA

ABS ASGS provides hybrid functional statistical regions. SA4s represent labour
markets or groups of labour markets. GCCSAs represent capital-city functional
areas and explicitly include populations that socialise, shop, or work in the
capital city while living in the city or surrounding areas.

Methodology implication:

- GCCSAs are strong candidate fallback boundaries for Australian capital-city
  MTRs;
- SA4s are useful substructure and validation layers;
- these systems justify a distinct confidence class for hybrid functional
  statistical regions.

### ONS TTWAs

ONS sources verify that TTWAs are tied to travel-to-work data and
self-contained labour-market geography, but Batch 2C did not locate and inspect
a full current official TTWA delineation algorithm.

Methodology implication:

- TTWAs remain candidate `national_commuting_zone` sources;
- acceptance requires direct inspection of official methodology, thresholds,
  units, and boundary access;
- ONS already supports the Batch 2B caveat rule.

## Formation-Stage Decision

Add a candidate confidence class:

```text
hybrid_functional_statistical_region
```

Definition:

```text
Official statistical geography that uses functional criteria such as commuting,
labour markets, service access, or capital-city influence, but also embeds
statistical-output, stability, population, administrative, or manual-adjustment
rules.
```

This class should sit between `observed_functional_region` and
`official_statistical_metro`.

## What This Does Not Mean

This does not mean:

- national metro systems are directly comparable across countries;
- official statistical geographies should become the default primary boundary;
- commuting zones measure all-purpose transport access;
- county- or municipality-based systems are precise enough for all indicators;
- manual-adjusted statistical geographies are invalid.

The correct stance is:

```text
national functional/statistical systems are admissible source families only
when their basis, building blocks, vintage, stability rules, and caveats are
explicitly recorded.
```

## Remaining Risks

- National systems optimize for different goals: federal statistics,
  labour-market analysis, census geography, or capital-city reporting.
- Building-block size differs sharply across countries.
- Some systems preserve stability even when flows change.
- Some methods use manual adjustment.
- Some systems are exhaustive partitions; others cover only metro cores or
  capital cities.
- Transport access may cross, underfill, or overfill the statistical boundary.

## Next Verification Batch

Proceed to a boundary decision record:

- define accepted confidence classes;
- define source-family hierarchy;
- decide whether `hybrid_functional_statistical_region` is accepted;
- define minimum required metadata before any MTR may be admitted.
