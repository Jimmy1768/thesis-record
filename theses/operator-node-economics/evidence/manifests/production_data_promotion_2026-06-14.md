# Production Data Promotion: 2026-06-14

## Scope

This manifest records the first promotion of structured Thesis 1 evidence rows
from the local prototype PostgreSQL database into the ThesisRecord production
PostgreSQL database.

This promotion did not copy raw files, local database files, dumps into git,
private artifacts, logs, tmp files, local env files, private keys, or
machine-specific state.

## Source

- Source repository context: `/Users/jimmy1768/Projects/operator-node-economics`
- Source database: `living_dissertation_app_development`
- Source role: local development PostgreSQL role
- Source type: local development database used as a rehearsal/capture store

Local PostgreSQL remains non-canonical after this promotion.

## Target

- Target repository: `/home/jimmy1768_user/Projects/thesis-record`
- Target app path: `/home/jimmy1768_user/Projects/thesis-record/thesis_record_app`
- Target host: `sourcecombatives-web`
- Target database: `thesis_record_production`
- Target runtime commit after promotion: `bb325c5`

Production PostgreSQL is the canonical system of record after import.

## Dump And Backup

- Production pre-promotion backup:
  `/home/jimmy1768_user/Projects/thesis-record/shared/backups/thesis_record_production_pre_promote_20260614T102500Z.dump`
- Production backup SHA-256:
  `3a0e57319ff998da9e49c4ec568c4b1ca56e0120660da55e1598d8c4bc7e1351`
- Structured promotion dump:
  `/home/jimmy1768_user/Projects/thesis-record/shared/imports/thesis_record_structured_promotion_20260614.dump`
- Structured promotion dump SHA-256:
  `f96b7185dec8321613adfe8f882cdd31fe803fe65dc9125cf58a8d881daac0ab`
- Local dump path used during transfer:
  `/private/tmp/thesis_record_structured_promotion_20260614.dump`

## Promoted Tables

| Table | Source rows | Production rows after verification | Notes |
| --- | ---: | ---: | --- |
| `data_sources` | 3 | 3 | Exact match |
| `source_access_paths` | 3 | 3 | Exact match |
| `intake_manifests` | 3 | 3 | Exact match |
| `schema_versions` | 3 | 3 | Exact match |
| `metric_definitions` | 21 | 21 | Exact match |
| `metric_observations` | 1179605 | 1179605 | Exact match |
| `metric_quality_reviews` | 1179605 | 1179605 | Exact match |
| `susb_public_file_rows` | 570105 | 570105 | Exact match |
| `bfs_api_rows` | 1368 | 1368 | Exact match |
| `bds_public_file_rows` | 104880 | 104880 | Exact match |
| `audit_events` | 92 | 93 | Production includes one post-import verification event |
| `privacy_reviews` | 0 | 0 | Exact match |
| `private_artifacts` | 0 | 0 | Exact match |
| `quality_flags` | 0 | 0 | Exact match |
| `prediction_links` | 0 | 0 | Exact match |
| `claim_reviews` | 0 | 0 | Exact match |
| `failure_records` | 0 | 0 | Exact match |
| `evidence_snapshots` | 0 | 0 | Exact match |
| `export_artifacts` | 0 | 0 | Exact match |

## Excluded Tables

| Table | Source rows | Production rows | Reason |
| --- | ---: | ---: | --- |
| `users` | 1 | 0 | Local operator account state; production accounts must be bootstrapped intentionally |
| `roles` | 1 | 0 | Local account support table; excluded with `users` |

## Verification

- `bin/rails operator:verify_operations_policy`: passed
- `bin/rails operator:verify_deployment_config`: passed
- `bin/rails operator:health_check`: passed
- Puma: running on `127.0.0.1:3400`
- Sidekiq: running against Redis DB 9
- `/up`: returned HTTP 200 from localhost

## Notes

The production runtime is currently user-space because `sudo` was not available
from the deployment session. Root-owned systemd installation remains a hardening
task before treating process supervision as complete.
