# European FUA Coverage Reconciliation Protocol

Status: formation-stage method protocol. No MTR admitted. No filled boundary
record, evidence manifest, candidate list, metric record, score, ranking, or raw
data archive is authorized.

Last updated: 2026-07-01

Applies first to:

- `mtr_src_001` Helsinki FUA / `FI001F`
- `mtr_src_002` Lyon FUA / `FR002F`

## Purpose

Define the minimum reconciliation work required before a European
Eurostat/GISCO FUA lead can use local service sources in a readiness review or
method test.

The protocol exists to prevent three mistakes:

- treating service-source geography as the MTR boundary;
- hiding unserved or weakly served population outside the feed footprint;
- mixing boundary, population, and service vintages without an explicit caveat.

## Inputs Required Before Reconciliation

A lead cannot enter coverage reconciliation until these source-family gates are
complete:

```yaml
required_source_family_gates:
  boundary:
    exact_fua_code_verified: true
    source_family: Eurostat GISCO Urban Audit FUA
    raw_geometry_archived: false
  population:
    candidate_source_family_identified: true
    source_family: Eurostat URB_LPOP1
    accepted_denominator_value: false
  service:
    local_service_source_family_traced: true
    raw_feed_archived: false
```

If any gate is missing, the lead remains in source-trace work and must not move
to readiness review.

## Reconciliation Units

The reconciliation must keep these units separate:

| Unit | Role | Can Define MTR? |
| --- | --- | --- |
| Eurostat/GISCO FUA polygon | Independent boundary candidate | Yes, after boundary-record gate |
| Eurostat `URB_LPOP1` population observation | Resident denominator candidate | No |
| GTFS / NeTEx / SIRI / routing data | Service/network overlay | No |
| Agency service area or fare zone | Governance/service context | No |
| Stops, route shapes, vehicle observations | Service evidence inputs | No |
| OSM/routing graph | Travel-time method input | No |

## Minimum Reconciliation Fields

Record the following before any readiness checklist dry review:

```yaml
coverage_reconciliation:
  lead_id:
  fua_code:
  boundary_source:
  boundary_vintage:
  boundary_geometry_status:
  population_source:
  population_candidate_year:
  population_status_flag:
  population_missingness_review:
  service_source_family:
  static_feed_status:
  realtime_feed_status:
  service_feed_vintage:
  service_feed_validity_window:
  service_geography_basis:
  service_geography_not_used_as_boundary: true
  operator_inventory_status:
  missing_operator_scan_status:
  modes_covered:
  modes_missing_or_unknown:
  non_fixed_route_services_review:
  regional_rail_or_interurban_review:
  fare_or_accessibility_fields_review:
  unserved_population_visibility_method:
  edge_area_review:
  vintage_alignment_class:
  license_and_access_status:
  evidence_manifest_status:
  reconciliation_decision:
  blockers:
```

## Operator Completeness Rule

The operator scan must start from the independent FUA boundary, not from the
service feed.

Minimum questions:

- Which public-transport operators provide service inside the FUA polygon?
- Which operators are inside the feed source and which are outside it?
- Are regional rail, interurban coach, airport connector, ferry,
  demand-responsive, paratransit, or school services material?
- Are there edge municipalities or commuting corridors with service not covered
  by the primary local feed?
- Would excluding an operator materially change access to opportunities,
  service availability, or travel-time estimates?

If these cannot be answered, set:

```yaml
operator_inventory_status: unresolved
reconciliation_decision: blocked_missing_operator_inventory
```

## Unserved Population Visibility Rule

A service feed can only support an access method if the method can see both
served and unserved residents inside the FUA.

Acceptable formation-stage approaches:

- intersect feed stop/service coverage with an independent resident-population
  grid or tract/LAU geography;
- classify FUA subareas as served, weakly served, or unserved with documented
  thresholds;
- explicitly mark population outside service-source coverage as visible
  missingness rather than dropping it.

Prohibited:

- clipping the MTR to the feed footprint;
- dropping areas with no stops because they have no service records;
- treating route/stop buffers as population denominators;
- counting only places the journey planner can route.

## Static vs Realtime Rule

Formation-stage access tests should prefer archived static schedule data when
the question is scheduled service availability or scheduled travel time.

Realtime feeds may be used only when:

- the metric question requires realtime or reliability information;
- the observation window is defined;
- raw observations are archived under a manifest;
- missingness, outages, and sampling bias are documented.

If only SIRI Lite or realtime-like resources are available, the lead must
receive one of these statuses:

```yaml
static_feed_status: unavailable_or_unresolved
reconciliation_decision:
  - blocked_static_feed_unavailable
  - eligible_for_siri_lite_method_test_only
```

The second status requires a separate method note.

## Vintage Alignment Rule

Each reconciliation must classify vintage alignment using the existing
source-vintage alignment rule:

- `same_year_alignment`
- `short_window_alignment`
- `mixed_vintage_with_rationale`
- `historical_or_baseline_only`
- `not_aligned_do_not_compare`
- `unknown_vintage_do_not_use`

Default decisions:

- If boundary and service vintages are known but population year is missing,
  the lead is blocked.
- If population is older than the service source by more than a short window,
  use `mixed_vintage_with_rationale` or `historical_or_baseline_only`.
- If a status flag indicates break in time series, record the flag and require
  a status-flag decision before metric use.

## Lead-Specific Starting Status

### Helsinki FUA / `FI001F`

```yaml
lead_id: mtr_src_001
fua_code: FI001F
reconciliation_start_status: source_family_ready_for_reconciliation
known_blockers:
  - selected population year unresolved
  - 2024 population break flag needs policy decision
  - HSL coverage against FI001F unresolved
  - non-HSL operator scan unresolved
  - raw feed archive not created
```

### Lyon FUA / `FR002F`

```yaml
lead_id: mtr_src_002
fua_code: FR002F
reconciliation_start_status: source_trace_found_but_static_feed_unresolved
known_blockers:
  - selected population year unresolved
  - current-year population missingness observed for 2023-2025
  - static GTFS/NeTEx unavailable in inspected catalog response
  - SIRI Lite substitution method unresolved
  - non-TCL operator scan unresolved
  - raw feed archive not created
```

## Reconciliation Decisions

Allowed formation-stage decisions:

- `ready_for_blocked_readiness_dry_review`
- `blocked_missing_population_vintage`
- `blocked_static_feed_unavailable`
- `blocked_missing_operator_inventory`
- `blocked_coverage_against_fua_unknown`
- `eligible_for_siri_lite_method_test_only`
- `quarantined_service_source_not_reproducible`

No decision here admits an MTR or accepts evidence.

## Next Allowed Output

Allowed:

- lead-specific coverage reconciliation worksheet;
- blocked readiness checklist dry review;
- denominator vintage/status-flag policy;
- static-feed availability follow-up;
- operator inventory source note.

## Prohibited Outputs

This protocol does not authorize:

- admitted MTR;
- filled boundary record;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- raw data archive without manifest.
