# Production Q3 2026 Collection Activation Plan

Status: proposed execution plan. This document does not authorize a production
deployment, migration, database write, DigitalOcean action, or recurring
schedule.

## Goal

Safely create the first production quarterly collection for `2026-Q3`, whose
UTC interval is `[2026-07-01T00:00:00Z, 2026-10-01T00:00:00Z)`. The collection
uses the fixed cutoff `2026-10-01T00:00:00Z` and the latest eligible SUSB, BDS,
and BFS releases available when retrieval occurs. Normal publication lag is
recorded; it is not filled with invented data.

The first production run is operator-triggered and attended. The recurring
Sidekiq schedule stays absent through this plan. The run does not accept thesis
evidence, alter claims, publish results, or change the June Day 0 baseline.

## Current State: 2026-10-14

- The date gate is open: Q3 closed on 2026-10-01 UTC.
- Production runs on `sourcegrid-web` from `release/current` at
  `c85ba2a650b903daf6c00839e9a91e648521da59`.
- Production PostgreSQL is at migration `20260614043000`; the periodic tables
  and enforcement triggers do not exist there.
- The production checkout does not contain the collection dispatcher or
  periodic migrations.
- Local `main` contains the tested quarterly implementation through
  `6d89d76`, but the production entry points intentionally fail closed in
  `Rails.env.production?`.
- The production collection schedule is absent.
- Sidekiq, Puma, Redis, and both watchdog timers are healthy. The queues,
  retry set, and dead set are empty.
- The September logical-dump rehearsals proved the application restore,
  migration, live three-source collection, and concurrent retry paths. They
  did not prove restoration from the Director-selected DigitalOcean backup.
  The restored production dump produced Day 0 registration digest
  `1ea8278d84b1eca2b8ddcbf485c2c237008136f4ede2992709e0f72b35091aea`;
  this is corroborating history, not a substitute for the new paired
  production/selected-backup comparison.

## Authority And Storage Boundaries

- The Director owns DigitalOcean backup selection, creation, and restore
  actions. Codex may inspect an isolated restored host after the Director makes
  it available, but must not operate the DigitalOcean control plane.
- PostgreSQL remains the system of record. Do not add S3 for this run.
- Do not import a local development database into production.
- Do not retain a disposable restored database or downloaded source data after
  its gate completes. Retain only a metadata-only receipt.
- Do not put one-shot authorization values into the standing production env
  file.
- Do not enable the quarterly schedule during this plan.

## Frozen Run Identity

| Field | Required value |
| --- | --- |
| Quarter | `2026-Q3` |
| Cutoff | `2026-10-01T00:00:00Z` |
| Source kinds | `census_susb_public_file`, `census_bds_public_file`, `census_bfs_api` |
| Target | production PostgreSQL on `sourcegrid-web` |
| Execution | one durable, operator-triggered application job |
| Schedule | absent |
| Expected first revision | `1` |

Row counts and capture digests are outputs, not frozen expectations. Public
sources can legitimately publish newer eligible material between rehearsal and
production retrieval. Every selected source reference period must end before
the frozen cutoff.

## Gate 1: Finish The Production-Safe Application Packet

The current local code cannot run in production by design. Before any backup
or deployment, implement and review one bounded packet with these acceptance
criteria:

1. Replace each unconditional production prohibition in Day 0 registration,
   source retrieval, periodic capture, collection completion, and the top-level
   quarterly workflow with explicit one-shot authorization. The default remains
   fail-closed in every environment. Freeze the names as
   `THESIS_RECORD_ALLOW_DAY_ZERO_REGISTRATION` and
   `THESIS_RECORD_ALLOW_QUARTERLY_COLLECTION`; only the exact value `true`
   authorizes its operation.
2. Use separate authorization values for Day 0 registration and quarterly
   collection. Neither value belongs in the standing server environment or a
   committed file.
3. Add `bin/rails operator:register_day_zero`. It registers Day 0 only after
   building the full manifest, matching every expected count, and matching the
   exact digest supplied through the one-shot
   `THESIS_RECORD_EXPECTED_DAY_ZERO_MANIFEST_DIGEST` value. An absent or
   mismatched digest exits before creating the registration.
4. Add `bin/rails operator:collect_quarterly QUARTER=2026-Q3`. It requires an
   explicit quarter, derives and validates the cutoff, resolves exactly one
   coherent registry chain for each of the three required source kinds,
   invokes the existing `QuarterlyDatabaseCollectionJob`, and emits metadata
   only.
