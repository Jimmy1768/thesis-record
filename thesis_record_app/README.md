# ThesisRecord App

Rails foundation for the Operator Node Economics ThesisRecord.

Status: Phase 1 scaffold. No private data ingestion, claim promotion,
publication automation, or production deployment is enabled.

## Local Setup

```bash
bundle install
bin/rails db:prepare
bin/rails test
```

## Local Periodic Collection Work

The June Day 0 database baseline must be registered in place, not reimported. The
local collection code adds capture-linked SUSB/BDS/BFS rows and immutable
quarter/result identities beside the existing thesis checkpoint records.
`operator:day_zero_digest_rehearsal` is read-only and expects the documented
June counts. Synthetic tests exercise duplicate checks, corrected captures,
unchanged quarters, and append-only database guards.

The SUSB, BDS, and BFS parsers, three-source release lookup, append-only
source-native computation, pending review links, and Sidekiq quarterly job
have local controlled-response tests. The job takes an explicit quarter,
cutoff, and source registry IDs; it is not scheduled. No live collection has
run. Production collection and Day 0 registration entry points remain disabled
until the later production phase. See
`ops/docs/plans/periodic_evidence_pipeline_plan.md` at the repository root for
the phase boundary.

The reporting quarter is a UTC calendar interval, with an exclusive end derived
from its label; retrieval happens after that end. A quarterly record must show
the source releases and reference periods actually available at retrieval,
which may lag the reporting quarter. The local job rejects a cutoff that does
not match the quarter or a run before the quarter closes. BFS requests are
bounded through the quarter's last eligible month; the live query predicate
still requires verification during production preparation.

## Boundaries

- Structured private data belongs in production PostgreSQL.
- Raw private documents belong in private file storage, with metadata in
  PostgreSQL.
- Secrets, API keys, database URLs, and `config/master.key` must not be
  committed.
- Background jobs may collect, validate, compute, and prepare reviewed exports.
  They must not promote claims or write paper prose.
- Protected source, privacy, claim, export, and snapshot actions must write
  audit events.

* ...
