# Production PostgreSQL Private Data Decision Return

Run date: 2026-06-12.

## Task

Record the storage-boundary decision that structured private data for the
living dissertation should be saved in the production PostgreSQL database.

## Files Changed

- `research/data/living_dissertation_application_build_plan.md`
- `research/data/private_data_governance.md`
- `research/data/company_operator_network_pilot_intake_plan.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-12-production-postgresql-private-data-return.md`

## Decision Recorded

Production PostgreSQL is selected as the private evidence system of record for
structured private data.

It may store:

- governed structured private records;
- source registry records;
- intake and schema versions;
- privacy and human-review states;
- metric observations;
- snapshot metadata;
- private file metadata, hashes, privacy status, and storage pointers.

It should not cause raw private data, database dumps, credentials, or
unreviewed private outputs to enter Git.

## Still Unresolved

- Whether production PostgreSQL runs on the droplet or in a managed database.
- Whether confidential source documents live in private object storage,
  encrypted disk storage, or both.
- Authentication and access-control implementation.
- Backup and restore implementation.
- Production secret storage.

## Guardrails Preserved

- No private data ingestion is authorized by this decision.
- No `paper/draft.md` edits.
- No claim status changes.
- Local development should use synthetic, fixture, or redacted data by default.
- Production database dumps should not live on the MacBook unless explicitly
  encrypted, temporary, and documented.

## Status Flags

`production_postgresql_selected_for_private_structured_data=true`
`private_data_ingested=false`
`claim_support_updated=false`
`paper_prose_updated=false`

## Verification

Commands run after edits:

- `git diff -- paper/draft.md` returned no output.
- `git diff --check` passed.
- guardrail term scan across changed files returned no content matches.
- storage-decision scan confirmed the production PostgreSQL system-of-record
  flag and decision language across the changed files.