5. The production command must run synchronously inside a durable transient
   user service so an SSH disconnect cannot terminate the collection. It must
   have an unambiguous service name, exit status, and journal.
6. Add `bin/rails operator:quarterly_collection_status QUARTER=2026-Q3` as a
   read-only command. It reports the requested quarter, revision, state,
   capture identities, source reference periods, result-set counts, review
   coverage, and digests without printing source rows or secrets.
7. Add tests proving production fails without authorization, accepts only the
   intended one-shot operation with authorization, rejects a wrong or open
   quarter, fails before enqueue or writes on missing/ambiguous registries, and
   does not change the scheduler configuration.
8. Keep `QuarterlyCollectionDispatchJob` out of
   `config/thesis_record_policy.yml`. Scheduling is a later gate.

Freeze the resulting candidate commit and rerun the full Rails suite, focused
lint, Zeitwerk check, and `git diff --check`. The candidate commit, not a moving
branch name, becomes the deployment input.

Exit: a reviewed candidate can perform one authorized production Day 0
registration and one authorized Q3 collection while remaining disabled by
default.

## Gate 2: Director DigitalOcean Recovery Check

The Director completes this gate in DigitalOcean before production migration:

1. Select or create a pre-change backup of `sourcegrid-web`.
2. Confirm the backup covers the actual PostgreSQL data and WAL locations. If
   PostgreSQL uses an attached Volume, cover and restore that Volume separately.
3. Restore the selected backup into an isolated environment. Do not replace or
   boot production from the restore.
4. Keep public routing and all Sidekiq schedules disabled on the restored host.
5. Record only the backup identifier, creation time, restore identifier, and
   result needed for the operational receipt; do not commit credentials or
   backup contents.

Exit: the isolated restored host is available for application verification and
the original production host is unchanged.

## Gate 3: Verify The Final Candidate On The Isolated Restore

On the isolated restored host:

1. Confirm the database opens and reports the pre-change production migration
   `20260614043000`.
2. Run the Day 0 manifest builder read-only before migration. Confirm the ten
   expected table counts and retain its metadata output for the paired live
   production comparison. Do not compare it to the local development digests
   in the recovery plan as if they were production authority.
3. Deploy the frozen candidate only to the isolated checkout. Keep collection
   scheduling disabled.
4. Apply migrations `20260918090000` and `20260918091000`, confirm the
   expected tables, constraints, indexes, and triggers exist, then run the Day
   0 manifest builder again. This post-migration output is the candidate
   production Day 0 manifest and expected registration digest.
5. Run targeted boot, database-connectivity, policy, job-loading, and
   scheduler-configuration checks. Confirm the recurring collection job is
   still absent.
6. Exercise the new operator commands and one-shot authorization boundaries.
7. Register Day 0 in the isolated database, run the full Q3 job against the
   public sources, and verify successful retry convergence without duplicate
   collections or result sets.
8. Run the dispatcher timing test in isolation and prove that a quarter-boundary
   fire produces exactly one Q3 job with the frozen cutoff. Do not install that
   schedule in production.
9. Verify Day 0 again after collection, save a metadata-only receipt, and
   remove the isolated database, application copy, source responses, and logs
   containing source data.

Exit: the selected DigitalOcean backup restores successfully and the final
candidate completes the migration and collection workflow on that restore.

## Gate 4: Promote And Deploy With Collection Disabled

Use an attended quiet window. Before starting, confirm Sidekiq has no busy,
queued, scheduled, retry, or dead work.

1. Push the accepted candidate to `main`, fast-forward `release/current` to the
   exact candidate commit, and verify the remote commit identity.
2. On `sourcegrid-web`, fetch and fast-forward the clean production checkout to
   that exact `release/current` commit. Do not deploy from local `main`.
3. Stop Sidekiq for the migration window. The recurring collection schedule is
   still absent, so no collection can start during deployment.
4. Install dependencies only if the lockfile changed.
5. Before migration, build the production Day 0 manifest read-only and compare
   it exactly with the isolated restore's pre-migration output. Stop on any
   mismatch.
6. Apply migrations `20260918090000` and `20260918091000`.
7. Rebuild the Day 0 manifest and compare it exactly with the isolated
   restore's post-migration output. Stop on any count, member, content,
   review-link, or manifest-digest mismatch.
8. Run targeted production smoke checks: Rails boot, migration status,
   database connectivity, operations policy, deployment configuration, job
   loading, scheduler job list, and `http://127.0.0.1:3400/up`.
9. Restart web and Sidekiq, confirm linger and both watchdog timers, and verify
   all queues and failure sets are empty.
