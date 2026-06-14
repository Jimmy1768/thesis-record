# Private Storage Classification Matrix

Status: storage-boundary design. Not application code, data ingestion, claim
support, paper prose, legal advice, or security certification.

Run date: 2026-06-12.

## Purpose

Define where each type of living-dissertation information belongs before any
private ingestion or Rails implementation begins.

Core principle:

- Git is the public scientific record.
- Production PostgreSQL is the private structured evidence system of record.
- Private file storage is the private evidence warehouse for documents and
  large blobs.
- Secret manager or environment configuration is the only place for secrets.

Data moves from private storage to Git only after review, redaction,
aggregation, and snapshot approval.

Never allow:

`private source -> Git`

Allowed flow:

`private source -> production PostgreSQL / private files -> validation -> metric -> review -> redacted Git export`

## Storage Zones

| Zone | Purpose | Durable? | Queryable? | Public? |
| --- | --- | --- | --- | --- |
| Git repository | Public research memory, code, schemas, source notes, returns, reviewed exports, and snapshot manifests. | Yes | Limited | Yes or shareable |
| Production PostgreSQL | Private structured evidence, review states, metrics, registry rows, snapshot metadata, and file pointers. | Yes | Yes | No |
| Private file storage | Contracts, invoices, PDFs, screenshots, raw exports, large CSVs, audio/video, and other document/blob evidence. | Yes | Metadata only through PostgreSQL | No |
| Secret manager/env | Credentials, API keys, database URLs, encryption keys, and service tokens. | Yes | No | No |
| Local development database | Synthetic, fixture, or redacted development data. | No production authority | Yes | No |
| Encrypted backup storage | Encrypted production database backups and private file backups. | Yes | Restore only | No |

## Storage Classification Matrix

| Information Type | Git | Production PostgreSQL | Private File Storage | Secret Manager/Env | Notes |
| --- | --- | --- | --- | --- | --- |
| Research plans and architecture docs | Yes | Optional metadata | No | No | Public research memory. |
| Paper prose | Yes when intentionally edited | Optional metadata | No | No | `paper/draft.md` remains outside research-slice edits unless explicitly requested. |
| Source notes for public sources | Yes | Optional mirror | No | No | Must distinguish inspection status. |
| Private source metadata | Redacted summary only | Yes | No | No | Use source role, privacy class, access status, and review state. |
| Code, validators, migrations, jobs | Yes | No | No | No | Must not embed private records or secrets. |
| Empty schemas and intake templates | Yes | Yes if app uses them | No | No | Templates only, no raw records. |
| Source registry rows | Public rows only or redacted export | Yes | No | No | Private source rows stay in production PostgreSQL. |
| Raw public datasets | Usually no; ignored staging or reviewed snapshot only | Optional if ingested | Optional for large files | No | Track manifests/checksums when public raw files are too large. |
| Raw private structured rows | No | Yes | No | No | Production PostgreSQL is the system of record. |
| Raw contracts, invoices, PDFs, screenshots | No | Metadata only | Yes | No | Store file hash, source, privacy class, pointer, retention rule in PostgreSQL. |
| HRIS/payroll exports | No | Structured fields after approval | Original export if retained | No | Requires privacy review and restricted access. |
| Client, worker, evaluator, supplier identities | No | Restricted or hashed | Possibly in original source file | No | Public artifacts use redacted or hashed identifiers only. |
| Exact client-level revenue or contract values | No | Yes with access controls | Possibly in source file | No | Public outputs should use bands or aggregates unless separately approved. |
| Metric definitions | Yes | Yes | No | No | Definitions can be public if they do not expose private facts. |
| Metric observations from private data | Reviewed aggregate only | Yes | No | No | Public export requires review, redaction, and minimum-cell check. |
| Claim review decisions | Publishable summary only | Yes | No | No | Claim status changes require human review. |
| Evidence snapshot manifests | Yes if redacted | Yes | Optional artifact bundle | No | Must include source statuses and privacy-review state. |
| Redacted aggregate exports | Yes after review | Yes | Optional | No | Only after disclosure and minimum-cell review. |
| API keys, database URLs, SSH keys, tokens | No | No | No | Yes | Never commit secrets or put them in source notes. |
| Production database dumps | No | Backup source only | Encrypted backup storage only | No | Do not store on MacBook unless explicitly encrypted, temporary, and documented. |
| Local dev fixtures | Yes if synthetic | Yes in dev only | No | No | Must not be copied from production unless redacted and approved. |

## Rails Enforcement Requirements

The application should enforce storage class before ingestion.

Required fields on source or intake records:

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

Ingestion should fail closed when:

- `storage_zone` is missing;
- `privacy_classification` is missing;
- private rows are marked as Git-allowed;
- secrets are detected in a file or field intended for Git;
- a raw private document lacks private file-storage approval;
- a private-data export lacks review status;
- an aggregate violates the minimum public-cell rule.

Every storage-zone classification and classification change should write an
audit event as defined in:

- `research/data/audit_trail_minimum_design.md`

## Export Rules

An export can enter Git only when all are true:

- source status is known;
- schema version is recorded;
- privacy classification is recorded;
- private identifiers are removed, hashed, or banded;
- minimum public-cell rule passes when private data are involved;
- human review is recorded;
- export artifact is marked `reviewed_for_public_repo=true`;
- claim-status effect is explicit: unchanged, weak support, support,
  contradiction, or not evidence.

Private records should never be exported directly.

## Local Development Rule

Local development should use:

- synthetic fixtures;
- empty templates;
- public sample data;
- redacted extracts approved for development.

Local development should not use:

- production database dumps;
- raw client records;
- raw worker or evaluator records;
- raw invoices, contracts, or payroll exports;
- production credentials.

Exception:

- A production-derived local dataset requires explicit approval, encryption,
  time-bounded retention, deletion record, and documentation outside public
  Git if it contains confidential facts.

## Current Status Flags

`private_data_ingested=false`
`claim_support_updated=false`
`paper_prose_updated=false`
`storage_classification_matrix_created=true`
`production_postgresql_selected_for_private_structured_data=true`
`audit_trail_minimum_design_created=true`
