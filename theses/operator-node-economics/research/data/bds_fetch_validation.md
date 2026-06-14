# BDS Fetch And Validation

Status: living-dissertation raw-file validation implemented. No parser rows,
staging table, metrics, quality reviews, exports, prediction links, analysis,
claim support, or paper prose.

Date: 2026-06-14.

## Source

Official Census BDS public file:

- `https://www2.census.gov/programs-surveys/bds/tables/time-series/2023/bds2023_sec_fa_fz.csv`

Local ignored raw path:

- `data/raw/bds/2023/bds2023_sec_fa_fz.csv`

Committed manifest:

- `data/manifests/bds_2023_manifest.csv`

## App Service

Rails service:

- `PublicSources::Bds::FetchAndValidatePublicFile`

Rails task:

```sh
bin/rails public_sources:bds:fetch_and_validate
```

Default behavior validates the existing ignored local raw file. A force fetch
uses the `BDS_FORCE_FETCH` environment flag, but the completed validation run
did not fetch from the network because the local file already existed.

## Validation Performed

The service validates:

- exact header;
- comma-delimited CSV parsing;
- manifest checksum, byte size, row count, local path, and field list;
- zero bad-width rows;
- zero blank lines;
- zero duplicate rows at `year`, `sector`, `fage`, `fsize`;
- allowed sector, firm-age, and firm-size values;
- publication flags `D`, `S`, `X`, and `N`;
- numeric or official-flag values for measure cells;
- strict expected shape for the full local file.

Live validation result:

```text
fetched_this_run=false
sha256=c4790ccdf964788a8bbc8404349df69db2a7457f8784411a39ddb228dedfbabd
byte_size=12606118
row_count_excluding_header=104880
duplicate_key_count=0
observed_year_range={:start=>1978, :end=>2023}
sector_count=19
firm_age_count=12
firm_size_count=10
manifest_reconciled=true
metric_definitions_created=0
metric_observations_created=0
quality_reviews_created=0
prediction_links_created=0
exports_created=0
```

## Registry Effects

The service updates only metadata registry records:

- `DataSource.source_status = raw_file_validated`;
- `SourceAccessPath.status = fetched_and_validated`;
- `IntakeManifest.manifest_status = raw_file_validated`;
- validation metadata and one validation audit event.

## Guardrails

BDS remains employer-firm dynamics context only. This validation does not
create:

- a BDS staging table;
- BDS source rows;
- metric definitions;
- metric observations;
- quality reviews;
- prediction links;
- exports;
- claim support;
- analysis.

It does not measure nonemployers, nonemployer-to-employer transitions, AI
adoption, Operator Nodes, management layers, vendor substitution, transaction
costs, one-person firms, or firm-boundary conclusions.

## Next Gate

The BDS staging-table skeleton now exists; see
`research/data/bds_staging_table_skeleton.md`. The fixture-only parser skeleton
now exists; see `research/data/bds_parser_skeleton.md`. The full local-file
parser dry run now exists; see `research/data/bds_parser_dry_run.md`. The next
BDS slice can define row-load QA policy, cleanup/rollback behavior, and review
policy, but full row load should remain separately gated unless those controls
are ready.
