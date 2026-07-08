# Batch S1C: Commonwealth Hybrid Statistical Regions

Date: 2026-07-01

Status: formation-stage source-system mechanics decision. No MTR is selected.
No boundary record, evidence manifest, candidate-universe ledger, outcome
metric record, score, ranking, or MTR comparison is authorized.

Related intake:

- `theses/mobility-conversion/research/source_led_mtr_proposal_intake_2026-07-01.md`

Related source notes:

- `theses/mobility-conversion/research/source_notes/statistics_canada_cma_ca_miz_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/statistics_canada_cma_ca_2021_current_glossary_followup_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/abs_asgs_sa4_gccsa_2026-06-28.md`

## Question

Can hybrid functional-statistical regions serve as MTR denominators without
baking governance, source wealth, or service coverage into selection?

## Short Decision

Yes, but only under the `hybrid_functional_statistical_region` confidence class
and only after exact boundary, population, functional-rule, and service-overlay
limits are documented.

Canada CMAs and Australia GCCSAs are not weak because they are hybrid. Their
hybrid design is methodologically useful. The risk is overstating them as pure
observed travel regions or allowing their strong statistical-data compatibility
to become hidden candidate selection.

## Source-System Contrast

### Statistics Canada CMA / CA

Boundary family:

- `hybrid_functional_statistical_region`

Strengths:

- official national statistical geography;
- built from adjacent municipalities/census subdivisions;
- centred on population-centre cores;
- uses commuting-flow integration from previous Census Program place-of-work
  data;
- has explicit forward commuting, reverse commuting, spatial contiguity,
  historical comparability, manual adjustment, and merge rules;
- supports compatible population denominators through Statistics Canada.

Risks:

- municipality/census-subdivision building blocks may not match daily transport
  geography;
- historical comparability can retain areas whose current commuting fit has
  weakened;
- manual adjustment rules require caveat fields;
- CMA status and high-quality data availability can be mistaken for transport
  quality;
- municipal transit feeds may cover less than the full CMA denominator.

### ABS GCCSA / SA4

Boundary family:

- `hybrid_functional_statistical_region`

Strengths:

- official Australian statistical geography;
- ASGS is built for publication and analysis of official statistics;
- GCCSAs represent the functional area of each state and territory capital
  city;
- GCCSAs are built from SA4s;
- SA4s represent labour markets and the functional area of capital cities;
- ASGS Edition 3 provides a clear July 2021 to June 2026 vintage.

Risks:

- GCCSAs exist for capital-city functional areas, not every metropolitan
  system;
- ASGS design combines functional concepts, statistical stability, hierarchy,
  and output needs;
- GCCSA extent may be broader than the daily public-transport catchment;
- statewide transport feeds must be clipped or assessed against the GCCSA
  denominator, not treated as defining it;
- Edition 4 begins release in 2026, creating a near-term vintage transition.

## S1C Rule

Hybrid functional-statistical regions can proceed to source-note review and
later readiness-checklist review only if the record distinguishes:

- functional criteria;
- statistical publication needs;
- administrative or census building blocks;
- historical comparability or stability rules;
- manual adjustment or merge rules;
- exact boundary vintage;
- population denominator vintage;
- service-overlay coverage.

A hybrid source is not automatically inferior to an observed commuting FUA, but
it must not be labelled as an observed functional region.

## Required Fields

```yaml
hybrid_boundary_review:
  source_system:
  source_authority:
  exact_code:
  exact_name:
  boundary_vintage:
  building_blocks:
  functional_basis:
  commuting_or_labour_market_vintage:
  statistical_stability_rules:
  historical_comparability_rules:
  manual_adjustment_rules:
  merge_or_secondary_core_rules:
  official_use_limitations:
  population_denominator_source:
  population_vintage:
  service_overlay_source:
  service_coverage_against_boundary:
  source_rich_region_bias_risk:
```

## Lead Implications

### `mtr_src_005` Calgary CMA

Current status after S1C: remains `ready_for_source_note_review`.

Allowed next output:

- exact Calgary CMA code and boundary-source review;
- Statistics Canada population denominator source review;
- Calgary Transit and regional service-overlay completeness review;
- later draft evidence manifest if raw boundary/population artifacts are
  acquired.

Not allowed:

- treating Calgary Transit service geography as the denominator;
- filled boundary record before exact CMA fields are verified;
- candidate admission;
- score or ranking.

### `mtr_src_006` Greater Melbourne GCCSA

Current status after S1C: remains `ready_for_source_note_review`.

Allowed next output:

- exact Greater Melbourne GCCSA code and boundary-source review;
- ABS population denominator source review;
- Victoria DTP GTFS service-overlay completeness review;
- later draft evidence manifest if raw ASGS boundary/population artifacts are
  acquired.

Not allowed:

- treating Victoria DTP/statewide feed geography as the denominator;
- filled boundary record before exact GCCSA fields are verified;
- candidate admission;
- score or ranking.

## Evidence Manifest Decision

No evidence manifest is created in S1C.

Reason:

- S1C decides source-system mechanics.
- A manifest becomes required only if raw boundary files, population tables, or
  service-source artifacts are acquired, archived, transformed, or
  version-pinned.

## Methodology Implication

`hybrid_functional_statistical_region` should remain an accepted formation-stage
confidence class.

It should sit below observed functional regions when observed flow boundaries
are current and usable, but it may outrank modelled global boundaries where the
hybrid source is official, traceable, current, and denominator-compatible.

## Next Recommended Work

Proceed to Batch S1E: local service-source verification queue.

S1E should verify named service/network source families as indicator inputs
only, with explicit denial that service geography can define the MTR
denominator.

## Closing Guardrail

This batch does not select, admit, score, rank, or compare MTRs. It only
defines how hybrid functional-statistical regions may proceed without becoming
hidden service-area or source-wealth selection.
