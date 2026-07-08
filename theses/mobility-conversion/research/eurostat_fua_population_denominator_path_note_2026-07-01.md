# Eurostat FUA Population Denominator Path Note

Date: 2026-07-01

Status: denominator-path decision note. No MTR admitted. No boundary record,
candidate list, metric record, score, ranking, or raw evidence archive is
authorized.

Related source notes:

- `theses/mobility-conversion/research/source_notes/eurostat_gisco_urban_audit_fua_download_api_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/eurostat_urb_lpop1_fua_population_2026-07-01.md`

Related extraction note:

- `theses/mobility-conversion/research/eurostat_oecd_fua_exact_row_extraction_note_2026-07-01.md`

## Decision

Eurostat `URB_LPOP1` is accepted as the candidate population-denominator source
family for European Eurostat/GISCO FUA leads at formation stage.

This is a source-family decision only. No lead has an accepted denominator yet.

## Denominator Path Shape

```yaml
population_denominator_path:
  source_name: Eurostat URB_LPOP1
  source_authority: Eurostat / European Commission
  source_url_or_access_path: https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/urb_lpop1
  geography_alignment: >
    Query by Eurostat Urban Audit FUA code through the `cities` dimension,
    after the same FUA code has been verified in the GISCO Urban Audit boundary
    source.
  candidate_indicator:
    indic_ur: DE1001V
    label: Population on the 1st of January, total
  required_dimensions:
    - freq
    - indic_ur
    - cities
    - time
  aggregation_or_reconciliation_method: >
    None at source-family stage. Do not aggregate, interpolate, carry forward,
    or reconcile values without a lead-specific method note.
  mismatch_notes: >
    Population availability and status flags vary by FUA and year. The
    denominator path is feasible, but not automatically aligned to the 2024
    GISCO geometry vintage or to service/feed vintages.
```

## Lead Effects

### Helsinki FUA / `FI001F`

Current status: remains `ready_for_lead_review`.

Effect:

- denominator source family found;
- `FI001F` is queryable through `URB_LPOP1` using `cities=FI001F`;
- inspected total-population observations are present for 2020-2024;
- inspected 2024 observation carries Eurostat status flag `b` / break in time
  series;
- 2025 is present in the response time dimension but has no observation in the
  inspected query.

Required before any readiness promotion:

- decide whether 2023, 2024 flagged, or another year is the candidate
  denominator vintage;
- document vintage alignment against GISCO geometry, service-source vintage,
  and any opportunity/access input;
- resolve service-source trace and coverage against the FUA;
- create an evidence manifest before archiving raw API responses.

### Lyon FUA / `FR002F`

Current status: remains `needs_source_trace`.

Effect:

- denominator source family found;
- `FR002F` is queryable through `URB_LPOP1` using `cities=FR002F`;
- inspected total-population observations are present for 2020-2022;
- inspected 2023, 2024, and 2025 positions have no observations.

Required before any readiness promotion:

- decide whether an older denominator year can be used under a
  `mixed_vintage_with_rationale` or `historical_or_baseline_only` posture;
- do not silently substitute 2022 for current performance;
- resolve France local service-source trace;
- document why the corrected FUA code `FR002F` is used and why `FR003F` is not;
- create an evidence manifest before archiving raw API responses.

## Method Rule

For European FUA leads, denominator acceptance is a two-step gate:

1. Verify the source family and query shape.
2. Verify the lead-specific observation year, status flag, and vintage
   alignment.

Passing step 1 does not pass step 2.

## Manifest Trigger Check

No evidence manifest is created by this note.

Reason:

- only API shape, dimensions, labels, response metadata, and observation
  presence were inspected;
- raw API responses were not archived in the repo;
- no population value was accepted;
- no denominator was transformed, interpolated, aggregated, or used in a metric.

Manifest required before:

- storing raw Eurostat population responses in the repository;
- deriving an accepted population denominator;
- transforming or joining population values to geometry;
- using population values in any metric test or boundary record.

## Open Questions

- What analysis vintage should European FUA lead tests target first?
- Should flagged observations such as Eurostat status `b` be allowed for
  denominator work, and under what caveat?
- Is a 2022 denominator acceptable for a later service-source year, or should
  Lyon remain blocked until a same-window denominator is found?
- Which source should verify Eurostat reuse/license terms before API responses
  are archived?

## Next Allowed Output

Allowed:

- service-source trace note for Helsinki or Lyon;
- Eurostat license/reuse source note;
- lead-specific readiness checklist review only after boundary, denominator,
  service trace, and vintage alignment are complete.

## Prohibited Outputs

This note does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- raw data archive without manifest.
