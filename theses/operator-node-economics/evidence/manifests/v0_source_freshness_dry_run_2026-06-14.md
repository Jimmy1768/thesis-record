# Operator Nodes V0 Source Freshness Dry Run: 2026-06-14 UTC

Status: executed read-only dry run.

## Scope

This manifest records the first production source-freshness dry run for the
Operator Nodes v0 baseline. The run checked configured public-source endpoints
for SUSB, BFS, and BDS with network access enabled.

This was not ingestion. It did not store raw files, insert source rows, compute
metrics, create quality reviews, create claim reviews, create prediction links,
change claim or forecast status, edit paper prose, or publish v0.

## Execution

- Host: `sourcecombatives-web`
- Repository path: `/home/jimmy1768_user/Projects/thesis-record`
- Runtime commit: `81fc54c`
- Rails environment: production
- Command:

```bash
THESIS_RECORD_V0_SOURCE_FRESHNESS_NETWORK=true bin/rails operator:v0_source_freshness_dry_run
```

## Result

- `passed=true`
- `network_enabled=true`
- blockers: none
- warnings: `dry_run_only_no_rows_written`

All configured endpoints were reachable with HTTP status `200`.

## Source Results

### Census SUSB Public File

- source kind: `census_susb_public_file`
- policy key: `susb_us_state_annual`
- source kind matches policy: true
- endpoints configured: true
- source rows authorized: false
- claim effect: unchanged

| Endpoint | HTTP status | Last modified | Content length | Error |
| --- | ---: | --- | ---: | --- |
| `source_url` | 200 | Thu, 10 Apr 2025 13:17:09 GMT | unknown | none |
| `record_layout_url` | 200 | Fri, 28 May 2021 10:41:39 GMT | unknown | none |

### Census BFS API

- source kind: `census_bfs_api`
- policy key: `bfs_monthly_api`
- source kind matches policy: true
- endpoints configured: true
- source rows authorized: false
- claim effect: unchanged

| Endpoint | HTTP status | Last modified | Content length | Error |
| --- | ---: | --- | ---: | --- |
| `variables_url` | 200 | unknown | 478 | none |
| `geography_url` | 200 | unknown | 86 | none |
| `examples_url` | 200 | unknown | 190 | none |
| `monthly_data_dictionary_url` | 200 | Thu, 11 Dec 2025 16:44:33 GMT | unknown | none |

### Census BDS Public File

- source kind: `census_bds_public_file`
- policy key: `bds_sector_age_size_public_file`
- source kind matches policy: true
- endpoints configured: true
- source rows authorized: false
- claim effect: unchanged

| Endpoint | HTTP status | Last modified | Content length | Error |
| --- | ---: | --- | ---: | --- |
| `source_url` | 200 | Thu, 25 Sep 2025 12:02:41 GMT | 12606118 | none |
| `dataset_page_url` | 200 | unknown | unknown | none |
| `methodology_url` | 200 | unknown | unknown | none |

## Post-Run Production Summary

Observed after the dry run with `bin/rails operator:production_summary`.

| Table | Rows after dry run |
| --- | ---: |
| `data_sources` | 3 |
| `source_access_paths` | 3 |
| `intake_manifests` | 3 |
| `schema_versions` | 3 |
| `metric_definitions` | 21 |
| `metric_observations` | 1179605 |
| `metric_quality_reviews` | 1179605 |
| `susb_public_file_rows` | 570105 |
| `bfs_api_rows` | 1368 |
| `bds_public_file_rows` | 104880 |
| `audit_events` | 96 |
| `users` | 0 |
| `roles` | 0 |

The evidence/source row counts remained unchanged from the v0 baseline. The
audit-event count reflects production guardrail checks run during deployment and
verification; the source freshness dry run does not write audit events.

## Interpretation

This dry run establishes that the configured SUSB, BFS, and BDS public-source
endpoints were reachable from production before the first post-v0 collection
loop. It does not add new evidence to the baseline and does not change the
claim or forecast inventories.

## Remaining Gates

Before canonical collection or ingestion:

- select the first live collection source;
- select the first live collection mode;
- define expected row-count delta;
- create a collection manifest path;
- take a production backup;
- run row-count reconciliation;
- run post-collection production and v0 baseline summaries;
- keep claim, forecast, prose, and publication effects disabled unless
  explicitly approved.
