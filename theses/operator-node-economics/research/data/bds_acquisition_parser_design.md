# BDS Acquisition And Parser Design

Status: acquisition design superseded by implemented raw-file validation,
parser dry run, QA policy, and source-row load. Not metric computation,
analysis, claim support, or paper prose.

Date: 2026-06-14.

## Purpose

Define the safe V1 acquisition and parser contract for the official Census BDS
sector by firm age by firm size public file before metrics, review policy, or
analysis are added to the living dissertation app.

The acquisition side now has an implemented validation service recorded in
`research/data/bds_fetch_validation.md`. This still does not create new
empirical evidence.

The parser storage side has a staging-table skeleton recorded in
`research/data/bds_staging_table_skeleton.md` and a source-row load recorded in
`research/data/bds_source_row_load.md`. These rows are source-native context,
not empirical findings.

The parser logic side now has a fixture-only skeleton recorded in
`research/data/bds_parser_skeleton.md`. It parses in memory and persists zero
rows. The same source file now has a full local-file dry run recorded in
`research/data/bds_parser_dry_run.md`; it reports counts and persists zero
rows.

## Policy Source

Current values live in:

- `thesis_record_app/config/thesis_record_policy.yml`
  under `public_ingestion_v1.bds_sector_age_size_public_file`.

Relevant policy sections:

- `acquisition_design_v1`
- `parser_design_v1`

## Acquisition Design

V1 acquisition now authorizes raw-file fetch/validation only:

- status: `fetch_validation_service_ready`;
- raw-file fetch authorized: `true`;
- default execution: validate the existing local ignored file;
- local raw path: `data/raw/bds/2023/bds2023_sec_fa_fz.csv`;
- manifest path: `data/manifests/bds_2023_manifest.csv`;
- raw-file storage zone: `private_file_storage`;
- expected delimiter: comma;
- expected encoding: UTF-8;
- checksum required before parser: true;
- manifest reconciliation required: true;
- expected row count excluding header: 104,880;
- expected year range: 1978-2023.

Required future audit events:

- `collection_started`
- `collection_completed`
- `validation_completed`

Prohibited effects in the acquisition design:

- metric-definition creation;
- metric-observation creation;
- quality-review creation;
- prediction-link creation;
- export creation;
- claim-status change;
- analysis.

## Parser Design

V1 fixture parsing, full-file dry-run parsing, QA policy, and source-row
loading are implemented:

- status: `source_row_load_authorized`;
- staging table: `bds_public_file_rows`;
- staging-table creation authorized: `true`;
- fixture parser authorized: `true`;
- full-file dry run authorized: `true`;
- full-file parser authorized: `true`;
- row load authorized: `true`;
- parser authorized: `true`;
- metric computation authorized: `false`;
- quality reviews authorized: `false`;
- prediction links authorized: `false`;
- exports authorized: `false`;
- claim-status effect: `unchanged`.

Source grain:

- `year`
- `sector`
- `fage`
- `fsize`

Future primary-key candidate:

- `data_source_id`
- `year`
- `sector_code`
- `firm_age_code`
- `firm_size_code`

Flag handling:

- preserve raw cell values;
- extract publication flags before numeric coercion;
- set flagged numeric values to null;
- allowed publication flags: `D`, `S`, `X`, `N`.

## Guardrail Interpretation

BDS remains employer-firm dynamics context only. The design does not measure:

- nonemployers;
- nonemployer-to-employer transitions;
- AI adoption;
- Operator Nodes;
- management layers;
- vendor substitution;
- transaction costs;
- one-person firms;
- firm-boundary conclusions.

## Executable Checks

Rails tasks:

```sh
bin/rails public_sources:bds:verify_acquisition_design
bin/rails public_sources:bds:verify_parser_design
```

The checks fail if acquisition or parser policy drifts toward metrics, exports,
prediction links, analysis, or claim support before a later slice explicitly
authorizes those steps.

## Next Gate

The row-load QA policy gate is recorded in
`research/data/bds_row_load_qa_policy.md`. The source-row load is recorded in
`research/data/bds_source_row_load.md`.

The next BDS implementation slice can define draft-disabled source-native
metric definitions while keeping computation, review rows, exports, prediction
links, analysis, and claim support disabled.
