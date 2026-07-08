# MTR Boundary Design

Status: formation-stage methodology design. No boundary rule is approved yet.

## Purpose

Mobility Conversion needs a unit of analysis that matches how transport access
is actually produced and experienced. Municipal boundaries are often too small,
country boundaries are too large, and transport-agency boundaries may reflect
institutions rather than travel behavior.

The Metropolitan Transport Region boundary rule must be defined before any MTR
is selected, compared, scored, or described as a case.

## Boundary Design Requirements

An acceptable MTR boundary rule should:

- capture cross-municipal travel for work, education, services, care, commerce,
  and social life;
- include the main transport system that shapes usable access;
- avoid selection by reputation, fame, or intuition;
- be replicable across regions;
- preserve source traceability;
- allow missing-data failures to be recorded instead of silently changing the
  unit;
- avoid making governance structure itself the outcome.

## Rejection Rules For Proposed Boundaries

Reject or quarantine a proposed boundary if it:

- is chosen because the region is famous, admired, notorious, or familiar;
- is chosen after seeing favorable or unfavorable access outcomes;
- cannot be traced to a source, date, and definition;
- is only a municipal core when the functional transport region is materially
  larger;
- is only a national or state/provincial unit when the metropolitan transport
  region is materially smaller;
- follows a transport agency boundary without documenting major travel flows
  outside that agency territory;
- changes from case to case without a written adjustment rule;
- makes governance performance impossible to analyze because the governance
  structure has been baked into the unit definition;
- excludes peripheral populations whose access is materially shaped by the
  metropolitan transport system;
- includes distant populations whose travel behavior is not meaningfully tied
  to the metropolitan transport system.

## Candidate Boundary Families

### Functional Travel Boundary

Defines the MTR by observed travel flows, such as commuting zones or functional
urban areas.

Strengths:

- closest to the lived geography of access;
- less dependent on administrative borders;
- useful for comparing regions with fragmented municipalities.

Risks:

- commuting data may be stale, unavailable, or inconsistent;
- non-work access may be undercounted;
- informal transport and non-commute trips may be invisible.

### Statistical Metropolitan Boundary

Uses official metropolitan statistical regions or similar national statistical
units.

Strengths:

- often documented and stable;
- easier to connect with population, income, safety, and economic data;
- source provenance is usually clear.

Risks:

- definitions vary by country;
- may not match actual transport service geography;
- may embed national statistical assumptions into the thesis.

### Transport Governance Boundary

Uses the territory of the main regional transport authority, transport planning
body, fare union, or service coordination institution.

Strengths:

- directly relevant to governance fit;
- useful for service availability, fare integration, and investment records;
- often maps to decision-making authority.

Risks:

- may omit important commuter sheds;
- may collapse explanation into the unit definition;
- fragmented regions may require multiple overlapping institutions.

### Built-Up Urban Boundary

Uses contiguous urbanized land or built-up area boundaries.

Strengths:

- captures physical urban form;
- less dependent on political boundaries;
- useful for density, network shape, and walking/cycling context.

Risks:

- may exclude peripheral commuters and regional access needs;
- may overemphasize land form relative to actual transport behavior;
- data products may vary by resolution and year.

### Thesis-Specific Composite Boundary

Combines a primary boundary rule with documented adjustments for transport
service areas, commuting sheds, or built-up continuity.

Strengths:

- can better match the thesis question;
- allows explicit treatment of edge cases;
- can handle regions where no single official unit works.

Risks:

- highest discretion risk;
- requires strict versioning and audit records;
- may reduce comparability if adjustments are too frequent.

## Recommended Formation Position

Use a two-layer design until evidence standards are clearer:

- Primary candidate boundary: functional travel boundary where a traceable
  source exists.
- Fallback candidate boundary: official metropolitan statistical boundary where
  functional travel data is unavailable or non-comparable.

Transport governance boundaries should be recorded as explanatory context, not
as the default unit, unless the research question narrows to governance design.

Built-up boundaries should support urban-form analysis, not replace the MTR
unit unless the thesis narrows to spatial form.

Composite boundaries remain possible, but only after a written adjustment rule
is approved.

