# Calgary CMA Exact Row Extraction Workflow

Date: 2026-07-04

Status: formation-stage extraction workflow. No MTR admitted. No exact Calgary
CMA row accepted. No filled boundary record, evidence manifest, candidate list,
candidate-universe ledger, metric record, score, ranking, accepted denominator
value, or raw data archive is authorized.

Related lead:

- `mtr_src_005` Calgary CMA

Related records:

- `theses/mobility-conversion/research/calgary_cma_boundary_population_source_path_review_2026-07-03.md`
- `theses/mobility-conversion/research/source_notes/statistics_canada_2021_boundary_profile_source_paths_2026-07-03.md`
- `theses/mobility-conversion/research/source_notes/statistics_canada_cma_ca_2021_current_glossary_followup_2026-07-01.md`

## Purpose

Define the exact extraction gates required before Calgary CMA can move beyond
source-path review.

This workflow exists because Statistics Canada source paths are identified, but
the exact Calgary CMA row/code, boundary artifact, population denominator field,
and service-overlay fit are not accepted.

## Extraction Principle

Do not infer the Calgary CMA row from memory, common identifiers, search
snippets, or raw research output.

Accept the exact row only after a Statistics Canada source directly identifies:

- exact geography name;
- exact CMA/CA code or DGUID/equivalent;
- source vintage;
- boundary file/product path;
- population denominator table/profile path;
- relation between geography identifier and boundary/population artifacts.

## Required Extraction Fields

```yaml
calgary_cma_exact_row_extraction:
  lead_id: mtr_src_005
  working_name: Calgary CMA
  source_authority: Statistics Canada
  exact_name:
  exact_code:
  DGUID_or_equivalent:
  geography_type:
  census_release_or_geography_vintage:
  boundary_product:
  boundary_product_url_or_catalogue_path:
  boundary_file_name_or_layer:
  boundary_geometry_status: not_archived
  population_product:
  population_product_url_or_table_path:
  population_field:
  population_vintage:
  accepted_denominator_value: false
  building_blocks:
  commuting_or_labour_market_vintage:
  historical_comparability_rule_impact:
  manual_adjustment_rule_impact:
  merge_or_secondary_core_rule_impact:
  service_overlay_source:
  service_coverage_against_boundary:
  license_or_reuse_terms:
  evidence_manifest_status: not_created
  extraction_decision:
  blockers:
```

## Step 1. Verify Geography Identifier

Find an official Statistics Canada source that identifies the Calgary CMA row.

Acceptable source examples:

- Census Profile row/page;
- boundary file attribute table or official metadata;
- geographic hierarchy file;
- Statistics Canada API or download metadata;
- other Statistics Canada product that directly maps Calgary to the relevant
  CMA/CA identifier.

Do not accept:

- third-party lookups;
- Wikipedia;
- transit agency geography;
- search-result snippets;
- uncited Deep Research claims.

## Step 2. Verify Boundary Artifact

Identify the official boundary product and layer/file that contains the Calgary
CMA geometry.

Required:

- product title;
- catalogue or download path;
- release/vintage;
- coordinate/reference details if available from metadata;
- file/layer name;
- identifier field that joins to the Calgary CMA row.

Do not download or archive the raw boundary artifact until an evidence manifest
is created.

## Step 3. Verify Population Denominator Path

Identify the official Statistics Canada population table/profile path for the
same geography.

Required:

- selected population field;
- selected year or census vintage;
- exact geography identifier;
- whether the field is total population, usual residents, or another
  denominator definition;
- caveats for census undercount, nonresponse, or profile availability if
  source documentation raises them.

Do not accept or copy a population value at this workflow stage.

## Step 4. Verify Functional/Statistical Caveats

Record how Calgary CMA is affected by CMA/CA methodology:

- population-centre core;
- census subdivision / municipality building blocks;
- forward commuting rule;
- reverse commuting rule;
- spatial contiguity rule;
- historical comparability;
- manual adjustments;
- merge or secondary-core rules.

If a source does not show whether a caveat applies to Calgary specifically,
record `unknown`, not `none`.

## Step 5. Verify Service-Overlay Implication

Identify service-source questions before any readiness promotion:

- Does Calgary Transit coverage align with the CMA boundary?
- Are Airdrie, Cochrane, Chestermere, Okotoks, or other regional municipalities
  inside the CMA relevant to the service bundle?
- Are regional bus, commuter, airport, paratransit, demand-responsive, or
  private services material?
- Could Calgary Transit service geography hide unserved CMA population?

Service geography cannot define the MTR.

## Decision Classes

Allowed extraction decisions:

- `exact_row_verified_ready_for_blocked_readiness_review`
- `blocked_exact_row_not_found`
- `blocked_boundary_product_unresolved`
- `blocked_population_product_unresolved`
- `blocked_service_overlay_unresolved`
- `quarantined_source_conflict`

No decision here admits Calgary or creates a boundary record.

## Manifest Trigger

No evidence manifest is created by this workflow.

Manifest required before:

- archiving raw boundary files;
- archiving profile/population tables;
- extracting and storing accepted population values;
- joining boundary, population, and service artifacts;
- creating any filled boundary record or method test.

## Next Allowed Output

Allowed:

- external research handoff for Calgary exact-row/source bundle;
- exact-row extraction note if official source rows are independently
  inspected;
- service-source trace plan for Calgary Transit/regional operators.

## Prohibited Outputs

This workflow does not authorize:

- admitted MTR;
- exact Calgary CMA row acceptance without source inspection;
- filled boundary record;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted denominator value;
- raw data archive without manifest.
