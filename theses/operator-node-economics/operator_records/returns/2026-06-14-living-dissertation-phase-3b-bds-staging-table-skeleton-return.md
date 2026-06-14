# Living Dissertation Phase 3B: BDS Staging Table Skeleton Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/db/migrate/20260614043000_create_bds_public_file_rows.rb`
- `living_dissertation_app/db/schema.rb`
- `living_dissertation_app/app/models/bds_public_file_row.rb`
- `living_dissertation_app/app/services/public_sources/bds/parser_design_check.rb`
- `living_dissertation_app/app/services/public_sources/bds/fetch_and_validate_public_file.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/models/bds_public_file_row_test.rb`
- `living_dissertation_app/test/services/public_sources/bds/parser_design_check_test.rb`
- `research/data/bds_staging_table_skeleton.md`
- `research/data/bds_acquisition_parser_design.md`
- `research/data/bds_fetch_validation.md`
- `research/data/bds_public_file_scaffold.md`
- `research/data/schema_mapping.md`
- `research/data/naics_panel_inventory.md`
- `docs/operator/handoffs/2026-06-14-living-dissertation-phase-3b-bds-staging-table-skeleton-handoff.md`
- `docs/operator/returns/2026-06-14-living-dissertation-phase-3b-bds-staging-table-skeleton-return.md`

## Slice Result

Implemented an empty BDS staging-table skeleton:

- table: `bds_public_file_rows`;
- model: `BdsPublicFileRow`;
- unique grain: `data_source_id`, `year`, `sector_code`, `firm_age_code`,
  `firm_size_code`;
- source-value storage: `raw_measure_values`, `numeric_measure_values`,
  `publication_flags`;
- metadata storage: `source_row_number`, `row_hash`, `metadata`.

Parser policy now says:

- `status = staging_table_skeleton_ready`;
- `staging_table_creation_authorized = true`;
- `row_load_authorized = false`;
- `parser_authorized = false`;
- `metric_computation_authorized = false`;
- `quality_reviews_authorized = false`;
- `analysis_authorized = false`;
- `exports_authorized = false`;
- `prediction_links_authorized = false`;
- `claim_status_effect = unchanged`.

Live table count:

```text
BdsPublicFileRow.count = 0
```

## Boundaries Preserved

- No BDS row load.
- No full parser execution.
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

- Parser skeleton remains unimplemented.
- Full row load remains unauthorized.
- BDS source-native metric definitions remain unimplemented.
- BDS quality-review policy and review storage remain unimplemented.
- BDS still cannot support nonemployer, AI exposure, management-layer,
  transaction-cost, or firm-boundary claims.

## Verification

Commands run so far:

```sh
bin/rails db:migrate
bin/rails test test/models/bds_public_file_row_test.rb test/services/public_sources/bds/parser_design_check_test.rb test/services/public_sources/bds/fetch_and_validate_public_file_test.rb test/services/public_sources/bds/acquisition_design_check_test.rb
bin/rails public_sources:bds:verify_parser_design
bin/rails public_sources:bds:fetch_and_validate
bin/rails runner 'puts BdsPublicFileRow.count'
bin/rails db:migrate:status
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

- migration succeeded;
- focused BDS tests: 14 runs, 58 assertions, 0 failures;
- BDS parser design guardrails: passed;
- BDS fetch/validation still validates the raw file and creates 0 downstream
  records;
- `BdsPublicFileRow.count`: 0.
- migration status: all migrations up, including
  `20260614043000 Create bds public file rows`;
- full Rails test suite: 111 runs, 560 assertions, 0 failures;
- `public_sources:source_health_summary`: unchanged BFS/SUSB source-health
  counts, 0 prediction links, 0 exports, and
  `context_only_no_claim_links`;
- `operator:verify_operations_policy`: passed;
- RuboCop: 141 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

## Next Slice

Recommended next step: implement a BDS parser skeleton with fixture-only tests
and an explicit row-load policy gate. Keep full row load disabled until parser
QA and review policy are ready.
