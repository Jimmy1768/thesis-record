# Operator Nodes V0 Operating Runbook

Status: pre-v0 scaffold.

This runbook is for operating ThesisRecord before Operator Nodes v0 is
published. It keeps the system useful without pretending the thesis is ready for
publication.

## Scope

- keep production Puma and Sidekiq running;
- keep production PostgreSQL as the canonical structured evidence store;
- run read-only health and readiness checks;
- rehearse ingestion locally without treating local data as canonical;
- keep claim promotion and publication approval manual.

## Production Checks

Run from the production checkout inside `thesis_record_app`:

```bash
bin/rails operator:production_summary
bin/rails operator:v0_readiness
bin/rails operator:verify_operations_policy
bin/rails operator:verify_claim_review_gate
```

Expected pre-v0 outcome:

- production summary passes;
- operations policy passes;
- claim-review gate passes;
- v0 readiness fails only on explicit publication blockers.

## Sidekiq Maintenance Jobs

The Sidekiq schedule is policy-driven by
`thesis_record_app/config/thesis_record_policy.yml`.

Pre-v0 scheduled jobs may:

- record read-only source-release checks across the approved public endpoints;
- record no-op quarterly checkpoint requests;
- record no-op annual snapshot candidate requests;
- record read-only production-summary checks;
- record read-only v0-readiness checks.

They must not ingest new canonical rows, promote claims, publish artifacts, or
edit paper prose by default.

The weekly source-release check runs the same source-freshness dry-run logic as
`bin/rails operator:v0_source_freshness_dry_run` with network checks enabled.
It records one `source_release_check_completed` audit event summarizing endpoint
status and warnings. It must not write source rows, metrics, quality reviews,
prediction links, claim reviews, exports, publication state, or thesis verdicts.

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

Canonical v0 row collection is production-only and source-specific. Direct
source-row loaders may be used in development and test for rehearsal, but in
production they fail closed unless the v0 canonical collection preflight passes.

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

- v0 publication date;
- v0 prose source and approval;
- frozen v0 claim set;
- frozen v0 forecast set;
- public release timing.
