# BDS Parser Skeleton

Status: fixture-only parser skeleton implemented. Full-file dry run and
source-row load now exist separately. No metric computation, quality reviews,
exports, prediction links, analysis, claim support, or paper prose.

Date: 2026-06-14.

## Purpose

Define and test the BDS source-native parser contract in memory. The fixture
parser remains a no-write guardrail even after source-row loading.

## App Objects

Rails service:

- `PublicSources::Bds::ParserSkeleton`

Row-load gate:

- `PublicSources::Bds::RowLoadPolicyCheck`

Rails tasks:

```sh
bin/rails public_sources:bds:parse_fixture
bin/rails public_sources:bds:verify_row_load_policy
```

## Parser Behavior

The fixture parser:

- requires `fixture_only: true`;
- parses comma-delimited BDS fixture text;
- validates exact header shape;
- validates sector, firm-age, and firm-size values;
- preserves raw measure values;
- separates numeric measure values from publication flags;
- stores flagged numeric cells as null in the in-memory representation;
- preserves publication flags `D`, `S`, `X`, and `N`;
- computes row hashes from source-native field values;
- returns parsed row objects in memory only.

It does not write to `bds_public_file_rows`.

## Row-Load Gate

Current policy:

- `row_load_gate_v1.status = source_row_load_authorized`;
- `table_must_exist = true`;
- `table_must_remain_empty = false`;
- `parser_fixture_only = true`;
- `full_file_parser_authorized = true`;
- `row_load_authorized = true`;
- `metric_observations_authorized = false`;
- `quality_reviews_authorized = false`;
- `exports_authorized = false`;
- `prediction_links_authorized = false`;
- `claim_status_effect = unchanged`.

Live fixture parse result:

```text
rows_seen=1
rows_persisted=0
bds_public_file_row_count=0
```

## Guardrails

The parser skeleton is infrastructure only. It does not create evidence and
does not support claims. BDS remains employer-firm dynamics context only and
does not measure nonemployers, nonemployer-to-employer transitions, AI
adoption, Operator Nodes, management layers, vendor substitution, transaction
costs, one-person firms, or firm-boundary conclusions.

## Next Gate

The full-file parser dry run now exists; see
`research/data/bds_parser_dry_run.md`. The row-load QA policy gate now exists;
see `research/data/bds_row_load_qa_policy.md`. The source-row load is recorded
in `research/data/bds_source_row_load.md`.
