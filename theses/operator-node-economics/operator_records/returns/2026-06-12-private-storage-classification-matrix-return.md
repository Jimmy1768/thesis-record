# Private Storage Classification Matrix Return

Run date: 2026-06-12.

## Task

Record the hard storage classification matrix for Git, production PostgreSQL,
private file storage, secret manager/environment configuration, local
development data, and encrypted backup storage.

## Files Changed

- `research/data/private_storage_classification_matrix.md`
- `research/data/living_dissertation_application_build_plan.md`
- `research/data/private_data_governance.md`
- `research/data/company_operator_network_pilot_intake_plan.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-12-private-storage-classification-matrix-return.md`

## Decision Recorded

Storage zones:

- Git is the public scientific record.
- Production PostgreSQL is the private structured evidence system of record.
- Private file storage is the private evidence warehouse for documents and
  large blobs.
- Secret manager or environment configuration stores credentials and keys.
- Local development uses synthetic, fixture, public sample, or redacted data by
  default.
- Encrypted backup storage holds encrypted production backups.

## Matrix Added

The matrix classifies research docs, source notes, private source metadata,
code, templates, source registry rows, public datasets, raw private structured
rows, contracts/invoices/PDFs/screenshots, HRIS/payroll exports, identities,
client-level values, metric definitions, metric observations, claim review
decisions, snapshot manifests, redacted aggregate exports, secrets, database
dumps, and local dev fixtures.

## Rails Enforcement Requirements Added

Required source/intake fields:

- `storage_zone`
- `privacy_classification`
- `public_repo_allowed`
- `structured_private_allowed`
- `private_file_storage_allowed`
- `secret_material_present`
- `redaction_required`
- `minimum_cell_rule_required`
- `human_review_required`
- `retention_rule`

## Guardrails Preserved

- No private data ingestion is authorized.
- No `paper/draft.md` edits.
- No claim status changes.
- Private source data cannot flow directly to Git.
- Git exports require review, redaction or aggregation, minimum-cell checks
  when private data are involved, and explicit public-repo approval.

## Status Flags

`private_data_ingested=false`
`claim_support_updated=false`
`paper_prose_updated=false`
`storage_classification_matrix_created=true`
`production_postgresql_selected_for_private_structured_data=true`

## Verification

Commands run after edits:

- `git diff -- paper/draft.md` returned no output.
- `git diff --check` passed.
- guardrail term scan across changed files returned no content matches.
- storage-matrix scan confirmed `storage_zone`, `public_repo_allowed`,
  `secret_material_present`, `reviewed_for_public_repo=true`, and
  `storage_classification_matrix_created=true`.
