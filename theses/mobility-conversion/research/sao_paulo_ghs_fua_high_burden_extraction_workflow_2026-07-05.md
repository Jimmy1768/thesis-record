# Sao Paulo GHS-FUA High-Burden Extraction Workflow

Date: 2026-07-05

Status: formation-stage extraction workflow. No MTR admitted. No exact Sao
Paulo GHS-FUA row accepted. No filled boundary record, evidence manifest,
candidate list, candidate-universe ledger, metric record, score, ranking,
accepted denominator value, or raw data archive is authorized.

Related lead:

- `mtr_src_008` Sao Paulo GHS-FUA

Related records:

- `theses/mobility-conversion/research/sao_paulo_ghs_fua_boundary_classification_review_2026-07-05.md`
- `theses/mobility-conversion/research/batch_s1d_modelled_global_boundary_burden_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/ghs_functional_urban_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ghs_pop_population_grid_2026-07-01.md`

## Purpose

Define the exact extraction and burden gates required before Sao Paulo GHS-FUA
can move beyond modelled-boundary classification review.

This workflow exists because GHS-FUA can preserve global scope where stronger
boundaries are unavailable, but modelled global boundaries carry a higher burden
than observed, national, hybrid, or official statistical source families.

## Extraction Principle

Do not infer the Sao Paulo GHS-FUA row from the city name, megacity status,
population size, congestion reputation, or raw research output.

Accept the exact row only after official or primary sources directly identify:

- exact GHS-FUA identifier/name;
- product release and epoch;
- coordinate system and resolution;
- source URL or catalogue path;
- license/reuse terms;
- relation between the boundary and any population or service artifacts.

## Required Extraction Fields

```yaml
sao_paulo_ghs_fua_high_burden_extraction:
  lead_id: mtr_src_008
  working_name: Sao Paulo GHS-FUA
  source_authority: European Commission JRC / GHSL
  exact_ghs_fua_identifier:
  exact_ghs_fua_name:
  geography_type:
  product_release:
  boundary_epoch:
  coordinate_system:
  resolution:
  boundary_product_url_or_catalogue_path:
  boundary_geometry_status: not_archived
  license_or_reuse_terms:
  fallback_justification:
  stronger_boundary_sources_checked:
  official_or_national_context_sources:
  model_input_disclosure:
  economic_capacity_input_overlap_caveat:
  vintage_and_growth_review:
  ghs_pop_product:
  ghs_pop_release:
  ghs_pop_target_year:
  population_summarization_method:
  accepted_denominator_value: false
  built_form_overlay_source:
  service_overlay_sources:
  formal_service_coverage_against_boundary:
  informal_or_weakly_documented_service_gaps:
  access_registration_or_license_constraints:
  evidence_manifest_status: not_created
  extraction_decision:
  blockers:
```

## Step 1. Verify Exact GHS-FUA Row

Find an official GHSL/JRC source, catalogue, documentation table, or product
attribute table that identifies the Sao Paulo GHS-FUA row.

Required:

- exact identifier;
- exact name;
- product title;
- product release;
- epoch;
- coordinate system;
- resolution;
- source path;
- license/reuse terms.

Do not accept:

- Wikipedia;
- city-size lists;
- transit-agency geography;
- service areas;
- search-result snippets;
- uncited Deep Research claims.

## Step 2. Verify Fallback Justification

Before treating GHS-FUA as a primary boundary candidate, search for stronger
source families:

- observed functional urban areas;
- national commuting zones or labour-market areas;
- official statistical metropolitan regions;
- hybrid functional-statistical regions;
- official population-denominator geographies;
- planning or governance regions, as overlays only unless independently
  eligible.

The return must state whether each family was found, unavailable, unusable,
stale, less appropriate, or unresolved.

## Step 3. Verify Model Input And Axis-Overlap Caveats

Record that GHS-FUA is modelled and not observed commuting geography.

Required caveats:

- model input disclosure;
- GDP per capita or economic-capacity input overlap;
- travel-time/friction input implications;
- urban-centre inheritance risk;
- boundary epoch;
- rapid-growth/staleness risk.

## Step 4. Verify GHS-POP Denominator Pairing

Identify whether GHS-POP is needed as:

- denominator source;
- reconciliation layer;
- fallback where official denominators do not align;
- not needed because stronger official denominators exist.

Required:

- GHS-POP release;
- target year;
- resolution;
- estimate versus projection status;
- summarization method;
- mismatch with GHS-FUA epoch;
- uncertainty and caveats.

Do not accept or copy a population value at this workflow stage.

## Step 5. Verify Built-Form Overlay

Identify at least one built-form or urban-centre overlay for context:

- GHS-SMOD / Degree of Urbanisation;
- GHS-UCDB;
- stronger official built-up extent source if available.

This is validation/context only. Built-form overlays cannot define the MTR
denominator.

## Step 6. Verify Service-Source Completeness

Identify service-source questions before any readiness promotion:

- What SPTrans sources exist, and what access, registration, license, and
  reproducibility constraints apply?
- What EMTU sources exist, and what access, registration, license, and
  reproducibility constraints apply?
- Which metro, rail, municipal, intermunicipal, ferry, private, informal,
  demand-responsive, paratransit, or other services are material?
- Could formal-service feeds hide weakly documented or informal service?
- Could service-source availability bias the lead toward source-rich formal
  systems inside the modelled boundary?

Service geography cannot define the MTR.

## Decision Classes

Allowed extraction decisions:

- `exact_row_verified_but_readiness_blocked_pending_burden_review`
- `blocked_exact_ghs_fua_row_not_found`
- `blocked_fallback_justification_unresolved`
- `blocked_population_pairing_unresolved`
- `blocked_official_context_search_unresolved`
- `blocked_service_overlay_unresolved`
- `quarantined_model_input_axis_overlap`
- `quarantined_vintage_growth_mismatch`
- `quarantined_service_reproducibility_failure`

No decision here admits Sao Paulo or creates a boundary record.

## Manifest Trigger

No evidence manifest is created by this workflow.

Manifest required before:

- archiving GHS-FUA files;
- archiving GHS-POP rasters;
- archiving GHS-SMOD, GHS-UCDB, or other overlay files;
- archiving service/API artifacts;
- extracting and storing accepted population values;
- joining boundary, population, overlay, and service artifacts;
- creating any filled boundary record or method test.

## Next Allowed Output

Allowed:

- external research handoff for Sao Paulo GHS-FUA high-burden source bundle;
- exact-row extraction note if official source rows are independently
  inspected;
- official/national context source-search note;
- service-source trace plan for formal/informal operator coverage.

## Prohibited Outputs

This workflow does not authorize:

- admitted MTR;
- readiness review;
- exact Sao Paulo GHS-FUA row acceptance without source inspection;
- filled boundary record;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted denominator value;
- raw data archive without manifest.
