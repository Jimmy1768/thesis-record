# Handoff: Bristol TTWA Exact Row / Source Bundle Request

Date: 2026-07-05

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

The Bristol lead is `mtr_src_003`.

Current reviewed source path:

```yaml
working_name: Bristol TTWA
boundary_source_family: national_commuting_zone
boundary_authority: ONS
source_path_status: source_family_relevance_verified_exact_paths_unresolved
exact_ttwa_row_status: unresolved
service_overlay_status: unresolved
```

Relevant Thesis 2 artifacts:

- `theses/mobility-conversion/research/bristol_ttwa_boundary_population_source_path_review_2026-07-05.md`
- `theses/mobility-conversion/research/bristol_ttwa_exact_row_extraction_workflow_2026-07-05.md`
- `theses/mobility-conversion/research/source_notes/ons_travel_to_work_areas_national_method_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ons_travel_to_work_caveats_2026-06-28.md`
- `theses/mobility-conversion/research/batch_s1e_local_service_source_verification_queue_2026-07-01.md`

## Research Purpose

Find traceable ONS and transport-service sources needed to evaluate the Bristol
TTWA lead.

This is not a request to prove Bristol has good transport.

This is not a request to compare Bristol to any other region.

This is not a request to calculate access, coverage, scores, or rankings.

## Research Questions

Answer these questions from official or primary sources:

1. What is the exact official geography identifier for the Bristol TTWA?
2. What official source directly maps the name "Bristol" to that TTWA code or
   equivalent geography identifier?
3. Which official boundary product/layer contains the Bristol TTWA geometry?
4. What is the TTWA boundary vintage and commuting-flow/data vintage?
5. What official source documents the current TTWA delineation method,
   self-containment rule, and building-block geography?
6. What official source provides or supports a population denominator for the
   same Bristol TTWA geography?
7. Is population available directly for TTWA, or must it be aggregated from
   smaller units through an official lookup?
8. What caveats does ONS provide about using 2011 TTWAs or post-2020
   travel-to-work data?
9. What NaPTAN stop data source covers the Bristol TTWA, and what vintage,
   license, and access terms apply?
10. What Bus Open Data Service source covers bus timetables in the Bristol
    TTWA, and what vintage, license, and access terms apply?
11. What rail, ferry, coach, demand-responsive, paratransit, or private service
    sources are material inside the Bristol TTWA?
12. Would a bus-only service bundle miss material service or unserved
    population inside the TTWA?

## Required Source Families To Check

At minimum, check source paths in these families:

- ONS TTWA boundary products;
- ONS Open Geography Portal or equivalent official ONS geography metadata;
- ONS geography code lists or lookup tables;
- ONS TTWA delineation methodology;
- ONS or official UK population denominator tables / lookup-based aggregation
  paths;
- NaPTAN;
- Bus Open Data Service;
- National Rail or rail schedule/source families if material;
- ferry, coach, demand-responsive, paratransit, or other local public-transport
  source families if material.

Do not rely on Wikipedia, travel guides, blogs, city reputation, livability
rankings, "best transit city" articles, congestion fame, or walkability
reputation.

## Required Return Fields

Return a raw source bundle using this shape:

```yaml
bristol_ttwa_exact_row_return:
  return_status: raw_research_material_only
  reviewed_boundary:
    working_name: Bristol TTWA
    source_authority: ONS
    exact_name:
    exact_code:
    geography_type:
    source_url_or_access_path:
    verification_status:
  boundary_artifact:
    product_title:
    catalogue_or_download_path:
    file_or_layer:
    vintage:
    identifier_field:
    license_or_reuse_terms:
    raw_download_required_later:
  population_denominator:
    source_title:
    source_url_or_access_path:
    geography_identifier:
    population_field:
    vintage:
    aggregation_method:
    value_returned: do_not_return_value_unless_needed_for_source_identification
    verification_status:
  methodology_caveats:
    commuting_flow_vintage:
    delineation_method:
    self_containment_rule:
    building_blocks:
    pandemic_or_remote_work_caveat:
    rural_hinterland_or_overinclusion_risk:
    source_url_or_access_path:
  service_source_bundle:
    naptan_source:
      source_authority:
      source_url_or_access_path:
      format:
      vintage_or_update_date:
      license_or_access_terms:
      coverage_against_TTWA:
    bus_open_data_source:
      source_authority:
      source_url_or_access_path:
      format:
      vintage_or_update_date:
      license_or_access_terms:
      coverage_against_TTWA:
    rail_or_other_modes:
      material_sources:
      source_url_or_access_path:
      coverage_against_TTWA:
      missing_operators_or_modes:
  rejected_or_quarantined_material:
    - item:
      reason:
```

## Evidence Limits

The return must not:

- admit Bristol as an MTR;
- create a candidate list;
- score or rank Bristol;
- claim Bristol has good or bad transport;
- use NaPTAN, Bus Open Data Service, rail, route, stop, fare-zone, or agency
  coverage as the MTR boundary;
- use service geography as the denominator;
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
