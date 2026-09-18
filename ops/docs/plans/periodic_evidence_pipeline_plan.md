# Periodic Database Collection Plan

Status: local implementation plan. Production changes and scheduling are a later phase.

## Purpose

Keep the June 2026 Day 0 database rows as the fixed baseline. Each quarter,
collect the configured public datasets into PostgreSQL and record which database
rows and computations belong to that quarter. Analysis reads database rows, not
source response storage. A correction appends a new quarter revision; it never
rewrites Day 0 or a completed revision.

This is an operational collection history, not a new evidence-acceptance or
publication system. Jobs cannot accept evidence or change thesis conclusions.

## First-Quarter Timing

The internal v0 baseline date is 2026-06-15 UTC, but the accepted forecast
clock uses full calendar quarters, not three-month anniversaries. Its first
measurement period is 2026-Q3, from July 1 through September 30. September 15
is not a collection deadline. Preparation can occur before September 30; the
first Q3 database collection belongs after that quarter closes. This plan does
not set a fixed production run date or activate a schedule.

Treat each reporting quarter as a UTC calendar interval. For example, 2026-Q3
is `[2026-07-01T00:00:00Z, 2026-10-01T00:00:00Z)`. Its `cutoff_at` is the
exclusive upper bound, derived from the quarter rather than supplied as an
independent date. The run occurs after that bound; its actual retrieval and
completion timestamps are separate. A Q3 collection describes what the
configured sources returned when checked after Q3 closed, limited to source
reference periods completed by the cutoff. It does not claim that every source had
published through September or that its returned edition existed on September
30.

The existing quarter-start `QuarterlyIndicatorCheckpointJob` is audit-only. It
does not collect SUSB, BDS, or BFS rows and does not satisfy the first database
collection. Keep its scheduler entry distinct from the new collection job.

## Known State

The June baseline is documented in
`theses/operator-node-economics/evidence/manifests/v0_baseline_snapshot_2026-06-14.md`.
The local `living_dissertation_app_development` database and its September
recovery dump have the documented counts. The production runbook records the
same counts after the June cutover, but equal counts alone do not prove equal
row contents. Production verification belongs to the later production phase.

The existing `evidence_snapshots` table is a thesis checkpoint record and must
not be reused for operational quarterly collections. Existing source loaders
replace or upsert rows, and existing computations replace observations. The
periodic job must never invoke those destructive paths. Existing natural-grain
unique indexes also prevent storing a corrected release as another row set;
version identity is required in the database.

## Local Data Contract

1. Register Day 0 without modifying its members. Record baseline date, table
   counts, deterministic primary-key/member/content digests, and exact
   observation-to-review links. Historical code and parser provenance that
   cannot be proved stays unknown. Registration time is not collection time.
2. A source check records source, dataset/request scope, reference period,
   check time, and success or safe failure. A successful check records a digest
   of the returned response and a validated database capture identity. An
   unchanged digest reuses the existing capture and its parsed rows. A changed
   response under the same release creates another capture.
3. New SUSB, BDS, and BFS rows link to a capture. Day 0 rows retain their
   existing IDs and null capture link. Database constraints prevent duplicate
   rows within a capture and prevent modifying completed capture members.
4. A quarterly collection records quarter, input capture IDs, source release
   and reference periods, the quarter-derived exclusive cutoff, method/definition
   identity, status, revision, and completion time. A completed collection links
   to its exact observation/review result set. Reject a quarter/cutoff mismatch
   and a run before the quarter closes. The unique identity is quarter plus
   ordered input IDs and method identity; retries converge on the same record.
   A correction gets a new revision. An unchanged-input quarter still gets its
   own completed record while reusing the existing result set.
5. Results are append-only. Exactly one quality review belongs to each new
   observation. Partial work cannot be marked complete or consumed by reports.
   Reports explicitly select a completed quarter and revision; they never
   silently follow a newer one. Definition and method content used by a result
   must be stable or retained as a versioned digest plus content.
6. Source checks are not quarterly collections. A healthy unchanged check does
   not satisfy an overdue quarter. A failed check cannot be reported as
   unchanged.

Retrieval time and validation result are metadata, not capture identity. The
source reference period can be older than the reporting quarter; record the
latest period actually present for each input rather than implying full-quarter
coverage. Select the latest available eligible source edition at retrieval time and
record its release identity and retrieval time. The quarter-end cutoff limits
included observations by their reference-period end; it is not a claim about
when that edition was published.
A late correction creates a revised collection, not an update to a completed one.
Use a database transaction, uniqueness constraints, and a per-quarter lock so
concurrent Sidekiq jobs and commit-before-ack retries are safe.

