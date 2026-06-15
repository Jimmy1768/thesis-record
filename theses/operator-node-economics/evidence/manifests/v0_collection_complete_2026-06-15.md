# Operator Nodes V0 Baseline Collection Completion: 2026-06-15 UTC

Status: v0 baseline source-row collection complete.

## Scope

This manifest consolidates the completed Operator Nodes v0 baseline collection
state as of 2026-06-15 UTC. It records that the approved source-row baseline
for BFS, BDS, and SUSB has been collected or refreshed in production
PostgreSQL through the v0 canonical collection gate.

This is not a public thesis release. It does not approve paper prose, promote
claims, create prediction links, publish v0, or change the thesis verdict.

## Source Result Manifests

- BFS 2012:
  `theses/operator-node-economics/evidence/manifests/v0_canonical_collection_bfs_2012_result_2026-06-15.md`
- BDS 2023:
  `theses/operator-node-economics/evidence/manifests/v0_canonical_collection_bds_2023_result_2026-06-15.md`
- SUSB 2022:
  `theses/operator-node-economics/evidence/manifests/v0_canonical_collection_susb_2022_result_2026-06-15.md`
- Source-release monitor:
  `theses/operator-node-economics/evidence/manifests/v0_source_release_check_2026-06-15.md`

## Runtime Commits

- `6ee64e3` approve BFS v0 collection manifest.
- `21baf0a` record BFS v0 collection result.
- `21afae4` run read-only source release checks.
- `8eccccc` record source release check result.
- `fe15ffe` approve BDS v0 collection manifest.
- `898bf1b` record BDS v0 collection result.
- `925dc53` fix SUSB binary public file fetch.
- `35f44d3` approve SUSB v0 collection manifest.
- `ab920c2` record SUSB v0 collection result.

## Final Production Counts

The final production state after the three source-row refreshes was:

| Table | Count |
| --- | ---: |
| `data_sources` | `3` |
| `source_access_paths` | `3` |
| `intake_manifests` | `3` |
| `schema_versions` | `3` |
| `metric_definitions` | `21` |
| `metric_observations` | `1179605` |
| `metric_quality_reviews` | `1179605` |
| `susb_public_file_rows` | `570105` |
| `bfs_api_rows` | `1368` |
| `bds_public_file_rows` | `104880` |
| `prediction_links` | `0` |
| `claim_reviews` | `0` |
| `export_artifacts` | `0` |
| `users` | `0` |
| `roles` | `0` |

The `users` and `roles` counts are expected at v0 because operator accounts are
intentionally not bootstrapped yet.

## Protected Effects

The v0 baseline collection was limited to source-row refreshes and the
read-only source-release monitor audit event. The following protected effects
remained absent:

- no metric computation from the v0 collection runs;
- no quality-review creation from the v0 collection runs;
- no prediction links;
- no claim reviews;
- no export artifacts;
- no paper prose edits;
- no public release;
- no thesis verdict change.

The existing metric tables remain from earlier migrated baseline work. They
were not expanded by the gated v0 collection runs.

## Current Operating Mode

- Production PostgreSQL remains the canonical structured evidence store.
- Local databases remain development and rehearsal only.
- Weekly source-release monitoring may run automatically through Sidekiq.
- Canonical row ingestion remains manual, source-specific, backup-backed, and
  manifest-gated.
- Public release remains `not_public`.
- Claim and forecast inventories remain internal v0 inventories.
- Individual claims and forecasts remain `candidate_unapproved` until a later
  explicit review step changes them.

## Readiness Result

Post-collection production checks passed:

- `bin/rails operator:production_summary`
- `bin/rails operator:v0_baseline_summary`
- `bin/rails operator:v0_readiness`

Known warnings remained:

- `no_production_users`
- `no_production_roles`
- `v0_indicator_universe_unapproved`
- `operator_accounts_not_bootstrapped_intentionally`

## Next Work

The next engineering slice should move from one-time baseline collection to
checkpoint operation:

1. keep the weekly source-release monitor as read-only;
2. implement the first quarterly checkpoint candidate behavior as audit-only;
3. ensure checkpoint jobs do not promote claims, compute thesis verdicts, or
   publish artifacts without explicit approval;
4. record any first production checkpoint run in a thesis-specific manifest.
