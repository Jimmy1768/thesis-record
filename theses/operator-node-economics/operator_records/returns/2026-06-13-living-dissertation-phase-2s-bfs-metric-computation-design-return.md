# Living Dissertation Phase 2S: BFS Metric Computation Design Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/app/services/public_sources/bfs/metric_computation_design_check.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/bfs/metric_computation_design_check_test.rb`
- `research/data/bfs_metric_computation_design.md`
- `research/data/bfs_sample_row_load.md`
- `research/data/bfs_ingestion_design.md`
- `research/data/naics_panel_inventory.md`
- `research/data/schema_mapping.md`
- `docs/operator/handoffs/2026-06-13-living-dissertation-phase-2s-bfs-metric-computation-design-handoff.md`
- `docs/operator/returns/2026-06-13-living-dissertation-phase-2s-bfs-metric-computation-design-return.md`

## Slice Result

Implemented a disabled BFS metric-computation design gate.

The gate reserves future source-native monthly context metric keys but does not
create `MetricDefinition` rows, `MetricObservation` rows, quality reviews,
prediction links, exports, claim support, paper prose, or thesis evidence.

## V1 Rules

Eligible future source rows are limited to staged `bfs_api_rows` with:

- U.S. geography;
- source-native monthly grain;
- `seasonally_adj=no`;
- policy-listed sector/aggregate categories;
- target `data_type_code` values:
  - `BA_BA`
  - `BA_HBA`
  - `BF_BF4Q`
  - `BF_BF8Q`
  - `BF_PBF4Q`
  - `BF_PBF8Q`

Source value rules:

| Source condition | V1 status |
| --- | --- |
| Numeric `cell_value` | `staged_context` |
| Non-numeric `cell_value` | `blocked_suppression_or_non_numeric` |
| `error_data=yes` | `blocked_error_data` |
| Missing `cell_value` | `blocked_missing_value` |

## Boundaries Preserved

- No paper prose added.
- No `paper/draft.md` edits.
- No metric definitions created.
- No metric observations created.
- No quality reviews created.
- No prediction links created.
- No exports created.
- No claim status changed.
- No quantitative analysis.
- No AI, Operator Node, productivity, transaction-cost, or firm-boundary
  interpretation added.

## Verification

Commands run:

```sh
bin/rails test test/services/public_sources/bfs/metric_computation_design_check_test.rb
bin/rails public_sources:bfs:verify_metric_computation_design
bin/rails runner "<BFS post-load guardrail query>"
bin/rails test
bin/rails operator:verify_operations_policy
RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false
bundle exec brakeman --no-pager --no-exit-on-warn
git diff --check
git diff -- paper/draft.md
rg -n "<standard secret-pattern scan>" <changed files>
```

Results:

- focused BFS metric-computation design test: 4 runs, 12 assertions,
  0 failures;
- `public_sources:bfs:verify_metric_computation_design`: passed;
- post-load guardrail query:

```text
{:bfs_api_rows=>1368, :bfs_metric_definitions=>0, :bfs_observations=>0, :bfs_prediction_links=>0, :exports=>0}
```

- full Rails test suite: 72 runs, 334 assertions, 0 failures;
- `operator:verify_operations_policy`: passed;
- RuboCop: 112 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

## Remaining Gates

- BFS metric definitions still need a separate authorization slice.
- BFS metric observation creation still needs a separate implementation slice.
- Quality-review storage for BFS observations remains blocked until BFS
  observations exist.
- No public export path exists for BFS rows or metrics.
- No quantitative findings exist.

Next likely slice: create disabled BFS metric-definition scaffolding for the six
reserved metric keys without observations, prediction links, exports, or claim
support.
