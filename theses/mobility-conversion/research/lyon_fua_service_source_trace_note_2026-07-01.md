# Lyon FUA Service Source Trace Note

Date: 2026-07-01

Status: service-source trace note. No MTR admitted. No evidence manifest,
boundary record, candidate list, metric record, score, ranking, or raw data
archive is authorized.

Related lead:

- `mtr_src_002` Lyon FUA / `FR002F`

Related source notes:

- `theses/mobility-conversion/research/source_notes/eurostat_gisco_urban_audit_fua_download_api_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/eurostat_urb_lpop1_fua_population_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/france_nap_lyon_tcl_service_sources_2026-07-01.md`

## Decision

The Lyon service-source trace has moved from unknown source trace to traced but
not sufficient.

France NAP identifies an official `Réseau urbain TCL` dataset for Lyon, with
SYTRAL Mobilités as publisher/legal owner. However, the inspected API response
shows current availability risk: SIRI Lite resources are available, while listed
GTFS and NeTEx resources are unavailable in the catalog response.

## Lead Status

Previous service status: `needs_source_trace`

New service status: `source_trace_found_static_feed_unresolved`

Boundary status: exact FUA row verified for `FR002F`, but no filled boundary
record is authorized.

Denominator status: Eurostat `URB_LPOP1` source-family path found, but no
denominator value accepted; inspected current-year observations were missing
for 2023-2025.

## What Is Now Known

```yaml
lyon_service_trace:
  independent_boundary_candidate:
    source: Eurostat GISCO Urban Audit FUA
    code: FR002F
    label: Lyon
    correction_note: FR003F is Lille, not Lyon
    boundary_record_status: not_created
  service_source_family:
    catalog: France National Access Point transport.data.gouv.fr
    dataset_id: 5de42c4d8b4c417a10e62ec9
    title: Réseau urbain TCL
    publisher: SYTRAL Mobilités
    legal_owner: SYTRAL Mobilités
    license: mobility-licence
    available_resources:
      - SIRI Lite estimated timetables
      - SIRI Lite situation exchange
      - SIRI Lite vehicle monitoring
    listed_unavailable_resources:
      - GTFS
      - NeTEx
      - PDF documentation
    api_access_posture: catalog tag includes authentification_requise
  current_classification: source_trace_found_static_feed_unresolved
```

## What Is Not Known

- Whether a current static GTFS or NeTEx file is recoverable from the producer
  or another official source.
- Whether SIRI Lite can support the intended scheduled-service/access method
  without a static GTFS archive.
- Which non-TCL operators are material inside `FR002F`.
- Whether regional rail, Rhônexpress, regional coach, or demand-responsive
  services require separate feed sources.
- Whether TCL/SYTRAL coverage materially under-covers the Eurostat/GISCO Lyon
  FUA.
- What the full `mobility-licence` and authentication conditions require for
  reproducible research use.

## Required Next Fields Before Readiness Review

```yaml
lyon_ready_gate_remaining:
  boundary_record: not_created
  raw_geometry_manifest: not_created
  population_denominator:
    source_family: Eurostat URB_LPOP1
    selected_year: unresolved
    status_flag_policy: unresolved
    current_year_missingness: observed for 2023-2025 in inspected query
  service_feed_archive:
    static_gtfs_or_netex: unavailable_in_inspected_catalog_response
    siri_lite: available_but_method_unresolved
    manifest: not_created
  coverage_reconciliation:
    compare_tcl_sytral_to_fr002f: unresolved
    missing_operator_scan: unresolved
    unserved_population_visibility: unresolved
  vintage_alignment:
    boundary: 2024 GISCO geometry path inspected
    population: unresolved, likely older than current if using URB_LPOP1
    service: unresolved
    routing_network: unresolved
```

## Method Rule

For Lyon FUA, France NAP/TCL sources may become overlays or metric inputs only
after:

1. an independent `FR002F` boundary record exists;
2. a denominator vintage is selected and documented;
3. static schedule availability or SIRI Lite substitution is methodologically
   resolved;
4. raw feed acquisition has an evidence manifest;
5. material non-TCL operators and services inside `FR002F` are identified;
6. source coverage is reconciled against the FUA boundary.

## Prohibited Moves

Do not:

- use TCL, SYTRAL, catalog covered areas, routes, stops, or service geography as
  the MTR;
- treat unavailable historical GTFS metadata as current service evidence;
- silently substitute SIRI Lite for GTFS without a method note;
- treat source availability as evidence of transport quality;
- create a candidate list or score from this trace note.

## Next Allowed Output

Allowed:

- France NAP licence/authentication follow-up;
- static-feed availability follow-up for TCL/SYTRAL;
- `FR002F` non-TCL operator scan;
- blocked readiness checklist dry review.

## Prohibited Outputs

This note does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- raw data archive without manifest.
