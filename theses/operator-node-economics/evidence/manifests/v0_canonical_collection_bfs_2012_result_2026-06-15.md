# Operator Nodes V0 Canonical Collection Result: BFS 2012

Status: completed canonical source-row refresh.

## Scope

This manifest records the first gated Operator Nodes v0 canonical collection
run after the v0 collection preflight was added. The run refreshed the Census
BFS 2012 sample rows in production PostgreSQL.

This was source-row collection only. It did not compute metrics, create quality
reviews, create prediction links, create claim reviews, create exports, edit
paper prose, publish v0, or change the thesis verdict.

## Approval Manifest

- Approval manifest:
  `theses/operator-node-economics/evidence/manifests/v0_canonical_collection_bfs_2012.yml`
- Runtime commit: `6ee64e3`
- Production host: `sourcecombatives-web`
- Rails environment: `production`
- Source kind: `census_bfs_api`
- Source table: `bfs_api_rows`
- Run mode: `canonical_ingestion_candidate`
- One-shot env gate used: `THESIS_RECORD_ALLOW_V0_CANONICAL_COLLECTION=true`

## Backup

- Backup path:
  `/home/jimmy1768_user/backups/thesis-record/thesis_record_production_pre_bfs_v0_20260615T022319Z.dump`
- Backup SHA-256:
  `fafbf59f61ef17f0a4fdb980b5e1c7afa324e89d4b0e8230741abdad3dda2cba`
- Backup size: `121M`
- Integrity check: `pg_restore -l` completed successfully

## Pre-Run Checks

BFS dry-run query validation passed before collection:

- total API rows: `5544`
- eligible rows: `1368`
- eligible data type codes:
  `BA_BA`, `BA_HBA`, `BF_BF4Q`, `BF_BF8Q`, `BF_PBF4Q`, `BF_PBF8Q`
- eligible category codes:
  `NAICS11`, `NAICS21`, `NAICS22`, `NAICS23`, `NAICS42`, `NAICS51`,
  `NAICS52`, `NAICS53`, `NAICS54`, `NAICS55`, `NAICS56`, `NAICS61`,
  `NAICS62`, `NAICS71`, `NAICS72`, `NAICS81`, `NAICSMNF`, `NAICSRET`,
  `NAICSTW`
- eligible seasonally adjusted values: `no`
- eligible time slot ids: `0`
- eligible error data values: `no`
- dry-run database counts unchanged: `true`

Canonical collection preflight passed with no blockers.

## Collection Command

```bash
THESIS_RECORD_ALLOW_V0_CANONICAL_COLLECTION=true \
THESIS_RECORD_V0_COLLECTION_MANIFEST=/home/jimmy1768_user/Projects/thesis-record/theses/operator-node-economics/evidence/manifests/v0_canonical_collection_bfs_2012.yml \
bin/rails public_sources:bfs:load_sample_rows
```

## Collection Result

- data source id: `2`
- total API rows: `5544`
- eligible rows: `1368`
- rows upserted: `1368`
- `metric_definitions_created`: `0`
- `metric_observations_created`: `0`
- `prediction_links_created`: `0`
- `exports_created`: `0`
- latest BFS collection audit event: `2026-06-15T02:28:10Z`

## Reconciliation

Expected and observed row counts reconciled:

- `bfs_api_rows` before: `1368`
- `bfs_api_rows` after: `1368`
- source row-count delta: `0`
- duplicate BFS natural keys after: `0`
- `metric_definitions`: `21`
- `metric_observations`: `1179605`
- `metric_quality_reviews`: `1179605`
- `prediction_links`: `0`
- `claim_reviews`: `0`
- `export_artifacts`: `0`

## Post-Run Checks

Post-run production checks passed:

- `bin/rails operator:production_summary`: health passed
- `bin/rails operator:v0_baseline_summary`: v0 readiness passed, blockers none
- `bin/rails operator:v0_readiness`: passed, blockers none

Known warnings remained unchanged:

- production summary: `no_production_users`, `no_production_roles`
- v0 readiness:
  `v0_indicator_universe_unapproved`,
  `operator_accounts_not_bootstrapped_intentionally`

## Interpretation

This run confirms that the BFS source-row loader can execute through the
canonical v0 collection preflight on production and remain idempotent at the
current BFS 2012 source-row scope. It does not add claim support or thesis
confirmation. The BFS rows remain indirect context only under the v0 source
truth and claim-review gates.
