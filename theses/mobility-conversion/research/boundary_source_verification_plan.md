# Boundary Source Verification Plan

Status: formation-stage verification plan. No source is verified or accepted
yet.

## Purpose

The MTR boundary source scan produced useful source leads. The next task is to
inspect those leads directly and decide which can support candidate methodology.

This plan defines the first verification sequence and the questions each source
inspection must answer.

## Immediate Rule

Do not select MTRs yet.

Do not accept boundary rules from the Deep Research return alone.

Do not promote any source claim until the underlying source has been inspected
and summarized in a source note.

## Verification Outputs

Each inspected source should produce one of:

- verified source note;
- partial source note with limitations;
- rejected source note;
- open question;
- methodology update.

Source notes should live under:

```text
theses/mobility-conversion/research/source_notes/
```

## First Verification Batch

The first batch should verify source families, not individual MTRs.

### Batch 1A: Functional Urban Area Foundations

Priority reason: this is the strongest candidate primary MTR boundary family.

Source leads:

- OECD Functional Urban Areas
- Eurostat functional urban areas
- Eurostat metropolitan regions

Questions to answer:

- What is the official definition?
- Does the source use observed commuting flows, modelled flows, administrative
  approximation, or a mix?
- What threshold or algorithm defines the commuting zone?
- What countries or regions are covered?
- What spatial unit is used?
- What vintage or update cadence exists?
- Are polycentric and cross-border regions handled?
- Is geometry downloadable or only described?
- What license or reuse constraint applies?
- Is it suitable as a primary MTR boundary, fallback, validation layer, or not
  suitable?

### Batch 1B: Global Modelled / Built-Form Context

Priority reason: global coverage may be useful, but these sources are likely
weaker as full MTR boundaries.

Source leads:

- GHSL-OECD Functional Urban Areas
- GHSL Degree of Urbanisation
- GHSL Urban Centre Database

Questions to answer:

- Is the boundary observed or modelled?
- Is it a commuting region, an urban centre, a built-up area, or another unit?
- What year or release does it represent?
- What grid or spatial resolution is used?
- Does the method include travel impedance, built form, population, or other
  variables?
- Does it risk confusing urban core with full transport region?
- Is it better classified as primary, fallback, overlay, or validation source?

### Batch 1C: Service-Derived Boundary Guardrail

Priority reason: this is a high-risk denominator problem.

Source leads:

- MobilityData GTFS
- U.S. FTA National Transit Database GTFS weblinks
- Transitland

Questions to answer:

- What does the source actually describe: service schedules, feeds, operators,
  stops, routes, frequencies, or geography?
- What modes or services are excluded?
- Does the source include all operators in a region?
- Can it measure service coverage without defining the population denominator?
- What failure modes would hide unserved populations?
- Should service-derived boundaries be formally prohibited as MTR denominators?

## Verification Fields

Each source note should include:

- source name;
- source authority;
- source URL or access path;
- inspected date;
- source vintage or release date;
- boundary family;
- observed or modelled;
- basis type;
- spatial unit;
- geographic coverage;
- update cadence if stated;
- geometry availability;
- license or reuse notes;
- quoted or paraphrased definition with citation;
- relevance to Mobility Conversion;
- limitations;
- suitability judgment;
- verification status.

## Suitability Vocabulary

Use one of:

- `candidate_primary_boundary`
- `candidate_fallback_boundary`
- `candidate_validation_layer`
- `candidate_overlay`
- `indicator_input_only`
- `not_suitable`
- `requires_more_inspection`

## Acceptance Threshold

A source can only influence accepted methodology after:

- the source note is completed;
- the source authority and definition are inspected directly;
- boundary basis is classified;
- limitations are recorded;
- suitability is assigned;
- the source is linked back to the boundary confidence classes.

## Current Next Action

Start with Batch 1A because the thesis currently leans toward behavioral
validity first. If OECD/Eurostat FUA definitions are weaker, narrower, or less
available than the return suggests, the boundary position must be revised.

## Batch 1A Status

Completed initial direct inspection on 2026-06-28.

Summary:

- `theses/mobility-conversion/research/batch_1a_boundary_verification_summary_2026-06-28.md`

Source notes:

