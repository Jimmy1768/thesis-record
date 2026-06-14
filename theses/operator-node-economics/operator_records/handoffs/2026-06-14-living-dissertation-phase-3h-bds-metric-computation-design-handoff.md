# Living Dissertation Phase 3H: BDS Metric Computation Design Handoff

Date: 2026-06-14.

Scope: define BDS metric-computation design after draft-disabled metric
definitions exist. Do not compute observations yet unless the design explicitly
adds and verifies a no-claim, source-native computation gate.

## Task

Implement a conservative design for computing BDS source-native context
observations from `bds_public_file_rows`.

The design must specify:

- eligible metric keys;
- source row eligibility;
- handling for null numeric cells and publication flags `D`, `S`, `X`, `N`;
- required quality metadata;
- blocked outputs;
- review-policy dependency;
- guardrail tests.

## Boundaries

- Do not edit `paper/draft.md`.
- Do not create prediction links.
- Do not create exports.
- Do not write paper prose.
- Do not interpret BDS employer dynamics as AI, Operator Node, nonemployer,
  management-layer, transaction-cost, or firm-boundary evidence.
- Do not decide the thesis is true.

## Guardrail

BDS observations, if later computed, must remain source-native context only
until quality reviews and claim-review gates are separately implemented.
