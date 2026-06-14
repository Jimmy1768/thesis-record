# Living Dissertation Phase 3A: BDS Fetch Validation Handoff

Date: 2026-06-14.

Scope: implement BDS raw public-file fetch/validation service for the official
Census BDS sector by firm age by firm size CSV. Keep parser execution, staging
rows, metrics, quality reviews, exports, prediction links, analysis, and claim
support disabled.

## Task

Implement:

- policy update from BDS acquisition design-only to fetch/validation service
  ready;
- BDS fetch/validation service;
- Rails task for validation;
- focused tests;
- research/operator records documenting the live validation result.

## Boundaries

- Do not edit `paper/draft.md`.
- Do not create a BDS staging table.
- Do not load BDS rows.
- Do not create BDS metric definitions, metric observations, quality reviews,
  prediction links, or exports.
- Do not write paper prose.
- Do not interpret BDS employer dynamics as AI, Operator Node, nonemployer,
  management-layer, transaction-cost, or firm-boundary evidence.
- Do not decide the thesis is true.

## Guardrail

This slice may validate the ignored local raw public file and update source
metadata, but it must not create claim-relevant evidence. BDS remains
employer-firm dynamics context only until a later parser, QA, metric, and
claim-review gate is explicitly implemented.
