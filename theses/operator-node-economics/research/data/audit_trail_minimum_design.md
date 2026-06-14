# Audit Trail Minimum Design

Status: auditability design. Not application code, data ingestion, analysis,
claim support, paper prose, legal advice, or security certification.

Run date: 2026-06-12.

## Purpose

Define the minimum audit trail the living dissertation application must
implement before any private data ingestion.

Core principle:

Auditability matters more than interface complexity. The first version should
make every important evidence action answerable:

- who did it;
- what changed;
- when it changed;
- why it changed;
- what source, schema, metric, review, export, or snapshot it affected;
- whether the change can affect a claim or publication.

## First-Principles Rule

Evidence without provenance is not evidence for this project.

If the app cannot reconstruct how a source, row, metric, review decision, or
export entered the system, that item should be blocked from claim support,
forecast snapshots, and public export.

## Minimum Audit Event Table

The first Rails implementation should include an `audit_events` table.

Required fields:

| Field | Purpose |
| --- | --- |
| `id` | Stable event identifier. |
| `occurred_at` | Timestamp of the audited action. |
| `actor_type` | Human user, background job, system process, import script, or external service. |
| `actor_id` | User ID, job ID, service ID, or null only for bootstrapping events. |
| `event_type` | Controlled vocabulary for what happened. |
| `entity_type` | Model or object type affected. |
| `entity_id` | ID of affected object. |
| `source_id` | Source link when applicable. |
| `snapshot_id` | Snapshot link when applicable. |
| `request_id` | Web request or job execution ID. |
| `job_id` | Background job ID when applicable. |
| `previous_state_hash` | Hash or digest of important pre-change state. |
| `new_state_hash` | Hash or digest of important post-change state. |
| `change_summary` | Human-readable summary without private secrets. |
| `reason_code` | Controlled reason for the action. |
| `review_required` | Whether this action requires human review. |
| `review_id` | Review decision link when applicable. |
| `storage_zone` | Git, production PostgreSQL, private file storage, secret manager/env, local dev, or backup. |
| `privacy_classification` | Public, aggregated public, redacted public, internal, or confidential. |
| `claim_status_effect` | Unchanged, weak support, support, contradiction, rejected, or not evidence. |
| `export_allowed` | Whether the affected object is allowed in a public export. |
| `ip_or_host` | Request IP, job host, or server identifier when available. |
| `created_at` | Database creation timestamp. |

The audit event should not store raw private payloads or secrets. It should
store identifiers, hashes, status fields, and short summaries.

## Required Event Types

### Identity And Access

- `user_created`
- `user_role_changed`
- `access_granted`
- `access_revoked`
- `login_succeeded`
- `login_failed`

### Source And Intake

- `source_registered`
- `source_status_changed`
- `source_access_path_changed`
- `intake_manifest_created`
- `intake_manifest_changed`
- `schema_version_created`
- `schema_version_changed`

### Storage And Privacy

- `storage_zone_classified`
- `privacy_classification_changed`
- `private_file_registered`
- `private_file_hash_changed`
- `retention_rule_changed`
- `redaction_status_changed`
- `minimum_cell_check_completed`

### Collection And Validation

- `collection_started`
- `collection_completed`
- `collection_failed`
- `validation_started`
- `validation_completed`
- `validation_failed`
- `suppression_or_missingness_flagged`

### Metric And Evidence

- `metric_definition_created`
- `metric_definition_changed`
- `metric_observation_created`
- `metric_observation_recomputed`
- `evidence_classified`
- `quality_flag_created`
- `quality_flag_resolved`

### Human Review And Claims

- `review_requested`
- `review_approved`
- `review_rejected`
- `review_reopened`
- `claim_status_change_requested`
- `claim_status_changed`
- `claim_status_change_rejected`

### Export And Snapshot

- `export_requested`
- `export_blocked`
- `export_created`
- `export_approved`
- `export_published_to_git`
- `snapshot_created`
- `snapshot_frozen`
- `snapshot_superseded`

### Operations

- `backup_completed`
- `backup_failed`
- `restore_test_completed`
- `restore_test_failed`
- `secret_rotated`
- `job_failed`

## Actions Blocked Without Audit

The application should fail closed if it cannot write an audit event for:

- source registration;
- source status changes;
- intake manifest creation or change;
- privacy classification changes;
- storage-zone classification changes;
- private file registration;
- validation completion or failure;
- metric definition changes;
- metric observation creation or recomputation;
- evidence classification;
- human review decisions;
- claim-status changes;
- public export approval;
- snapshot freezing;
- access grants or revocations.

## Claim And Publication Guardrail

No claim status can change unless the audit trail links:

- source status;
- schema version;
- metric definition or evidence object;
- evidence classification;
- human review decision;
- reason code;
- prior claim status;
- new claim status.

No export can enter Git unless the audit trail links:

- source status;
- storage-zone classification;
- privacy classification;
- redaction or aggregation status;
- minimum-cell check when private data are involved;
- human review decision;
- export artifact ID;
- target commit or export package identifier.

## Minimal Reason Codes

Use a controlled vocabulary for review and status changes:

- `new_source`
- `source_correction`
- `schema_correction`
- `validation_failure`
- `metric_definition_update`
- `new_metric_observation`
- `privacy_review`
- `redaction_review`
- `minimum_cell_rule`
- `claim_review`
- `forecast_snapshot`
- `export_review`
- `error_correction`
- `superseded`

## Retention And Mutability

Audit events should be append-only at the application layer.

Allowed:

- append a corrective audit event;
- mark an event as superseded by another event;
- link a correction reason.

Not allowed:

- edit the original audit event in normal app workflows;
- delete audit events through the application;
- store raw private payloads in audit event summaries;
- store secrets in audit events.

## Minimal Implementation Order

Phase 1 must include:

1. `audit_events` table.
2. Audit writer service.
3. Current user or job actor capture.
4. Request/job ID capture.
5. Audit events for user access, source registry, intake manifests, storage
   classification, privacy classification, and export attempts.
6. Tests showing protected actions fail if audit logging fails.

Later phases can add:

- richer state diffs;
- immutable database-level enforcement;
- append-only partitioning;
- external log shipping;
- tamper-evident hashes;
- admin audit dashboard.

## Current Status Flags

`audit_trail_minimum_design_created=true`
`rails_app_implemented=false`
`private_data_ingested=false`
`claim_support_updated=false`
`paper_prose_updated=false`
