# Handoff: Calgary CMA Exact Row / Source Bundle Request

Date: 2026-07-04

From: Thesis 2 working thread

To: Deep Research / external research thread

Status: research request. This is not evidence, not source truth, not an
accepted MTR, not a candidate-universe record, not a boundary record, not a
metric record, not a score, and not a ranking.

## Thesis Context

Thesis: Mobility Conversion

Full title: Mobility Conversion: How Metropolitan Transport Regions Convert
Capacity, Pressure, Shape, Governance, and Growth into Usable Access

Use term:

- Metropolitan Transport Region
- MTR

Do not use:

- Metropolitan Transit Region

## Current Thesis 2 Gate

The Calgary lead is `mtr_src_005`.

Current reviewed source path:

```yaml
working_name: Calgary CMA
boundary_source_family: hybrid_functional_statistical_region
boundary_authority: Statistics Canada
source_path_status: boundary_and_profile_paths_identified
exact_cma_row_status: unresolved
service_overlay_status: unresolved
```

Relevant Thesis 2 artifacts:

- `theses/mobility-conversion/research/calgary_cma_boundary_population_source_path_review_2026-07-03.md`
- `theses/mobility-conversion/research/calgary_cma_exact_row_extraction_workflow_2026-07-04.md`
- `theses/mobility-conversion/research/source_notes/statistics_canada_2021_boundary_profile_source_paths_2026-07-03.md`
- `theses/mobility-conversion/research/source_notes/statistics_canada_cma_ca_2021_current_glossary_followup_2026-07-01.md`

## Research Purpose

Find traceable Statistics Canada and local transport sources needed to evaluate
the Calgary CMA lead.

This is not a request to prove Calgary has good transport.

This is not a request to compare Calgary to any other region.

This is not a request to calculate access, coverage, scores, or rankings.

## Research Questions

Answer these questions from official or primary sources:

1. What is the exact Statistics Canada geography identifier for Calgary CMA in
   the 2021 Census geography system?
2. What official source directly maps the name "Calgary" to that CMA code,
   DGUID, or equivalent geography identifier?
3. Which 2021 Census Boundary file product/layer contains the Calgary CMA
   geometry?
4. What official source provides the population denominator for the same Calgary
   CMA geography?
5. What field should be used for total resident population, and what census
   vintage does it represent?
6. What census subdivisions / municipalities are included in the Calgary CMA?
7. Does Statistics Canada documentation identify any Calgary-specific
   historical comparability, manual adjustment, merge, or secondary-core caveat?
8. What official Calgary Transit schedule/feed source exists, and what format,
   vintage, license, and access terms does it use?
9. Are there public-transport operators or services inside the Calgary CMA that
   are not represented by Calgary Transit?
10. Are regional bus, commuter, airport, paratransit, demand-responsive, or
    private services material inside the CMA?

## Required Source Families To Check

At minimum, check source paths in these families:

- Statistics Canada 2021 Census Boundary files;
- Statistics Canada 2021 Census Profile;
- Statistics Canada geographic hierarchy, GeoSuite, or equivalent official
  geography lookup if needed;
- Statistics Canada CMA/CA glossary/methodology;
- City of Calgary / Calgary Transit open data or developer sources;
- Calgary Transit schedule/GTFS/source data;
- regional municipal transit or intermunicipal service sources if material;
- airport/commuter/intercity bus sources if material.

Do not rely on Wikipedia, travel guides, blogs, city reputation, livability
rankings, or "best transit city" articles.

## Required Return Fields

Return a raw source bundle using this shape:

```yaml
calgary_cma_exact_row_return:
  return_status: raw_research_material_only
  reviewed_boundary:
    working_name: Calgary CMA
    source_authority: Statistics Canada
    exact_name:
    exact_code:
    DGUID_or_equivalent:
    geography_type:
    source_url_or_access_path:
    verification_status:
  boundary_artifact:
    product_title:
    catalogue_or_download_path:
    file_or_layer:
    vintage:
    identifier_field:
    raw_download_required_later:
  population_denominator:
    source_title:
    source_url_or_access_path:
    geography_identifier:
    population_field:
    vintage:
    value_returned: do_not_return_value_unless_needed_for_source_identification
    verification_status:
  building_blocks:
    census_subdivisions_or_municipalities:
    source_url_or_access_path:
    uncertainty_notes:
  methodology_caveats:
    commuting_flow_vintage:
    historical_comparability:
    manual_adjustment:
    merge_or_secondary_core:
    source_url_or_access_path:
  service_source_bundle:
    primary_service_source:
    source_authority:
    source_url_or_access_path:
    format:
    vintage_or_update_date:
    license_or_access_terms:
    coverage_against_CMA:
    missing_operators_or_modes:
  rejected_or_quarantined_material:
    - item:
      reason:
```

## Evidence Limits

The return must not:

- admit Calgary as an MTR;
- create a candidate list;
- score or rank Calgary;
- claim Calgary has good or bad transport;
- use Calgary Transit service geography as the MTR boundary;
- use GTFS extent, route buffers, stop buffers, fare zones, or agency coverage
  as the denominator;
- calculate population coverage;
- download raw datasets;
- archive raw feeds;
- write polished paper prose.

## Output Format

Return in this order:

1. Short method summary.
2. Source table.
3. YAML-style raw source bundle.
4. Exact geography row/code findings.
5. Boundary/population artifact findings.
6. Service/operator coverage findings.
7. Rejected/quarantined material.
8. Open questions for Thesis 2.
9. Source URL list.

## Intake Reminder

The Thesis 2 working thread will process the return through:

- raw-return buffer protocol;
- Deep Research return protocol;
- source-note verification;
- coverage reconciliation worksheet;
- evidence manifest process, only if raw artifacts are later acquired.

Do not present the return as final evidence.
