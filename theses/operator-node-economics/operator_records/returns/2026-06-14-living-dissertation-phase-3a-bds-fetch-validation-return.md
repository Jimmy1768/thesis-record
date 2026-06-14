# Living Dissertation Phase 3A: BDS Fetch Validation Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/app/services/public_sources/bds/acquisition_design_check.rb`
- `living_dissertation_app/app/services/public_sources/bds/fetch_and_validate_public_file.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/bds/acquisition_design_check_test.rb`
- `living_dissertation_app/test/services/public_sources/bds/fetch_and_validate_public_file_test.rb`
- `research/data/bds_fetch_validation.md`
- `research/data/bds_acquisition_parser_design.md`
- `research/data/bds_public_file_scaffold.md`
- `research/data/schema_mapping.md`
- `research/data/naics_panel_inventory.md`
- `docs/operator/handoffs/2026-06-14-living-dissertation-phase-3a-bds-fetch-validation-handoff.md`
- `docs/operator/returns/2026-06-14-living-dissertation-phase-3a-bds-fetch-validation-return.md`

## Slice Result

Implemented BDS raw public-file validation for the official Census BDS sector
by firm age by firm size CSV.

Policy changed from design-only acquisition to fetch/validation service ready:

- `acquisition_design_v1.status = fetch_validation_service_ready`;
- `raw_file_fetch_authorized = true`;
- default behavior validates the existing ignored local raw file;
- force fetch is gated by `BDS_FORCE_FETCH`;
- parser, staging rows, metrics, quality reviews, exports, prediction links,
  analysis, and claim support remain disabled.

Rails task:

```sh
bin/rails public_sources:bds:fetch_and_validate
```

## Live Validation Result

```text
data_source_id=3
fetched_this_run=false
sha256=c4790ccdf964788a8bbc8404349df69db2a7457f8784411a39ddb228dedfbabd
byte_size=12606118
row_count_excluding_header=104880
duplicate_key_count=0
observed_year_range={:start=>1978, :end=>2023}
sector_count=19
firm_age_count=12
firm_size_count=10
manifest_reconciled=true
metric_definitions_created=0
metric_observations_created=0
quality_reviews_created=0
prediction_links_created=0
exports_created=0
```

The task validated the existing ignored local file and did not fetch from the
network.

## Boundaries Preserved

- No BDS staging table migration.
- No BDS row load.
- No BDS metric definitions.
- No BDS metric observations.
- No BDS quality reviews.
- No prediction links.
- No exports.
- No claim support.
- No analysis.
- No paper prose.
- No `paper/draft.md` edits.

## Remaining Gaps

- BDS staging-table migration remains unimplemented.
- BDS parser implementation remains unimplemented.
- BDS source-native metric definitions remain unimplemented.
- BDS quality-review policy and review storage remain unimplemented.
- BDS still cannot support nonemployer, AI exposure, management-layer,
  transaction-cost, or firm-boundary claims.

## Verification

Commands run so far:

```sh
bin/rails test test/services/public_sources/bds/fetch_and_validate_public_file_test.rb test/services/public_sources/bds/acquisition_design_check_test.rb test/services/public_sources/bds/parser_design_check_test.rb test/services/public_sources/bds/scaffold_policy_check_test.rb test/services/public_sources/bds/public_file_scaffold_test.rb
bin/rails public_sources:bds:verify_acquisition_design
bin/rails public_sources:bds:verify_parser_design
bin/rails public_sources:bds:fetch_and_validate
bin/rails test
bin/rails public_sources:source_health_summary
bin/rails operator:verify_operations_policy
RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false
bundle exec brakeman --no-pager --no-exit-on-warn
git diff --check
git diff -- paper/draft.md
rg -n "<standard secret-pattern scan>" <changed files>
```

Results so far:

- BDS focused tests: 18 runs, 99 assertions, 0 failures;
- BDS acquisition guardrails: passed;
- BDS parser guardrails: passed;
- BDS live fetch/validation task: passed with the result above.
- full Rails test suite: 109 runs, 552 assertions, 0 failures;
- `public_sources:source_health_summary`: unchanged BFS/SUSB source-health
  counts, 0 prediction links, 0 exports, and
  `context_only_no_claim_links`;
- `operator:verify_operations_policy`: passed;
- RuboCop: 138 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

## Next Slice

Recommended next step: implement the BDS staging-table migration skeleton and
parser policy skeleton while keeping row load disabled, or implement parser
skeleton with fixture-only tests before authorizing full row load.
