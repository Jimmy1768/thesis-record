# Handoff: Helsinki FUA Operator Inventory / Coverage Request

Date: 2026-07-03

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

The Helsinki FUA lead is `mtr_src_001`.

Current reviewed boundary unit:

```yaml
working_name: Helsinki FUA
fua_code: FI001F
boundary_source_family: Eurostat GISCO Urban Audit FUA
boundary_status: exact_row_verified_not_archived
population_posture: short_window_candidate_unflagged_2023
service_source_family: HSL / Digitransit
current_blocker: operator_inventory_and_service_coverage_against_FI001F_unresolved
```

Relevant Thesis 2 artifacts:

- `theses/mobility-conversion/research/helsinki_fua_coverage_reconciliation_worksheet_2026-07-03.md`
- `theses/mobility-conversion/research/european_fua_coverage_reconciliation_protocol.md`
- `theses/mobility-conversion/research/source_notes/hsl_digitransit_service_sources_2026-07-01.md`
- `theses/mobility-conversion/research/european_fua_denominator_vintage_worksheet_2026-07-03.md`

## Research Purpose

Find source-led evidence about whether HSL/Digitransit service sources cover all
material public-transport service inside the Eurostat/GISCO Helsinki FUA
`FI001F`.

This is not a request to prove Helsinki has good transport.

This is not a request to compare Helsinki to any other region.

This is not a request to calculate access, coverage, scores, or rankings.

## Research Questions

Answer these questions from traceable sources:

1. What municipalities, localities, or named subareas are included in the
   Eurostat/GISCO Helsinki FUA `FI001F`, or what official source can identify
   them?
2. What municipalities, operators, and modes are covered by HSL service data,
   HSL GTFS, HSL GTFS-RT, Digitransit routing data, or related official HSL
   open-data products?
3. Are there parts of `FI001F` outside the HSL service area or outside HSL
   schedule/routing feed coverage?
4. Are there public-transport operators or modes inside `FI001F` that are not
   represented by HSL/Digitransit sources?
5. Are regional rail, interurban bus, ferry, demand-responsive, paratransit,
   school, or municipal services material inside `FI001F`?
6. Does Digitransit include non-HSL operators, national rail, Waltti operators,
   Matkahuolto/intercity coach, or other feeds relevant to the Helsinki FUA?
7. What licenses, registration requirements, API-key requirements, or reuse
   limits apply to the sources needed for this operator inventory?
8. Which source paths can later support an evidence manifest if raw feeds are
   intentionally acquired?

## Required Source Families To Check

At minimum, check source paths in these families:

- Eurostat/GISCO Urban Audit FUA metadata or geodata for `FI001F`;
- HSL open data;
- HSL GTFS and GTFS-RT documentation;
- Digitransit API and routing-data documentation;
- Finnish national or regional transport-data portals if relevant;
- national rail operator/infrastructure data if regional rail is material;
- Waltti or other Finnish regional public transport sources if relevant;
- Matkahuolto or interurban coach sources if relevant;
- municipal/regional ferry or demand-responsive service sources if relevant.

Do not rely on Wikipedia, travel guides, blogs, city reputation, livability
rankings, or "best transit city" articles.

## Required Return Fields

Return a raw source bundle using this shape:

```yaml
helsinki_operator_inventory_return:
  return_status: raw_research_material_only
  reviewed_boundary:
    fua_code: FI001F
    boundary_source:
    source_url_or_access_path:
    municipalities_or_subareas_found:
    uncertainty_notes:
  hsl_digitransit_coverage:
    source_name:
    source_authority:
    source_url_or_access_path:
    modes_or_operators_claimed:
    municipalities_or_geography_claimed:
    feed_or_api_format:
    vintage_or_update_date:
    access_or_license_terms:
    verification_status:
  possible_missing_operators_or_modes:
    - operator_or_mode:
      reason_it_may_matter:
      source_url_or_access_path:
      geography_relevance_to_FI001F:
      verification_status:
  coverage_risk_assessment:
    likely_inside_hsl_digitransit:
    likely_outside_hsl_digitransit:
    unclear:
    high_risk_missingness:
  recommended_next_source_notes:
    - source_name:
      reason:
      source_url_or_access_path:
  rejected_or_quarantined_material:
    - item:
      reason:
```

## Evidence Limits

The return must not:

- admit Helsinki as an MTR;
- create a candidate list;
- score or rank Helsinki;
- claim Helsinki has good or bad transport;
- use HSL service geography as the MTR boundary;
- use GTFS extent, route buffers, stop buffers, fare zones, or Journey Planner
  coverage as the denominator;
- calculate population coverage;
- download raw datasets;
- archive raw feeds;
- write polished paper prose.

## Output Format

Return in this order:

1. Short method summary.
2. Source table.
3. YAML-style raw source bundle.
4. Possible missing operators/modes.
5. Rejected/quarantined material.
6. Open questions for Thesis 2.
7. Source URL list.

## Intake Reminder

The Thesis 2 working thread will process the return through:

- raw-return buffer protocol;
- Deep Research return protocol;
- source-note verification;
- coverage reconciliation worksheet;
- evidence manifest process, only if raw artifacts are later acquired.

Do not present the return as final evidence.
