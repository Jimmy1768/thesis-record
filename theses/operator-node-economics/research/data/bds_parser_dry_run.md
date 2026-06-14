# BDS Parser Dry Run

Status: full local-file parser dry-run implemented. No row load, metric
computation, quality reviews, exports, prediction links, analysis, claim
support, or paper prose.

Date: 2026-06-14.

## Purpose

Read the validated local BDS CSV through the parser logic and report source
shape, coverage, duplicate-key, numeric-cell, and publication-flag counts
without inserting rows into `bds_public_file_rows`.

## App Objects

Rails service:

- `PublicSources::Bds::ParserDryRun`

Rails task:

```sh
bin/rails public_sources:bds:dry_run_parser
```

## Live Dry-Run Result

```text
rows_seen=104880
rows_parsed=104880
rows_persisted=0
bad_width_rows=0
blank_lines=0
duplicate_key_count=0
observed_year_range={:start=>1978, :end=>2023}
sector_count=19
firm_age_count=12
firm_size_count=10
numeric_cell_count=1668177
publication_flag_totals={"D"=>252783, "S"=>0, "X"=>492480, "N"=>103680}
bds_public_file_row_count=104880
metric_observations_created=0
quality_reviews_created=0
prediction_links_created=0
exports_created=0
```

## Interpretation

This is parser-readiness evidence only. It confirms that the local BDS file can
be read through the parser shape and that the row grain has zero duplicate keys
in the dry run. It does not create empirical observations, trends, ratios,
prediction links, or claim support.

The publication-flag totals are source-cell QA counts, not business outcomes.

## Guardrails

- The dry run reads the full local file.
- It does not insert into `bds_public_file_rows`.
- It does not create metric definitions or metric observations.
- It does not create quality reviews.
- It does not create exports.
- It does not create prediction links.
- It does not support claims.
- BDS remains employer-firm dynamics context only.

## Next Gate

The source-row load is recorded in `research/data/bds_source_row_load.md`.
The next slice can define draft-disabled BDS source-native metric definitions.
