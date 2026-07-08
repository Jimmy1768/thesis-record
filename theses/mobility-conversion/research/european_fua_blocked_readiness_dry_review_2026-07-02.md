# European FUA Blocked Readiness Dry Review

Date: 2026-07-02

Status: blocked readiness dry review. No MTR admitted. No filled boundary
record, evidence manifest, candidate list, candidate-universe ledger, metric
record, score, ranking, or raw data archive is authorized.

Reviewed leads:

- `mtr_src_001` Helsinki FUA / `FI001F`
- `mtr_src_002` Lyon FUA / `FR002F`

Related protocol:

- `theses/mobility-conversion/research/european_fua_coverage_reconciliation_protocol.md`

Related gate note:

- `theses/mobility-conversion/research/european_fua_lead_gate_status_2026-07-01.md`

## Review Decision

Both European FUA leads fail readiness review at dry-review stage.

This is useful progress, not rejection. The dry review identifies the exact
blockers that must be resolved before either lead can move toward a
`record_status: not_admitted` boundary record or evidence manifest.

## Gate Summary

| Gate | Helsinki FUA / `FI001F` | Lyon FUA / `FR002F` |
| --- | --- | --- |
| Boundary source eligibility | Pass at source-family level | Pass at source-family level |
| Source verification | Partial pass | Partial pass |
| Boundary fit | Blocked pending coverage reconciliation | Blocked pending coverage reconciliation |
| Data bundle plausibility | Blocked pending denominator vintage and operator scan | Blocked pending static feed, denominator vintage, and operator scan |
| Evidence manifest need | Manifest not yet allowed because no raw artifact is being acquired | Manifest not yet allowed because no raw artifact is being acquired |
| Candidate-universe guardrail | Pass: no admission | Pass: no admission |

## Helsinki FUA Dry Review

```yaml
lead_id: mtr_src_001
working_name: Helsinki FUA
fua_code: FI001F
dry_review_decision: blocked_not_ready_for_boundary_record
blocking_decisions:
  - blocked_missing_population_vintage
  - blocked_missing_operator_inventory
  - blocked_coverage_against_fua_unknown
not_admitted_boundary_record_allowed: false
evidence_manifest_allowed: false
raw_archive_allowed: false
```

### Passed At Source-Family Level

- Eurostat/GISCO FUA exact row/code has been inspected.
- Eurostat `URB_LPOP1` population-denominator source family has been
  identified.
- HSL/Digitransit service-source family has been verified at source-note level.
- No reputation-led selection basis is present in the reviewed record.

### Readiness Blockers

- No population denominator year is selected.
- The inspected 2024 Eurostat population observation has a break-in-time-series
  flag requiring a status-flag policy decision.
- HSL/Digitransit service geography has not been reconciled against `FI001F`.
- Non-HSL operator completeness inside `FI001F` is unresolved.
- No raw GTFS, routing, realtime, geometry, or population artifact has been
  archived under manifest.
- Unserved or weakly served population visibility is unresolved.

### Helsinki Next Allowed Work

Allowed:

- denominator vintage/status-flag policy for `FI001F`;
- HSL coverage reconciliation worksheet against `FI001F`;
- non-HSL operator scan;
- later evidence manifest draft only if a raw artifact is intentionally
  acquired.

Not allowed:

- filled boundary record;
- accepted denominator value;
- service-derived boundary;
- metric record;
- score or ranking.

## Lyon FUA Dry Review

```yaml
lead_id: mtr_src_002
working_name: Lyon FUA
fua_code: FR002F
dry_review_decision: blocked_not_ready_for_boundary_record
blocking_decisions:
  - blocked_static_feed_unavailable
  - blocked_missing_population_vintage
  - blocked_missing_operator_inventory
  - blocked_coverage_against_fua_unknown
not_admitted_boundary_record_allowed: false
evidence_manifest_allowed: false
raw_archive_allowed: false
```

### Passed At Source-Family Level

- Eurostat/GISCO FUA exact row/code has been inspected and corrected to
  `FR002F`.
- `FR003F` has been identified as Lille and is not the Lyon FUA lead.
- Eurostat `URB_LPOP1` population-denominator source family has been
  identified.
- France NAP traces an official `Réseau urbain TCL` dataset under SYTRAL
  Mobilités.
- No reputation-led selection basis is present in the reviewed record.

### Readiness Blockers

- No population denominator year is selected.
- Inspected Eurostat `URB_LPOP1` current-year observations were missing for
  2023-2025.
- France NAP listed GTFS/NeTEx resources as unavailable in the inspected catalog
  response.
- Available SIRI Lite resources require a method note before they can substitute
  for static schedule archives.
- Non-TCL operator completeness inside `FR002F` is unresolved.
- TCL/SYTRAL service geography has not been reconciled against `FR002F`.
- No raw service, geometry, or population artifact has been archived under
  manifest.
- Unserved or weakly served population visibility is unresolved.

### Lyon Next Allowed Work

Allowed:

- static-feed availability follow-up for TCL/SYTRAL GTFS or NeTEx;
- France NAP licence/authentication follow-up;
- SIRI Lite method note only if static feed recovery fails;
- `FR002F` non-TCL operator scan;
- denominator vintage posture decision, likely historical/baseline unless a
  newer accepted source is found.

Not allowed:

- filled boundary record;
- accepted denominator value;
- service-derived boundary;
- metric record;
- score or ranking.

## Shared Method Finding

The dry review confirms that "boundary source exists" is not enough. A European
FUA lead needs a reconciled source bundle:

- independent FUA boundary;
- lead-specific population denominator vintage and status-flag policy;
- static or otherwise method-justified service source;
- operator completeness review;
- visibility of unserved/weakly served population;
- manifest plan before raw artifacts are archived.

## Next Recommended Artifact

Create a denominator vintage/status-flag policy for European FUA leads.

Reason:

- Helsinki is blocked by a break-flagged 2024 population observation.
- Lyon is blocked by missing 2023-2025 population observations.
- Without this policy, a worker cannot decide whether to use same-year,
  short-window, mixed-vintage, historical/baseline, or blocked status.

## Prohibited Outputs

This dry review does not authorize:

- admitted MTR;
- filled boundary record;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- raw data archive without manifest.
