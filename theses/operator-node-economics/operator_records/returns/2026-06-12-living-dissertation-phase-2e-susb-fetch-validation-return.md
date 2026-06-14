# Living Dissertation Phase 2E SUSB Fetch Validation Return

## Status

Completed.

## Files Changed

- `docs/operator/handoffs/2026-06-12-living-dissertation-phase-2e-susb-fetch-validation-handoff.md`
- `docs/operator/returns/2026-06-12-living-dissertation-phase-2e-susb-fetch-validation-return.md`
- `living_dissertation_app/app/services/public_sources/susb/fetch_and_validate_public_file.rb`
- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/public_sources/susb/fetch_and_validate_public_file_test.rb`
- `research/data/susb_public_file_ingestion_scaffold.md`

## Exact Fetch And Validation Performed

Official source re-fetch check:

- Command: `curl -sL https://www2.census.gov/programs-surveys/susb/tables/2022/us_state_6digitnaics_2022.txt -o /tmp/susb_2022_refetch_check.txt`
- Result: completed.
- `/tmp` byte size: `56000447`.
- `/tmp` SHA-256:
  `6f7b2f2b14cbad9dbfeb31d3bfc9f729368a0e971727de4eda88c9f83f77a513`.
- `cmp -s /tmp/susb_2022_refetch_check.txt data/raw/susb/2022/us_state_6digitnaics_2022.txt`
  returned success, confirming the official re-fetch matched the existing
  ignored local raw file.

Rails validation task:

- Command: `bin/rails public_sources:susb:fetch_and_validate`
- Result: passed.
- `data_source_id=1`
- `local_path=/Users/jimmy1768/Projects/operator-node-economics/data/raw/susb/2022/us_state_6digitnaics_2022.txt`
- `fetched_this_run=false`
- `sha256=6f7b2f2b14cbad9dbfeb31d3bfc9f729368a0e971727de4eda88c9f83f77a513`
- `byte_size=56000447`
- `row_count_excluding_header=570105`
- `duplicate_key_count=0`
- `manifest_reconciled=true`

The Rails task did not re-fetch because the ignored raw file already existed.
The separate `/tmp` official re-fetch proved the source file matched the local
ignored copy byte-for-byte.

## Validation Logic Added

Added `PublicSources::Susb::FetchAndValidatePublicFile` and
`bin/rails public_sources:susb:fetch_and_validate`.

The service:

- fetches the public file only if missing or if `SUSB_FORCE_FETCH=true`;
- stores raw public files only under ignored `data/raw/`;
- reads Census text using ISO-8859-1 to handle non-UTF-8 description bytes;
- computes SHA-256 and byte size;
- validates the exact header;
- validates required columns;
- counts rows excluding the header;
- counts bad-width rows;
- counts blank lines;
- checks duplicate `STATE`/`NAICS`/`ENTRSIZE` row-grain keys;
- fails closed if bad-width rows, blank lines, or duplicate row-grain keys are
  observed;
- preserves and counts `EMPLFL_N`, `PAYRFL_N`, and `RCPTFL_N` noise flags;
- rejects noise flags outside official `G/H/J/D/S` values;
- reconciles byte size, checksum, row count, local path, and field list against
  `data/manifests/susb_2022_manifest.csv`;
- updates Rails source/access-path/intake-manifest metadata;
- writes audit events;
- leaves metrics, analysis, exports, and claim status untouched.

## Manifest Reconciliation

Tracked manifest:

- `data/manifests/susb_2022_manifest.csv`

Reconciliation result:

- passed;
- checksum matched;
- byte size matched;
- row count including header matched;
- local path matched;
- field list matched.

No tracked manifest update was needed.

## DB Metadata And Audit Behavior

The task updates local Rails DB metadata only:

- `DataSource.source_status = raw_file_validated`;
- `SourceAccessPath.status = fetched_and_validated`;
- `IntakeManifest.manifest_status = raw_file_validated`;
- validation metadata is recorded on source/access-path/manifest JSON;
- audit event `validation_completed` is written.

No claim-status effect is recorded beyond `unchanged`.

## Verification

- `bin/rails test`
  - Result: passed.
  - Output: 33 runs, 130 assertions, 0 failures, 0 errors, 0 skips.
- `bin/rails public_sources:susb:fetch_and_validate`
  - Result: passed with the validation output listed above.
- `bin/rails operator:verify_operations_policy`
  - Result: passed.
  - Output: `Operations policy guardrails passed`.
- `RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false`
  - Result: passed.
  - Output: 79 files inspected, no offenses detected.
- `bundle exec brakeman --no-pager --no-exit-on-warn`
  - Result: passed with no code warnings.
  - Residual warnings: Ruby 3.2.3 support ended on 2026-03-31; Rails 7.2.3.1 support ends on 2026-08-09.
- `git diff --check`
  - Result: passed with no output.
- `git diff -- paper/draft.md`
  - Result: passed with no output.

## Private Data, Secrets, Claims, And Paper Boundary

- No private data was ingested.
- No secrets, database URLs, API keys, SSH keys, private keys, or production
  env values were added.
- No metrics, ratios, panels, or analysis were computed.
- No claim status was changed.
- `paper/draft.md` remained untouched.

## Remaining Gaps

- The Rails task has validated the raw file and metadata path, but there is no
  durable processed-row table yet.
- No parser has loaded SUSB rows into structured database records.
- No metric definitions or observations have been computed.
- No export-review path has approved SUSB-derived artifacts.
- No public ingestion scheduler is enabled.
- Redis/live deployment health remains a host-level verification step.
