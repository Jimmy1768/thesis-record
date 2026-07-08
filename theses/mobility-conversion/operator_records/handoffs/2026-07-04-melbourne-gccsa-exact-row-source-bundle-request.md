# Handoff: Greater Melbourne GCCSA Exact Row / Source Bundle Request

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

The Greater Melbourne lead is `mtr_src_006`.

Current reviewed source path:

```yaml
working_name: Greater Melbourne GCCSA
boundary_source_family: hybrid_functional_statistical_region
boundary_authority: Australian Bureau of Statistics
source_path_status: asgs_gccsa_source_family_identified
exact_gccsa_row_status: unresolved
service_overlay_status: unresolved
```

Relevant Thesis 2 artifacts:

- `theses/mobility-conversion/research/melbourne_gccsa_boundary_population_source_path_review_2026-07-04.md`
- `theses/mobility-conversion/research/melbourne_gccsa_exact_row_extraction_workflow_2026-07-04.md`
- `theses/mobility-conversion/research/source_notes/abs_asgs_sa4_gccsa_2026-06-28.md`

## Research Purpose

Find traceable ABS and Victorian transport sources needed to evaluate the
Greater Melbourne GCCSA lead.

This is not a request to prove Melbourne has good transport.

This is not a request to compare Melbourne to any other region.

This is not a request to calculate access, coverage, scores, or rankings.

## Research Questions

Answer these questions from official or primary sources:

1. What is the exact ABS geography identifier for Greater Melbourne GCCSA in
   ASGS Edition 3?
2. What official source directly maps the name "Greater Melbourne" to that
   GCCSA code or equivalent identifier?
3. Which ABS boundary file/product/layer contains the Greater Melbourne GCCSA
   geometry?
4. What official source provides the population denominator for the same GCCSA
   geography?
5. What field should be used for total resident population, and what census or
   estimate vintage does it represent?
6. Which SA4s are included in Greater Melbourne GCCSA?
7. Does ABS documentation identify any Greater Melbourne-specific functional,
   stability, or ASGS edition-transition caveat?
8. What official Victoria DTP / PTV GTFS or schedule source exists, and what
   format, vintage, license, and access terms does it use?
9. Are there public-transport operators or modes inside Greater Melbourne GCCSA
   that are not represented by the primary Victoria DTP/PTV feed?
10. Are regional rail, coach, ferry, demand-responsive, paratransit, school,
    airport, or privately operated services material inside the GCCSA?

## Required Source Families To Check

At minimum, check source paths in these families:

- ABS ASGS Edition 3 GCCSA documentation;
- ABS ASGS boundary files;
- ABS population/census profile or regional population sources;
- ABS correspondence files for GCCSA to SA4 if available;
- Victoria Department of Transport and Planning / PTV open data;
- PTV GTFS or timetable data;
- regional rail/coach/ferry sources if material;
- demand-responsive/paratransit or other non-standard service sources if
  material.

Do not rely on Wikipedia, travel guides, blogs, city reputation, livability
rankings, or "best transit city" articles.

## Required Return Fields

Return a raw source bundle using this shape:

```yaml
melbourne_gccsa_exact_row_return:
  return_status: raw_research_material_only
  reviewed_boundary:
    working_name: Greater Melbourne GCCSA
    source_authority: Australian Bureau of Statistics
    exact_name:
    exact_code:
    ASGS_edition:
    geography_type: GCCSA
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
    SA4_membership:
    source_url_or_access_path:
    uncertainty_notes:
  methodology_caveats:
    functional_basis:
    statistical_stability:
    ASGS_edition_transition:
    source_url_or_access_path:
  service_source_bundle:
    primary_service_source:
    source_authority:
    source_url_or_access_path:
    format:
    vintage_or_update_date:
    license_or_access_terms:
    coverage_against_GCCSA:
    missing_operators_or_modes:
  rejected_or_quarantined_material:
    - item:
      reason:
```

## Evidence Limits

The return must not:

- admit Greater Melbourne as an MTR;
- create a candidate list;
- score or rank Greater Melbourne;
- claim Greater Melbourne has good or bad transport;
- use Victoria DTP/PTV feed geography as the MTR boundary;
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
