# Operator Nodes V0 Baseline Snapshot: 2026-06-14

Status: review draft.

## Scope

This manifest records the first v0 baseline snapshot for the Operator Nodes
thesis. It freezes what the ThesisRecord production database currently knows
before v0 publication approval.

This is a baseline manifest, not a publication approval, claim review, thesis
verdict, paper draft, or evidence promotion. It does not authorize automatic
claim promotion, prediction-link creation, claim-review creation, exports, paper
prose edits, or public publication.

## System Of Record

- Canonical structured evidence store: production PostgreSQL
- Production database: `thesis_record_production`
- Production host: `sourcecombatives-web`
- Public path target: `sourcegridlabs.com/thesis`
- Rails relative URL root: `/thesis`
- Local development database role: dev-only rehearsal, not canonical
- Canonical data promotion default: disabled

Local development PostgreSQL exists for rehearsal and app checks, but it is not
the system of record. At the time this manifest was prepared, the local
development database had no migrated evidence rows.

## Production Counts

Observed from `bin/rails operator:production_summary` against production on
2026-06-14.

| Table | Production rows | Baseline role |
| --- | ---: | --- |
| `data_sources` | 3 | Source registry |
| `source_access_paths` | 3 | Source access metadata |
| `intake_manifests` | 3 | Intake records |
| `schema_versions` | 3 | Source/schema records |
| `metric_definitions` | 21 | Baseline metric vocabulary |
| `metric_observations` | 1179605 | Source-native/context observations |
| `metric_quality_reviews` | 1179605 | Observation-level quality review records |
| `susb_public_file_rows` | 570105 | Census SUSB public-file source rows |
| `bfs_api_rows` | 1368 | Census BFS API source rows |
| `bds_public_file_rows` | 104880 | Census BDS public-file source rows |
| `audit_events` | 95 | Audit trail records after production checks |
| `users` | 0 | Intentionally absent before operator account bootstrap |
| `roles` | 0 | Intentionally absent before operator account bootstrap |

Production health at observation time:

- `rails_env=production`
- `relative_url_root=/thesis`
- `canonical_data_promotion_disabled=true`
- `health_passed=true`
- `health.rails_booted=true`
- `health.database_connected=true`
- `health.redis_connected=true`
- `health.sidekiq_config_loaded=true`
- `health.operations_policy_passed=true`
- warnings: `no_production_users`, `no_production_roles`

The user/role warnings are accepted for the current no-login production phase.

## Source Coverage

The v0 baseline includes structured records for:

- Census Statistics of U.S. Businesses public-file rows;
- Census Business Formation Statistics API rows;
- Census Business Dynamics Statistics public-file rows;
- metric definitions and source-native/context metric observations derived
  from those records;
- matching metric quality-review records.

The source coverage is sufficient to establish a production evidence baseline
and measurement infrastructure. It is not sufficient by itself to verify
AI-enabled one-human firms, transaction-cost reduction, firm-boundary change,
management-layer shrinkage, nonemployer-to-employer transitions, or
AI-specific remote-employment substitution.

## Claim Baseline

The candidate v0 claim inventory is:

`theses/operator-node-economics/publication/v0_claim_set.yml`

Baseline state:

- claim set status: `candidate_inventory`
- approval status: `unapproved`
- claim status effect: unchanged
- automatic promotion authorized: false
- candidate claim IDs: `TCE-CLAIM-001` through `TCE-CLAIM-015`

No claim is approved for v0 by this manifest. Existing claim statuses in
`research/claims_index.md` remain research-state labels only until the v0 claim
set is reviewed and approved.

## Forecast Baseline

The candidate v0 forecast inventory is:

`theses/operator-node-economics/publication/v0_forecast_set.yml`

Baseline state:

- forecast set status: `candidate_inventory`
- approval status: `unapproved`
- forecast status effect: unchanged
- quarterly updates are verdicts: false
- automatic verdicts authorized: false
- candidate forecast IDs: `TCE-P001` through `TCE-P012`

No forecast is approved for v0 by this manifest. Forecast measurement and
failure conditions remain candidates until the forecast set is reviewed and
approved.

## Timeline Baseline

The candidate v0 timeline is:

`theses/operator-node-economics/publication/v0_timeline.yml`

Current timeline state:

- mode: internal v0 first
- target internal publication date: 2026-06-30
- final publication date: unset
- first provisional measurement quarter: 2026-Q3
- 3-year checkpoint target: 2029-06-30
- 5-year checkpoint target: 2031-06-30
- 10-year checkpoint target: 2036-06-30
- date status: provisional until publication approval

The timeline gives the system a rehearsal clock. It does not publish v0 or
start a final canonical forecast clock until the publication date is approved.

## What This Baseline Establishes

- Production PostgreSQL contains the structured evidence migrated from the
  prototype.
- The migrated evidence has source-row counts, metric definitions, metric
  observations, and matching quality-review records.
- SUSB, BFS, and BDS are available as public-source context infrastructure for
  future quarterly assimilation.
- ThesisRecord can now distinguish baseline evidence inventory from claim and
  forecast approval.
- Local development is available for rehearsal without becoming canonical.

## What This Baseline Does Not Establish

- It does not prove the Operator Nodes thesis.
- It does not approve the v0 thesis prose.
- It does not copy or approve `paper/draft.md`.
- It does not promote any evidence into claim support.
- It does not create claim reviews or prediction links.
- It does not publish the thesis.
- It does not authorize production ingestion jobs beyond the current controlled
  scaffold.
- It does not resolve the missing direct evidence for AI-enabled one-human
  firm-boundary change.

## Review Gates Before Approval

Before this baseline can support v0 approval, review must decide:

- whether the current claim inventory is the correct v0 claim set;
- whether the current forecast inventory is the correct v0 forecast set;
- whether the source limitations are sufficiently visible in the v0 record;
- whether the internal target date becomes the canonical v0 publication date;
- whether the v0 paper/prose artifact is created from scratch or adapted from
  the archived draft;
- whether any production operator account is needed before publication.

## Verification Commands

Run from `thesis_record_app`:

```bash
bin/rails operator:production_summary
bin/rails operator:v0_readiness
bin/rails operator:verify_operations_policy
bin/rails operator:verify_claim_review_gate
```

Expected pre-approval result:

- production summary healthy;
- operations policy passed;
- claim-review gate passed;
- v0 readiness blocked on intentional approval/prose/publication decisions.
