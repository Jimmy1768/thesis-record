# Living Dissertation Phase 2N: BFS API Scaffold Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/app/services/public_sources/bfs/api_scaffold.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/bfs/api_scaffold_test.rb`
- `research/data/bfs_api_ingestion_scaffold.md`
- `research/data/schema_mapping.md`
- `research/data/naics_panel_inventory.md`
- `docs/operator/handoffs/2026-06-13-living-dissertation-phase-2n-bfs-api-scaffold-handoff.md`
- `docs/operator/returns/2026-06-13-living-dissertation-phase-2n-bfs-api-scaffold-return.md`

## Scaffold Behavior

Added:

```sh
bin/rails public_sources:bfs:scaffold
```

The task registers:

- BFS `DataSource`;
- official Census API metadata `SourceAccessPath`;
- metadata-only `IntakeManifest`;
- `SchemaVersion` for verified API metadata fields.

It does not query BFS data rows, compute metrics, create exports, create
prediction links, or change claim support.

## Blockers Preserved

- `data_type_code` value-code mapping remains blocked.
- `category_code` to industry/NAICS mapping remains blocked.
- geography remains U.S.-only in inspected metadata.
- NAICS panel use remains blocked.
- BFS remains an indirect payroll-transition proxy only.

## Verification

Commands run:

```sh
bin/rails test test/services/public_sources/bfs/api_scaffold_test.rb
bin/rails public_sources:bfs:scaffold
bin/rails test
bin/rails operator:verify_operations_policy
RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false
bundle exec brakeman --no-pager --no-exit-on-warn
git diff --check
git diff -- paper/draft.md
bin/rails runner "<BFS guardrail query>"
rg -n "BEGIN RSA|BEGIN OPENSSH|BEGIN PRIVATE|DATABASE_URL=|SECRET_KEY_BASE=|REDIS_URL=|postgres://|sk-|AKIA|AIza" <changed files>
```

Results:

- focused BFS scaffold test: 3 runs, 31 assertions, 0 failures;
- local scaffold task: registered BFS API metadata with
  `api_data_queried=false` and `analysis_authorized=false`;
- full Rails test suite: 58 runs, 264 assertions, 0 failures;
- `operator:verify_operations_policy`: passed;
- RuboCop: 101 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

BFS guardrail query:

```text
bfs_source=ingestion_scaffold_ready
access_status=verified_metadata_only_not_queried
api_data_queried=false
analysis_authorized=false
metric_definitions=0
observations=0
prediction_links=0
exports=0
```

## Commit

Local commit created after verification.
