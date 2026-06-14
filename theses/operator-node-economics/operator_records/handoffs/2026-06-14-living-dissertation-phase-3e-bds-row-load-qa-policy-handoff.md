# Living Dissertation Phase 3E: BDS Row-Load QA Policy Handoff

Date: 2026-06-14.

Scope: define the BDS row-load QA policy and explicit authorization checks
after the full local-file parser dry run. Keep actual row loading, metrics,
quality reviews, exports, prediction links, analysis, and claim support
disabled unless this slice explicitly authorizes only the policy gate.

## Task

Implement:

- BDS row-load QA policy values under
  `living_dissertation_app/config/living_dissertation_policy.yml`;
- a Rails guardrail check that fails unless row-load prerequisites are explicit;
- documented cleanup/rollback expectations for any future BDS row load;
- tests proving actual row load remains disabled;
- research/operator records for the policy gate.

## Required Inputs

- `research/data/bds_parser_dry_run.md`
- `research/data/bds_parser_skeleton.md`
- `research/data/bds_staging_table_skeleton.md`
- `research/data/bds_acquisition_parser_design.md`
- `living_dissertation_app/app/services/public_sources/bds/parser_dry_run.rb`
- `living_dissertation_app/config/living_dissertation_policy.yml`

## Boundaries

- Do not edit `paper/draft.md`.
- Do not load BDS rows.
- Do not create metric definitions or metric observations.
- Do not create quality reviews.
- Do not create prediction links.
- Do not create exports.
- Do not write paper prose.
- Do not interpret BDS employer dynamics as AI, Operator Node, nonemployer,
  management-layer, transaction-cost, or firm-boundary evidence.
- Do not decide the thesis is true.

## Guardrail

The next slice should only make the future row load auditable. It should not
turn the dry run into persistence. `BdsPublicFileRow.count` must remain zero at
the end of the slice.
