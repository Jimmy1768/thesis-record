# Living Dissertation Application Build Plan

Status: implementation build plan. Not application code, data ingestion,
analysis, claim support, paper prose, legal advice, or security certification.

Run date: 2026-06-12.

## Purpose

Build the living dissertation as a private, durable evidence system rather than
as a folder of static files.

The application should collect public and governed private data over time,
validate it, preserve versioned evidence snapshots, and export only reviewed,
redacted, or aggregate artifacts into the public research repository.

## Core Decision

Use a Rails application with PostgreSQL and Sidekiq as the operating system for
the living dissertation.

Adjustable thresholds, cadence values, and operations defaults must be defined
once in the canonical policy file before app code or workflow docs depend on
them:

- `living_dissertation_app/config/living_dissertation_policy.yml`

This is now a global design rule. Research docs may describe why a threshold
exists, but the policy file is the current-value source.

| Component | Role | Guardrail |
| --- | --- | --- |
| Git repository | Public research logic, schemas, source notes, validators, returns, migrations, and reviewed aggregate exports. | No raw private records, secrets, client names, worker names, evaluator names, or unreviewed outputs. |
| Rails application | Authenticated evidence intake, source registry, review workflow, audit trail, snapshot management, and export controls. | Must not automatically promote claim status or write paper prose. |
| PostgreSQL | Private source registry, raw/private evidence records, normalized metrics, review states, and snapshot metadata. | Hosted outside the repo; encrypted backups and access controls required before private ingestion. |
| Sidekiq/Redis | Scheduled fetching, validation, QA, aggregation, snapshot generation, and stale-source checks. | Jobs may compute indicators, but interpretation and claim-status changes require human review. |
| Droplet or managed host | Durable deployment target so the MacBook is not the source of truth. | Secrets, database dumps, and private files must stay outside Git. |

## System Boundary

The app exists to make forecast updating auditable.

It should answer:

- what source was collected;
- when it was collected;
- what schema version was used;
- whether validation passed;
- what private identifiers were removed or hashed;
- what aggregate metric was computed;
- which prediction, criticism, or open question the metric can inform;
- who reviewed it;
- what snapshot version included it.

It should not decide:

- whether the Operator Node thesis is true;
- whether a claim is supported;
- whether a result deserves paper interpretation;
- whether a policy conclusion follows.

## Evidence Gate Enforcement

The application should enforce the locked evidence pipeline:

`collect -> verify -> validate -> compute -> classify -> review -> publish`

Forbidden shortcut:

`collect -> interpret -> write`

Implementation implication:

- collection jobs can create source records, retrieval logs, checksums, and
  raw/private storage pointers;
- verification workflows can update source status and access-path evidence;
- validation jobs can update schema, privacy, suppression, and QA status;
- metric jobs can write calculated observations;
- classification workflows can tag what kind of evidence a metric can be;
- only human review workflows can change prediction or claim status;
- publication/export workflows can use only reviewed evidence.

The Rails permission model should make claim-status changes and publication
exports separate actions from ingestion, validation, and metric calculation.

## Data Storage Rules

Raw private data must never be stored in tracked files.

Structured private data should be stored in the production PostgreSQL database
as the private evidence system of record.

The hard storage classification matrix is defined in:

- `research/data/private_storage_classification_matrix.md`

Allowed in Git:

- source code;
- database migrations;
- schema definitions;
- validation scripts;
- public source notes;
- empty intake templates;
- redacted aggregate exports after review;
- snapshot manifests;
- return records.

Not allowed in Git:

- raw contracts;
- raw invoices;
- HRIS or payroll exports;
- client, worker, evaluator, supplier, account, or project names;
- exact client-level revenue;
- secrets, API keys, database URLs, private SSH keys, or production config;
- unreviewed private outputs.

Private storage decision:

- production PostgreSQL is the system of record for structured private records;
- development databases should use synthetic, fixture, or redacted data unless
  a specific encrypted temporary exception is approved and documented;
- production database dumps should not be stored on the MacBook or committed to
  Git;
- encrypted backups and tested restore procedures are required before private
  ingestion.

Private file storage remains a separate implementation decision:

- private object storage or encrypted disk paths for source documents;
- a separate private artifact store for files that should not be in the repo;
- PostgreSQL should store file metadata, hashes, privacy status, and storage
  pointers rather than large confidential documents when object storage or
  encrypted file storage is used.

No private data ingestion is authorized until storage, access control,
retention, disclosure, and redaction rules are implemented.

## Proposed Rails Modules

