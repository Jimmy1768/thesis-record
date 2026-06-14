# Operator Nodes Evidence Assimilation Plan

Status: operating scaffold.

This plan defines the Phase 1 evidence loop for Operator Nodes. It is scoped to
collection, validation, source-health summaries, and checkpoint preparation. It
does not authorize automatic claim promotion, thesis verdicts, or paper prose
changes.

## Cadence

- Weekly source-release check: detect whether known public sources have new
  releases or schema notices.
- Quarterly indicator checkpoint: prepare source-native indicator refreshes for
  the next calendar-quarter measurement cycle.
- Annual snapshot candidate: prepare a frozen evidence-state candidate every
  four quarters after the v0 forecast clock starts.

## System Of Record

Production PostgreSQL is the canonical structured evidence store after the
2026-06-14 promotion. Local databases are dev-only rehearsal environments and
must not be treated as canonical.

Canonical ingestion or promotion requires:

- production PostgreSQL target;
- pre-promotion backup;
- migration manifest;
- row-count reconciliation;
- post-promotion health check.

## Allowed Automated Work

- record scheduler audit events;
- check source release availability;
- run read-only production health summaries;
- run v0 readiness checks;
- prepare ingestion candidates without mutating claim status;
- create checkpoint candidate records only after the specific job is authorized
  for that phase.

## Prohibited Automated Work

- claim status changes;
- prediction-link creation;
- claim-review creation;
- export creation;
- paper prose edits;
- thesis verdicts;
- interpreting source-native metrics as Operator Node evidence without human
  review.

## Initial Sources

The current structured evidence base covers Census SUSB public-file rows, Census
BFS API rows, and Census BDS public-file rows promoted from the local prototype.
Those records are context evidence unless a future human claim-review gate
authorizes a narrower evidentiary use.

## Verification Commands

Run from `thesis_record_app`:

```bash
bin/rails operator:production_summary
bin/rails operator:v0_baseline_summary
bin/rails operator:v0_collection_readiness
bin/rails operator:v0_readiness
bin/rails operator:verify_claim_review_gate
bin/rails operator:verify_operations_policy
```
