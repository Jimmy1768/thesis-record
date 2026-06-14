# Living Dissertation Phase 2G SUSB Metric Definition Return

## Status

Completed.

## Files Changed

- `docs/operator/handoffs/2026-06-12-living-dissertation-phase-2g-susb-metric-definition-handoff.md`
- `docs/operator/returns/2026-06-12-living-dissertation-phase-2g-susb-metric-definition-return.md`
- `living_dissertation_app/app/services/public_sources/susb/metric_definition_scaffold.rb`
- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/susb/metric_definition_scaffold_test.rb`
- `research/data/susb_metric_definition_scaffold.md`
- `research/data/susb_public_file_ingestion_scaffold.md`

## Metric Definitions Scaffolded

Added policy-backed, draft-disabled SUSB metric definitions:

- `susb_employer_firm_count`
- `susb_employer_establishment_count`
- `susb_employment`
- `susb_annual_payroll_thousand`
- `susb_receipts_thousand_economic_census_year`

All definitions have `formula_status=draft_disabled`.

They are scaffold definitions only. They do not authorize observations,
aggregation, ratios, trend analysis, exports, claim linkage, or thesis
interpretation.

## Task Behavior

Added:

- `bin/rails public_sources:susb:scaffold_metric_definitions`

Observed task output:

```text
Scaffolded SUSB metric definitions
susb_employer_firm_count=draft_disabled
susb_employer_establishment_count=draft_disabled
susb_employment=draft_disabled
susb_annual_payroll_thousand=draft_disabled
susb_receipts_thousand_economic_census_year=draft_disabled
```

The task:

- reads definitions from `living_dissertation_app/config/living_dissertation_policy.yml`;
- creates or updates `MetricDefinition` rows idempotently;
- appends scaffold guardrail language to limitations;
- writes `metric_definition_changed` audit events;
- does not create `MetricObservation` rows.

## Guardrails Preserved

SUSB remains employer-side public context only.

These draft definitions cannot support:

- AI adoption claims;
- nonemployer or one-human firm claims;
- management-layer thinning claims;
- transaction-cost claims;
- remote employment substitution claims;
- Operator Node thesis claims.

## Verification

- `bin/rails test`
  - Result: passed.
  - Output: 35 runs, 143 assertions, 0 failures, 0 errors, 0 skips.
- `bin/rails public_sources:susb:scaffold_metric_definitions`
  - Result: passed with task output shown above.
- `bin/rails runner 'puts MetricObservation.count'`
  - Result: `0`.
- `bin/rails operator:verify_operations_policy`
  - Result: passed.
  - Output: `Operations policy guardrails passed`.
- `RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false`
  - Result: passed.
  - Output: 81 files inspected, no offenses detected.
- `bundle exec brakeman --no-pager --no-exit-on-warn`
  - Result: passed with no code warnings.
  - Residual warnings: Ruby 3.2.3 support ended on 2026-03-31; Rails 7.2.3.1 support ends on 2026-08-09.
- `git diff --check`
  - Result: passed with no output.
- `git diff -- paper/draft.md`
  - Result: passed with no output.
- Changed-path secret scan:
  - Command: `rg -n "(BEGIN (RSA|OPENSSH|PRIVATE) KEY|DATABASE_URL=.+|SECRET_KEY_BASE=.+|REDIS_URL=.+|postgres://[^\\s]+:[^\\s]+@|sk-[A-Za-z0-9]{20,}|AIza[0-9A-Za-z_-]{20,}|AKIA[0-9A-Z]{16})" docs/operator/handoffs/2026-06-12-living-dissertation-phase-2g-susb-metric-definition-handoff.md living_dissertation_app research/data/susb_public_file_ingestion_scaffold.md research/data/susb_metric_definition_scaffold.md`
  - Result: passed with no matches.

## Private Data, Secrets, Claims, And Paper Boundary

- No private data was ingested.
- No public file was fetched in this slice.
- No SUSB rows were parsed or loaded.
- No `MetricObservation` rows were created.
- No aggregation, ratios, panels, or trends were computed.
- No claim linkage or claim-status change was made.
- No secrets, database URLs, API keys, SSH keys, private keys, or production
  env values were added.
- `paper/draft.md` remained untouched.

## Remaining Gaps Before Analytic Use

- 2F staging-table parser remains undone.
- No durable SUSB row table exists yet.
- No row-level source quality flags are stored in a queryable table.
- No metric-observation computation design has been approved.
- No export-review path has approved any SUSB-derived artifact.
- No claim-review gate has accepted any SUSB metric as evidence.
