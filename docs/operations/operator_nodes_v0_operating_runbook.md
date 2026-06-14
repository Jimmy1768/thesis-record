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

- record no-op source-release checks;
- record no-op quarterly checkpoint requests;
- record no-op annual snapshot candidate requests;
- record read-only production-summary checks;
- record read-only v0-readiness checks.

They must not ingest new canonical rows, promote claims, publish artifacts, or
edit paper prose by default.

## Local Rehearsal

Local databases are rehearsal-only. A successful local run can justify a future
production change request, but it is not a canonical evidence update.

Before any production ingestion/promotion, require:

- backup plan and restore check;
- manifest path under `theses/operator-node-economics/evidence/manifests/`;
- row-count reconciliation target;
- post-promotion `operator:production_summary`;
- post-promotion `operator:v0_readiness`.

## Current Human Decision Gaps

- v0 publication date;
- v0 prose source and approval;
- frozen v0 claim set;
- frozen v0 forecast set;
- public release timing.
