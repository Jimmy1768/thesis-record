# Living Dissertation Phase 3E: BDS Row-Load QA Policy Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/app/services/public_sources/bds/row_load_policy_check.rb`
- `living_dissertation_app/test/services/public_sources/bds/row_load_policy_check_test.rb`
- `research/data/bds_row_load_qa_policy.md`
- `research/data/bds_parser_dry_run.md`
- `research/data/bds_parser_skeleton.md`
- `research/data/bds_staging_table_skeleton.md`
- `research/data/bds_acquisition_parser_design.md`
- `research/data/bds_public_file_scaffold.md`
- `research/data/schema_mapping.md`
- `research/data/naics_panel_inventory.md`
- `docs/operator/returns/2026-06-14-living-dissertation-phase-3e-bds-row-load-qa-policy-return.md`

## Slice Result

Defined the BDS row-load QA policy gate while keeping actual row loading
disabled.

Policy section:

```text
public_ingestion_v1.bds_sector_age_size_public_file.parser_design_v1.row_load_qa_policy_v1
```

The policy requires any future BDS row load to preserve or verify:

- full-file dry run before load;
- expected source row count of 104,880;
- zero bad-width rows;
- zero duplicate row-grain keys;
- observed year range 1978-2023;
- 19 sectors, 12 firm-age categories, and 10 firm-size categories;
- publication flags `D`, `S`, `X`, and `N`;
- source row hash;
- load ID;
- cleanup strategy;
- rollback strategy;
- idempotency;
- post-load reconciliation.

The row-load policy checker now fails if those QA requirements are weakened or
if row loading, metric definitions, metric observations, quality reviews,
exports, prediction links, analysis, or claim-status effects are authorized.

## Boundaries Preserved

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

- BDS source-row loader remains unimplemented.
- BDS row load remains unauthorized.
- BDS review policy and review storage remain unimplemented.
- BDS source-native metric definitions remain unimplemented.
- BDS still cannot support nonemployer, AI exposure, management-layer,
  transaction-cost, or firm-boundary claims.

## Verification

Commands run:

```sh
bin/rails test test/services/public_sources/bds/row_load_policy_check_test.rb test/services/public_sources/bds/parser_dry_run_test.rb
bin/rails public_sources:bds:verify_row_load_policy
bin/rails public_sources:bds:dry_run_parser
RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false app/services/public_sources/bds/row_load_policy_check.rb test/services/public_sources/bds/row_load_policy_check_test.rb
```

Results:

- focused BDS tests: 8 runs, 38 assertions, 0 failures;
- BDS row-load policy guardrails: passed;
- BDS dry-run parser task: read 104,880 rows, parsed 104,880 rows, persisted
  0 rows, found 0 duplicate keys, and left `BdsPublicFileRow.count` at 0;
- focused RuboCop: 2 files inspected, no offenses.

Full-suite commands run before commit:

```sh
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

Full-suite results:

- full Rails test suite: 123 runs, 620 assertions, 0 failures;
- `public_sources:source_health_summary`: policy checks passed,
  `overall_evidence_status=context_only_no_claim_links`, 0 prediction links,
  and 0 export-created audit events;
- `BdsPublicFileRow.count`: 0;
- `operator:verify_operations_policy`: passed;
- RuboCop: 147 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

## Next Slice

Recommended next step: implement a BDS source-row loader only if the loader
keeps metric definitions, metric observations, quality reviews, exports,
prediction links, analysis, and claim support disabled, and only if it includes
cleanup/rollback plus post-load reconciliation.
