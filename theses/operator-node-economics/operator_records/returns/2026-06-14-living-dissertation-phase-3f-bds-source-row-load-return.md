# Living Dissertation Phase 3F: BDS Source Row Load Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/app/services/public_sources/bds/parser_design_check.rb`
- `living_dissertation_app/app/services/public_sources/bds/row_load_policy_check.rb`
- `living_dissertation_app/app/services/public_sources/bds/fetch_and_validate_public_file.rb`
- `living_dissertation_app/app/services/public_sources/bds/parser_dry_run.rb`
- `living_dissertation_app/app/services/public_sources/bds/parser_skeleton.rb`
- `living_dissertation_app/app/services/public_sources/bds/load_staging_rows.rb`
- `living_dissertation_app/app/services/public_sources/source_health_summary.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/bds/load_staging_rows_test.rb`
- `living_dissertation_app/test/services/public_sources/bds/parser_design_check_test.rb`
- `living_dissertation_app/test/services/public_sources/bds/row_load_policy_check_test.rb`
- `living_dissertation_app/test/services/public_sources/bds/parser_skeleton_test.rb`
- `living_dissertation_app/test/services/public_sources/source_health_summary_test.rb`
- `research/data/bds_source_row_load.md`
- `research/data/bds_row_load_qa_policy.md`
- `research/data/bds_parser_dry_run.md`
- `research/data/bds_parser_skeleton.md`
- `research/data/bds_staging_table_skeleton.md`
- `research/data/bds_acquisition_parser_design.md`
- `research/data/bds_public_file_scaffold.md`
- `research/data/schema_mapping.md`
- `research/data/naics_panel_inventory.md`
- `research/data/source_health_summary.md`
- `docs/operator/handoffs/2026-06-14-living-dissertation-phase-3g-bds-metric-definition-scaffold-handoff.md`
- `docs/operator/returns/2026-06-14-living-dissertation-phase-3f-bds-source-row-load-return.md`

## Slice Result

Implemented and ran a guarded BDS source-row loader:

- validates the official BDS raw file and manifest before loading;
- requires row-load QA policy;
- deletes existing BDS rows for the source inside the load transaction;
- inserts source-native rows in batches;
- preserves raw measure values;
- preserves publication flags before numeric coercion;
- stores flagged numeric cells as null;
- stores row hashes and a load ID;
- reconciles final row count to 104,880;
- creates no metrics, quality reviews, prediction links, exports, analysis, or
  claim support.

Rails task:

```sh
bin/rails public_sources:bds:load_staging
```

Live load result:

```text
rows_read=104880
rows_inserted=104880
rows_deleted_before_load=0
metric_definitions_created=0
metric_observations_created=0
quality_reviews_created=0
prediction_links_created=0
exports_created=0
```

Post-load checks:

```text
BdsPublicFileRow.count=104880
bds_metric_observation_count=0
bds_quality_review_count=0
bds_prediction_link_count=0
```

## Boundaries Preserved

- BDS rows are source-native staging rows only.
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

- BDS source-native metric definitions remain unimplemented.
- BDS metric computation remains unauthorized.
- BDS quality-review policy and review storage remain unimplemented.
- BDS still cannot support nonemployer, AI exposure, management-layer,
  transaction-cost, or firm-boundary claims.

## Verification

Commands run so far:

```sh
bin/rails test test/services/public_sources/bds/load_staging_rows_test.rb test/services/public_sources/bds/row_load_policy_check_test.rb test/services/public_sources/bds/parser_design_check_test.rb test/services/public_sources/bds/parser_skeleton_test.rb test/services/public_sources/bds/parser_dry_run_test.rb
bin/rails test test/services/public_sources/source_health_summary_test.rb test/integration/source_health_summary_workflow_test.rb
bin/rails public_sources:bds:verify_parser_design
bin/rails public_sources:bds:verify_row_load_policy
bin/rails public_sources:bds:load_staging
bin/rails runner 'result = PublicSources::Bds::RowLoadPolicyCheck.call(require_loaded_table: true); puts({passed: result.passed, failures: result.failures, count: BdsPublicFileRow.count}.inspect)'
bin/rails public_sources:bds:dry_run_parser
bin/rails public_sources:source_health_summary
bin/rails runner 'puts({bds_rows: BdsPublicFileRow.count, bds_metrics: MetricObservation.joins(:data_source).where(data_sources: {source_kind: "census_bds_public_file"}).count, bds_reviews: MetricQualityReview.joins(:data_source).where(data_sources: {source_kind: "census_bds_public_file"}).count, bds_links: PredictionLink.joins(:data_source).where(data_sources: {source_kind: "census_bds_public_file"}).count}.inspect)'
```

Results so far:

- focused BDS tests: 18 runs, 101 assertions, 0 failures;
- focused source-health tests: 4 runs, 28 assertions, 0 failures;
- BDS parser design guardrails: passed;
- BDS row-load policy guardrails: passed;
- live BDS load: 104,880 rows inserted, 0 downstream records created;
- loaded-table policy reconciliation: passed with 104,880 BDS rows;
- BDS dry-run parser still reads 104,880 rows and persists 0 rows;
- source-health summary includes BDS with 104,880 source rows and 0 BDS
  metric definitions, observations, reviews, prediction links, or exports.

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

- full Rails test suite: 125 runs, 649 assertions, 0 failures;
- `public_sources:source_health_summary`: policy checks passed,
  `overall_evidence_status=context_only_no_claim_links`, 0 prediction links,
  and 0 export-created audit events;
- `operator:verify_operations_policy`: passed;
- RuboCop: 149 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

## Next Slice

Recommended next step: create draft-disabled BDS source-native metric
definitions. Do not compute observations or create reviews yet.
