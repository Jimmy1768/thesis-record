# Policy Source Of Truth Return

## Status

Completed.

## User Decision Implemented

Threshold and cadence gaps should use conservative V1 defaults where possible,
and adjustable values should have a single source of truth so they can be
changed in one place.

## Files Changed

- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/config/sidekiq.yml`
- `living_dissertation_app/test/jobs/scheduler_scaffold_jobs_test.rb`
- `docs/source_truth/global_design_rules.md`
- `docs/source_truth/operator_node_definition.md`
- `research/forecast_versioning_framework.md`
- `research/living_forecast_system.md`
- `research/data/living_dissertation_application_build_plan.md`
- `research/data/private_data_governance.md`
- `research/data/field_dictionary.md`
- `paper/evidence_requirements.md`

## Canonical Source Added

Added:

- `living_dissertation_app/config/living_dissertation_policy.yml`

This file is now the canonical current-value source for:

- forecast-clock cadence;
- scheduled checkpoint quarter counts;
- Sidekiq scheduler cron values;
- production operations defaults;
- private/public export thresholds;
- Operator Node classification V1 defaults.

Docs may describe the meaning of these settings, but current values should be
changed in the policy file first.

## V1 Defaults Set

Set conservative defaults for:

- quarter as the measurement atom;
- V2/V3/V4 scheduled checkpoint quarters;
- weekly source-release checks;
- quarterly measurement checkpoints;
- annual snapshot candidates;
- single-droplet Rails/PostgreSQL/Redis/Sidekiq production model for V1;
- server environment or managed secret store for secrets;
- public and private ingestion disabled by default;
- minimum public-cell threshold;
- one-human Operator Node classification boundary;
- no paid employees or managerial layer inside a qualifying node by default;
- hidden human labor disqualifies a case if undisclosed;
- core human subcontracting disqualifies or reclassifies a case unless
  explicitly partitioned.

These defaults are measurement and operations rules only. They do not support
or prove the thesis.

## App Wiring

Updated `config/sidekiq.yml` so scheduler cron/class/queue/description values
are read from the canonical policy file through Rails `config_for`.

Added tests confirming:

- Sidekiq schedule values match policy values;
- the policy carries V1 defaults for forecast clock, public-cell threshold,
  Operator Node human count, and ingestion-disabled guardrails.

## Verification

- `bin/rails test`
  - Result: passed.
  - Output: 17 runs, 70 assertions, 0 failures, 0 errors, 0 skips.
- `RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false`
  - Result: passed.
  - Output: 67 files inspected, no offenses detected.
- `bundle exec brakeman --no-pager --no-exit-on-warn`
  - Result: passed with no code warnings.
  - Residual warnings: Ruby 3.2.3 support ended on 2026-03-31; Rails 7.2.3.1 support ends on 2026-08-09.
- `git diff --check`
  - Result: passed with no output.
- `git diff -- paper/draft.md`
  - Result: passed with no output.

## Remaining Decision Gaps

- Production provider details remain unchosen: exact droplet size, host path,
  domain, TLS, backups, and restore cadence.
- Admin bootstrap implementation remains undone; policy now specifies the
  default method, but no task exists yet.
- Private ingestion remains disabled by default and still requires the storage,
  backup, restore, access-control, and export-review path to be implemented.
- Operator Node thresholds are V1 defaults, not empirically validated final
  definitions.