| Module | Purpose | First Objects |
| --- | --- | --- |
| Identity and access | Restrict private evidence by role. | `User`, `Role`, `AccessGrant` |
| Source registry | Track public and private sources before ingestion. | `DataSource`, `SourceStatus`, `AccessPath` |
| Intake manifests | Define what may be collected before raw rows arrive. | `IntakeManifest`, `SchemaVersion`, `RetentionRule` |
| Private evidence vault | Store governed private records or file metadata. | `EvidenceRecord`, `PrivateArtifact`, `PrivacyReview` |
| Normalized metrics | Hold validated, comparable indicators. | `MetricDefinition`, `MetricObservation`, `QualityFlag` |
| Prediction registry | Link indicators to predictions without changing claim status. | `PredictionLink`, `CriticismLink`, `OpenQuestionLink` |
| Claim review | Require human review for status changes. | `ClaimReview`, `ReviewDecision`, `ReviewNote` |
| Failure records | Preserve adverse, null, missing, or contradictory evidence as research outputs. | `FailureRecord` |
| Snapshot registry | Freeze V1, V2, V3, and later evidence states. | `EvidenceSnapshot`, `SnapshotArtifact`, `SnapshotManifest` |
| Export controls | Produce reviewed aggregate artifacts for the repo. | `ExportJob`, `ExportArtifact`, `RedactionCheck` |
| Audit log | Preserve who changed what and when. | `AuditEvent` |

Minimum audit design:

- `research/data/audit_trail_minimum_design.md`

## Initial Domain Tables

The first implementation should favor narrow, boring tables over a broad
research ontology.

Suggested first tables:

- `data_sources`
- `source_access_paths`
- `intake_manifests`
- `schema_versions`
- `privacy_reviews`
- `evidence_records`
- `private_artifacts`
- `metric_definitions`
- `metric_observations`
- `quality_flags`
- `prediction_links`
- `claim_reviews`
- `failure_records`
- `evidence_snapshots`
- `export_artifacts`
- `audit_events`

The company operator network pilot should start as a governed source in
`data_sources` and an empty `intake_manifest`, not as raw operational rows.

## Background Job Families

| Job | Purpose | Writes | Human Gate |
| --- | --- | --- | --- |
| `FetchPublicDatasetJob` | Pull approved public datasets from verified APIs or downloads. | Raw private storage or ignored staging, retrieval log, manifest. | New source class approval. |
| `ImportPrivateIntakeJob` | Import records from an approved private intake manifest. | Private evidence tables and audit events. | Storage, consent, retention, and disclosure rules. |
| `ValidatePrivateIntakeJob` | Check required fields, privacy flags, hash/redaction status, and hidden-labor fields. | Validation results and quality flags. | Failed validation blocks downstream use. |
| `ComputeNodeFeasibilityIndicatorsJob` | Compute bounded node-case feasibility metrics. | Metric observations. | Feasibility interpretation review. |
| `ComputeTransactionCostIndicatorsJob` | Compute search, contracting, monitoring, dispute, payment, and repeat-purchase indicators. | Metric observations. | Baseline and comparability review. |
| `ComputeRemoteSubstitutionIndicatorsJob` | Track remote employee, vendor, node, contractor, owner-operator, and AI labor-service shifts. | Metric observations. | Replacement-destination review. |
| `ComputeExperiencerIndicatorsJob` | Track compensated human evaluation tasks and substitution by telemetry or synthetic users. | Metric observations. | Category-definition review. |
| `RedactAndAggregateExportJob` | Produce publishable aggregates or redacted artifacts. | Export artifacts. | Disclosure and minimum-cell review. |
| `GenerateEvidenceSnapshotJob` | Freeze reviewed evidence for V1/V2/V3 releases. | Snapshot manifests. | Human publication review. |
| `StaleSourceCheckJob` | Identify sources, API schemas, or credentials requiring refresh. | Maintenance tickets or source flags. | Source-truth correction review. |

## Private Evidence Workflow

1. Register the source with owner, role, privacy class, retention rule, and
   disclosure rule.
2. Verify source reality, access path, and citation or source-note status.
3. Create an empty intake manifest before reviewing outcomes.
4. Map available fields to approved governance schemas.
5. Define comparison baselines before importing outcome data.
6. Import data into private storage only after access controls and audit logs
   are active.
7. Validate required fields, hidden-labor flags, redaction, cell-size rules,
   and schema version.
8. Compute indicators only from validated records.
9. Classify the evidence type without changing claim status.
10. Require human review before a metric can be accepted for a forecast check.
11. Export only redacted or aggregate artifacts after disclosure review.
12. Freeze reviewed artifacts into a versioned evidence snapshot.

## Security And Operations Requirements

Minimum requirements before private ingestion:

- storage-zone classification enforced for each source or intake;
- audit trail implemented for protected evidence, review, export, and access
  actions;
- production secrets stored outside Git;
- database credentials loaded from environment or a managed secret store;
- production PostgreSQL provisioned as the private structured-data system of
  record;
