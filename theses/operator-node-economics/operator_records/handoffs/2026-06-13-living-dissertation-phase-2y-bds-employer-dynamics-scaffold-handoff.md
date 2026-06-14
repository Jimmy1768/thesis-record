# Living Dissertation Phase 2Y: BDS Employer Dynamics Scaffold Handoff

Date: 2026-06-13.

Scope: add a metadata-only living-dissertation scaffold for the official Census
BDS sector by firm age by firm size public file. This is source architecture,
not acquisition, metric computation, analysis, claim support, or paper prose.

## Task

Implement:

- BDS source metadata in the global living dissertation policy file;
- a Rails service to register the BDS `DataSource`, `SourceAccessPath`,
  `IntakeManifest`, and `SchemaVersion`;
- a policy checker that preserves BDS as metadata-only and claim-neutral;
- Rails tasks for scaffold registration and guardrail verification;
- focused tests and research/operator records.

## Boundaries

- Do not edit `paper/draft.md`.
- Do not fetch the BDS raw CSV in this slice.
- Do not create BDS staging rows.
- Do not create BDS metric definitions, metric observations, quality reviews,
  prediction links, or exports.
- Do not write paper prose.
- Do not interpret BDS employer dynamics as AI, Operator Node, nonemployer,
  management-layer, transaction-cost, or firm-boundary evidence.
- Do not decide the thesis is true.

## Guardrail

BDS remains employer-firm dynamics context only. The official multi-year
sector-age-size public-file path helps future measurement design, but it does
not close six-digit NAICS, subnational age-size, API multi-year, direct
nonemployer, AI exposure, or management-layer evidence gaps.
