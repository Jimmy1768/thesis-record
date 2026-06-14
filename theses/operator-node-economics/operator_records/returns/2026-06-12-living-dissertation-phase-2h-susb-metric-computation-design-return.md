# Living Dissertation Phase 2H SUSB Metric Computation Design Return

## Status

Completed.

## Files Changed

- `docs/operator/handoffs/2026-06-12-living-dissertation-phase-2h-susb-metric-computation-design-handoff.md`
- `docs/operator/returns/2026-06-12-living-dissertation-phase-2h-susb-metric-computation-design-return.md`
- `living_dissertation_app/app/services/public_sources/susb/metric_computation_design_check.rb`
- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/susb/metric_computation_design_check_test.rb`
- `research/data/susb_metric_computation_design.md`
- `research/data/susb_metric_definition_scaffold.md`
- `research/data/susb_staging_parser.md`

## V1 Defaults Set

Added centralized SUSB metric-computation design defaults under:

- `public_ingestion_v1.susb_us_state_annual.metric_computation_design_v1`

Defaults:

- status: `design_only_disabled`
- eligible first-pass enterprise-size rows: `ENTRSIZE=01`
- grain: `source_native_context`
- dimensions: `year`, `state_code`, `naics_code`
- evidence class: `employer_side_context_only`
- claim-status effect: `unchanged`

Allowed first-pass metric keys:

- `susb_employer_firm_count`
- `susb_employer_establishment_count`
- `susb_employment`
- `susb_annual_payroll_thousand`
- `susb_receipts_thousand_economic_census_year`

Noise/status rules:

- `G` -> `staged_context`
- `H` -> `staged_context`
- `J` -> `quality_review_required`
- `D` -> `blocked_noise_or_suppression`
- `S` -> `blocked_noise_or_suppression`

Prohibited in this design phase:

- ratios;
- trends;
- aggregation;
- productivity measures;
- AI or node interpretation;
- claim support;
- exports.

## Validator And Task Behavior

Added:

- `PublicSources::Susb::MetricComputationDesignCheck`
- `bin/rails public_sources:susb:verify_metric_design`

Task result:

```text
SUSB metric computation design guardrails passed
```

The validator checks that:

- design status remains disabled;
- first-pass eligibility remains `ENTRSIZE=01`;
- evidence class remains employer-side context only;
- claim-status effect remains unchanged;
- all required noise-flag rules are present;
- prohibited computations include ratios, trends, aggregation, productivity
  measures, AI/node interpretation, claim support, and exports;
- no `MetricObservation` rows already exist.

## Design Doc

Added:

- `research/data/susb_metric_computation_design.md`

The doc records the same V1 policy defaults and the hard boundary that SUSB
remains employer-side context only.

## Verification

- `bin/rails test`
  - Result: passed.
  - Output: 40 runs, 164 assertions, 0 failures, 0 errors, 0 skips.
- `bin/rails public_sources:susb:verify_metric_design`
  - Result: passed.
  - Output: `SUSB metric computation design guardrails passed`.
- `bin/rails runner 'puts MetricObservation.count'`
  - Result: `0`.
- `bin/rails operator:verify_operations_policy`
  - Result: passed.
  - Output: `Operations policy guardrails passed`.
- `RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false`
  - Result: passed.
  - Output: 87 files inspected, no offenses detected.
- `bundle exec brakeman --no-pager --no-exit-on-warn`
  - Result: passed with no code warnings.
  - Residual warnings: Ruby 3.2.3 support ended on 2026-03-31; Rails 7.2.3.1 support ends on 2026-08-09.
- `git diff --check`
  - Result: passed with no output.
- `git diff -- paper/draft.md`
  - Result: passed with no output.

## Boundary Confirmation

- No `MetricObservation` rows were created.
- No metrics, ratios, aggregates, panels, trends, exports, or analysis were
  computed.
- No claim linkage or claim-status change was made.
- No private data was ingested.
- No public file was fetched.
- No secrets, database URLs, API keys, SSH keys, private keys, or production
  env values were added.
- `paper/draft.md` remained untouched.

## Remaining Gaps Before 2I

- 2I can compute first-pass context observations only after preserving these
  design defaults.
- 2I must keep `ENTRSIZE=01` only.
- 2I must map `G/H/J/D/S` flags into the policy-defined statuses.
- 2I must not compute ratios, trends, aggregation, productivity measures,
  exports, or claim support.
- Later quality-review design is still needed before any observation can be
  used beyond `staged_context`.
