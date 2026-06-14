# BFS Dry-Run Query Validation

Status: dry-run query validation. This remains validation-only and performs no
data writes, even after the separate V1 sample-row load. Not metric
computation, quantitative analysis, export, claim support, paper prose, or
thesis evidence.

Run date: 2026-06-13.

## Purpose

Validate the BFS API query shape and V1 policy filters independently from row
storage.

## Rails Task

```sh
bin/rails public_sources:bfs:dry_run_query
```

The task:

- loads `CENSUS_API_KEY` from the process environment or ignored `.env.local`;
- never prints the key;
- calls the official BFS API example-shape query;
- validates response header shape;
- filters the in-memory rows to the V1 target scope;
- verifies target `data_type_code` values, seasonality, `time_slot_id`, and
  `error_data`;
- confirms database counts are unchanged.

The dry-run validator intentionally allows existing staged `bfs_api_rows` so it
can be re-run after the V1 sample-row load documented in
`research/data/bfs_sample_row_load.md`.

## Query Shape

```text
get=data_type_code,time_slot_id,seasonally_adj,category_code,cell_value,error_data
time=2012
for=us:*
```

## V1 Eligible Scope

- `seasonally_adj=no`
- target series only:
  - `BA_BA`
  - `BA_HBA`
  - `BF_BF4Q`
  - `BF_BF8Q`
  - `BF_PBF4Q`
  - `BF_PBF8Q`
- first-pass category codes from `living_dissertation_policy.yml`
- U.S. geography only

## Guardrail

The dry run must leave unchanged:

- `bfs_api_rows`
- BFS metric definitions
- BFS metric observations
- BFS prediction links
- export-created audit events

BFS remains an indirect payroll-transition proxy only.
