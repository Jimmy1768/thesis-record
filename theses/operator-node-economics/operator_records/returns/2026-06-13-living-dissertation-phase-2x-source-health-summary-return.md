# Living Dissertation Phase 2X: Source Health Summary Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/app/services/public_sources/source_health_summary.rb`
- `living_dissertation_app/app/services/public_sources/bfs/quality_review_policy_check.rb`
- `living_dissertation_app/app/services/public_sources/susb/quality_review_policy_check.rb`
- `living_dissertation_app/app/services/public_sources/susb/quality_review_summary.rb`
- `living_dissertation_app/app/controllers/source_health_controller.rb`
- `living_dissertation_app/app/views/source_health/show.html.erb`
- `living_dissertation_app/app/views/data_sources/index.html.erb`
- `living_dissertation_app/config/routes.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/source_health_summary_test.rb`
- `living_dissertation_app/test/integration/source_health_summary_workflow_test.rb`
- `living_dissertation_app/test/services/public_sources/susb/quality_review_policy_check_test.rb`
- `research/data/source_health_summary.md`
- `research/data/schema_mapping.md`
- `docs/operator/handoffs/2026-06-13-living-dissertation-phase-2x-source-health-summary-handoff.md`
- `docs/operator/returns/2026-06-13-living-dissertation-phase-2x-source-health-summary-return.md`

## Slice Result

Implemented a read-only combined source health service, command-line task, and
authenticated dashboard at:

- `/source_health`

Live summary output:

```text
total_source_rows=571473
total_metric_definitions=11
total_metric_observations=433431
total_quality_reviews=433431
total_prediction_links=0
total_export_created_audit_events=0
all_policy_checks_passed=true
overall_evidence_status=context_only_no_claim_links
bfs.source_row_count=1368
bfs.metric_definition_count=6
bfs.metric_observation_count=1351
bfs.quality_review_count=1351
bfs.unreviewed_observation_count=0
bfs.prediction_link_count=0
susb.source_row_count=570105
susb.metric_definition_count=5
susb.metric_observation_count=432080
susb.quality_review_count=432080
susb.unreviewed_observation_count=0
susb.prediction_link_count=0
```

## Boundaries Preserved

- No paper prose added.
- No `paper/draft.md` edits.
- Summary paths are read-only.
- No observation or review mutation from summary paths.
- No prediction links created.
- No exports created.
- No claim status changed.
- No aggregation, ratios, trends, or thesis interpretation added.

## Verification

Commands run:

```sh
bin/rails test test/services/public_sources/source_health_summary_test.rb
bin/rails test test/integration/source_health_summary_workflow_test.rb
bin/rails test test/services/public_sources/susb/quality_review_summary_test.rb
bin/rails test test/services/public_sources/susb/quality_review_policy_check_test.rb
bin/rails test test/services/public_sources/bfs/quality_review_summary_test.rb
bin/rails test test/services/public_sources/bfs/quality_review_policy_check_test.rb
bin/rails public_sources:source_health_summary
bin/rails public_sources:susb:quality_review_summary
bin/rails test
bin/rails operator:verify_operations_policy
RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false
bundle exec brakeman --no-pager --no-exit-on-warn
git diff --check
git diff -- paper/draft.md
rg -n "<standard secret-pattern scan>" <changed files>
```

Results:

- focused combined/SUSB/BFS summary and policy tests: 16 runs, 82 assertions,
  0 failures;
- `public_sources:source_health_summary`: returned expected combined counts,
  0 prediction links, 0 exports, and `context_only_no_claim_links`;
- `public_sources:susb:quality_review_summary`: returned expected SUSB counts
  after source-ID query optimization;
- browser check at `http://127.0.0.1:3020/source_health`: rendered the expected
  heading, overall `context_only_no_claim_links` status, BFS source, SUSB
  source, and claim-review boundary text;
- full Rails test suite: 91 runs, 453 assertions, 0 failures;
- `operator:verify_operations_policy`: passed;
- RuboCop: 128 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

## Implementation Note

The first combined source-health pass was too slow because it reused detailed
SUSB/BFS summary paths and repeated large JSON scans. The final implementation
uses source-ID scoped aggregate SQL for observation/review totals, unreviewed
counts, and guardrail-flag counts.

## Remaining Gates

- No prediction links exist.
- No exports exist.
- No aggregation/trend/ratio analysis exists.
- No claim review exists.
- No quantitative findings exist.

Next likely slice: decide whether to add the next source family, likely BDS for
employer dynamics or NES for nonemployer boundary evidence. Do not create claim
links until a separate claim-review gate is designed.