- production operations runbook followed:
  `research/data/living_dissertation_production_operations.md`;
- deployment-readiness scaffold followed:
  `research/data/living_dissertation_deployment_readiness.md`;
- TLS for the web application;
- SSH key access only, with password login disabled on the host;
- least-privilege database users;
- encrypted database backups;
- tested restore procedure;
- audit logging for source, evidence, review, export, and user changes;
- role-based access for private records;
- retention and deletion procedure for confidential records;
- separate production and development databases;
- no production database dumps on the MacBook unless explicitly encrypted and
  temporary.

The first deployment may use a single secured droplet for Rails, Sidekiq,
Redis, and PostgreSQL if operational simplicity is more valuable than managed
service separation. A later production-grade setup can move PostgreSQL and file
storage to managed services.

## Redacted Export Path

The app may write to the repository only through reviewed export artifacts.

Export artifacts should include:

- snapshot version;
- source IDs;
- source statuses;
- schema versions;
- transformation code commit;
- row-count and cell-suppression checks;
- privacy-review status;
- claim-review status;
- reviewed aggregate tables or manifests.

Exports should never include raw private rows.

## Versioned Forecast Schedule

The app should support scheduled versions such as:

- `v1`: baseline thesis, forecast definitions, and initial source registry;
- `v2`: first major evidence update after a predefined interval;
- `v3`: longer-run update after additional data accrues;
- later versions: continued updates or error classification.

Each version should preserve adverse evidence. A failed prediction is an output
of the system, not a reason to change the measurement rule after the fact.

## Phased Build Plan

### Phase 0: Plan And Guardrails

Status: current phase.

Deliverables:

- this build plan;
- links from existing living-forecast and private-data governance docs;
- no private data ingestion;
- no application code required yet.

### Phase 1: Rails Skeleton

Deliverables:

- Rails app scaffold;
- PostgreSQL configured;
- Sidekiq and Redis configured;
- authentication and role model;
- audit-event table;
- audit writer service;
- environment and secret handling;
- deployment README.

Exit criteria:

- app boots locally;
- tests pass;
- no secrets in Git;
- audit events are created for protected changes.
- protected changes fail closed if audit logging fails.
- storage-zone fields exist but no private ingestion is enabled.

### Phase 2: Source Registry And Intake Manifests

Deliverables:

- source registry CRUD;
- intake manifest model;
- schema version model;
- privacy classification workflow;
- storage classification workflow;
- empty company operator network intake manifest.

Exit criteria:

- company operator network source exists as metadata only;
- no private operational rows ingested;
- export of an empty manifest passes redaction checks.

### Phase 3: Private Evidence Vault

Deliverables:

- private evidence records;
- private artifact metadata;
- privacy review workflow;
- hidden-labor review fields;
- retention rule fields;
- validation jobs.

Exit criteria:

- test fixtures validate the workflow;
- private records are inaccessible to unauthorized roles;
- failed privacy validation blocks export.

### Phase 4: Public Dataset Jobs

Deliverables:

- public dataset source adapters for already verified sources;
- manifest validation;
- row-count and schema checks;
- stale-source checks.

Exit criteria:

- public datasets can be fetched into ignored/private staging;
- tracked artifacts contain only manifests and reviewed aggregates.

### Phase 5: Indicator And Review Layer

Deliverables:

- metric definitions;
- metric observations;
- prediction and criticism links;
- claim-review workflow;
- failure-record workflow;
- redacted aggregate export jobs.

Exit criteria:

- indicators can be computed without changing claim status;
- adverse, null, missing, or contradictory indicators can be recorded as
  failure records without changing claim status;
- human review is required before acceptance into a forecast snapshot.

### Phase 6: Snapshot And Publication Support

Deliverables:

- V1/V2/V3 snapshot registry;
- snapshot manifests;
- reviewed export bundles;
- dashboard or appendix-data exports.

Exit criteria:

- a snapshot can be reproduced from source registry, schema versions,
  validation state, and reviewed metrics;
- adverse evidence remains visible.

## Immediate Implementation Decisions

Before code starts, choose:

- whether the Rails app lives inside this repository or in a sibling private
  application repository;
- whether production PostgreSQL runs on the droplet or in a managed database;
- whether private files live on encrypted disk, object storage, or both;
- authentication approach;
- backup and restore approach;
- deployment target and naming convention;
- whether the first code milestone should be local-only or droplet-ready.

## Current Status Flags

`rails_app_implemented=false`
`private_data_ingested=false`
`registry_rows_added=false`
`claim_support_updated=false`
`paper_prose_updated=false`
`production_postgresql_selected_for_private_structured_data=true`
`storage_classification_matrix_created=true`
`audit_trail_minimum_design_created=true`
`failure_as_first_class_output_policy_created=true`
