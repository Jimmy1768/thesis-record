# Living Dissertation Phase 3C: BDS Parser Skeleton Handoff

Date: 2026-06-14.

Scope: implement a fixture-only BDS parser skeleton and explicit row-load
policy gate. Keep full-file parser execution, row load, metrics, quality
reviews, exports, prediction links, analysis, and claim support disabled.

## Task

Implement:

- BDS parser policy transition to fixture parser skeleton ready;
- in-memory fixture parser service;
- row-load policy guardrail service;
- Rails tasks for fixture parse and row-load gate verification;
- focused tests and research/operator records.

## Boundaries

- Do not edit `paper/draft.md`.
- Do not load BDS rows.
- Do not run a full-file parser.
- Do not create BDS metric definitions, metric observations, quality reviews,
  prediction links, or exports.
- Do not write paper prose.
- Do not interpret BDS employer dynamics as AI, Operator Node, nonemployer,
  management-layer, transaction-cost, or firm-boundary evidence.
- Do not decide the thesis is true.

## Guardrail

The parser may parse only fixture CSV text in memory. `BdsPublicFileRow.count`
must remain zero at the end of the slice.
