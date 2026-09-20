# Q3 2026 Isolated Quarterly Collection Rehearsal Receipt

Status: passed and cleaned up.

This is an operational verification receipt. It is not thesis evidence, a
publication decision, or proof that the production backup/restore gate has
been completed.

## Scope

- Executed on 2026-09-19 UTC against a socket-only PostgreSQL 16.15 cluster on
  the Droplet.
- Restored the existing September production logical dump into the isolated
  cluster; the production database was not used as the write target.
- Used committed application revision
  `c5b7a0b95d9e4fc2c50ef3b1192052ff09752769`.
- Applied migrations `20260918090000` and `20260918091000` only to the
  isolated database.
- Simulated `2026-10-01T00:05:00Z` only inside the rehearsal process so the
  `2026-Q3` cutoff at `2026-10-01T00:00:00Z` could be exercised before the
  real quarter closed.
- Used the real configured public-source retrieval paths. No source response,
  database dump, credential, or copied database is stored in this receipt.

Restore artifact SHA-256:
`9f1cefab3463827c5062c2c98dd47c2c611991e6b27a150cb246ec4d7471abe0`.

## Source Captures

| Source | Release | Rows | Response SHA-256 | Parsed rows SHA-256 |
| --- | ---: | ---: | --- | --- |
| SUSB public file | 2022 | 570,105 | `6f7b2f2b14cbad9dbfeb31d3bfc9f729368a0e971727de4eda88c9f83f77a513` | `f2103d00d17c20bcea59d7bc6d872f752f78d1b3ba112401d1ed58d5f60b48cd` |
| BDS public file | 2023 | 104,880 | `c4790ccdf964788a8bbc8404349df69db2a7457f8784411a39ddb228dedfbabd` | `1d31b89614ff14b0b3a1c0df460ea0cbe339d7434147b9d991767931de579ae3` |
| BFS API | 2026 through the available eligible months | 608 | `8f702804d162f5da03d9d98c73fe4b995072c5f0ff8db71f2f06dbf488c60b77` | `4c824c893b167d7667762f190b5aa34009bf671c22ee80fb7b0661842c0fff8d` |

The first pass recorded three `new` source checks. The concurrent retry
recorded three `unchanged` checks and reused the same captures.

## Completed Collection

- Quarter: `2026-Q3`
- Revision: `1`
- Collection ID: `1`
- Result-set ID: `1`
- Capture links: `3`
- New observations: `1,178,862`
- New quality reviews: `1,178,862`
- Result status: `completed`
- Collection status: `completed`
- Input digest:
  `a615eeaee21de5179de080de8c3052c8da901138406ba71c38c032845f7d54f4`
- Method digest:
  `e9c963ef20e1cbf9bdb3748d5e22e16542bbe8adb2abba54013b2bc7b630af76`
- Definition digest:
  `db4234ab661c6263b6b1956134ec78f1c8035f072e43cd072590b94a026d7d8b`
- Result identity:
  `17b6323e5241fa538d21b65d90176f71c5eb4365dad664234b131b4cca980df4`
- Collection identity:
  `585e15cb7949fdc90c7b98fd73f09e64f30aea9333d51aa09cd13e93945bf793`

The initial writer held the quarterly advisory lock while building the result.
A second full invocation waited on that lock, then returned collection `1` and
result set `1` after the first writer committed. No duplicate collection or
result set was created. The persistent retry ran from 2026-09-19 09:29:17 UTC
through the observed successful return at 13:59:12 UTC.

## Baseline Invariants

After collection, the isolated database retained the original null-linked Day
0 members:

| Relation | Day 0 rows |
| --- | ---: |
| SUSB public-file rows | 570,105 |
| BDS public-file rows | 104,880 |
| BFS API rows | 1,368 |
| Metric observations | 1,179,605 |
| Quality reviews linked to Day 0 observations | 1,179,605 |

The isolated post-run database size was 5,877,963,799 bytes. This was measured
only to confirm capacity and was not retained.

A separate disposable rehearsal on 2026-09-18 restored the same logical dump,
applied the migrations, and successfully registered all ten Day 0 table
manifests with registration digest
`1ea8278d84b1eca2b8ddcbf485c2c237008136f4ede2992709e0f72b35091aea`.
That disposable environment was also removed.

## Production Boundary And Cleanup

- Production remained at schema migration `20260614043000`; the production
  `quarterly_collections` table did not exist after the rehearsal.
- Production web and Sidekiq services were active after verification.
- No production migration, Day 0 registration, quarterly write, scheduler
  activation, deployment, DigitalOcean control-plane action, or source-data
  publication occurred.
- The disposable PostgreSQL cluster, restored database, application copy,
  runner, socket, and logs under
  `/home/jimmy1768_user/thesis-record-rehearsal-q3-20260919` were stopped and
  permanently removed after verification.
- Droplet free space returned to 30 GB after cleanup.

This receipt verifies the application-level logical restore, migration, live
three-source collection, result construction, and concurrent retry behavior.
It does not replace the planned DigitalOcean backup activation and isolated
restore test, the guarded production Q3 run after the real quarter closes, or
the post-run recovery verification.
