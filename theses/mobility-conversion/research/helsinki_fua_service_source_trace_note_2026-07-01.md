# Helsinki FUA Service Source Trace Note

Date: 2026-07-01

Status: service-source trace note. No MTR admitted. No evidence manifest,
boundary record, candidate list, metric record, score, ranking, or raw data
archive is authorized.

Related lead:

- `mtr_src_001` Helsinki FUA / `FI001F`

Related source notes:

- `theses/mobility-conversion/research/source_notes/eurostat_gisco_urban_audit_fua_download_api_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/eurostat_urb_lpop1_fua_population_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/hsl_digitransit_service_sources_2026-07-01.md`

## Decision

HSL/Digitransit is traceable as an official service-source family for a later
Helsinki FUA service-overlay test.

This does not promote Helsinki FUA to readiness review. The service source is
verified only as a source family and must not define the MTR boundary or
denominator.

## Lead Status

Previous service status: `source_lead_only`

New service status: `source_family_verified_not_evidence`

Boundary status: exact FUA row verified for `FI001F`, but no filled boundary
record is authorized.

Denominator status: Eurostat `URB_LPOP1` source-family path found, but no
denominator value accepted.

## What Is Now Known

```yaml
helsinki_service_trace:
  independent_boundary_candidate:
    source: Eurostat GISCO Urban Audit FUA
    code: FI001F
    label: Helsinki/Helsingfors
    boundary_record_status: not_created
  service_source_family:
    source: HSL / Digitransit
    static_schedule_path: HSL GTFS package documented by HSL open data
    realtime_paths:
      service_alerts: https://realtime.hsl.fi/realtime/service-alerts/v2/hsl
      trip_updates: https://realtime.hsl.fi/realtime/trip-updates/v2/hsl
      vehicle_positions: https://realtime.hsl.fi/realtime/vehicle-positions/v2/hsl
    routing_data_path: https://api.digitransit.fi/routing-data/v3/hsl/
    license_posture: CC BY 4.0 with OSM ODbL caveat
    api_access_posture: registration/API key required for hosted Digitransit APIs
  current_classification: source_family_verified_not_evidence
```

## What Is Not Known

- Whether the HSL static GTFS package covers every material public-transport
  operator inside the `FI001F` FUA.
- Whether HSL service geography is materially smaller than the FUA.
- Which municipalities or edge areas of `FI001F` are outside HSL service
  coverage.
- Whether regional rail, ferry, demand-responsive, school, or non-HSL services
  need separate source handling.
- Whether accessibility fields, fare fields, or universal-access fields are
  sufficient for any outcome metric.
- Whether a scheduled-service metric is enough or realtime/reliability archives
  are required.

## Required Next Fields Before Readiness Review

```yaml
helsinki_ready_gate_remaining:
  boundary_record: not_created
  raw_geometry_manifest: not_created
  population_denominator:
    source_family: Eurostat URB_LPOP1
    selected_year: unresolved
    status_flag_policy: unresolved
  service_feed_archive:
    static_gtfs: not_archived
    realtime: not_archived
    manifest: not_created
  coverage_reconciliation:
    compare_hsl_feed_to_fi001f: unresolved
    missing_operator_scan: unresolved
    unserved_population_visibility: unresolved
  vintage_alignment:
    boundary: 2024 GISCO geometry path inspected
    population: unresolved
    service: unresolved
    routing_network: unresolved
```

## Method Rule

For Helsinki FUA, HSL/Digitransit service sources may become overlays or metric
inputs only after:

1. an independent `FI001F` boundary record exists;
2. a denominator vintage is selected and documented;
3. the feed archive has an evidence manifest;
4. source coverage is reconciled against the FUA boundary;
5. missing operators and unserved areas are explicitly recorded.

## Prohibited Moves

Do not:

- use HSL service area as the MTR;
- use GTFS extent, route buffers, stop buffers, fare zones, or Journey Planner
  coverage as a denominator;
- treat source richness as evidence of transport quality;
- use realtime observations without an archive plan;
- create a candidate list or score from this trace note.

## Next Allowed Output

Allowed:

- Eurostat/HSL license and attribution follow-up;
- Helsinki readiness checklist dry review with all unresolved fields marked
  blocked;
- France/Lyon service-source trace to keep European leads balanced.

## Prohibited Outputs

This note does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- raw data archive without manifest.
