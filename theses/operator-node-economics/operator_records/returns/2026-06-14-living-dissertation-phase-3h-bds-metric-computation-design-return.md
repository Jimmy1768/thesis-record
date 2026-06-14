# Living Dissertation Phase 3H: BDS Metric Computation Design Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/app/services/public_sources/bds/metric_computation_design_check.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/bds/metric_computation_design_check_test.rb`
- `research/data/bds_metric_computation_design.md`
- `research/data/bds_metric_definition_scaffold.md`
- `research/data/schema_mapping.md`
- `research/data/naics_panel_inventory.md`
- `docs/operator/returns/2026-06-14-living-dissertation-phase-3h-bds-metric-computation-design-return.md`

## Slice Result

Defined BDS metric-computation design without computing observations.

The design records:

- 10 eligible BDS metric keys;
- source-native year-sector-firm-age-firm-size grain;
- publication flag rules for `D`, `S`, `X`, and `N`;
- null/missing source-cell blocking rules;
- required quality metadata;
- prohibited computations;
- claim-neutral status.

Executable check:

```sh
bin/rails public_sources:bds:verify_metric_design
```

## Boundaries Preserved

- No BDS metric observations.
- No BDS quality reviews.
- No prediction links.
- No exports.
- No claim support.
- No analysis.
- No paper prose.
- No `paper/draft.md` edits.

## Remaining Gaps

- BDS metric observation computation remains unimplemented and unauthorized.
- BDS quality-review policy and review storage remain unimplemented.
- BDS still cannot support nonemployer, AI exposure, management-layer,
  transaction-cost, or firm-boundary claims.

## Verification

Commands run before commit:

```sh
bin/rails test test/services/public_sources/bds/metric_computation_design_check_test.rb
bin/rails public_sources:bds:verify_metric_design
bin/rails test
bin/rails public_sources:source_health_summary
bin/rails operator:verify_operations_policy
RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false
bundle exec brakeman --no-pager --no-exit-on-warn
git diff --check
git diff -- paper/draft.md
rg -n "<standard secret-pattern scan>" <changed files>
```

Results:

- focused BDS metric-computation design tests: 4 runs, 12 assertions,
  0 failures;
- `public_sources:bds:verify_metric_design`: passed;
- BDS observations, reviews, and prediction links remained 0;
- full Rails test suite: 131 runs, 676 assertions, 0 failures;
- `public_sources:source_health_summary`: policy checks passed,
  `overall_evidence_status=context_only_no_claim_links`, 0 prediction links,
  and 0 export-created audit events;
- `operator:verify_operations_policy`: passed;
- RuboCop: 153 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

## Next Slice

Recommended next step: implement BDS source-native observation computation only
if it preserves the design rules and still creates no quality reviews, exports,
prediction links, analysis, or claim support.
