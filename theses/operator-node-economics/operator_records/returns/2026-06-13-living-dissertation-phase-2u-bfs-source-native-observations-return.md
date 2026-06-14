# Living Dissertation Phase 2U: BFS Source-Native Observations Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/app/services/public_sources/bfs/compute_source_native_observations.rb`
- `living_dissertation_app/app/services/public_sources/bfs/metric_computation_design_check.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/bfs/compute_source_native_observations_test.rb`
- `living_dissertation_app/test/services/public_sources/bfs/metric_computation_design_check_test.rb`
- `research/data/bfs_source_native_observations.md`
- `research/data/bfs_metric_computation_design.md`
- `research/data/naics_panel_inventory.md`
- `research/data/schema_mapping.md`
- `docs/operator/handoffs/2026-06-13-living-dissertation-phase-2u-bfs-source-native-observations-handoff.md`
- `docs/operator/returns/2026-06-13-living-dissertation-phase-2u-bfs-source-native-observations-return.md`

## Slice Result

Implemented and ran BFS source-native context-observation computation.

Initial live task output:

```text
Computed BFS source-native observations
data_source_id=2
eligible_rows=1368
observations_deleted=0
observations_created=1351
status_counts={"staged_context"=>1351}
metric_counts={"bfs_business_applications"=>228, "bfs_high_propensity_business_applications"=>228, "bfs_business_formations_4q"=>228, "bfs_business_formations_8q"=>211, "bfs_projected_business_formations_4q"=>228, "bfs_projected_business_formations_8q"=>228}
blocked_cells={"bfs_business_formations_8q"=>17}
prediction_links_created=0
exports_created=0
```

Idempotency rerun:

```text
observations_deleted=1351
observations_created=1351
prediction_links_created=0
exports_created=0
```

## Boundaries Preserved

- No paper prose added.
- No `paper/draft.md` edits.
- No aggregation.
- No ratios.
- No trends.
- No prediction links created.
- No exports created.
- No claim status changed.
- No AI, Operator Node, productivity, transaction-cost, or firm-boundary
  interpretation added.
- Non-numeric/suppressed source cells were blocked, not coerced.

## Verification

Commands run:

```sh
bin/rails test test/services/public_sources/bfs/compute_source_native_observations_test.rb
bin/rails test test/services/public_sources/bfs/metric_computation_design_check_test.rb
bin/rails test test/services/public_sources/bfs/metric_definition_scaffold_test.rb
bin/rails public_sources:bfs:compute_source_native_observations
bin/rails public_sources:bfs:compute_source_native_observations
bin/rails runner "<BFS post-observation guardrail query>"
bin/rails test
bin/rails operator:verify_operations_policy
RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false
bundle exec brakeman --no-pager --no-exit-on-warn
git diff --check
git diff -- paper/draft.md
rg -n "<standard secret-pattern scan>" <changed files>
```

Results:

- focused BFS source-native observation test: 2 runs, 17 assertions,
  0 failures;
- focused BFS metric-computation design test: 4 runs, 12 assertions,
  0 failures;
- focused BFS metric-definition scaffold test: 2 runs, 18 assertions,
  0 failures;
- `public_sources:bfs:compute_source_native_observations`: created 1,351
  source-native observations, blocked 17 non-numeric/suppressed source cells,
  and created zero links/exports;
- idempotency rerun: deleted and recreated the same 1,351 observations;
- post-observation guardrail query:

```text
{:bfs_api_rows=>1368, :bfs_metric_definitions=>6, :bfs_observations=>1351, :bfs_prediction_links=>0, :exports=>0}
```

- full Rails test suite: 76 runs, 369 assertions, 0 failures;
- `operator:verify_operations_policy`: passed;
- RuboCop: 116 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

## Remaining Gates

- BFS quality-review policy and review storage remain unimplemented.
- No prediction links exist.
- No exports exist.
- No aggregation/trend/ratio analysis exists.
- No claim review exists.
- No quantitative findings exist.

Next likely slice: implement BFS quality-review policy for source-native
observations, keeping all observations context-only and claim-neutral.
