# Greater Melbourne GCCSA Exact Row Extraction Workflow

Date: 2026-07-04

Status: formation-stage extraction workflow. No MTR admitted. No exact Greater
Melbourne GCCSA row accepted. No filled boundary record, evidence manifest,
candidate list, candidate-universe ledger, metric record, score, ranking,
accepted denominator value, or raw data archive is authorized.

Related lead:

- `mtr_src_006` Greater Melbourne GCCSA

Related records:

- `theses/mobility-conversion/research/melbourne_gccsa_boundary_population_source_path_review_2026-07-04.md`
- `theses/mobility-conversion/research/source_notes/abs_asgs_sa4_gccsa_2026-06-28.md`

## Purpose

Define the extraction gates required before Greater Melbourne GCCSA can move
beyond source-path review.

## Extraction Principle

Do not infer the Greater Melbourne GCCSA row from memory, common identifiers,
search snippets, or raw research output.

Accept the exact row only after an ABS source directly identifies:

- exact GCCSA name;
- exact GCCSA code or equivalent identifier;
- ASGS edition/vintage;
- boundary file/product path;
- population denominator table/source path;
- relation between the identifier and boundary/population artifacts.

## Required Extraction Fields

```yaml
melbourne_gccsa_exact_row_extraction:
  lead_id: mtr_src_006
  working_name: Greater Melbourne GCCSA
  source_authority: Australian Bureau of Statistics
  exact_name:
  exact_code:
  ASGS_edition:
  geography_type: GCCSA
  boundary_product:
  boundary_product_url_or_catalogue_path:
  boundary_file_name_or_layer:
  boundary_geometry_status: not_archived
  building_blocks:
    SA4_membership:
  population_product:
  population_product_url_or_table_path:
  population_field:
  population_vintage:
  accepted_denominator_value: false
  functional_basis:
  statistical_stability_or_publication_rules:
  edition_transition_notes:
  service_overlay_source:
  service_coverage_against_boundary:
  license_or_reuse_terms:
  evidence_manifest_status: not_created
  extraction_decision:
  blockers:
```

## Step 1. Verify Geography Identifier

Find an official ABS source that identifies the Greater Melbourne GCCSA row.

Acceptable source examples:

- ASGS coding/index file;
- boundary file attribute table or metadata;
- official ABS geography lookup;
- official ABS data table with GCCSA code/name;
- ABS correspondence file mapping GCCSA to SA4s.

Do not accept third-party geography lookups or uncited research claims.

## Step 2. Verify Boundary Artifact

Identify the official ABS boundary product and layer/file containing the
Greater Melbourne GCCSA geometry.

Required:

- product title;
- release/vintage;
- ASGS edition;
- file/layer name;
- identifier field that joins to the Greater Melbourne GCCSA row;
- datum/projection notes if available from source metadata.

Do not download or archive the raw boundary artifact until an evidence manifest
is created.

## Step 3. Verify Population Denominator Path

Identify the official ABS population source for the same GCCSA geography.

Required:

- selected population field;
- selected year/census vintage;
- exact GCCSA identifier;
- denominator definition;
- source caveats if documented.

Do not accept or copy a population value at this workflow stage.

## Step 4. Verify SA4 Building Blocks And Fit Caveats

Record:

- SA4s included in the Greater Melbourne GCCSA;
- functional basis for GCCSA construction;
- labour-market or service-access basis;
- stability/statistical-publication rules;
- edition-transition notes if ASGS Edition 4 changes are relevant.

If a caveat is not source-specific to Greater Melbourne, record `unknown`.

## Step 5. Verify Service-Overlay Implication

Identify service-source questions before readiness promotion:

- Does Victoria DTP GTFS cover all material scheduled public transport inside
  the GCCSA?
- Does statewide feed coverage include regional rail/coach/ferry services that
  are material to the GCCSA?
- Are demand-responsive, paratransit, school, airport, private, or special
  services material?
- Would clipping statewide service to the GCCSA hide unserved or weakly served
  population?

Service geography cannot define the MTR.

## Decision Classes

Allowed extraction decisions:

- `exact_row_verified_ready_for_blocked_readiness_review`
- `blocked_exact_row_not_found`
- `blocked_boundary_product_unresolved`
- `blocked_population_product_unresolved`
- `blocked_service_overlay_unresolved`
- `blocked_edition_transition_unresolved`
- `quarantined_source_conflict`

No decision here admits Greater Melbourne or creates a boundary record.

## Manifest Trigger

No evidence manifest is created by this workflow.

Manifest required before:

- archiving raw ABS boundary files;
- archiving ABS population tables;
- extracting and storing accepted population values;
- joining boundary, population, and service artifacts;
- creating any filled boundary record or method test.

## Next Allowed Output

Allowed:

- external research handoff for Greater Melbourne exact-row/source bundle;
- exact-row extraction note if official source rows are independently
  inspected;
- service-source trace plan for Victoria DTP/regional operators.

## Prohibited Outputs

This workflow does not authorize:

- admitted MTR;
- exact Greater Melbourne GCCSA row acceptance without source inspection;
- filled boundary record;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted denominator value;
- raw data archive without manifest.
