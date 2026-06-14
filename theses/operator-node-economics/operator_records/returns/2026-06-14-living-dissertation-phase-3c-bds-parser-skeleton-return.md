# Living Dissertation Phase 3C: BDS Parser Skeleton Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/app/services/public_sources/bds/parser_design_check.rb`
- `living_dissertation_app/app/services/public_sources/bds/parser_skeleton.rb`
- `living_dissertation_app/app/services/public_sources/bds/row_load_policy_check.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/bds/parser_design_check_test.rb`
- `living_dissertation_app/test/services/public_sources/bds/parser_skeleton_test.rb`
- `living_dissertation_app/test/services/public_sources/bds/row_load_policy_check_test.rb`
- `research/data/bds_parser_skeleton.md`
- `research/data/bds_acquisition_parser_design.md`
- `research/data/bds_fetch_validation.md`
- `research/data/bds_staging_table_skeleton.md`
- `research/data/bds_public_file_scaffold.md`
- `research/data/schema_mapping.md`
- `research/data/naics_panel_inventory.md`
- `docs/operator/handoffs/2026-06-14-living-dissertation-phase-3c-bds-parser-skeleton-handoff.md`
- `docs/operator/returns/2026-06-14-living-dissertation-phase-3c-bds-parser-skeleton-return.md`

## Slice Result

Implemented a fixture-only in-memory BDS parser skeleton:

- parses comma-delimited fixture CSV text;
- validates exact BDS header;
- validates sector, firm-age, and firm-size dimensions;
- preserves raw measure values;
- separates numeric values from publication flags;
- stores flagged numeric cells as null in memory;
- preserves publication flags `D`, `S`, `X`, and `N`;
- computes source-native row hashes;
- persists zero rows.

Implemented explicit row-load gate:

- `row_load_gate_v1.status = row_load_disabled`;
- `table_must_exist = true`;
- `table_must_remain_empty = true`;
- `parser_fixture_only = true`;
- `full_file_parser_authorized = false`;
- `row_load_authorized = false`;
- `metric_observations_authorized = false`;
- `quality_reviews_authorized = false`;
- `exports_authorized = false`;
- `prediction_links_authorized = false`;
- `claim_status_effect = unchanged`.

Rails tasks:

```sh
bin/rails public_sources:bds:parse_fixture
bin/rails public_sources:bds:verify_row_load_policy
```

Live fixture parse result:

```text
rows_seen=1
rows_persisted=0
bds_public_file_row_count=0
```

## Boundaries Preserved

- No BDS row load.
- No full-file parser execution.
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

- Full-file parser dry-run remains unimplemented.
- Full row load remains unauthorized.
- BDS parser QA policy remains unimplemented.
- BDS source-native metric definitions remain unimplemented.
- BDS quality-review policy and review storage remain unimplemented.
- BDS still cannot support nonemployer, AI exposure, management-layer,
  transaction-cost, or firm-boundary claims.

## Verification

Commands run so far:

```sh
bin/rails test test/services/public_sources/bds/parser_skeleton_test.rb test/services/public_sources/bds/row_load_policy_check_test.rb test/services/public_sources/bds/parser_design_check_test.rb test/models/bds_public_file_row_test.rb
bin/rails public_sources:bds:verify_parser_design
bin/rails public_sources:bds:verify_row_load_policy
bin/rails public_sources:bds:parse_fixture
bin/rails test
bin/rails public_sources:source_health_summary
bin/rails runner 'puts BdsPublicFileRow.count'
bin/rails operator:verify_operations_policy
RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false
bundle exec brakeman --no-pager --no-exit-on-warn
git diff --check
git diff -- paper/draft.md
rg -n "<standard secret-pattern scan>" <changed files>
```

Results so far:

- focused parser/gate tests: 12 runs, 48 assertions, 0 failures;
- BDS parser design guardrails: passed;
- BDS row-load policy guardrails: passed;
- BDS fixture parse task: parsed 1 row, persisted 0 rows, table count 0.
- full Rails test suite: 117 runs, 588 assertions, 0 failures;
- `public_sources:source_health_summary`: unchanged BFS/SUSB source-health
  counts, 0 prediction links, 0 exports, and
  `context_only_no_claim_links`;
- `BdsPublicFileRow.count`: 0;
- `operator:verify_operations_policy`: passed;
- RuboCop: 145 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

## Next Slice

Recommended next step: implement a full-file parser dry-run that reads the
validated local BDS file and reports counts/flags without inserting rows.
Full row load should remain disabled.
