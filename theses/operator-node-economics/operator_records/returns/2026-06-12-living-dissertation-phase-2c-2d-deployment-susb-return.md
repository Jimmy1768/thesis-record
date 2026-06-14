# Living Dissertation Phase 2C/2D Deployment And SUSB Scaffold Return

## Status

Completed.

## Files Changed

- `.gitignore`
- `docs/operator/handoffs/2026-06-12-living-dissertation-phase-2c-2d-deployment-susb-handoff.md`
- `docs/operator/returns/2026-06-12-living-dissertation-phase-2c-2d-deployment-susb-return.md`
- `living_dissertation_app/.env.production.example`
- `living_dissertation_app/app/services/operations/health_check.rb`
- `living_dissertation_app/app/services/public_sources/susb/public_file_scaffold.rb`
- `living_dissertation_app/config/deploy/systemd/living-dissertation-sidekiq.service.example`
- `living_dissertation_app/config/deploy/systemd/living-dissertation-web.service.example`
- `living_dissertation_app/config/living_dissertation_policy.yml`
- `living_dissertation_app/lib/tasks/operator.rake`
- `living_dissertation_app/lib/tasks/public_sources.rake`
- `living_dissertation_app/test/services/operations/health_check_test.rb`
- `living_dissertation_app/test/services/public_sources/susb/public_file_scaffold_test.rb`
- `research/data/living_dissertation_application_build_plan.md`
- `research/data/living_dissertation_deployment_readiness.md`
- `research/data/susb_public_file_ingestion_scaffold.md`

## Phase 2C Implementation Summary

Added deployment-readiness scaffold:

- production environment example with variable names only;
- systemd web service template;
- systemd Sidekiq service template;
- deployment-readiness runbook;
- operations health-check service;
- `bin/rails operator:health_check` task.

The health-check service verifies:

- Rails boot;
- database connection;
- Redis ping;
- Sidekiq schedule config load;
- operations policy guardrails.

The live Redis check was not run to completion because local Redis did not
respond to `redis-cli ping` and the command was interrupted. The health-check
behavior is covered by unit tests with an injected Redis client. Actual Redis
health verification belongs on the deployed host.

## Phase 2D Implementation Summary

Added SUSB public-file ingestion scaffold:

- `PublicSources::Susb::PublicFileScaffold`;
- `bin/rails public_sources:susb:scaffold`;
- SUSB scaffold tests;
- SUSB public-file scaffold runbook.

The scaffold registers metadata only:

- `DataSource`;
- `SourceAccessPath`;
- `IntakeManifest`;
- `SchemaVersion`;
- audit events.

It does not fetch the raw SUSB file, compute metrics, transform data, or change
claim status.

## V1 Defaults Used

From `living_dissertation_app/config/living_dissertation_policy.yml`:

- Linux user: `operator-node`;
- deploy path: `/var/www/operator-node-economics/living_dissertation_app`;
- env file path: `/etc/operator-node-economics/living-dissertation.env`;
- process supervision: systemd or equivalent;
- web unit: `living-dissertation-web.service`;
- worker unit: `living-dissertation-sidekiq.service`;
- first public dataset: `susb_us_state_annual_public_file`;
- default SUSB year: `2022`;
- SUSB source URL:
  `https://www2.census.gov/programs-surveys/susb/tables/2022/us_state_6digitnaics_2022.txt`;
- SUSB record layout URL:
  `https://www2.census.gov/programs-surveys/susb/technical-documentation/record_layout_us_and_state_2007_to_present.txt`;
- public file fetch disabled by default;
- metric computation disabled by default;
- claim-status effect: `unchanged`;
- raw public file Git storage not allowed.

## SUSB Guardrails Preserved

- SUSB is employer-side public source evidence only.
- SUSB does not measure AI adoption.
- SUSB does not measure nonemployers.
- SUSB does not measure transaction costs.
- SUSB does not measure management layers or hierarchy depth.
- SUSB does not measure one-person firms.
- Enterprise-size categories are not management layers.
- No SUSB metric computation is authorized in this scaffold phase.
- No claim-status effect is authorized.

## Verification

- `bin/rails test`
  - Result: passed.
  - Output: 29 runs, 119 assertions, 0 failures, 0 errors, 0 skips.
- `bin/rails operator:verify_operations_policy`
  - Result: passed.
  - Output: `Operations policy guardrails passed`.
- `redis-cli ping`
  - Result: interrupted after no local response.
  - Interpretation: local Redis runtime was not available for live ping; host
    health check remains a deployment verification step.
- `RUBOCOP_CACHE_ROOT=tmp/rubocop_cache bin/rubocop --cache false`
  - Result: passed.
  - Output: 77 files inspected, no offenses detected.
- `bundle exec brakeman --no-pager --no-exit-on-warn`
  - Result: passed with no code warnings.
  - Residual warnings: Ruby 3.2.3 support ended on 2026-03-31; Rails 7.2.3.1 support ends on 2026-08-09.
- `git diff --check`
  - Result: passed with no output.
- `git diff -- paper/draft.md`
  - Result: passed with no output.
- Changed-path secret scan:
  - Command: `rg -n "(BEGIN (RSA|OPENSSH|PRIVATE) KEY|DATABASE_URL=.+|SECRET_KEY_BASE=.+|REDIS_URL=.+|postgres://[^\\s]+:[^\\s]+@|sk-[A-Za-z0-9]{20,}|AIza[0-9A-Za-z_-]{20,}|AKIA[0-9A-Z]{16})" .gitignore docs/operator/handoffs/2026-06-12-living-dissertation-phase-2c-2d-deployment-susb-handoff.md living_dissertation_app research/data/living_dissertation_application_build_plan.md research/data/living_dissertation_deployment_readiness.md research/data/susb_public_file_ingestion_scaffold.md`
  - Result: passed with no matches.

## Private Data, Raw Files, And Secrets

- No raw SUSB file was fetched.
- No public dataset file was downloaded.
- No private data was ingested.
- No production database connection was used.
- No secrets, database URLs, API keys, SSH keys, private keys, or production
  env values were added.
- `.env.production.example` contains names and blank placeholders only.

## Paper Boundary

- `paper/draft.md` remained untouched.
- No paper prose, thesis conclusion, claim promotion, or publication text was
  added.

## Remaining Gaps Before Public Ingestion Is Actually Enabled

- Deploy host is not provisioned.
- Redis is not verified locally or on a host.
- TLS/domain setup is not implemented.
- Encrypted backup destination and restore-test record do not exist.
- Production admin has not been bootstrapped.
- SUSB scaffold has not fetched a raw file.
- No checksum has been calculated for a newly fetched file.
- No raw-file parser or row validator has been connected to the Rails app.
- No metric computation, export review, or claim review has been authorized.
