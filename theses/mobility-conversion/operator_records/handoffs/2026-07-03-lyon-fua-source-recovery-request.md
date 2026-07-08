# Handoff: Lyon FUA Static Feed / SIRI Lite / Operator Recovery Request

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

The Lyon FUA lead is `mtr_src_002`.

Current reviewed boundary unit:

```yaml
working_name: Lyon FUA
fua_code: FR002F
boundary_source_family: Eurostat GISCO Urban Audit FUA
boundary_status: exact_row_verified_not_archived
population_posture: historical_baseline_only_or_blocked_current_testing
service_source_family: France NAP / Réseau urbain TCL
current_blockers:
  - static_GTFS_or_NeTEx_unavailable_in_refreshed_catalog_metadata
  - SIRI_Lite_method_unresolved
  - non_TCL_operator_inventory_unresolved
  - coverage_against_FR002F_unresolved
```

Relevant Thesis 2 artifacts:

- `theses/mobility-conversion/research/lyon_tcl_static_feed_availability_followup_2026-07-03.md`
- `theses/mobility-conversion/research/lyon_siri_lite_method_feasibility_note_2026-07-03.md`
- `theses/mobility-conversion/research/lyon_fua_service_source_trace_note_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/france_nap_lyon_tcl_service_sources_2026-07-01.md`

## Research Purpose

Find traceable source-led answers for Lyon FUA service-source recovery.

This is not a request to prove Lyon has good transport.

This is not a request to compare Lyon to any other region.

This is not a request to calculate access, coverage, scores, or rankings.

## Research Questions

Answer these questions from traceable official or primary sources:

1. Is there a current official GTFS or NeTEx source for `Réseau urbain TCL`,
   SYTRAL Mobilités, or TCL Lyon outside the currently inspected France NAP
   catalog resource flags?
2. If the France NAP lists GTFS/NeTEx resources as unavailable, is there an
   official explanation, replacement path, authentication process, or producer
   page that provides current static schedule data?
3. What official documentation defines the listed TCL SIRI Lite resources:
   `estimated-timetables`, `situation-exchange`, and `vehicle-monitoring`?
4. Can SIRI Lite `estimated-timetables` provide a reproducible scheduled-service
   snapshot, or is it only an operational/dynamic view?
5. What fields does the TCL SIRI Lite source expose for stops, routes, trips,
   calendar/validity, operators, modes, accessibility, and service disruptions?
6. What license, authentication, registration, or API-key requirements apply to
   TCL/SYTRAL data, France NAP resources, Grand Lyon resources, and SIRI Lite
   endpoints?
7. What non-TCL operators or modes are material inside Eurostat/GISCO Lyon FUA
   `FR002F`?
8. Are regional rail, Rhônexpress, regional coach/interurban bus,
   demand-responsive transport, paratransit, school services, or other local
   services inside `FR002F` outside the TCL/SYTRAL source bundle?
9. Which source paths can later support an evidence manifest if raw feeds are
   intentionally acquired?

## Required Source Families To Check

At minimum, check source paths in these families:

- France National Access Point / transport.data.gouv.fr;
- data.gouv.fr resource metadata for TCL/SYTRAL;
- SYTRAL Mobilités official data pages;
- TCL official data or developer pages;
- Grand Lyon open data pages for the listed SIRI Lite endpoints;
- French mobility license documentation;
- regional rail official sources if material;
- Rhônexpress official/source data if material;
- regional coach/interurban bus sources if material;
- local demand-responsive/paratransit sources if material;
- Eurostat/GISCO source only for confirming `FR002F`, not for service coverage.

Do not rely on Wikipedia, travel guides, blogs, livability rankings, or
"best transit city" articles.

## Required Return Fields

Return a raw source bundle using this shape:

```yaml
lyon_source_recovery_return:
  return_status: raw_research_material_only
  reviewed_boundary:
    fua_code: FR002F
    boundary_source:
    source_url_or_access_path:
    service_coverage_relevance:
    uncertainty_notes:
  static_feed_recovery:
    gtfs:
      source_found:
      source_authority:
      source_url_or_access_path:
      current_or_stale:
      authentication_or_license:
      verification_status:
    netex:
      source_found:
      source_authority:
      source_url_or_access_path:
      current_or_stale:
      authentication_or_license:
      verification_status:
  siri_lite_feasibility:
    source_name:
    source_authority:
    source_url_or_access_path:
    schema_documentation:
    snapshot_or_dynamic:
    fields_available:
    archive_reproducibility:
    license_or_authentication_terms:
    verification_status:
  possible_missing_operators_or_modes:
    - operator_or_mode:
      reason_it_may_matter:
      source_url_or_access_path:
      geography_relevance_to_FR002F:
      verification_status:
  coverage_risk_assessment:
    likely_inside_TCL_SYTRAL:
    likely_outside_TCL_SYTRAL:
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

- admit Lyon as an MTR;
- create a candidate list;
- score or rank Lyon;
- claim Lyon has good or bad transport;
- use TCL/SYTRAL service geography as the MTR boundary;
- use GTFS extent, route buffers, stop buffers, fare zones, catalog covered
  areas, or SIRI Lite coverage as the denominator;
- calculate population coverage;
- download raw datasets;
- archive raw feeds;
- write polished paper prose.

## Output Format

Return in this order:

1. Short method summary.
2. Source table.
3. YAML-style raw source bundle.
4. Static GTFS/NeTEx recovery findings.
5. SIRI Lite schema/licence findings.
6. Possible missing operators/modes.
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
