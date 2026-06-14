# Living Dissertation Phase 3G: BDS Metric Definition Scaffold Handoff

Date: 2026-06-14.

Scope: create draft-disabled BDS source-native metric definitions after the BDS
source-row load. Do not compute observations, create quality reviews, export,
link predictions, analyze trends, or support claims.

## Task

Implement:

- a conservative BDS metric-definition scaffold for source-native count/rate
  fields already loaded in `bds_public_file_rows`;
- policy values under the central living dissertation policy file;
- a guardrail check that keeps definitions draft-disabled;
- tests and research/operator records.

## Required Inputs

- `research/data/bds_source_row_load.md`
- `research/data/bds_row_load_qa_policy.md`
- `research/data/bds_parser_dry_run.md`
- `research/data/schema_mapping.md`
- `living_dissertation_app/app/services/public_sources/bds/load_staging_rows.rb`
- `living_dissertation_app/config/living_dissertation_policy.yml`

## Boundaries

- Do not edit `paper/draft.md`.
- Do not compute BDS metric observations.
- Do not create BDS quality reviews.
- Do not create prediction links.
- Do not create exports.
- Do not write paper prose.
- Do not interpret BDS employer dynamics as AI, Operator Node, nonemployer,
  management-layer, transaction-cost, or firm-boundary evidence.
- Do not decide the thesis is true.

## Guardrail

Metric definitions are labels and formulas only. They must remain
`draft_disabled` and claim-neutral until a later computation and quality-review
slice explicitly authorizes observations and review rows.
