# Living Dissertation Phase 2O: BFS Value-Code Mapping Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/app/services/public_sources/bfs/api_scaffold.rb`
- `living_dissertation_app/test/services/public_sources/bfs/api_scaffold_test.rb`
- `research/data/bfs_api_ingestion_scaffold.md`
- `research/data/bfs_value_code_mapping.md`
- `research/data/schema_mapping.md`
- `research/data/naics_panel_inventory.md`
- `docs/operator/handoffs/2026-06-13-living-dissertation-phase-2o-bfs-value-code-mapping-handoff.md`
- `docs/operator/returns/2026-06-13-living-dissertation-phase-2o-bfs-value-code-mapping-return.md`

## Official Sources/API Paths Inspected

- `https://www.census.gov/econ/bfs/pdf/bfs_monthly_data_dictionary.pdf`
- `https://api.census.gov/data/timeseries/eits/bfs/examples.json`
- `https://www.census.gov/econ/bfs/definitions.html`
- `https://api.census.gov/data/timeseries/eits/bfs/variables.json`
- `https://api.census.gov/data/timeseries/eits/bfs/geography.json`
- `https://api.census.gov/data/timeseries/eits/bfs/variables/data_type_code.json`
- `https://api.census.gov/data/timeseries/eits/bfs/variables/category_code.json`
- attempted value-list paths under `/variables/.../values.json` and
  `/values/...json`, which returned 404.

## Mappings Verified

Target `data_type_code` mappings:

- `BA_BA`: business applications
- `BA_HBA`: high-propensity business applications
- `BF_BF4Q`: business formations within four quarters
- `BF_BF8Q`: business formations within eight quarters
- `BF_PBF4Q`: projected business formations within four quarters
- `BF_PBF8Q`: projected business formations within eight quarters

Additional verified series codes:

- `BA_CBA`
- `BA_WBA`
- `BF_SBF4Q`
- `BF_SBF8Q`
- `BF_DUR4Q`
- `BF_DUR8Q`

Category-code mapping:

- monthly BFS dictionary maps total, sector, aggregate, and no-NAICS category
  codes including `TOTAL`, `NAICS11`, `NAICSMNF`, `NAICSRET`, `NAICSTW`,
  `NAICS54`, and `NONAICS`.

API example-shape query:

- `get=data_type_code,time_slot_id,seasonally_adj,category_code,cell_value,error_data`
- `time=2012`
- `for=us:*`
- returned 5,544 rows excluding header;
- observed `time_slot_id=0`;
- observed `seasonally_adj=no/yes`.

## Blockers Remaining

- No BFS data rows stored.
- No BFS metrics created.
- Inspected API geography metadata remains U.S.-only.
- Monthly CSV documentation includes state/region codes, but API access for
  those geographies remains unverified.
- Ingestion design still must decide seasonally adjusted versus not adjusted.
- Ingestion design still must decide target-only, spliced, and duration series
  handling.
- NAICS panel use remains blocked until sector, aggregate-category, `NONAICS`,
  and harmonization rules are explicit.
- BFS remains only an indirect payroll-transition proxy.

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
bin/rails runner "<BFS mapping guardrail query>"
rg -n "BEGIN RSA|BEGIN OPENSSH|BEGIN PRIVATE|DATABASE_URL=|SECRET_KEY_BASE=|REDIS_URL=|postgres://|sk-|AKIA|AIza" <changed files>
```

Results:

- focused BFS scaffold test: 3 runs, 36 assertions, 0 failures;
- local scaffold task refreshed existing BFS metadata with
  `api_data_queried=false` and `analysis_authorized=false`;
- full Rails test suite: 58 runs, 269 assertions, 0 failures;
- `operator:verify_operations_policy`: passed;
- RuboCop: 101 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

BFS mapping guardrail query:

```text
target_business_applications=BA_BA
target_projected_4q=BF_PBF4Q
category_total=Total for All NAICS
category_manufacturing=Manufacturing
observed_2012_row_count=5544
api_data_queried=false
analysis_authorized=false
metric_definitions=0
observations=0
prediction_links=0
exports=0
```

## Commit

Local commit created after verification.
