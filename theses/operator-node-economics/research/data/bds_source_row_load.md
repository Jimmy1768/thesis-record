# BDS Source Row Load

Status: source-native BDS rows loaded into PostgreSQL staging. Not metric
definition creation, metric observation creation, quality review, export,
prediction-link creation, analysis, claim support, or paper prose.

Date: 2026-06-14.

## Purpose

Load the official Census BDS sector by firm age by firm size public file into
`bds_public_file_rows` so later slices can define source-native metric
definitions and review policy against database rows instead of flat files.

This is not quantitative analysis.

## Rails Objects

Service:

- `PublicSources::Bds::LoadStagingRows`

Task:

```sh
bin/rails public_sources:bds:load_staging
```

## Live Load Result

```text
local_path=/Users/jimmy1768/Projects/operator-node-economics/data/raw/bds/2023/bds2023_sec_fa_fz.csv
rows_read=104880
rows_inserted=104880
rows_deleted_before_load=0
metric_definitions_created=0
metric_observations_created=0
quality_reviews_created=0
prediction_links_created=0
exports_created=0
```

Post-load reconciliation:

```text
BdsPublicFileRow.count=104880
policy_check_passed=true
bds_metric_observation_count=0
bds_quality_review_count=0
bds_prediction_link_count=0
```

## Load Controls

The loader:

- validates the raw file and manifest before loading;
- requires the row-load QA policy in
  `research/data/bds_row_load_qa_policy.md`;
- deletes existing BDS rows for the same source inside the load transaction;
- inserts source-native rows in batches;
- preserves raw measure values;
- preserves publication flags before numeric coercion;
- stores flagged numeric cells as null;
- stores source row hashes;
- stores a load ID in row metadata;
- verifies the final source-row count.

The transaction rolls back delete and insert work if loading or reconciliation
fails.

## Boundary

BDS rows are employer-firm dynamics context only. They do not measure AI
adoption, nonemployers, hidden contractors, management layers, transaction
costs, Operator Nodes, one-person firms, or firm-boundary change.

The load does not authorize:

- metric definitions;
- metric observations;
- quality reviews;
- prediction links;
- exports;
- aggregation;
- trends;
- ratios;
- claim support.

## Next Gate

Draft-disabled BDS source-native metric definitions are recorded in
`research/data/bds_metric_definition_scaffold.md`.

The next slice can define BDS metric-computation design. It should not compute
observations until source-native eligibility, null/flag handling, quality
metadata, and review policy are specified.