This follows the defended first-principles position in
`theses/mobility-conversion/research/first_principles_methodology_position.md`.

The 2026-06-28 Deep Research source scan reinforces this position but does not
prove it. Intake is recorded in
`theses/mobility-conversion/research/mtr_boundary_source_scan_intake_2026-06-28.md`.

## Candidate Boundary Confidence Classes

Boundary confidence should be explicit because different source families do not
carry equal methodological force.

Candidate classes:

- `observed_functional_region`: observed FUA or similar commuting-flow region.
- `national_commuting_zone`: national labor-market or travel-to-work boundary.
- `hybrid_functional_statistical_region`: official statistical geography that
  uses functional criteria but also embeds statistical-output, stability,
  population, administrative, or manual-adjustment rules.
- `official_statistical_metro`: official metropolitan statistical boundary.
- `modelled_functional_region`: modelled FUA or travel-impedance estimate.
- `built_up_urban_core`: built-form or urban-agglomeration boundary.
- `governance_or_service_region`: authority, fare, planning, or service region.
- `service_derived_boundary`: GTFS, stop, route, or service-catchment boundary.
- `accessibility_dataset_geography`: geography inherited from an accessibility
  product.

These classes are candidates, not final methodology. The formation-stage source
hierarchy and admission gate are recorded in
`theses/mobility-conversion/research/boundary_source_decision_record_2026-06-28.md`.

Service-derived boundaries should not define the MTR denominator because doing
so can hide unserved populations.

Batch 1A direct source inspection supports keeping observed functional regions,
official statistical metropolitan regions, and modelled functional regions as
separate confidence classes. See
`theses/mobility-conversion/research/batch_1a_boundary_verification_summary_2026-06-28.md`.

Batch 1B direct source inspection supports using GHSL modelled FUAs only as
fallback or validation layers and GHSL built-form products as urban-core
overlays. See
`theses/mobility-conversion/research/batch_1b_boundary_verification_summary_2026-06-28.md`.

Batch 1C direct source inspection supports the guardrail that service-derived
boundaries should not define MTR denominators. See
`theses/mobility-conversion/research/batch_1c_boundary_verification_summary_2026-06-28.md`.

Batch 2A direct source inspection distinguishes U.S. FTA / NTD GTFS Weblinks as
a feed-inventory source from the BTS National Transit Map as a processed
geospatial service catalog. Both are service-derived inputs and overlays, not
MTR denominators. See
`theses/mobility-conversion/research/batch_2a_boundary_verification_summary_2026-06-28.md`.

Batch 2B direct source inspection supports mandatory vintage and caveat metadata
for commute-derived boundary sources. See
`theses/mobility-conversion/research/batch_2b_boundary_verification_summary_2026-06-28.md`.

Commute-flow boundary methods remain useful, but every use should record
commuting-data vintage, geography-release vintage, pandemic/remote-work caveat,
source-authority caveat, and boundary-quality notes.

Batch 2C direct source inspection supports adding
`hybrid_functional_statistical_region` as a candidate confidence class. See
`theses/mobility-conversion/research/batch_2c_boundary_verification_summary_2026-06-28.md`.

National functional/statistical systems should be admissible only when their
basis, building blocks, vintage, stability rules, manual-adjustment rules, and
caveats are explicitly recorded.

## Pre-Selection Gate

Before any candidate MTR can be named, the project must define:

- proposed primary boundary source class;
- proposed fallback or validation boundary source class;
- minimum population or scale rule, if any;
- treatment of polycentric regions;
- treatment of cross-border regions;
- treatment of regions with multiple transport authorities;
- treatment of informal or weakly documented transport systems;
- source freshness expectations;
- missing-data failure rule.

## Open Decision

The formation-stage decision is to optimize for behavioral validity first while
preserving source comparability through explicit confidence classes.

Remaining open decisions include vintage thresholds, polycentric and
cross-border handling, minimum scale, and conflict resolution when functional,
statistical, governance, and service geographies disagree.

Boundary record template:

- `theses/mobility-conversion/research/boundary_record_template.md`

Candidate-universe testing workflow:

- `theses/mobility-conversion/research/candidate_universe_testing_workflow.md`
