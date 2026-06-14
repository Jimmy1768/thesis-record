# Living Dissertation Phase 2I SUSB Context Observations Return

## Status

Completed.

## Files Changed

- `docs/operator/handoffs/2026-06-12-living-dissertation-phase-2i-susb-context-observations-handoff.md`
- `docs/operator/returns/2026-06-12-living-dissertation-phase-2i-susb-context-observations-return.md`
- `living_dissertation_app/app/services/public_sources/susb/compute_context_observations.rb`
- `living_dissertation_app/app/services/public_sources/susb/metric_computation_design_check.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/susb/compute_context_observations_test.rb`
- `living_dissertation_app/test/services/public_sources/susb/metric_computation_design_check_test.rb`
- `research/data/susb_context_observations.md`
- `research/data/susb_metric_computation_design.md`

## Observation Rules Applied

Applied V1 defaults from:

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `research/data/susb_metric_computation_design.md`

Rules:

- eligible rows: `ENTRSIZE=01` only;
- dimensions: `year`, `state_code`, `naics_code`, `enterprise_size_code`;
- evidence class: `employer_side_context_only`;
- claim-status effect: `unchanged`;
- `G/H` noise flags map to `staged_context`;
- `J` noise flags map to `quality_review_required`;
- `D/S` noise flags are blocked from observation creation;
- firm and establishment counts have no source noise flag, so they are
  `staged_context`;
- no ratios, trends, aggregation, productivity measures, exports, or claim
  support.

## Task Behavior

Added:

- `bin/rails public_sources:susb:compute_context_observations`

Behavior:

- verifies SUSB metric-computation design guardrails;
- finds draft SUSB metric definitions;
- deletes prior scoped SUSB observations for the same source/year/definitions;
- recreates context observations idempotently;
- stores source row ID and row hash in `quality_metadata`;
- records guardrails in `quality_metadata`;
- writes an audit event.

## Actual Observation Counts

First run:

```text
Computed SUSB context observations
data_source_id=1
eligible_rows=86416
observations_deleted=0
observations_created=432080
status_counts={"quality_review_required"=>36343, "staged_context"=>395737}
metric_counts={"susb_annual_payroll_thousand"=>86416, "susb_employer_establishment_count"=>86416, "susb_employer_firm_count"=>86416, "susb_employment"=>86416, "susb_receipts_thousand_economic_census_year"=>86416}
blocked_cells={}
```

Idempotency rerun:

```text
Computed SUSB context observations
data_source_id=1
eligible_rows=86416
observations_deleted=432080
observations_created=432080
status_counts={"quality_review_required"=>36343, "staged_context"=>395737}
metric_counts={"susb_annual_payroll_thousand"=>86416, "susb_employer_establishment_count"=>86416, "susb_employer_firm_count"=>86416, "susb_employment"=>86416, "susb_receipts_thousand_economic_census_year"=>86416}
blocked_cells={}
```

Final count check:

```text
MetricObservation.count = 432080
MetricObservation.group(:metric_status).count = {"quality_review_required"=>36343, "staged_context"=>395737}
```

Guardrail metadata checks:

```text
claim_support_authorized=true rows: 0
exports_created=true rows: 0
```

## Verification

- `bin/rails test`
  - Result: passed.
  - Output: 43 runs, 178 assertions, 0 failures, 0 errors, 0 skips.
- `bin/rails public_sources:susb:verify_metric_design`
  - Result: passed before and after observation computation.
  - Output: `SUSB metric computation design guardrails passed`.
- `bin/rails public_sources:susb:compute_context_observations`
  - Result: passed twice; idempotency confirmed.
- `bin/rails runner 'puts MetricObservation.count; puts MetricObservation.group(:metric_status).count.sort.to_h'`
  - Result: `432080`, `{"quality_review_required"=>36343, "staged_context"=>395737}`.
- `bin/rails runner 'puts MetricObservation.where("quality_metadata ->> ? = ?", "claim_support_authorized", "true").count; puts MetricObservation.where("quality_metadata ->> ? = ?", "exports_created", "true").count'`
  - Result: `0`, `0`.
- `bin/rails operator:verify_operations_policy`
  - Result: passed.
  - Output: `Operations policy guardrails passed`.
- `RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false`
  - Result: passed.
  - Output: 89 files inspected, no offenses detected.
- `bundle exec brakeman --no-pager --no-exit-on-warn`
  - Result: passed with no code warnings.
  - Residual warnings: Ruby 3.2.3 support ended on 2026-03-31; Rails 7.2.3.1 support ends on 2026-08-09.
- `git diff --check`
  - Result: passed with no output.
- `git diff -- paper/draft.md`
  - Result: passed with no output.

## Boundary Confirmation

- No ratios, trends, aggregation, productivity measures, exports, or analysis
  were computed.
- No claim links were created.
- No claim status was changed.
- No private data was ingested.
- No public file was fetched in this slice.
- No secrets, database URLs, API keys, SSH keys, private keys, or production
  env values were added.
- `paper/draft.md` remained untouched.

## Remaining Gaps Before Claim Or Export Use

- Quality-review workflow for `quality_review_required` observations is not
  implemented.
- No export-review path has approved SUSB observations for public artifacts.
- No claim-review gate has accepted any SUSB observation as evidence.
- SUSB observations remain employer-side context only and do not measure AI
  adoption, nonemployers, one-human firms, management layers, transaction
  costs, remote work, or Operator Nodes.
