# Operator Nodes Annual Snapshot Candidate Verification: 2026-06-15 UTC

Status: completed production verification run.

## Scope

This manifest records the first production verification of the audit-only
annual snapshot candidate job after implementation.

This was not a scheduled annual snapshot publication and not a thesis update.
The job was run manually with an explicit `as_of` value inside the first annual
review window so the forecast-clock behavior could be verified before the real
annual schedule begins.

The run did not create evidence snapshots, ingest source rows, compute metrics,
create quality reviews, create prediction links, create claim reviews, create
exports, publish v0, or change the thesis verdict.

## Execution

- Production host: `sourcecombatives-web`
- Runtime commit: `6664af8`
- Rails environment: `production`
- Job class: `Evidence::AnnualSnapshotCandidateJob`
- Queue: `maintenance`
- Manual verification `as_of`: `2027-07-15T06:00:00Z`
- Current period resolved by job: `2027-Q3`
- Snapshot period resolved by job: `2027-Q2`
- First snapshot period: `2027-Q2`
- Snapshot index: `1`
- Forecast count: `12`
- Audit event id: `116`
- Audit event reason code: `scheduled_annual_snapshot_candidate`
- Audit event entity id: `annual_snapshot_candidate:2027-Q2`

## Reconciliation

The verification wrapper observed:

- annual snapshot audit-event delta: `1`
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

## Recorded Summary

```text
Annual evidence snapshot candidate recorded; as_of=2027-07-15T06:00:00Z; current_period=2027-Q3; snapshot_period=2027-Q2; first_snapshot_period=2027-Q2; snapshot_index=1; status=annual_snapshot_candidate; forecast_count=12; source_rows=susb_public_file_rows=570105,bfs_api_rows=1368,bds_public_file_rows=104880; protected_counts=metric_definitions=21,metric_observations=1179605,metric_quality_reviews=1179605,prediction_links=0,claim_reviews=0,export_artifacts=0,evidence_snapshots=0,failure_records=0; warnings=forecast_items_unapproved; effects=no_row_writes,no_metric_writes,no_reviews,no_prediction_links,no_claims,no_exports,no_publication,no_thesis_verdict
```

## Interpretation

The annual snapshot candidate job is ready for scheduled audit-only operation.
The first annual snapshot period is `2027-Q2`; the review window begins after
that quarter closes. The Sidekiq schedule is July-based so it does not produce
a premature January snapshot.

Future scheduled runs remain operational candidates only unless a separate
human-approved review creates an evidence snapshot, promotes evidence
interpretation, changes claim status, releases public artifacts, or changes the
thesis verdict.
