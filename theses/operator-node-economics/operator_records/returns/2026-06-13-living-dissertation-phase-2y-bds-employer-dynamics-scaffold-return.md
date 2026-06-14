# Living Dissertation Phase 2Y: BDS Employer Dynamics Scaffold Return

Status: implemented, verified, and committed locally.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/app/services/public_sources/bds/public_file_scaffold.rb`
- `living_dissertation_app/app/services/public_sources/bds/scaffold_policy_check.rb`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/bds/public_file_scaffold_test.rb`
- `living_dissertation_app/test/services/public_sources/bds/scaffold_policy_check_test.rb`
- `research/data/bds_public_file_scaffold.md`
- `research/data/schema_mapping.md`
- `research/data/field_dictionary.md`
- `research/data/naics_panel_inventory.md`
- `docs/operator/handoffs/2026-06-13-living-dissertation-phase-2y-bds-employer-dynamics-scaffold-handoff.md`
- `docs/operator/returns/2026-06-13-living-dissertation-phase-2y-bds-employer-dynamics-scaffold-return.md`

## Slice Result

Added a metadata-only BDS employer-dynamics scaffold for the official Census
BDS sector by firm age by firm size public file:

- source: `census_bds_public_file`;
- schema status: `verified_public_file_metadata_scaffold`;
- evidence class: `employer_dynamics_context_only`;
- observed coverage encoded from prior direct inspection: 1978-2023,
  national sector by firm age by firm size;
- row grain: `year`, `sector`, `fage`, `fsize`;
- publication flags preserved in policy: `D`, `S`, `X`, `N`.

The scaffold task registered:

```text
data_source_id=3
source_status=ingestion_scaffold_ready
schema_status=verified_public_file_metadata_scaffold
raw_file_fetched=false
analysis_authorized=false
prediction_links_authorized=false
```

## Boundaries Preserved

- No BDS raw CSV fetch.
- No BDS staging table or source rows.
- No BDS metric definitions.
- No BDS metric observations.
- No BDS quality reviews.
- No prediction links.
- No exports.
- No claim support.
- No paper prose.
- No `paper/draft.md` edits.

## Compatibility Status

| Candidate | Status |
| --- | --- |
| NAICS-year | Sector-year only. |
| Geography-NAICS-year | Blocked for this public file because it is national sector-level only. |
| Employer/nonemployer comparison cells | Blocked because BDS has no nonemployer measure. |
| Exposure cells | Blocked because BDS has no AI or transaction-cost field. |
| TCE-P005 | Blocked because BDS has no management-layer, span-of-control, or support-staff fields. |

## Remaining Gaps

- Six-digit NAICS firm-age-by-size coverage remains unresolved.
- Subnational firm-age-by-size multi-year coverage remains unresolved.
- API `BDSFAGEFSIZE` multi-year coverage remains unresolved.
- Direct employer firm-startup field distinct from establishment entry remains
  unresolved.
- BDS acquisition, manifest checksum, parser, staging, QA, metric definitions,
  observations, and quality reviews remain future work.

## Verification

Commands run:

```sh
bin/rails test test/services/public_sources/bds/public_file_scaffold_test.rb
bin/rails test test/services/public_sources/bds/scaffold_policy_check_test.rb
bin/rails public_sources:bds:scaffold
bin/rails public_sources:bds:verify_scaffold_policy
bin/rails test test/services/public_sources/susb/create_quality_reviews_test.rb test/services/public_sources/susb/quality_review_summary_test.rb test/services/public_sources/susb/quality_review_policy_check_test.rb test/services/public_sources/source_health_summary_test.rb test/integration/source_health_summary_workflow_test.rb
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

- BDS public-file scaffold test: 3 runs, 40 assertions, 0 failures;
- BDS scaffold policy-check test: 3 runs, 9 assertions, 0 failures;
- `public_sources:bds:scaffold`: registered metadata-only source scaffold;
- `public_sources:bds:verify_scaffold_policy`: passed.
- focused regression tests for SUSB/source-health policy interaction: 13 runs,
  68 assertions, 0 failures;
- full Rails test suite: 97 runs, 502 assertions, 0 failures;
- `public_sources:source_health_summary`: returned unchanged BFS/SUSB source
  row and review counts, 0 prediction links, 0 exports, and
  `context_only_no_claim_links`;
- `operator:verify_operations_policy`: passed;
- RuboCop: 132 files inspected, no offenses;
- Brakeman: 0 errors, 2 existing dependency lifecycle warnings
  (`.ruby-version` Ruby 3.2.3 EOL; Rails 7.2.3.1 support end date);
- `git diff --check`: passed with no output;
- `git diff -- paper/draft.md`: no output;
- changed-file secret scan: no matches.

## Next Slice

Likely next step: BDS acquisition design or parser design for the official CSV,
still without analysis or claim support.