The quarterly source set is SUSB, BDS, and BFS together. Use their existing
configured source scopes. For BFS, the policy already specifies U.S. geography,
unadjusted data, six first-pass data-type codes, and the first-pass category
codes. The `2012` sample period tested the original loader; it is not a
BFS-only gate or a limit on later quarterly periods. The adapter must collect
the configured scope for periods available at retrieval and completed by the
quarter-end cutoff. Query BFS for a bounded monthly interval through the last
month of the reporting quarter, using the Census
[`time` predicate](https://www.census.gov/data/developers/guidance/api-user-guide/query-components.html),
and validate the returned months. Confirm the exact predicate works for BFS
before the first live collection. For SUSB and BDS, select the latest available
annual edition whose reference year has ended by the cutoff; that year may
precede the reporting quarter. Do not invent missing months or treat normal
release lag as a failed source check.

## Phases

### 1. Local Schema And Day 0 Rehearsal

- Remove the uncommitted prototype's acceptance-pointer and publication-like
  machinery. Keep the thesis checkpoint schema and authority unchanged.
- Add only Day 0 registration, source checks/captures, capture-linked source
  rows, immutable result identity, and quarterly collection records.
- Test Day 0 registration against a disposable database. Separately run the
  digest builder read-only against the existing local June database and record
  counts and member/content digests. Do not update or reimport existing rows.
- Rebuild a disposable database from migrations and run focused tests. Locally
  applied prototype migrations are not production history.

Exit: the minimal schema rebuilds, Day 0 registration tests pass, and the
existing local baseline digest scan matches documented counts. No production
database is touched.

### 2. Local Quarterly Workflow

- Implement source-specific collection adapters and validation behind one
  Sidekiq job contract. Keep source responses in memory while persisting the
  validated parsed database rows and their digest/lineage metadata.
- Implement append-only computation and reviews in a transaction. Never call
  the legacy replace/upsert loaders for a quarterly run.
- Test success, failure, duplicate/concurrent retry, commit-before-ack retry,
  unchanged-input next quarter, and corrected-release same-quarter revision.
- Verify Day 0 member/value/review-link digests still match after every case.

Exit: local tests demonstrate an identifiable, append-only quarter. No live
source retrieval or schedule is required for this exit.

### 3. Three-Source Adapter Readiness

- Implement release discovery and validation for SUSB, BDS, and BFS using the
  existing configured scope for each source. Treat a source-shape mismatch as
  an implementation or validation failure, not a new user decision.
- Test adapters with controlled responses. Keep all schedules disabled.

Exit: each source adapter has an explicit expected scope and can be exercised
without changing thesis evidence authority.

### 4. Production Preparation And Manual Run

- Verify the Director's Droplet backup and isolated restore before any
  production migration or collection. Backup activation and restore are
  Droplet operations, not application-managed backup code.
- Verify production Day 0 row digests read-only, rehearse the migration and
  real collection job on an isolated restored database, and retire incompatible
  queued writers. Discard the rehearsal database; a production collection is
  not a no-persistence smoke test.
- After recovery verification, deploy with the collection schedule disabled
  and enable the currently blocked production entry points for this phase.
  Use targeted read-only Droplet smoke checks for app boot, database
  connectivity, job loading, and scheduler configuration; do not rerun the
  full test suite as the Droplet smoke test. Test scheduler dispatch in the
  isolated environment without enabling a production collection run.
- After September 30 and the preceding checks, register production Day 0 in
  place, then run one guarded manual Q3 collection. Verify row links, digests,
  retry behavior, and a post-run isolated restore.

Exit: one manual production quarter and Day 0 are verified and recoverable.

### 5. Quarterly Activation

- After the manual run and post-run restore verify, enable the Sidekiq
  collection schedule and observe its first actual fire. Monitor expected
  release checks, collection completion, retries, and failed runs separately.
- Retain completed quarterly history for the planned ten-year horizon. The
  operational collection does not itself publish or accept thesis claims.

Exit: the first scheduled quarter completes without changing earlier members.

## Current Boundary

Phases 1-3 are local work. Production verification, backup activation,
deployment, and scheduling are Phase 4 or later. Do not use count agreement or
the September dump timestamp as proof of June row-level provenance. No
production write is authorized by this plan.

As of 2026-09-18, Phase 1's local schema and synthetic registration tests
pass. The read-only scan of `living_dissertation_app_development` matched all
ten documented counts and produced the digests recorded in
`evidence_archive_snapshot_recovery_plan.md`. The local quarterly core,
three source parsers, release lookup, source-native computation, pending review
links, explicit quarter/revision reader, and unscheduled Sidekiq job have
controlled-response tests. No live source retrieval or actual quarterly run
has been performed. Production entry points remain explicitly disabled in code.

The local implementation now derives the exclusive cutoff from the quarter,
rejects early or mismatched runs, bounds BFS queries to eligible months, and
tests later-month responses and lagged source coverage. These corrections use
the existing quarterly workflow; live BFS predicate verification and all
production preparation remain in the later phase.

The existing `thesis_record_app_development` database on this workstation
still records five uncommitted 2026-09-14 prototype migrations. Do not use it
as proof that the new schema rebuilds cleanly, and do not reset it implicitly.
Fresh disposable PostgreSQL databases were used for the successful migration,
SQL-schema load, and test rehearsals. Reconcile or replace that local
development database only after its current contents are checked; this has no
bearing on the June baseline database or production.

On 2026-09-18, the `sourcegrid-web` Droplet's separate ThesisRecord repository
fetched `origin/main` at `8052b7b` for inspection. Its clean production checkout
remained on `release/current` at `c85ba2a`; no deployment or migration occurred.
Read-only checks found the ThesisRecord web and Sidekiq services and both
watchdog timers active, and the local `/up` endpoint returned HTTP 200. This is
host/app availability, not quarterly-collection readiness: the production
backup/restore, Day 0 row verification, isolated rehearsal, and production
entry-point activation gates above remain unverified or incomplete.
