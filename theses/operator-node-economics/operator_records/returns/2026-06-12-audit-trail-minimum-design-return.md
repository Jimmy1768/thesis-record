# Audit Trail Minimum Design Return

Run date: 2026-06-12.

## Task

Analyze and define the minimum audit trail the living dissertation application
must implement before any private data ingestion.

## Files Changed

- `research/data/audit_trail_minimum_design.md`
- `research/data/living_dissertation_application_build_plan.md`
- `research/data/private_storage_classification_matrix.md`
- `research/living_forecast_system.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-12-audit-trail-minimum-design-return.md`

## Decision Recorded

Auditability is now treated as a minimum implementation requirement before
private ingestion.

Core rule:

- evidence without provenance is not evidence for this project;
- if the app cannot reconstruct how a source, row, metric, review decision, or
  export entered the system, that item is blocked from claim support, forecast
  snapshots, and public export.

## Minimum Audit Design

Created a required `audit_events` design with:

- actor fields;
- event type;
- affected entity;
- source and snapshot links;
- request and job IDs;
- previous and new state hashes;
- reason code;
- review linkage;
- storage zone;
- privacy classification;
- claim-status effect;
- export permission;
- request IP or host when available.

## Required Event Areas

- identity and access;
- source and intake;
- storage and privacy;
- collection and validation;
- metric and evidence;
- human review and claims;
- export and snapshot;
- operations.

## Blocked Without Audit

The design requires protected actions to fail closed when audit logging fails,
including source registration, intake changes, privacy and storage
classification changes, validation results, metric changes, evidence
classification, human review decisions, claim-status changes, public export
approval, snapshot freezing, and access grants or revocations.

## Guardrails Preserved

- No private data ingestion is authorized.
- No `paper/draft.md` edits.
- No claim support changes.
- Audit events must not store raw private payloads or secrets.

## Status Flags

`audit_trail_minimum_design_created=true`
`rails_app_implemented=false`
`private_data_ingested=false`
`claim_support_updated=false`
`paper_prose_updated=false`

## Verification

Commands run after edits:

- `git diff -- paper/draft.md` returned no output.
- `git diff --check` passed.
- guardrail term scan across changed files returned no content matches.
- audit-design scan confirmed `audit_events`, fail-closed behavior,
  `claim_status_effect`, `previous_state_hash`, `new_state_hash`, and
  `audit_trail_minimum_design_created=true`.
