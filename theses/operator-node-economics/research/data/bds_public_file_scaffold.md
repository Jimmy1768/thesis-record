# BDS Public File Metadata Scaffold

Status: living-dissertation app scaffold only. Not raw-data acquisition,
metric computation, analysis, claim support, or paper prose.

Date: 2026-06-13.

## Source

Official source path encoded in the living dissertation policy:

- Dataset page:
  `https://www.census.gov/data/datasets/time-series/econ/bds/bds-datasets.html`
- Public file:
  `https://www2.census.gov/programs-surveys/bds/tables/time-series/2023/bds2023_sec_fa_fz.csv`
- Methodology:
  `https://www.census.gov/programs-surveys/bds/documentation/methodology.html`

The source path and schema envelope are reused from the directly inspected
records in:

- `research/data/bds_multiyear_firm_age_size_path.md`
- `research/data/bds_ingestion_readiness.md`
- `research/data/bds_value_sets.md`
- `research/data/bds_coverage_validation.md`

No new source fetch was performed in this slice.

## App Scaffold

Policy source of truth:

- `thesis_record_app/config/thesis_record_policy.yml`
  under `public_ingestion_v1.bds_sector_age_size_public_file`.

Rails services:

- `PublicSources::Bds::PublicFileScaffold`
- `PublicSources::Bds::ScaffoldPolicyCheck`

Rails tasks:

```sh
bin/rails public_sources:bds:scaffold
bin/rails public_sources:bds:verify_scaffold_policy
```

Follow-on design tasks:

```sh
bin/rails public_sources:bds:verify_acquisition_design
bin/rails public_sources:bds:verify_parser_design
bin/rails public_sources:bds:fetch_and_validate
```

The acquisition/parser contract is recorded in
`research/data/bds_acquisition_parser_design.md`.
The implemented raw-file validation record is
`research/data/bds_fetch_validation.md`.
The empty staging-table skeleton is recorded in
`research/data/bds_staging_table_skeleton.md`.
The fixture-only parser skeleton is recorded in
`research/data/bds_parser_skeleton.md`.
The full local-file parser dry run is recorded in
`research/data/bds_parser_dry_run.md`.
The row-load QA policy gate is recorded in
`research/data/bds_row_load_qa_policy.md`.
The source-row load is recorded in
`research/data/bds_source_row_load.md`.

The scaffold registers metadata only:

- `DataSource`
- `SourceAccessPath`
- `IntakeManifest`
- `SchemaVersion`

It does not fetch the raw CSV, store BDS rows, create metric definitions,
create metric observations, create quality reviews, create prediction links,
create exports, or change claim status.

## Encoded Coverage

The scaffold records the official multi-year sector by firm age by firm size
path:

- observed years: 1978-2023;
- row grain: `year`, `sector`, `fage`, `fsize`;
- geography grain: national;
- industry grain: sector;
- observed rows excluding header in prior schema inspection: 104,880;
- publication flags to preserve before numeric coercion: `D`, `S`, `X`, `N`.

## Compatibility Status

| Candidate | Status |
| --- | --- |
| NAICS-year | Sector-year only. |
| Geography-NAICS-year | Blocked for this file because it is national sector-level only. |
| Employer/nonemployer comparison cells | Blocked because BDS has no nonemployer measure. |
| AI exposure cells | Blocked because BDS has no AI field. |
| TCE-P005 management-layer evidence | Blocked because BDS has no management-layer, span-of-control, or support-staff fields. |

## Remaining Blockers

- Six-digit NAICS firm-age-by-size coverage.
- Subnational firm-age-by-size multi-year coverage.
- API `BDSFAGEFSIZE` multi-year coverage.
- Direct employer firm-startup field distinct from establishment entry.
- Explicit row-load authorization, loader implementation, review policy, and
  metric design.
- Acquisition validation, the staging-table skeleton, fixture parser skeleton,
  full local-file parser dry run, row-load QA policy, and source-row load
  exist, but QA rows and metrics remain disabled.
- The staging table contains source-native BDS rows only.
- The fixture-only parser skeleton and full local-file parser dry run remain
  available as guardrails.

## Guardrail

BDS is employer-firm dynamics context only. It does not measure nonemployers,
AI adoption, Operator Nodes, management layers, vendor substitution,
transaction costs, one-person firms, or firm-boundary conclusions.
