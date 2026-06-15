# Operator Nodes V0 Canonical Collection Result: BDS 2023

Status: completed canonical source-row refresh.

## Scope

This manifest records the gated Operator Nodes v0 canonical collection refresh
for the Census BDS 2023 sector by firm age by firm size public file.

This was source-row collection only. It did not compute metrics, create quality
reviews, create prediction links, create claim reviews, create exports, edit
paper prose, publish v0, or change the thesis verdict.

## Approval Manifest

- Approval manifest:
  `theses/operator-node-economics/evidence/manifests/v0_canonical_collection_bds_2023.yml`
- Runtime commit: `fe15ffe`
- Production host: `sourcecombatives-web`
- Rails environment: `production`
- Source kind: `census_bds_public_file`
- Source table: `bds_public_file_rows`
- Run mode: `canonical_ingestion_candidate`
- One-shot env gate used: `THESIS_RECORD_ALLOW_V0_CANONICAL_COLLECTION=true`

## Runtime Source File

The production checkout did not already have the ignored BDS raw file. The file
was downloaded from the official Census URL into the ignored runtime raw-data
path before parser dry run and collection:

- URL:
  `https://www2.census.gov/programs-surveys/bds/tables/time-series/2023/bds2023_sec_fa_fz.csv`
- Runtime path:
  `/home/jimmy1768_user/Projects/thesis-record/data/raw/bds/2023/bds2023_sec_fa_fz.csv`
- SHA-256:
  `c4790ccdf964788a8bbc8404349df69db2a7457f8784411a39ddb228dedfbabd`
- byte size: `12606118`
- line count including header: `104881`
- committed manifest used for reconciliation:
  `theses/operator-node-economics/evidence/manifests/bds_2023_manifest.csv`

The raw file remains ignored runtime state and was not committed.

## Backup

- Backup path:
  `/home/jimmy1768_user/backups/thesis-record/thesis_record_production_pre_bds_v0_20260615T024541Z.dump`
- Backup SHA-256:
  `59c1f22b06933900e0f5a1dba01ff4c623fc24a184567c6dcde89c609608150f`
- Backup size: `121M`
- Integrity check: `pg_restore -l` completed successfully

## Pre-Run Checks

BDS parser dry run passed before collection:

- rows seen: `104880`
- rows parsed: `104880`
- rows persisted: `0`
- bad-width rows: `0`
- blank lines: `0`
- duplicate source keys: `0`
- observed year range: `1978-2023`
- sector count: `19`
- firm age count: `12`
- firm size count: `10`
- numeric cell count: `1668177`
- publication flag totals: `D=252783`, `S=0`, `X=492480`, `N=103680`
- existing production BDS rows before collection: `104880`
- existing production duplicate BDS natural keys before collection: `0`

Canonical collection preflight passed with no blockers.

## Collection Command

The loader was run through `rails runner` so the committed thesis manifest path
could be passed directly while keeping production git clean:

```bash
THESIS_RECORD_ALLOW_V0_CANONICAL_COLLECTION=true \
THESIS_RECORD_V0_COLLECTION_MANIFEST=/home/jimmy1768_user/Projects/thesis-record/theses/operator-node-economics/evidence/manifests/v0_canonical_collection_bds_2023.yml \
bin/rails runner 'PublicSources::Bds::LoadStagingRows.call!(actor: "operator_bds_v0_collection", manifest_path: Rails.root.join("..", "theses/operator-node-economics/evidence/manifests/bds_2023_manifest.csv"))'
```

## Collection Result

- data source id: `3`
- load id: `6eef5654-b59a-47f5-87cd-f0bed25ec8fb`
- rows read: `104880`
- rows inserted: `104880`
- rows deleted before load: `104880`
- `metric_definitions_created`: `0`
- `metric_observations_created`: `0`
- `quality_reviews_created`: `0`
- `prediction_links_created`: `0`
- `exports_created`: `0`
- latest BDS source-row-load audit event: `2026-06-15T02:51:45Z`

## Reconciliation

Expected and observed row counts reconciled:

- `bds_public_file_rows` before: `104880`
- `bds_public_file_rows` after: `104880`
- source row-count delta: `0`
- duplicate BDS natural keys after: `0`
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

This run confirms that the BDS source-row loader can execute through the
canonical v0 collection preflight on production and transactionally refresh the
current BDS 2023 public-file row set without changing protected evidence or
interpretation tables. It does not add claim support or thesis confirmation.
The BDS rows remain employer-dynamics context only under the v0 source truth
and claim-review gates.
