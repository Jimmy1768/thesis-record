# BFS Ingestion Design

Status: staging schema plus one guarded sample-row load. Not metric
computation, quantitative analysis, export, claim support, paper prose, or
thesis evidence.

Run date: 2026-06-13.

## Canonical Defaults

V1 defaults are controlled by:

- `living_dissertation_app/config/living_dissertation_policy.yml`

Policy section:

- `public_ingestion_v1.bfs_monthly_api.ingestion_design_v1`

## V1 Design Decision

The first BFS ingestion design was intentionally narrow:

- API pull: authorized only for the V1 sample load documented in
  `research/data/bfs_sample_row_load.md`;
- data rows: authorized only for raw/staged V1 sample rows;
- metric computation: not authorized;
- analysis: not authorized;
- exports: not authorized;
- prediction links: not authorized;
- claim-status effect: `unchanged`.

## First-Pass Scope

The V1 sample-row load uses this scope:

- geography: U.S. only;
- `seasonally_adj`: `no`;
- target `data_type_code` values only:
  - `BA_BA`
  - `BA_HBA`
  - `BF_BF4Q`
  - `BF_BF8Q`
  - `BF_PBF4Q`
  - `BF_PBF8Q`
- source-native sector/aggregate `category_code` values only;
- exclude `TOTAL`;
- exclude `NONAICS`.

## Staging Table

Table:

- `bfs_api_rows`

Source-native row grain:

- `data_source_id`
- `period_month`
- `data_type_code`
- `category_code`
- `seasonally_adj`
- `geography_level`
- `geography_code`

The table preserves:

- `time_slot_id`
- raw cell value;
- numeric cell value where parseable;
- `error_data`;
- row hash;
- metadata guardrails.

## Rails Task

```sh
bin/rails public_sources:bfs:verify_ingestion_design
```

The task verifies that the design remains staging-only. It no longer requires
zero `BfsApiRow` rows because the V1 sample load is now allowed.

Dry-run query validation is documented in:

- `research/data/bfs_dry_run_query_validation.md`

The dry-run query task validates API shape and V1 filters without storing rows
and remains safe after staged rows exist:

```sh
bin/rails public_sources:bfs:dry_run_query
```

## Sample Row Load

Documented in:

- `research/data/bfs_sample_row_load.md`
- `research/data/bfs_metric_computation_design.md`

The V1 sample load stored 1,368 eligible 2012 monthly U.S.-level BFS rows in
`bfs_api_rows`. The loader preserves raw `cell_value` strings and stores
numeric values only where parseable. Census suppression markers such as `D`
remain raw staged values and are flagged in row metadata.

The metric-computation design remains disabled and does not create metric
definitions, observations, quality reviews, prediction links, exports, or claim
support.

## Remaining Blockers

- No BFS metric computation is authorized yet.
- API geography remains U.S.-only in inspected metadata.
- State/region monthly CSV paths remain outside this API design.
- NAICS panel use remains blocked until source-native BFS categories are mapped
  into an approved analysis panel with aggregation and suppression rules.
- BFS remains only an indirect payroll-transition proxy.

## Guardrail

BFS employer formations are not nonemployer-to-employer conversion evidence.
BFS does not measure AI use, Operator Nodes, one-human firms, nonemployer
survival, hidden contractors, management layers, transaction costs, or
productivity.
