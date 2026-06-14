# Living Dissertation Phase 3I: BDS Source-Native Observations Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/app/services/public_sources/bds/metric_computation_design_check.rb`
- `living_dissertation_app/app/services/public_sources/bds/compute_source_native_observations.rb`
- `living_dissertation_app/app/services/public_sources/source_health_summary.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/bds/metric_computation_design_check_test.rb`
- `living_dissertation_app/test/services/public_sources/bds/compute_source_native_observations_test.rb`
- `living_dissertation_app/test/services/public_sources/source_health_summary_test.rb`
- `research/data/bds_source_native_observations.md`
- `research/data/bds_metric_computation_design.md`
- `research/data/schema_mapping.md`
- `research/data/naics_panel_inventory.md`
- `research/data/source_health_summary.md`
- `docs/operator/handoffs/2026-06-14-living-dissertation-phase-3j-bds-quality-review-policy-handoff.md`
- `docs/operator/returns/2026-06-14-living-dissertation-phase-3i-bds-source-native-observations-return.md`

## Slice Result

Computed BDS source-native context observations:

```text
eligible_rows=104880
observations_deleted=0
observations_created=746174
status_counts={"staged_context"=>746174}
quality_reviews_created=0
prediction_links_created=0
exports_created=0
```

Source-health now reports:

```text
bds.metric_observation_count=746174
bds.quality_review_count=0
bds.unreviewed_observation_count=746174
bds.prediction_link_count=0
bds.evidence_status=source_native_observations_unreviewed_context_only
```

## Boundaries Preserved

- BDS observations are source-native context only.
- No BDS quality reviews.
- No prediction links.
- No exports.
- No claim support.
- No analysis.
- No paper prose.
- No `paper/draft.md` edits.

## Remaining Gaps

- BDS quality-review policy and review storage remain unimplemented.
- BDS observations remain unreviewed context only.
- BDS still cannot support nonemployer, AI exposure, management-layer,
  transaction-cost, or firm-boundary claims.

## Verification

Commands run so far:

```sh
bin/rails test test/services/public_sources/bds/compute_source_native_observations_test.rb test/services/public_sources/bds/metric_computation_design_check_test.rb
bin/rails public_sources:bds:verify_metric_design
bin/rails public_sources:bds:compute_source_native_observations
bin/rails runner 'puts({bds_rows: BdsPublicFileRow.count, bds_definitions: MetricDefinition.where("key LIKE ?", "bds_%").count, bds_observations: MetricObservation.joins(:data_source).where(data_sources: {source_kind: "census_bds_public_file"}).count, bds_reviews: MetricQualityReview.joins(:data_source).where(data_sources: {source_kind: "census_bds_public_file"}).count, bds_links: PredictionLink.joins(:data_source).where(data_sources: {source_kind: "census_bds_public_file"}).count}.inspect)'
bin/rails test test/services/public_sources/source_health_summary_test.rb test/integration/source_health_summary_workflow_test.rb
bin/rails public_sources:source_health_summary
```

Results so far:

- focused BDS computation/design tests: 6 runs, 36 assertions, 0 failures;
- BDS metric design guardrails: passed;
- live BDS computation created 746,174 observations;
- BDS reviews and prediction links remained 0;
- focused source-health tests: 4 runs, 31 assertions, 0 failures;
- source-health summary reports BDS observations as unreviewed context only.

Full-suite commands run before commit:

```sh
bin/rails test
bin/rails operator:verify_operations_policy
bin/rails public_sources:source_health_summary
RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false
bundle exec brakeman --no-pager --no-exit-on-warn
git diff --check
git diff -- paper/draft.md
rg -n "<standard secret-pattern scan>" <changed files>
```

Full-suite results:

- full Rails test suite: 133 runs, 703 assertions, 0 failures;
- `operator:verify_operations_policy`: passed;
- `public_sources:source_health_summary`: policy checks passed,
  `overall_evidence_status=context_only_no_claim_links`, 0 prediction links,
  and 0 export-created audit events;
- RuboCop: 155 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

## Next Slice

Recommended next step: define BDS quality-review policy and review-state
storage for source-native observations. Do not create claim links or exports.
