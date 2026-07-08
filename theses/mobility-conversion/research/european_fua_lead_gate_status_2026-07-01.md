# European FUA Lead Gate Status

Date: 2026-07-01

Status: gate-status decision note. No MTR admitted. No filled boundary record,
evidence manifest, candidate list, metric record, score, ranking, or raw data
archive is authorized.

Related leads:

- `mtr_src_001` Helsinki FUA / `FI001F`
- `mtr_src_002` Lyon FUA / `FR002F`

Related records:

- `theses/mobility-conversion/research/eurostat_oecd_fua_exact_row_extraction_note_2026-07-01.md`
- `theses/mobility-conversion/research/eurostat_fua_population_denominator_path_note_2026-07-01.md`
- `theses/mobility-conversion/research/helsinki_fua_service_source_trace_note_2026-07-01.md`
- `theses/mobility-conversion/research/lyon_fua_service_source_trace_note_2026-07-01.md`

## Decision

Neither Helsinki FUA nor Lyon FUA is ready for a filled boundary record or
readiness promotion.

Both are source-led European FUA leads with useful progress:

- exact Eurostat/GISCO FUA row identification is resolved;
- the European population-denominator source family is identified;
- local service-source families are traced at source-note level.

But the remaining blockers are material, not administrative.

## Current Gate Matrix

| Gate | Helsinki FUA / `FI001F` | Lyon FUA / `FR002F` |
| --- | --- | --- |
| Correct FUA row/code | Passed source inspection | Passed source inspection |
| Raw-return correction needed | No | Yes: `FR003F` is Lille, not Lyon |
| Boundary geometry archive | Not created | Not created |
| Evidence manifest | Not created | Not created |
| Population source family | Eurostat `URB_LPOP1` identified | Eurostat `URB_LPOP1` identified |
| Population vintage | Unresolved | Unresolved |
| Population status/missingness | 2024 inspected observation has break flag; 2025 absent in inspected query | 2023-2025 absent in inspected query |
| Local service source | HSL/Digitransit source family verified | France NAP/TCL trace found |
| Static feed posture | HSL GTFS documented; archive not acquired | GTFS/NeTEx listed but unavailable in inspected catalog response |
| Service coverage against FUA | Unresolved | Unresolved |
| Missing operator scan | Unresolved | Unresolved |
| Readiness posture | Blocked pending denominator vintage and FUA coverage reconciliation | Blocked pending static feed, denominator vintage, and FUA coverage reconciliation |

## Approved Framing

- These are source-led leads, not selected cases.
- Eurostat/GISCO FUA boundaries are independent of service-feed geography.
- Service sources may become overlays or metric inputs only after independent
  boundary and denominator gates.
- Population values are not accepted until a lead-specific vintage, status flag,
  manifest, and alignment rule are recorded.
- Service source richness does not indicate transport quality.

## Blocking Questions

### Shared European FUA Blockers

- Which denominator vintage should be used when geometry, population, service,
  and routing inputs do not share the same year?
- What status-flag policy applies to Eurostat population observations with
  breaks in time series?
- How should service-feed coverage be compared against FUA boundaries without
  letting service geography define the MTR?
- What minimum missing-operator scan is required before a service feed can be
  used as an access input?
- What evidence manifest pattern should be used for raw geometry, population,
  and service archives?

### Helsinki-Specific Blockers

- Is the 2024 break-flagged population observation admissible for method tests,
  or should 2023 be preferred?
- Does HSL service coverage leave material parts of `FI001F` outside the
  source bundle?
- Are non-HSL services material inside `FI001F`?

### Lyon-Specific Blockers

- Can a current static GTFS or NeTEx file be recovered from the producer or
  another official source?
- If not, can SIRI Lite support the intended method without undermining
  reproducibility?
- Is a 2022 denominator acceptable only as a historical/baseline posture, or
  should Lyon remain blocked for current-performance testing?
- Which non-TCL services are material inside `FR002F`?

## Method Recommendation

Do not create a filled boundary record for either lead yet.

Next method step should be a coverage-reconciliation protocol for source-led
MTR leads. The protocol should define how to compare:

- independent boundary geometry;
- resident-population denominator;
- service/feed coverage;
- missing operators or modes;
- unserved or weakly served population visibility;
- source vintages and status flags.

Only after that protocol exists should a worker run a blocked readiness
checklist dry review for Helsinki and Lyon.

## Next Allowed Output

Allowed:

- European FUA coverage-reconciliation protocol;
- denominator vintage/status-flag policy;
- static-feed availability follow-up for Lyon;
- blocked readiness checklist dry review with no filled boundary record.

## Prohibited Outputs

This note does not authorize:

- admitted MTR;
- filled boundary record;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- raw data archive without manifest.
