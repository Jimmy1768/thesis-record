# Living Dissertation Phase 3B: BDS Staging Table Skeleton Handoff

Date: 2026-06-14.

Scope: create the BDS staging-table migration skeleton and parser policy
skeleton. Keep parser execution, row load, metrics, quality reviews, exports,
prediction links, analysis, and claim support disabled.

## Task

Implement:

- BDS `bds_public_file_rows` table skeleton;
- BDS model;
- parser policy transition from no-table design to empty-table skeleton;
- guardrail check requiring the table to exist and remain empty;
- focused tests and research/operator records.

## Boundaries

- Do not edit `paper/draft.md`.
- Do not load BDS rows.
- Do not implement full parser execution.
- Do not create BDS metric definitions, metric observations, quality reviews,
  prediction links, or exports.
- Do not write paper prose.
- Do not interpret BDS employer dynamics as AI, Operator Node, nonemployer,
  management-layer, transaction-cost, or firm-boundary evidence.
- Do not decide the thesis is true.

## Guardrail

The table skeleton is infrastructure only. It defines future storage for
source-native employer-side BDS cells, but `BdsPublicFileRow.count` must remain
zero at the end of this slice.
