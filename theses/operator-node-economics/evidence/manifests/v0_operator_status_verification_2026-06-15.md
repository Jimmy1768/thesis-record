# Operator Nodes Operator Status Verification: 2026-06-15 UTC

Status: completed production verification run.

## Scope

This manifest records the first production verification of the
`bin/rails operator:status` command after implementation.

The command is read-only. It queries the latest operating audit events and
protected table counts. It does not ingest source rows, compute metrics, create
quality reviews, create prediction links, create claim reviews, create exports,
create evidence snapshots, publish v0, or change the thesis verdict.

## Execution

- Production host: `sourcecombatives-web`
- Runtime commit: `a4a72aa`
- Rails environment: `production`
- Command: `bin/rails operator:status`
- Verification time: `2026-06-15T04:27:21Z`

## Latest Operating Events

The production status command reported:

- source-release check audit event id: `106`
- quarterly checkpoint candidate audit event id: `115`
- annual snapshot candidate audit event id: `116`
- production-summary audit event id: `117`
- v0-readiness audit event id: `118`

The production-summary and v0-readiness audit events were created by running
their read-only jobs once before the final status check:

- audit-event delta: `2`
- `data_sources` delta: `0`
- `susb_public_file_rows` delta: `0`
- `bfs_api_rows` delta: `0`
- `bds_public_file_rows` delta: `0`
- `metric_definitions` delta: `0`
- `metric_observations` delta: `0`
- `metric_quality_reviews` delta: `0`
- `prediction_links` delta: `0`
- `claim_reviews` delta: `0`
- `export_artifacts` delta: `0`
- `evidence_snapshots` delta: `0`
- `failure_records` delta: `0`

## Final Status Counts

| Table | Count |
| --- | ---: |
| `audit_events` | `118` |
| `susb_public_file_rows` | `570105` |
| `bfs_api_rows` | `1368` |
| `bds_public_file_rows` | `104880` |
| `metric_observations` | `1179605` |
| `metric_quality_reviews` | `1179605` |
| `prediction_links` | `0` |
| `claim_reviews` | `0` |
| `export_artifacts` | `0` |
| `evidence_snapshots` | `0` |
| `failure_records` | `0` |

Final `operator:status` warnings: none.

## Interpretation

`operator:status` is ready as the first production operating dashboard command
for Thesis 1. It gives a single read-only view of source-release monitoring,
quarterly checkpoint candidates, annual snapshot candidates, production health,
v0 readiness, and protected table counts.

Future dashboard work can surface the same status inside an admin namespace,
but this command is sufficient for current v0 operations.