10. Confirm the one-shot collection authorizations are absent from the standing
   environment.

Before Day 0 registration, a failed app deploy may roll back to the preceding
release commit. Do not automatically roll back the migrated database. Inspect
the migration state first. After Day 0 registration or a collection write,
never use a destructive migration rollback; recovery uses the verified backup.

Exit: production runs the exact candidate, the schema is ready, services are
healthy, and collection remains impossible without an explicit one-shot run.

## Gate 5: Register Production Day 0

1. Run the production Day 0 manifest builder read-only.
2. Compare all ten table counts, member digests, content digests,
   observation-to-review links, and the overall manifest digest with the
   post-migration output from the selected backup restore. Stop on any
   mismatch.
3. Launch `operator:register_day_zero` once with only the Day 0 authorization
   and the exact paired manifest digest present in that process.
4. Verify the stored manifest digest and all sealed-relation checks.
5. Rerun the read-only manifest builder and confirm no baseline member or value
   changed.
6. Confirm the authorization was process-scoped and is absent afterward.

Exit: exactly one verified Day 0 registration exists and the June baseline is
unchanged.

## Gate 6: Run The First Production Q3 Collection

Use a durable transient user service named for the quarter and retain its
journal until the receipt is complete. The service runs the reviewed operator
command with an explicit `2026-Q3` argument and only the one-shot quarterly
authorization in its process environment. It must not alter the standing
Sidekiq service environment.

Before launch:

- confirm the deployed commit and schema versions;
- confirm Day 0 verification passes;
- confirm at least 15 GB disk space is free;
- confirm web and Sidekiq are healthy and the maintenance queue is empty;
- confirm the collection schedule is absent;
- record the UTC start time.

During the run:

- monitor the transient service state, journal progress, disk, memory, and
  PostgreSQL availability;
- do not stop the process merely because the long SUSB/BDS write phase appears
  quiet;
- do not launch a second manual writer;
- do not edit source rows or incomplete records after a failure.

On failure, retain the application error class and metadata. Fix the cause and
rerun the same Q3 command; the existing transaction, capture identities,
uniqueness constraints, and advisory locks provide the retry path. Do not
delete partial captures or manufacture a completed record.

Exit requires all of the following:

- one completed `2026-Q3` collection at revision `1`;
- exactly three linked completed captures, one per required source kind;
- every capture records its actual release identity, reference period,
  retrieval time, response digest, parsed-row digest, and row count;
- the result set is completed with a nonzero observation count;
- review count equals observation count exactly;
- input, method, definition, result, and collection identities are present;
- no completed collection or result set is duplicated;
- Day 0 member, value, and review-link verification still passes;
- the transient service exits successfully and its authorization disappears;
- web, Sidekiq, Redis, watchdogs, and queues remain healthy.

## Gate 7: Receipt And Post-Run Recovery

Create one metadata-only receipt under `ops/docs/rehearsals/`. Record the
deployed commit, migration versions, UTC timing, source release identities and
reference periods, row counts, digests, collection/result IDs, retry outcome,
Day 0 verification, service health, and cleanup. Do not store source responses,
database dumps, credentials, or private environment values in the receipt.

The Director then selects or creates a post-run DigitalOcean backup and restores
it in isolation. Codex verifies that the restored database contains the same
Day 0 registration and completed Q3 collection and that both pass their
read-only verification commands. Remove the isolated restore after the receipt
is complete.

Exit: the first production quarter is both complete and recoverable.

## Scheduler Is A Separate Decision

Do not add the dispatcher to the production schedule as part of the Q3 run.
After the post-run restore succeeds, freeze a separate scheduler packet with an
exact UTC cron, isolated one-fire test, monitoring behavior, and rollback. If
enabled before 2027-01-01, its first automatic collection targets `2026-Q4`;
it must not rerun Q3 merely because Q3 was operator-triggered.

## Stop Conditions

Stop before the next write if any of these occur:

- selected DigitalOcean backup coverage or restore is unverified;
- production Day 0 differs from the paired selected-backup manifest output;
- deployed commit or migration state is not exact;
- any collection authorization is present in the standing environment;
- the recurring collection schedule appears in production;
- registry resolution is missing or ambiguous;
- a selected source reference period extends past the Q3 cutoff;
- disk free space is below 15 GB or PostgreSQL is unhealthy;
- Sidekiq has unexplained retries, dead jobs, or competing writers;
- the result/review invariants fail.

No stop condition is resolved by deleting production records, resetting the
database, weakening constraints, or treating a partial run as complete.
