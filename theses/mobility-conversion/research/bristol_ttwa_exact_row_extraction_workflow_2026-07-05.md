# Bristol TTWA Exact Row Extraction Workflow

Date: 2026-07-05

Status: formation-stage extraction workflow. No MTR admitted. No exact Bristol
TTWA row accepted. No filled boundary record, evidence manifest, candidate list,
candidate-universe ledger, metric record, score, ranking, accepted denominator
value, or raw data archive is authorized.

Related lead:

- `mtr_src_003` Bristol TTWA

Related records:

- `theses/mobility-conversion/research/bristol_ttwa_boundary_population_source_path_review_2026-07-05.md`
- `theses/mobility-conversion/research/source_notes/ons_travel_to_work_areas_national_method_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ons_travel_to_work_caveats_2026-06-28.md`

## Purpose

Define the exact extraction gates required before Bristol TTWA can move beyond
source-family review.

This workflow exists because TTWAs are a plausible national commuting-zone
source family, but the exact Bristol row/code, official boundary artifact,
population denominator path, and service-overlay fit are not accepted.

## Extraction Principle

Do not infer the Bristol TTWA row from memory, search snippets, source-return
claims, or the name "Bristol" alone.

Accept the exact row only after an official or primary source directly
identifies:

- exact geography name;
- exact TTWA code or equivalent identifier;
- source vintage;
- boundary product path;
- population denominator path or aggregation method;
- relation between geography identifier and boundary/population artifacts.

## Required Extraction Fields

```yaml
bristol_ttwa_exact_row_extraction:
  lead_id: mtr_src_003
  working_name: Bristol TTWA
  source_authority: ONS
  exact_name:
  exact_code:
  geography_type:
  boundary_vintage:
  commuting_or_labour_market_vintage:
  boundary_product:
  boundary_product_url_or_catalogue_path:
  boundary_file_name_or_layer:
  boundary_geometry_status: not_archived
  delineation_method_source:
  building_blocks:
  self_containment_threshold_or_algorithm:
  population_product:
  population_product_url_or_table_path:
  population_field:
  population_vintage:
  population_aggregation_method:
  accepted_denominator_value: false
  pandemic_or_remote_work_caveat:
  service_overlay_sources:
  service_coverage_against_boundary:
  missing_modes_or_operators:
  license_or_reuse_terms:
  evidence_manifest_status: not_created
  extraction_decision:
  blockers:
```

## Step 1. Verify Geography Identifier

Find an official source that identifies the Bristol TTWA row.

Acceptable source examples:

- ONS or ONS Open Geography Portal boundary attribute table;
- ONS geography lookup, code list, or metadata table;
- official TTWA boundary product metadata;
- official population table or lookup that directly maps Bristol to the TTWA
  identifier.

Do not accept:

- Wikipedia;
- local tourism or council pages;
- transit-agency geography;
- search-result snippets;
- uncited Deep Research claims.

## Step 2. Verify Boundary Artifact

Identify the official boundary product and layer/file that contains the Bristol
TTWA geometry.

Required:

- product title;
- catalogue or download path;
- release/vintage;
- file/layer name;
- identifier field that joins to the Bristol TTWA row;
- license or reuse terms.

Do not download or archive the raw boundary artifact until an evidence manifest
is created.

## Step 3. Verify Population Denominator Path

Identify the official population denominator path for the same geography.

Required:

- selected population field;
- selected year or estimate/census vintage;
- exact geography identifier;
- whether the denominator is direct, lookup-based, or aggregated from smaller
  statistical units;
- caveats introduced by lookup or small-area aggregation.

Do not accept or copy a population value at this workflow stage.

## Step 4. Verify TTWA Caveats

Record how the Bristol TTWA is affected by TTWA methodology and vintage:

- travel-to-work data vintage;
- delineation method and self-containment rule;
- building-block geography;
- whether the boundary is current official geography, historical geography, or
  retained analytical geography;
- pandemic/remote-work caveat;
- over-inclusion or rural-hinterland risk.

If a source does not show whether a caveat applies to Bristol specifically,
record `unknown`, not `none`.

## Step 5. Verify Service-Overlay Implication

Identify service-source questions before any readiness promotion:

- What NaPTAN stop data covers the TTWA?
- What Bus Open Data Service timetable data covers the TTWA?
- Which rail services, National Rail sources, ferry services, coach services,
  demand-responsive services, paratransit, or private services are material?
- Does a bus-only feed bundle hide material public transport or unserved
  population inside the TTWA?
- Are source licenses, access terms, feed vintages, and reproducibility
  recordable?

Service geography cannot define the MTR.

## Decision Classes

Allowed extraction decisions:

- `exact_row_verified_ready_for_blocked_readiness_review`
- `blocked_exact_row_not_found`
- `blocked_boundary_product_unresolved`
- `blocked_population_product_unresolved`
- `blocked_service_overlay_unresolved`
- `quarantined_source_conflict`
- `quarantined_boundary_vintage_gap`

No decision here admits Bristol or creates a boundary record.

## Manifest Trigger

No evidence manifest is created by this workflow.

Manifest required before:

- archiving raw boundary files;
- archiving lookup tables or population tables;
- extracting and storing accepted population values;
- joining boundary, population, and service artifacts;
- creating any filled boundary record or method test.

## Next Allowed Output

Allowed:

- external research handoff for Bristol exact-row/source bundle;
- exact-row extraction note if official source rows are independently
  inspected;
- modal completeness source-note review for NaPTAN, Bus Open Data Service,
  rail, ferry, coach, and other material services.

## Prohibited Outputs

This workflow does not authorize:

- admitted MTR;
- exact Bristol TTWA row acceptance without source inspection;
- filled boundary record;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted denominator value;
- raw data archive without manifest.
