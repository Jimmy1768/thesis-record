# Boundary Source Decision Record

Date: 2026-06-28

Status: formation-stage decision record. This approves a provisional source
hierarchy and admission gate for candidate-universe design. It does not approve
final MTR boundaries, candidate MTRs, scores, rankings, or paper claims.

## Decision

Mobility Conversion should proceed with a behavioral-validity-first MTR boundary
strategy.

The project will prefer traceable functional travel geography over municipal,
service, agency, reputation-based, or country-level units.

This decision accepts the following provisional boundary source hierarchy for
candidate-universe screening:

1. `observed_functional_region`
2. `national_commuting_zone`
3. `hybrid_functional_statistical_region`
4. `official_statistical_metro`
5. `modelled_functional_region`
6. `built_up_urban_core`
7. `governance_or_service_region`
8. `service_derived_boundary`
9. `accessibility_dataset_geography`

Only the first five classes can potentially define the MTR denominator during
candidate formation. Classes 6 through 9 are overlays, validation layers,
indicator inputs, or contextual sources unless a later decision record changes
the thesis scope.

## Accepted For Formation-Stage Use

### Primary Candidate Class

`observed_functional_region`

Use when an official or authoritative source defines a metropolitan functional
area using observed commuting or travel-flow evidence, and when source vintage,
coverage, geometry, and limitations are documented.

Examples from verified source families:

- OECD observed Functional Urban Areas;
- Eurostat functional urban areas.

This class is preferred because it most closely matches the first-principles
requirement: the MTR unit should approximate how metropolitan transport access
is produced and experienced across municipal borders.

### Conditional Primary Or Strong Fallback Class

`national_commuting_zone`

Use when a national labour-market or travel-to-work boundary is directly
documented and better represents travel behaviour than an available official
metro statistical container.

Examples from verified or partially verified source families:

- USDA ERS Commuting Zones;
- ONS Travel To Work Areas, pending full official method-source inspection.

This class is not automatically primary. Labour-market geographies are
work-trip oriented and may be too coarse, too broad, or too rural/exurban for
some metropolitan transport questions.

### Conditional Fallback Class

`hybrid_functional_statistical_region`

Use when an official statistical geography explicitly uses functional criteria
such as commuting, labour markets, service access, or capital-city influence,
but also embeds statistical-output, stability, population, administrative, or
manual-adjustment rules.

Examples from verified source families:

- ABS Greater Capital City Statistical Areas;
- ABS Statistical Area Level 4;
- Statistics Canada CMA / CA, pending current CMA/CA method-source inspection;
- U.S. OMB CBSAs when treated as commute-informed official statistical
  containers rather than pure observed functional regions.

This class is accepted because several national systems are neither pure
observed flow regions nor generic metro containers. Treating them as one or the
other would overstate their precision or erase useful functional design.

### Fallback Statistical Container

`official_statistical_metro`

Use when functional-region sources are unavailable, stale, non-comparable, or
not usable with required indicators, and when the official statistical metro
source is transparent enough for source metadata.

Examples from verified source families:

- U.S. OMB Core Based Statistical Areas / Metropolitan Statistical Areas;
- Eurostat metropolitan regions;
- Statistics Canada CMA / CA, if current method inspection supports this class.

This class is useful for population, income, safety, and economic data joins,
but it should not outrank a stronger observed functional boundary by default.

### Weak Fallback Or Validation Class

`modelled_functional_region`

Use only where observed functional data are unavailable or where the modelled
source is used to validate a proposed boundary.

Examples from verified source families:

- GHS Functional Urban Areas.

This class must not be treated as equivalent to observed commuting-flow FUAs.

## Rejected As MTR Denominators

### Built-Up Urban Core

`built_up_urban_core` is an urban-form overlay, not a full MTR denominator.

Examples:

- GHSL Degree of Urbanisation / GHS-SMOD;
- GHSL Urban Centre Database.

Built-up cores can help test urban form, density, and whether a proposed MTR
boundary includes the relevant urban centre. They cannot by themselves capture
peripheral access, commuter sheds, or regional transport dependence.

### Governance Or Service Region

`governance_or_service_region` is governance context, not the default unit of
analysis.

Governance boundaries can become relevant when analysing governance fit, fare
integration, authority scope, funding, and planning competence. They should not
define the MTR denominator unless a later, explicit adjustment rule shows that
the governance boundary closely approximates the functional transport region.

### Service-Derived Boundary

`service_derived_boundary` is prohibited as an MTR denominator during candidate
formation.

Examples:

- GTFS feed extent;
- stop or route catchments;
- FTA / NTD GTFS Weblinks;
- BTS National Transit Map;
- Transitland feed coverage;
- agency-reported service area.

Reason: service-derived boundaries can hide unserved populations and make poor
coverage disappear from the denominator.

