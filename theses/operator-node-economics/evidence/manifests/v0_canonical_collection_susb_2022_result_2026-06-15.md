# Operator Nodes V0 Canonical Collection Result: SUSB 2022

Status: completed canonical source-row refresh.

## Scope

This manifest records the gated Operator Nodes v0 canonical collection refresh
for the Census SUSB 2022 U.S./state 6-digit NAICS public file.

This was source-row collection only. It did not compute metrics, create quality
reviews, create prediction links, create claim reviews, create exports, edit
paper prose, publish v0, or change the thesis verdict.

## Approval Manifest

- Approval manifest:
  `theses/operator-node-economics/evidence/manifests/v0_canonical_collection_susb_2022.yml`
- Runtime commit for loader: `35f44d3`
- Required fetch fix commit: `925dc53`
- Production host: `sourcecombatives-web`
- Rails environment: `production`
- Source kind: `census_susb_public_file`
- Source table: `susb_public_file_rows`
- Run mode: `canonical_ingestion_candidate`
- One-shot env gate used: `THESIS_RECORD_ALLOW_V0_CANONICAL_COLLECTION=true`

## Runtime Source File

The first production fetch attempt exposed that the SUSB downloader needed
binary-mode writes for Census text containing non-UTF bytes. That was fixed in
commit `925dc53` before validation and collection proceeded.

The public file was fetched into the ignored runtime raw-data path:

- URL:
  `https://www2.census.gov/programs-surveys/susb/tables/2022/us_state_6digitnaics_2022.txt`
- Runtime path:
  `/home/jimmy1768_user/Projects/thesis-record/data/raw/susb/2022/us_state_6digitnaics_2022.txt`
- SHA-256:
  `6f7b2f2b14cbad9dbfeb31d3bfc9f729368a0e971727de4eda88c9f83f77a513`
- byte size: `56000447`
- row count excluding header: `570105`
- committed manifest used for reconciliation:
  `theses/operator-node-economics/evidence/manifests/susb_2022_manifest.csv`

The raw file remains ignored runtime state and was not committed.

## Backup

- Backup path:
  `/home/jimmy1768_user/backups/thesis-record/thesis_record_production_pre_susb_v0_20260615T025955Z.dump`
- Backup SHA-256:
  `a0ed6a616d5e383d92704faffc37abd176f8b01ab7cc2afbf5270e425666944d`
- Backup size: `121M`
- Integrity check: `pg_restore -l` completed successfully

## Pre-Run Validation

SUSB public-file validation passed before collection:

- fetched this run: `true`
- row count excluding header: `570105`
- bad-width rows: `0`
- blank lines: `0`
- duplicate source keys: `0`
- manifest reconciled: `true`
- existing production SUSB rows before collection: `570105`
- existing production duplicate SUSB natural keys before collection: `0`

Noise flag counts:

| Field | G | H | J |
| --- | ---: | ---: | ---: |
| `EMPLFL_N` | `277234` | `167925` | `124946` |
| `PAYRFL_N` | `332347` | `170712` | `67046` |
| `RCPTFL_N` | `313670` | `181566` | `74869` |

Canonical collection preflight passed with no blockers.

## Collection Command

The loader was run through `rails runner` so the committed thesis manifest path
could be passed directly while keeping production git clean:

```bash
THESIS_RECORD_ALLOW_V0_CANONICAL_COLLECTION=true \
THESIS_RECORD_V0_COLLECTION_MANIFEST=/home/jimmy1768_user/Projects/thesis-record/theses/operator-node-economics/evidence/manifests/v0_canonical_collection_susb_2022.yml \
bin/rails runner 'PublicSources::Susb::LoadStagingRows.call!(actor: "operator_susb_v0_collection", manifest_path: Rails.root.join("..", "theses/operator-node-economics/evidence/manifests/susb_2022_manifest.csv"))'
```

The remote SSH session did not return the loader's stdout after the Rails runner
process exited, so the local session was interrupted after verifying no remote
Rails runner remained. The production audit event and row reconciliation below
confirmed the load completed.

## Collection Result

- data source id: `1`
- rows loaded: `570105`
- manifest status after load: `staging_rows_loaded`
- manifest staging row count: `570105`
- `metric_observations_created`: `0`
- `analysis_authorized`: `false`
- `metrics_authorized`: `false`
- SUSB source-row-load audit event id: `114`
- SUSB source-row-load audit event at: `2026-06-15T03:11:34Z`
- audit actor: `operator_susb_v0_collection`
- audit summary:
  `Loaded 570105 SUSB 2022 source-native rows into staging without metric computation`

## Reconciliation

Expected and observed row counts reconciled:

- `susb_public_file_rows` before: `570105`
- `susb_public_file_rows` after: `570105`
- source row-count delta: `0`
- duplicate SUSB natural keys after: `0`
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

This run confirms that the SUSB source-row loader can execute through the
canonical v0 collection preflight on production and refresh the current SUSB
2022 public-file row set without changing protected evidence or interpretation
tables. It does not add claim support or thesis confirmation. The SUSB rows
remain employer-side context only under the v0 source truth and claim-review
gates.
