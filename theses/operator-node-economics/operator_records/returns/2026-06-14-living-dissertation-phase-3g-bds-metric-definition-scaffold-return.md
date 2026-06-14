# Living Dissertation Phase 3G: BDS Metric Definition Scaffold Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/app/services/public_sources/bds/metric_definition_scaffold.rb`
- `living_dissertation_app/app/services/public_sources/source_health_summary.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/bds/metric_definition_scaffold_test.rb`
- `research/data/bds_metric_definition_scaffold.md`
- `research/data/bds_source_row_load.md`
- `research/data/schema_mapping.md`
- `research/data/naics_panel_inventory.md`
- `research/data/source_health_summary.md`
- `docs/operator/handoffs/2026-06-14-living-dissertation-phase-3h-bds-metric-computation-design-handoff.md`
- `docs/operator/returns/2026-06-14-living-dissertation-phase-3g-bds-metric-definition-scaffold-return.md`

## Slice Result

Created 10 draft-disabled BDS source-native metric definitions:

- `bds_firms`
- `bds_establishments`
- `bds_employment`
- `bds_establishment_entries`
- `bds_establishment_exits`
- `bds_firm_deaths`
- `bds_job_creation`
- `bds_job_destruction`
- `bds_net_job_creation`
- `bds_reallocation_rate`

Live task:

```sh
bin/rails public_sources:bds:scaffold_metric_definitions
```

Live result:

```text
metric_definitions_created=10
metric_observations_created=0
quality_reviews_created=0
prediction_links_created=0
exports_created=0
```

## Boundaries Preserved

- Definitions are `draft_disabled`.
- No BDS metric observations.
- No BDS quality reviews.
- No prediction links.
- No exports.
- No claim support.
- No analysis.
- No paper prose.
- No `paper/draft.md` edits.

## Remaining Gaps

- BDS metric computation design remains unimplemented.
- BDS metric observations remain unauthorized.
- BDS quality-review policy and review storage remain unimplemented.
- BDS still cannot support nonemployer, AI exposure, management-layer,
  transaction-cost, or firm-boundary claims.

## Verification

Commands run so far:

```sh
bin/rails test test/services/public_sources/bds/metric_definition_scaffold_test.rb test/services/public_sources/source_health_summary_test.rb
bin/rails public_sources:bds:scaffold_metric_definitions
bin/rails public_sources:source_health_summary
bin/rails runner 'puts({bds_definitions: MetricDefinition.where("key LIKE ?", "bds_%").count, bds_observations: MetricObservation.joins(:data_source).where(data_sources: {source_kind: "census_bds_public_file"}).count, bds_reviews: MetricQualityReview.joins(:data_source).where(data_sources: {source_kind: "census_bds_public_file"}).count, bds_links: PredictionLink.joins(:data_source).where(data_sources: {source_kind: "census_bds_public_file"}).count}.inspect)'
```

Results so far:

- focused tests: 3 runs, 29 assertions, 0 failures;
- live BDS metric definition scaffold: 10 definitions created;
- BDS observations, reviews, and prediction links remained 0;
- source-health summary reports BDS metric definitions = 10 and
  `overall_evidence_status=context_only_no_claim_links`.

Full-suite commands run before commit:

```sh
bin/rails test
bin/rails public_sources:source_health_summary
bin/rails operator:verify_operations_policy
RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false
bundle exec brakeman --no-pager --no-exit-on-warn
git diff --check
git diff -- paper/draft.md
rg -n "<standard secret-pattern scan>" <changed files>
```

Full-suite results:

- full Rails test suite: 127 runs, 664 assertions, 0 failures;
- `public_sources:source_health_summary`: policy checks passed,
  `overall_evidence_status=context_only_no_claim_links`, 0 prediction links,
  and 0 export-created audit events;
- `operator:verify_operations_policy`: passed;
- RuboCop: 151 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

## Next Slice

Recommended next step: define BDS metric-computation design. Do not compute
observations until source-native eligibility, flag/null handling, quality
metadata, and review dependency are specified.