### Accessibility Dataset Geography

`accessibility_dataset_geography` is methodology precedent, validation, or
indicator support. It is not usually a primary MTR boundary source because its
geography is inherited from the dataset design.

## Required Metadata Before Any MTR Can Be Named

No candidate MTR may be admitted unless the proposed boundary record includes:

- `boundary_source_id`
- `boundary_family`
- `source_name`
- `source_authority`
- `source_url_or_access_path`
- `source_vintage`
- `latest_known_release`
- `geographic_coverage`
- `spatial_unit`
- `geometry_type`
- `observed_or_modelled`
- `basis_type`
- `confidence_class`
- `known_limitations`
- `verification_status`
- `source_authority_caveat`
- `boundary_quality_notes`

For any boundary based on commuting, labour-market flows, travel-to-work areas,
or commute-informed statistical regions, the record must also include:

- `commuting_data_vintage`
- `geography_release_vintage`
- `pandemic_or_remote_work_caveat`

For hybrid or official statistical sources, the record must include whether the
source uses:

- stability rules;
- manual adjustment;
- administrative building blocks;
- population thresholds;
- historical comparability rules;
- merge or split rules.

## Admission Gate

Before any MTR can enter the candidate universe, the operator must answer:

1. What is the proposed primary boundary source?
2. What confidence class does it belong to?
3. Is the source observed, modelled, hybrid, or statistical?
4. What spatial unit does the source use?
5. What data vintage defines the boundary?
6. What geography release is being used?
7. What known limitations could distort transport-access measurement?
8. What fallback or validation boundary exists?
9. What governance and service overlays should be recorded separately?
10. Does the proposed boundary include unserved or weakly served populations
    shaped by the metropolitan transport system?

Failure to answer these questions means the MTR is not yet admissible.

## Rationale

The thesis asks how Metropolitan Transport Regions convert capacity, pressure,
shape, governance, and growth into usable access.

That question requires a unit of analysis closer to metropolitan access
geography than to municipal identity, country identity, transit reputation, or
service coverage.

The source verification batches support the following position:

- observed FUAs are strong candidate primary boundaries where available;
- national commuting zones and travel-to-work areas are useful but
  work-trip-oriented;
- hybrid official systems are valuable but include statistical and stability
  choices;
- official metro regions are useful fallbacks and data containers;
- modelled global FUAs are weaker than observed flow boundaries;
- built-form products are overlays, not full transport regions;
- service-derived sources are indicator inputs only.

## Evidence Base

This decision record is based on direct source notes and batch summaries:

- `theses/mobility-conversion/research/batch_1a_boundary_verification_summary_2026-06-28.md`
- `theses/mobility-conversion/research/batch_1b_boundary_verification_summary_2026-06-28.md`
- `theses/mobility-conversion/research/batch_1c_boundary_verification_summary_2026-06-28.md`
- `theses/mobility-conversion/research/batch_2a_boundary_verification_summary_2026-06-28.md`
- `theses/mobility-conversion/research/batch_2b_boundary_verification_summary_2026-06-28.md`
- `theses/mobility-conversion/research/batch_2c_boundary_verification_summary_2026-06-28.md`

Raw Deep Research and query-test material informed source discovery but is not
evidence for this decision.

## Explicit Non-Decisions

This record does not decide:

- the final global MTR boundary methodology;
- any final candidate MTR list;
- population thresholds;
- treatment of cross-border MTRs;
- treatment of polycentric MTRs;
- indicator-specific geometry harmonization;
- how to adjudicate conflicts between functional, statistical, and governance
  boundaries in named cases;
- whether missing boundary data excludes a region or creates a lower-confidence
  candidate.

## Open Decision Gaps

- Define maximum acceptable vintage gap for commute-derived boundaries.
- Locate and archive the full current ONS TTWA delineation method and boundary
  source.
- Locate and archive a current Statistics Canada CMA/CA detailed-methodology
  source before Canadian boundaries are admitted.
- Decide whether `hybrid_functional_statistical_region` is a permanent
  confidence class or a formation-stage diagnostic class.
- Define the minimum scale rule for candidate MTR admission.
- Define cross-border and polycentric handling rules.
- Define when a modelled functional region is acceptable as fallback instead of
  excluding a candidate.

## Next Step

Decide whether to run a source-led dry-run boundary record for method testing
or wait for a real admitted boundary record.

Boundary record template:

- `theses/mobility-conversion/research/boundary_record_template.md`

Candidate-universe testing workflow:

- `theses/mobility-conversion/research/candidate_universe_testing_workflow.md`

Pre-testing rules:

- `theses/mobility-conversion/research/pre_testing_rules.md`

Future candidate-universe ledger design:

- `theses/mobility-conversion/research/candidate_universe_ledger_design.md`
