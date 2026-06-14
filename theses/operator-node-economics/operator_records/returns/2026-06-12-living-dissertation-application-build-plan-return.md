# Living Dissertation Application Build Plan Return

Run date: 2026-06-12.

## Task

Write a plan document for building the living dissertation as a Rails,
PostgreSQL, and Sidekiq application with private data stored outside Git and
versioned evidence snapshots exported only after review.

## Files Changed

- `research/data/living_dissertation_application_build_plan.md`
- `research/living_forecast_system.md`
- `research/data/private_data_governance.md`
- `research/data/company_operator_network_pilot_intake_plan.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-12-living-dissertation-application-build-plan-return.md`

## Build Plan Summary

Created a conservative implementation plan for a living dissertation app:

- Rails application for authenticated intake, source registry, review workflow,
  audit logging, export controls, and evidence snapshots.
- PostgreSQL private evidence vault for governed private records and normalized
  metrics.
- Sidekiq/Redis job layer for scheduled fetch, validation, indicator
  computation, redacted export, stale-source checks, and snapshot generation.
- Droplet or managed host as durable source of truth so the MacBook is not the
  only storage location.
- Git repository limited to code, schemas, source notes, validators, returns,
  and reviewed aggregate/redacted exports.

## Guardrails Preserved

- No raw private data in Git.
- No secrets, API keys, database URLs, SSH keys, raw contracts, invoices,
  payroll exports, HRIS exports, client names, worker names, evaluator names,
  supplier names, or unreviewed private outputs in Git.
- No private data ingestion authorized.
- No recurring job may promote claim status or write paper prose.
- Human review remains required for source-truth promotion, metric acceptance,
  claim-status changes, and publication interpretation.

## Cross-References Updated

- `research/living_forecast_system.md` now points to the build plan as the
  implementation bridge.
- `research/data/private_data_governance.md` now points to the build plan and
  keeps implementation status false.
- `research/data/company_operator_network_pilot_intake_plan.md` now records the
  Rails/PostgreSQL/Sidekiq app as the current private-storage implementation
  target while preserving the no-ingestion rule.
- `research/reading_queue.md` now records the remaining living dissertation app
  build gap.

## Status Flags

`rails_app_implemented=false`
`private_data_ingested=false`
`registry_rows_added=false`
`claim_support_updated=false`
`paper_prose_updated=false`

## Remaining Implementation Decisions

- Decide whether the Rails app lives inside this repository or in a sibling
  private application repository.
- Decide whether production PostgreSQL runs on the droplet or in a managed
  database.
- Decide whether private files live on encrypted disk, object storage, or both.
- Select authentication, backup, restore, and deployment approach.
- Build the Rails skeleton before creating the company operator network empty
  intake manifest.

## Verification

Commands run after edits:

- `git diff -- paper/draft.md`
- `git diff --check`
- `rg -n "Living Dissertation Application Build Plan|rails_app_implemented=false|private_data_ingested=false|claim_support_updated=false|paper_prose_updated=false" research docs/operator/returns/2026-06-12-living-dissertation-application-build-plan-return.md`
- guardrail term scan across the changed files returned no content matches.

## Paper Draft Status

`paper/draft.md` remained untouched.
