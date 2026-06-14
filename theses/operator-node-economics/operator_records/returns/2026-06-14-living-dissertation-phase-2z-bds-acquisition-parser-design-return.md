# Living Dissertation Phase 2Z: BDS Acquisition Parser Design Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/app/services/public_sources/bds/acquisition_design_check.rb`
- `living_dissertation_app/app/services/public_sources/bds/parser_design_check.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/bds/acquisition_design_check_test.rb`
- `living_dissertation_app/test/services/public_sources/bds/parser_design_check_test.rb`
- `research/data/bds_acquisition_parser_design.md`
- `research/data/bds_public_file_scaffold.md`
- `research/data/schema_mapping.md`
- `research/data/naics_panel_inventory.md`
- `docs/operator/handoffs/2026-06-14-living-dissertation-phase-2z-bds-acquisition-parser-design-handoff.md`
- `docs/operator/returns/2026-06-14-living-dissertation-phase-2z-bds-acquisition-parser-design-return.md`

## Slice Result

Added design-only guardrails for BDS acquisition and parser architecture.

Acquisition design:

- status: `design_only_no_fetch`;
- raw fetch authorized: `false`;
- raw path: `data/raw/bds/2023/bds2023_sec_fa_fz.csv`;
- manifest path: `data/manifests/bds_2023_manifest.csv`;
- checksum and manifest reconciliation required before parser work;
- expected row count excluding header: 104,880;
- expected year range: 1978-2023.

Parser design:

- status: `design_only_no_staging_table`;
- future staging table: `bds_public_file_rows`;
- staging-table creation authorized: `false`;
- row load authorized: `false`;
- parser authorized: `false`;
- claim-status effect: `unchanged`;
- source grain: `year`, `sector`, `fage`, `fsize`;
- publication flags preserved before numeric coercion: `D`, `S`, `X`, `N`;
- flagged numeric values remain null under V1 design.

## Boundaries Preserved

- No BDS raw CSV fetch.
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

- BDS fetch/validation service remains unimplemented.
- BDS staging-table migration remains unimplemented.
- BDS parser implementation remains unimplemented.
- BDS source-native metric definitions remain unimplemented.
- No BDS quality-review policy or review storage exists yet.
- BDS still cannot support nonemployer, AI exposure, management-layer,
  transaction-cost, or firm-boundary claims.

## Verification

Commands run so far:

```sh
bin/rails test test/services/public_sources/bds/acquisition_design_check_test.rb test/services/public_sources/bds/parser_design_check_test.rb test/services/public_sources/bds/scaffold_policy_check_test.rb test/services/public_sources/bds/public_file_scaffold_test.rb
bin/rails test test/services/public_sources/bfs/api_scaffold_test.rb test/services/public_sources/bfs/ingestion_design_check_test.rb
bin/rails public_sources:bds:verify_acquisition_design
bin/rails public_sources:bds:verify_parser_design
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

- BDS focused tests: 13 runs, 70 assertions, 0 failures;
- BFS regression tests after YAML indentation repair: 6 runs, 45 assertions,
  0 failures;
- BDS acquisition design guardrails: passed;
- BDS parser design guardrails: passed.
- full Rails test suite: 104 runs, 523 assertions, 0 failures;
- `public_sources:source_health_summary`: unchanged BFS/SUSB source-health
  counts, 0 prediction links, 0 exports, and
  `context_only_no_claim_links`;
- `operator:verify_operations_policy`: passed;
- RuboCop: 136 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

## Next Slice

Recommended next step: implement BDS fetch/validation service while keeping
parser execution and staging rows disabled, or implement the staging-table
migration skeleton while keeping row load disabled. Do not do both with
analysis in the same slice.
