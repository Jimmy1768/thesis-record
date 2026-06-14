# Living Dissertation Phase 2T: BFS Metric Definition Scaffold Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/app/services/public_sources/bfs/metric_definition_scaffold.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/bfs/metric_definition_scaffold_test.rb`
- `research/data/bfs_metric_definition_scaffold.md`
- `research/data/bfs_metric_computation_design.md`
- `research/data/naics_panel_inventory.md`
- `research/data/schema_mapping.md`
- `docs/operator/handoffs/2026-06-13-living-dissertation-phase-2t-bfs-metric-definition-scaffold-handoff.md`
- `docs/operator/returns/2026-06-13-living-dissertation-phase-2t-bfs-metric-definition-scaffold-return.md`

## Slice Result

Implemented and ran the BFS metric-definition scaffold.

Local task output:

```text
Scaffolded BFS metric definitions
definition_keys=["bfs_business_applications", "bfs_high_propensity_business_applications", "bfs_business_formations_4q", "bfs_business_formations_8q", "bfs_projected_business_formations_4q", "bfs_projected_business_formations_8q"]
metric_definitions_created=6
metric_observations_created=0
prediction_links_created=0
exports_created=0
```

## Definitions Created

- `bfs_business_applications`
- `bfs_high_propensity_business_applications`
- `bfs_business_formations_4q`
- `bfs_business_formations_8q`
- `bfs_projected_business_formations_4q`
- `bfs_projected_business_formations_8q`

All definitions use `formula_status=draft_disabled`.

## Boundaries Preserved

- No paper prose added.
- No `paper/draft.md` edits.
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
bin/rails test test/services/public_sources/bfs/metric_definition_scaffold_test.rb
bin/rails public_sources:bfs:scaffold_metric_definitions
bin/rails public_sources:bfs:verify_metric_computation_design
bin/rails runner "<BFS post-definition guardrail query>"
bin/rails test
bin/rails operator:verify_operations_policy
RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false
bundle exec brakeman --no-pager --no-exit-on-warn
git diff --check
git diff -- paper/draft.md
rg -n "<standard secret-pattern scan>" <changed files>
```

Results:

- focused BFS metric-definition scaffold test: 2 runs, 18 assertions,
  0 failures;
- `public_sources:bfs:scaffold_metric_definitions`: created six
  draft-disabled definitions and zero downstream artifacts;
- `public_sources:bfs:verify_metric_computation_design`: passed;
- post-definition guardrail query:

```text
{:bfs_api_rows=>1368, :bfs_metric_definitions=>6, :bfs_observations=>0, :bfs_prediction_links=>0, :exports=>0}
```

- full Rails test suite: 74 runs, 352 assertions, 0 failures;
- `operator:verify_operations_policy`: passed;
- RuboCop: 114 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

## Remaining Gates

- BFS observation creation remains blocked.
- BFS source-value quality handling remains design-only until computation is
  authorized.
- No quality reviews exist for BFS because no BFS observations exist.
- No prediction links or public exports exist.
- No quantitative findings exist.

Next likely slice: implement BFS source-native observation creation for the six
draft-disabled metrics, still with blocked non-numeric values, no aggregation,
no trends, no links, no exports, and no claim support.
