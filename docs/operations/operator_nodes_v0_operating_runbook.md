# Operator Nodes V0 Operating Runbook

Status: v0 baseline source-row collection complete; public release still
`not_public`.

This runbook is for operating ThesisRecord before Operator Nodes v0 is
published. It keeps the system useful without pretending the thesis is ready for
publication.

## Scope

- keep production Puma and Sidekiq running;
- keep production PostgreSQL as the canonical structured evidence store;
- run read-only health and readiness checks;
- run the weekly source-release monitor;
- rehearse ingestion locally without treating local data as canonical;
- keep any future canonical source-row ingestion manual and manifest-gated;
- keep claim promotion and publication approval manual.

## Production Checks

Run from the production checkout inside `thesis_record_app`:

```bash
bin/rails operator:status
bin/rails operator:production_summary
bin/rails operator:v0_readiness
bin/rails operator:verify_operations_policy
bin/rails operator:verify_claim_review_gate
```

`operator:status` is read-only. It prints the latest source-release,
quarterly-checkpoint, annual-snapshot, production-summary, and v0-readiness
audit events plus the current protected table counts.

Freshness warnings are part of `operator:status`:

- source-release check older than eight days;
- quarterly checkpoint older than 100 days;
- annual snapshot older than 400 days;
- production summary older than 26 hours;
- v0 readiness older than 26 hours.

The daily `operator_status_alert` Sidekiq job emails the configured dev inbox
only when `operator:status` reports warnings. Broader monitoring layers are
documented in `docs/operations/monitoring_runbook.md`.

The first production verification run is recorded at:

```text
theses/operator-node-economics/evidence/manifests/v0_operator_status_verification_2026-06-15.md
```

Expected post-baseline, pre-public outcome:

- production summary passes;
- operations policy passes;
- claim-review gate passes;
- v0 readiness passes with only expected warnings for unbootstrapped operator
  accounts and unapproved indicator universe.

## V0 Baseline Collection State

The v0 baseline source-row collection completed on 2026-06-15 UTC. The
consolidated completion manifest is:

```text
theses/operator-node-economics/evidence/manifests/v0_collection_complete_2026-06-15.md
```

Completed source-row result manifests:

- BFS 2012:
  `theses/operator-node-economics/evidence/manifests/v0_canonical_collection_bfs_2012_result_2026-06-15.md`
- BDS 2023:
  `theses/operator-node-economics/evidence/manifests/v0_canonical_collection_bds_2023_result_2026-06-15.md`
- SUSB 2022:
  `theses/operator-node-economics/evidence/manifests/v0_canonical_collection_susb_2022_result_2026-06-15.md`
- source-release monitor:
  `theses/operator-node-economics/evidence/manifests/v0_source_release_check_2026-06-15.md`

This baseline is source-row collection only. It does not approve paper prose,
promote claims, publish v0, create prediction links, create claim reviews,
create export artifacts, or change the thesis verdict.

## Sidekiq Maintenance Jobs

The Sidekiq schedule is policy-driven by
`thesis_record_app/config/thesis_record_policy.yml`.

Pre-v0 scheduled jobs may:

- record read-only source-release checks across the approved public endpoints;
- record audit-only quarterly checkpoint candidates from the forecast clock;
- record audit-only annual snapshot candidates for completed annual periods;
- record read-only production-summary checks;
- record read-only v0-readiness checks.

They must not ingest new canonical rows, promote claims, publish artifacts, or
edit paper prose by default.

The weekly source-release check runs the same source-freshness dry-run logic as
`bin/rails operator:v0_source_freshness_dry_run` with network checks enabled.
It records one `source_release_check_completed` audit event summarizing endpoint
status and warnings. It must not write source rows, metrics, quality reviews,
prediction links, claim reviews, exports, publication state, or thesis verdicts.

The quarterly indicator checkpoint job records one
`quarterly_checkpoint_requested` audit event for the current calendar quarter.
It reads the v0 forecast clock and labels the current period, measurement index,
and v1/v2/v3 checkpoint reference when applicable. It must not write source
rows, compute metrics, create quality reviews, create prediction links, create
claim reviews, create exports, publish artifacts, or change thesis verdicts.

The first production verification run is recorded at:

```text
theses/operator-node-economics/evidence/manifests/v0_quarterly_checkpoint_candidate_verification_2026-06-15.md
```

The annual snapshot candidate job records one
`annual_snapshot_candidate_requested` audit event for the latest completed
annual snapshot period. It follows `v0_timeline.yml`, where the first annual
snapshot period is `2027-Q2` and the first review window starts on
`2027-07-01`. The Sidekiq schedule is therefore July-based, not January-based.
It must not create evidence snapshots, write source rows, compute metrics,
create quality reviews, create prediction links, create claim reviews, create
exports, publish artifacts, or change thesis verdicts.

The first production verification run is recorded at:

```text
theses/operator-node-economics/evidence/manifests/v0_annual_snapshot_candidate_verification_2026-06-15.md
```

## Local Rehearsal

Local databases are rehearsal-only. A successful local run can justify a future
production change request, but it is not a canonical evidence update.

Before any production ingestion/promotion, require:

- backup plan and restore check;
- manifest path under `theses/operator-node-economics/evidence/manifests/`;
- row-count reconciliation target;
- post-promotion `operator:production_summary`;
- post-promotion `operator:v0_readiness`.

## Canonical Row Collection Preflight

Canonical v0 row collection is production-only and source-specific. The initial
v0 source-row baseline has already been collected for BFS, BDS, and SUSB.
Future row collection remains manual and source-specific. Direct source-row
loaders may be used in development and test for rehearsal, but in production
they fail closed unless the v0 canonical collection preflight passes.

Before running any production source-row loader:

1. Copy
   `theses/operator-node-economics/evidence/manifests/v0_canonical_collection_manifest_template.yml`
   to a source-specific manifest in the same directory.
2. Select exactly one `source_kind`.
3. Fill in the source table, natural key, idempotency strategy, expected row
   counts, protected zero-delta counts, backup record, and restore or backup
   integrity check.
4. Keep production backup files outside Git.
5. Run the preflight from production with a one-shot environment gate:

   ```bash
   THESIS_RECORD_ALLOW_V0_CANONICAL_COLLECTION=true \
   THESIS_RECORD_V0_COLLECTION_MANIFEST=../theses/operator-node-economics/evidence/manifests/<manifest>.yml \
   bin/rails operator:v0_canonical_collection_preflight
   ```

6. Only after the preflight passes, run the source-specific loader for the same
   `source_kind`.
7. Immediately run:

   ```bash
   bin/rails operator:production_summary
   bin/rails operator:v0_baseline_summary
   bin/rails operator:v0_readiness
   ```

The preflight does not ingest rows. It verifies the production environment,
manifest approval, backup/integrity record, source natural key, expected row
delta, duplicate-key target, and zero deltas for metrics, reviews, prediction
links, claim reviews, exports, prose, publication, and verdict effects.

## Current Human Decision Gaps

- v0 prose source and approval;
- public release timing.
