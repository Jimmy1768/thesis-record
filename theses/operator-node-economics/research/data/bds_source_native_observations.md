# BDS Source-Native Observations

Status: BDS source-native context observations computed. Not quality review,
export, prediction-link creation, analysis, claim support, or paper prose.

Date: 2026-06-14.

## Purpose

Compute source-native BDS context observations from `bds_public_file_rows` using
the metric-computation design in
`research/data/bds_metric_computation_design.md`.

This is not aggregation, trend analysis, or claim support.

## Rails Objects

Service:

- `PublicSources::Bds::ComputeSourceNativeObservations`

Task:

```sh
bin/rails public_sources:bds:compute_source_native_observations
```

## Live Result

```text
eligible_rows=104880
observations_deleted=0
observations_created=746174
status_counts={"staged_context"=>746174}
quality_reviews_created=0
prediction_links_created=0
exports_created=0
```

Metric counts:

```text
bds_employment=80495
bds_establishment_entries=71326
bds_establishment_exits=64743
bds_establishments=80495
bds_firm_deaths=74475
bds_firms=80495
bds_job_creation=80495
bds_job_destruction=72161
bds_net_job_creation=80230
bds_reallocation_rate=61259
```

Blocked cells:

```text
bds_employment=24385
bds_establishment_entries=33554
bds_establishment_exits=40137
bds_establishments=24385
bds_firm_deaths=30405
bds_firms=24385
bds_job_creation=24385
bds_job_destruction=32719
bds_net_job_creation=24650
bds_reallocation_rate=43621
```

## Guardrails

The computation:

- uses source-native year-sector-firm-age-firm-size grain;
- creates observations only for numeric source cells;
- blocks flagged or null source cells;
- preserves source row ID and row hash in quality metadata;
- marks observations as `staged_context`;
- creates no quality reviews;
- creates no prediction links;
- creates no exports;
- does not authorize analysis or claim support.

## Boundary

BDS remains employer-firm dynamics context only. These observations do not
measure AI adoption, nonemployers, hidden contractors, management layers,
transaction costs, Operator Nodes, one-person firms, or firm-boundary change.

## Next Gate

BDS quality reviews are recorded in `research/data/bds_quality_reviews.md`.
The observations are reviewed context only, not claim-supporting evidence.
