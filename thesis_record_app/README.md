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
