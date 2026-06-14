# BDS Staging Table Skeleton

Status: living-dissertation database skeleton implemented and populated with
source-native BDS rows. No metric computation, quality reviews, exports,
prediction links, analysis, claim support, or paper prose.

Date: 2026-06-14.

## Purpose

Create the database table shape needed for BDS source-native rows. This is
infrastructure only.

## App Objects

Migration:

- `living_dissertation_app/db/migrate/20260614043000_create_bds_public_file_rows.rb`

Model:

- `BdsPublicFileRow`

Policy source:

- `thesis_record_app/config/thesis_record_policy.yml`
  under `public_ingestion_v1.bds_sector_age_size_public_file.parser_design_v1`.

## Table

Table name:

- `bds_public_file_rows`

Required identifiers:

- `data_source_id`
- `intake_manifest_id`
- `schema_version_id`
- `source_row_number`
- `year`
- `sector_code`
- `firm_age_code`
- `firm_size_code`

Source-value storage:

- `raw_measure_values` JSONB;
- `numeric_measure_values` JSONB;
- `publication_flags` JSONB;
- `row_hash`;
- `metadata` JSONB.

Unique grain:

- `data_source_id`
- `year`
- `sector_code`
- `firm_age_code`
- `firm_size_code`

Supporting index:

- `year`, `sector_code`

## Guardrails

Current parser policy:

- `status = source_row_load_authorized`;
- `staging_table_creation_authorized = true`;
- `row_load_authorized = true`;
- `parser_authorized = true`;
- `metric_computation_authorized = false`;
- `quality_reviews_authorized = false`;
- `analysis_authorized = false`;
- `exports_authorized = false`;
- `prediction_links_authorized = false`;
- `claim_status_effect = unchanged`.

Executable guardrail:

```sh
bin/rails public_sources:bds:verify_parser_design
```

Current live table count:

```text
BdsPublicFileRow.count = 104880
```

## Interpretation Boundary

The table is source-row storage only. It does not measure nonemployers,
nonemployer-to-employer transitions, AI adoption, Operator Nodes, management
layers, vendor substitution, transaction costs, one-person firms, or
firm-boundary conclusions.

## Parser Skeleton

The fixture-only parser skeleton now exists; see
`research/data/bds_parser_skeleton.md`. The source-row load is recorded in
`research/data/bds_source_row_load.md`.

## Next Gate

The full-file parser dry run now exists; see
`research/data/bds_parser_dry_run.md`. The row-load QA policy gate now exists;
see `research/data/bds_row_load_qa_policy.md`. The next gate is
draft-disabled BDS source-native metric definitions.
