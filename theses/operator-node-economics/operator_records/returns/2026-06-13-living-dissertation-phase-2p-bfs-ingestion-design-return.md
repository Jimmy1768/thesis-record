# Living Dissertation Phase 2P: BFS Ingestion Design Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/db/migrate/20260613133000_create_bfs_api_rows.rb`
- `living_dissertation_app/db/schema.rb`
- `living_dissertation_app/app/models/bfs_api_row.rb`
- `living_dissertation_app/app/services/public_sources/bfs/ingestion_design_check.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/models/bfs_api_row_test.rb`
- `living_dissertation_app/test/services/public_sources/bfs/ingestion_design_check_test.rb`
- `research/data/bfs_ingestion_design.md`
- `research/data/bfs_api_ingestion_scaffold.md`
- `research/data/schema_mapping.md`
- `research/data/naics_panel_inventory.md`
- `docs/operator/handoffs/2026-06-13-living-dissertation-phase-2p-bfs-ingestion-design-handoff.md`
- `docs/operator/returns/2026-06-13-living-dissertation-phase-2p-bfs-ingestion-design-return.md`

## Schema Added

New table:

- `bfs_api_rows`

Unique source-native row grain:

- `data_source_id`
- `period_month`
- `data_type_code`
- `category_code`
- `seasonally_adj`
- `geography_level`
- `geography_code`

## Policy Defaults

- API pull authorized: false
- data rows authorized: false
- metric computation authorized: false
- analysis authorized: false
- exports authorized: false
- prediction links authorized: false
- geography: U.S. only
- seasonality: `no`
- first-pass series: `BA_BA`, `BA_HBA`, `BF_BF4Q`, `BF_BF8Q`, `BF_PBF4Q`,
  `BF_PBF8Q`
- excluded categories: `TOTAL`, `NONAICS`

## Task Behavior

Added:

```sh
bin/rails public_sources:bfs:verify_ingestion_design
```

The task verifies staging-schema-only guardrails and fails if `BfsApiRow` rows
already exist.

## Blockers Preserved

- No BFS API pull.
- No BFS row loading.
- No BFS metrics.
- No analysis.
- No exports.
- No prediction links.
- No claim support.
- No NAICS harmonization.
- BFS remains only an indirect payroll-transition proxy.

## Verification

Commands run:

```sh
bin/rails db:migrate
bin/rails test test/models/bfs_api_row_test.rb
bin/rails test test/services/public_sources/bfs/ingestion_design_check_test.rb
bin/rails public_sources:bfs:verify_ingestion_design
bin/rails test
bin/rails operator:verify_operations_policy
RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false
bundle exec brakeman --no-pager --no-exit-on-warn
git diff --check
git diff -- paper/draft.md
bin/rails runner "<BFS no-row guardrail query>"
rg -n "BEGIN RSA|BEGIN OPENSSH|BEGIN PRIVATE|DATABASE_URL=|SECRET_KEY_BASE=|REDIS_URL=|postgres://|sk-|AKIA|AIza" <changed files>
```

Results:

- migration completed;
- focused BFS row model test: 2 runs, 6 assertions, 0 failures;
- focused BFS ingestion-design check test: 3 runs, 9 assertions, 0 failures;
- `public_sources:bfs:verify_ingestion_design`: passed;
- full Rails test suite: 63 runs, 284 assertions, 0 failures;
- `operator:verify_operations_policy`: passed;
- RuboCop: 106 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

BFS no-row guardrail query:

```text
bfs_api_rows=0
bfs_metric_definitions=0
bfs_observations=0
bfs_prediction_links=0
exports=0
```

## Commit

Local commit created after verification.
