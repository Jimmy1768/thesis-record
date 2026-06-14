# Living Dissertation Phase 2Z: BDS Acquisition Parser Design Handoff

Date: 2026-06-14.

Scope: add design-only guardrails for BDS raw-file acquisition and parser
architecture. This is not data acquisition, parser execution, metric
computation, analysis, claim support, or paper prose.

## Task

Implement:

- BDS acquisition design policy values under the global living dissertation
  policy;
- BDS parser design policy values under the same source-of-truth file;
- executable guardrail checks for both designs;
- Rails tasks to run the checks;
- focused tests and research/operator records.

## Boundaries

- Do not edit `paper/draft.md`.
- Do not fetch the BDS raw CSV.
- Do not create a BDS staging table.
- Do not load BDS rows.
- Do not create BDS metric definitions, metric observations, quality reviews,
  prediction links, or exports.
- Do not write paper prose.
- Do not interpret BDS employer dynamics as AI, Operator Node, nonemployer,
  management-layer, transaction-cost, or firm-boundary evidence.
- Do not decide the thesis is true.

## Guardrail

The design should make the next implementation path clearer while keeping all
evidence effects disabled. The future BDS parser must preserve raw cell values,
extract publication flags before numeric coercion, treat flagged numeric values
as null unless later policy changes this, and keep BDS employer-side context
separate from nonemployer and AI evidence.
