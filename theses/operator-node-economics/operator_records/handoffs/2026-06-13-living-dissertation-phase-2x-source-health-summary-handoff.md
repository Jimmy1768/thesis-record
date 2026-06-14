# Living Dissertation Phase 2X: Source Health Summary Handoff

Date: 2026-06-13.

Scope: add a read-only combined source health service, Rails task, and
dashboard for BFS and SUSB. Do not create prediction links, exports, claim
support, paper prose, or thesis conclusions.

## Task

Implement a combined source health layer that reports:

- source row counts;
- metric-definition counts;
- metric-observation counts;
- quality-review counts;
- unreviewed observation counts;
- policy-check status;
- guardrail flag counts;
- prediction-link counts;
- export-created audit-event counts;
- evidence status.

## Boundaries

- Do not edit `paper/draft.md`.
- Do not write paper prose.
- Do not mutate observations or review rows from summary paths.
- Do not create prediction links.
- Do not create exports.
- Do not create claim support.
- Do not interpret source-health counts as empirical findings.

## Guardrail

The source health summary is infrastructure telemetry only. Context observations
and quality reviews remain claim-neutral until a separate claim-review gate is
designed and explicitly authorized.