- `theses/mobility-conversion/research/source_notes/oecd_functional_urban_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/eurostat_functional_urban_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/eurostat_metropolitan_regions_2026-06-28.md`

Next verification batch:

- Batch 1B: global modelled / built-form context.

## Batch 1B Status

Completed initial direct inspection on 2026-06-28.

Summary:

- `theses/mobility-conversion/research/batch_1b_boundary_verification_summary_2026-06-28.md`

Source notes:

- `theses/mobility-conversion/research/source_notes/ghs_functional_urban_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ghsl_degree_of_urbanisation_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ghsl_urban_centre_database_2026-06-28.md`

Next verification batch:

- Batch 1C: service-derived boundary guardrail.

## Batch 1C Status

Completed initial direct inspection on 2026-06-28.

Summary:

- `theses/mobility-conversion/research/batch_1c_boundary_verification_summary_2026-06-28.md`

Source notes:

- `theses/mobility-conversion/research/source_notes/mobilitydata_gtfs_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/fta_ntd_service_area_and_gtfs_lead_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/transitland_feed_registry_2026-06-28.md`

Next work:

- draft candidate boundary decision record.

## Follow-Up Return Intake

A targeted Deep Research follow-up return was received and processed as raw
material on 2026-06-28.

Raw return:

- `theses/mobility-conversion/operator_records/external_query_tests/2026-06-28-boundary-follow-up-source-verification-raw-return.md`

Intake:

- `theses/mobility-conversion/research/boundary_followup_source_verification_intake_2026-06-28.md`

The return does not change verification status by itself. It defines Batch 2
source-verification work.

## Batch 2 Plan

### Batch 2A: U.S. GTFS Inventory Closure

Purpose:

- inspect FTA / NTD GTFS Weblinks;
- inspect NTD reporting policy / FAQ claims relevant to GTFS;
- inspect BTS National Transit Map and archive/update claims;
- distinguish feed inventory from service geography;
- close the open Batch 1C item.

Status:

- completed initial direct inspection on 2026-06-28.

Summary:

- `theses/mobility-conversion/research/batch_2a_boundary_verification_summary_2026-06-28.md`

Source notes:

- `theses/mobility-conversion/research/source_notes/fta_ntd_gtfs_weblinks_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/bts_national_transit_map_2026-06-28.md`

Next verification batch:

- Batch 2B: post-2020 commuting-boundary caveats.

### Batch 2B: Post-2020 Commuting-Boundary Caveats

Purpose:

- inspect U.S. Census commuting and home-based-work sources;
- inspect ONS travel-to-work quality and matrix-estimation sources;
- inspect OECD / ITF post-COVID mobility and remote-work sources;
- decide whether boundary-vintage caveats become required metadata.

Status:

- completed initial direct inspection on 2026-06-28.

Summary:

- `theses/mobility-conversion/research/batch_2b_boundary_verification_summary_2026-06-28.md`

Source notes:

- `theses/mobility-conversion/research/source_notes/us_census_commuting_and_home_based_work_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ons_travel_to_work_caveats_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/oecd_remote_work_place_based_policies_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/scientific_data_us_2020_commuting_zones_2026-06-28.md`

Next verification batch:

- Batch 2C: national functional / commuting boundary methods.

### Batch 2C: National Functional / Commuting Boundary Methods

Purpose:

- inspect UK ONS Travel to Work Areas;
- inspect U.S. OMB Core Based Statistical Areas;
- inspect USDA ERS Commuting Zones;
- inspect Statistics Canada CMA/CA rules;
- inspect ABS GCCSA / ASGS / SA4 functional-region rationale;
- classify national methods as observed, modelled, hybrid, fallback, primary,
  validation, or overlay candidates.

Status:

- completed initial direct inspection on 2026-06-28.

Summary:

- `theses/mobility-conversion/research/batch_2c_boundary_verification_summary_2026-06-28.md`

Source notes:

- `theses/mobility-conversion/research/source_notes/us_omb_core_based_statistical_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/usda_ers_commuting_zones_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/statistics_canada_cma_ca_miz_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/abs_asgs_sa4_gccsa_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ons_travel_to_work_areas_national_method_2026-06-28.md`

Next work:

- use the boundary source decision record to design a boundary-record template.

Decision record:

- `theses/mobility-conversion/research/boundary_source_decision_record_2026-06-28.md`
