# Living Dissertation Phase 2P: BFS Ingestion Design Handoff

Role: Research / infrastructure.

Scope: add BFS ingestion design and staging schema without API pull or row
loading.

## Task

Implement a conservative BFS staging-schema design.

Create or update:

- centralized BFS ingestion-design policy;
- `bfs_api_rows` staging-table migration;
- `BfsApiRow` model;
- BFS ingestion-design checker and task;
- focused tests;
- BFS data-architecture docs;
- a return record under `docs/operator/returns/`.

## Required Boundaries

- Do not edit `paper/draft.md`.
- Do not write paper prose.
- Do not query the BFS API for data rows.
- Do not load BFS rows.
- Do not compute metrics.
- Do not run quantitative analysis.
- Do not create public exports.
- Do not create prediction links.
- Do not treat BFS as nonemployer-to-employer conversion evidence.
- Do not convert BFS into AI, Operator Node, transaction-cost, productivity, or
  claim-support evidence.
- Preserve geography, seasonality, aggregate-category, and harmonization
  guardrails.
- Do not add private data, secrets, or credentials.
- Do not push or deploy.

## V1 Design Defaults

- geography: U.S. only;
- seasonality: `seasonally_adj=no`;
- target series only: `BA_BA`, `BA_HBA`, `BF_BF4Q`, `BF_BF8Q`, `BF_PBF4Q`,
  `BF_PBF8Q`;
- exclude spliced/duration series;
- exclude `TOTAL`;
- exclude `NONAICS`;
- store source-native category codes, not harmonized NAICS claims.

## Return Required

Return with:

- files changed;
- schema added;
- policy defaults;
- task behavior;
- blockers preserved;
- tests and verification commands;
- whether `paper/draft.md` remained untouched;
- whether the slice was committed locally.
