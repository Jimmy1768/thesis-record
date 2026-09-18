# Day 0 And Quarterly Database Recovery Plan

Status: planning only. Production backup activation is a later phase.

## Decision

The database is the analytical store. Preserve the June 2026 Day 0 rows and
append identifiable quarterly collections in PostgreSQL. Use the Director's
DigitalOcean Droplet backup tooling for production recovery; do not build an
application-managed backup service or an additional storage platform.

The companion [periodic database collection plan](periodic_evidence_pipeline_plan.md)
defines the local schema, job, retry, and correction contracts. This document
defines only the recovery boundary.

## Baseline Evidence

The accepted June baseline record is
`theses/operator-node-economics/evidence/manifests/v0_baseline_snapshot_2026-06-14.md`.
The local `living_dissertation_app_development` database and a September
recovery dump have the recorded counts: 570,105 SUSB rows, 104,880 BDS rows,
1,368 BFS rows, 1,179,605 observations, 1,179,605 reviews, 21 definitions,
and three data sources. The production runbook records matching core counts
after the June cutover. Matching counts do not establish equal row content.

The September dump is a recovery/rehearsal artifact, not proof of how the June
results were originally computed. Its SHA-256 is
`77c2ca73d69b5ad07a0da79694e4624181cf21de0ad9ae4fa66154ce053f7267`.
The June production migration dump hash recorded in the runbook is
`5d6fa9795e4000745f1290bf4688d85511b50c8348ed6353d0a47a765bea4a49`.
Do not import the local database over production. Verify production Day 0
members and values in place during the later production phase.

On 2026-09-18, the read-only `Evidence::DayZeroManifestBuilder` completed
against `living_dissertation_app_development` with all ten expected counts.
Its canonical manifest digest was
`3864876a2b0386543909556b3ab1e6f73ece5cc3f7a4d97d568a5f405fcaee8b`.
This is local comparison evidence, not a production acceptance result. The
builder uses `canonical-json-v1`, primary-key order, member ID ranges, and
every column value, including observation-to-review references. Production
must be checked with the same schema and builder version before comparing
digests.

| Table | Member ID SHA-256 | Content SHA-256 |
| --- | --- | --- |
| `data_sources` | `14c5e74c4b96ccef41cd94db73a9ec3348038ac094feca4fd897cecffa07cdae` | `446fef833991d6be9ba29780dcfaae7e7cc0a98c260eac0253a25563f0efb4f6` |
| `source_access_paths` | `14c5e74c4b96ccef41cd94db73a9ec3348038ac094feca4fd897cecffa07cdae` | `51394eaa13908243a1f96b426fd3b729daab17c822a3d0b20dfc27aff6e95a34` |
| `intake_manifests` | `14c5e74c4b96ccef41cd94db73a9ec3348038ac094feca4fd897cecffa07cdae` | `6bcf333453b05237755cf558354133b4af873c4925ef68f0526e4de34aaeb72b` |
| `schema_versions` | `14c5e74c4b96ccef41cd94db73a9ec3348038ac094feca4fd897cecffa07cdae` | `205d0001913e4ac10f9e737a64c33517365fcc86c650184c8bef50814dbb8f31` |
| `metric_definitions` | `4ba6838a14db858ba582370c7d475a9ecd74322e23c00a748a6aa879ede3adf9` | `24cf7e707a9bf17728b22c86cbb40185e345ca560037bc2e0da80e05e99bec22` |
| `metric_observations` | `66d625aef0ea864e8b38af99d05300f3c3772bddac04eef3a7e695af61aa717b` | `57cbd2d8eb4be27150c8b579077508b3b38e1d7b94ee03a4be8a014c076d9052` |
| `metric_quality_reviews` | `d6d16310d246725379b3715e97cc747ddc84140fbaa82bd30ace7a4f74f5bb7c` | `f7e6610d086d4acbd9cf19a97327835a1df7d18935f904a621fba9ab85601f82` |
| `susb_public_file_rows` | `c89f6d4eb37ab20d97d3bc7568ddf4a6d4f180639e6833ef374eebb288c089e5` | `c3b0f455f852a52b84457d77e33ec189a505b947f03db656e5c498d9e7be3ca3` |
| `bfs_api_rows` | `6298cb6ee9f672abf2286905cdcae049425ea052671d723561448d39bfdcad93` | `48e956a75def692e047f00337c21067d98398d6e0c5449d5aff6cd01bb6cae0e` |
| `bds_public_file_rows` | `e909352fa5a1c2130e065ce761a29c3a5fe825852e030604ec2d7592833264a0` | `edba42b01bf179d640accb0f7f2fd528053bd22ce6cde12253692272437d8bdd` |

## Recovery Gate, Later Phase

Before production migration or quarterly activation:

1. Confirm the actual PostgreSQL data and WAL locations and that the selected
   Droplet backup covers them. If PostgreSQL uses an attached Volume, its
   recovery must be covered and tested separately; do not assume the Droplet
   image includes it.
2. Restore a pre-change backup to an isolated environment with jobs disabled.
   Verify PostgreSQL opens, the Day 0 member/value/review-link digests match,
   and the app can read the restored database. Rehearse the migration and
   collection job there, then discard that environment. This is how a real
   write-path smoke test leaves no lasting production records.
3. After the pre-change restore succeeds, deploy schema changes and guarded
   production collection entry points with scheduling disabled. Run targeted
   read-only Droplet smoke checks; the full test suite is not the Droplet smoke
   test. Register the existing production Day 0 rows in place, then run and
   inspect one manual Q3 collection after September 30.
4. Restore a post-run backup in isolation and verify both Day 0 and the
   completed collection. Only then enable the collection schedule and observe
   its first fire. Scheduler dispatch can be checked in the isolated environment
   before activation without running a production collection.

Droplet backup retention is a recovery window, not the ten-year database
history policy. Keep completed quarterly records in PostgreSQL; do not prune
them merely because an older backup image expired. A backup can recover loss,
but it cannot prevent a faulty job from overwriting rows; database constraints
and append-only job behavior must enforce that separately.

No production backup, restore, deployment, or schedule change is part of the
current local implementation work.
