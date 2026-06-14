# Living Dissertation Phase 2Q: BFS Dry-Run Query Handoff

Role: Research / infrastructure.

Scope: validate BFS API query shape and V1 policy filters without storing rows.

## Task

Implement a dry-run BFS query validator.

Create or update:

- BFS dry-run policy values;
- dry-run query validator service;
- `public_sources:bfs:dry_run_query` task;
- focused tests;
- BFS data-architecture docs;
- a return record under `docs/operator/returns/`.

## Required Boundaries

- Do not edit `paper/draft.md`.
- Do not write paper prose.
- Do not store BFS data rows.
- Do not compute metrics.
- Do not run quantitative analysis.
- Do not create public exports.
- Do not create prediction links.
- Do not print the Census API key.
- Do not treat BFS as nonemployer-to-employer conversion evidence.
- Do not convert BFS into AI, Operator Node, transaction-cost, productivity, or
  claim-support evidence.
- Do not add private data, secrets, or credentials.
- Do not push or deploy.

## Return Required

Return with:

- files changed;
- dry-run query shape;
- local dry-run output;
- no-write guardrail result;
- tests and verification commands;
- whether `paper/draft.md` remained untouched;
- whether the slice was committed locally.
