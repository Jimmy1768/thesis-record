# Living Dissertation Phase 2F SUSB Staging Parser Return

## Status

Completed.

## Files Changed

- `docs/operator/handoffs/2026-06-12-living-dissertation-phase-2f-susb-staging-parser-handoff.md`
- `docs/operator/returns/2026-06-12-living-dissertation-phase-2f-susb-staging-parser-return.md`
- `living_dissertation_app/app/models/susb_public_file_row.rb`
- `living_dissertation_app/app/services/public_sources/susb/load_staging_rows.rb`
- `living_dissertation_app/db/migrate/20260612230000_create_susb_public_file_rows.rb`
- `living_dissertation_app/db/schema.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/susb/load_staging_rows_test.rb`
- `research/data/susb_staging_parser.md`
- `research/data/susb_metric_definition_scaffold.md`
- `research/data/susb_public_file_ingestion_scaffold.md`

## Staging Table Schema

Added table:

- `susb_public_file_rows`

Unique source-native grain:

- `data_source_id`
- `year`
- `state_code`
- `naics_code`
- `enterprise_size_code`

Source links:

- `data_source_id`
- `intake_manifest_id`
- `schema_version_id`

Preserved source-native fields:

- `STATE` -> `state_code`
- `NAICS` -> `naics_code`
- `ENTRSIZE` -> `enterprise_size_code`
- `FIRM` -> `firm_count`
- `ESTB` -> `establishment_count`
- `EMPL` -> `employment`
- `EMPLFL_N` -> `employment_noise_flag`
- `PAYR` -> `annual_payroll_thousand`
- `PAYRFL_N` -> `payroll_noise_flag`
- `RCPT` -> `receipts_thousand`
- `RCPTFL_N` -> `receipts_noise_flag`
- `STATEDSCR` -> `state_name`
- `NAICSDSCR` -> `naics_description`
- `ENTRSIZEDSCR` -> `enterprise_size_description`

The table also stores `row_hash` and JSON metadata for source-grain and
guardrail flags.

## Loader Task Behavior

Added:

- `bin/rails public_sources:susb:load_staging`

The loader:

- validates/reconciles the SUSB public file first;
- reads the source file as ISO-8859-1 and transcodes to UTF-8;
- captures flags before numeric coercion;
- upserts rows by source-native grain;
- records row hashes;
- updates intake-manifest metadata;
- writes an audit event;
- creates no `MetricObservation` rows;
- creates no quality flags in this phase;
- computes no ratios, aggregates, panels, trends, exports, or claim links.

## Load And QA Results

Command:

```sh
bin/rails public_sources:susb:load_staging
```

Result:

```text
Loaded SUSB staging rows
data_source_id=1
local_path=/Users/jimmy1768/Projects/operator-node-economics/data/raw/susb/2022/us_state_6digitnaics_2022.txt
rows_read=570105
rows_upserted=570105
metric_observations_created=0
quality_flags_created=0
```

Follow-up count check:

```text
SusbPublicFileRow.count = 570105
MetricObservation.count = 0
QualityFlag.count = 0
```

## Verification

- `bin/rails db:migrate`
  - Result: passed.
- `bin/rails db:test:prepare`
  - Result: passed.
- `bin/rails test`
  - Result: passed.
  - Output: 37 runs, 155 assertions, 0 failures, 0 errors, 0 skips.
- `bin/rails public_sources:susb:load_staging`
  - Result: passed with load output shown above.
- `bin/rails runner 'puts SusbPublicFileRow.count; puts MetricObservation.count; puts QualityFlag.count'`
  - Result: `570105`, `0`, `0`.
- `bin/rails operator:verify_operations_policy`
  - Result: passed.
  - Output: `Operations policy guardrails passed`.
- `RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false`
  - Result: passed.
  - Output: 85 files inspected, no offenses detected.
- `bundle exec brakeman --no-pager --no-exit-on-warn`
  - Result: passed with no code warnings.
  - Residual warnings: Ruby 3.2.3 support ended on 2026-03-31; Rails 7.2.3.1 support ends on 2026-08-09.
- `git diff --check`
  - Result: passed with no output.
- `git diff -- paper/draft.md`
  - Result: passed with no output.

## Boundary Confirmation

- No private data was ingested.
- No public file was fetched in this slice; the existing validated ignored raw
  file was loaded.
- No `MetricObservation` rows were created.
- No aggregation, ratios, panels, trends, or analysis were computed.
- No claim linkage or claim-status change was made.
- No secrets, database URLs, API keys, SSH keys, private keys, or production
  env values were added.
- `paper/draft.md` remained untouched.

## Remaining Gaps Before Metric Computation Design

- No metric-observation computation design has been approved.
- No quality-flag propagation design exists for noisy or withheld SUSB cells.
- No export-review path has approved any SUSB-derived artifact.
- No claim-review gate has accepted any SUSB metric as evidence.
- SUSB remains employer-side public context only and still does not measure AI
  adoption, nonemployers, management layers, transaction costs, remote work, or
  one-person firms.
