# Living Dissertation Phase 2N: BFS API Scaffold Handoff

Role: Research / infrastructure.

Scope: register Census Business Formation Statistics API metadata as a future
public-source candidate.

## Task

Implement a scaffold-only BFS source registration path.

Create or update:

- centralized policy values for BFS API metadata;
- `PublicSources::Bfs::ApiScaffold`;
- `public_sources:bfs:scaffold` task;
- focused tests;
- BFS data-architecture docs;
- a return record under `docs/operator/returns/`.

## Required Boundaries

- Do not edit `paper/draft.md`.
- Do not write paper prose.
- Do not run quantitative analysis.
- Do not query or store BFS data rows in this slice.
- Do not create metrics.
- Do not create public exports.
- Do not create prediction links.
- Do not treat BFS as nonemployer-to-employer conversion evidence.
- Do not convert BFS into AI, Operator Node, transaction-cost, productivity, or
  claim-support evidence.
- Preserve `data_type_code` and `category_code` blockers.
- Do not add private data, secrets, or credentials.
- Do not push or deploy.

## Return Required

Return with:

- files changed;
- policy values added;
- scaffold behavior;
- blockers preserved;
- tests and verification commands;
- whether `paper/draft.md` remained untouched;
- whether the slice was committed locally.
