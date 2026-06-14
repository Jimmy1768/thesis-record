# SUSB Public-File Ingestion Scaffold

Status: public-file ingestion scaffold. Not raw data fetch, ingestion run,
processed panel, analysis, claim support, paper prose, or thesis evidence.

Run date: 2026-06-12.

## Canonical Defaults

The V1 SUSB public-file scaffold is controlled by:

- `thesis_record_app/config/thesis_record_policy.yml`

Current first public dataset:

- `susb_us_state_annual_public_file`

Current default year:

- `2022`

## What The Scaffold Does

The Rails scaffold can register:

- a `DataSource` for the SUSB U.S./state annual public file;
- a `SourceAccessPath` for the official Census file URL;
- an `IntakeManifest` for the expected public-file metadata;
- a `SchemaVersion` using the verified U.S./state annual record layout;
- audit events for each registry action.

It does not fetch the raw file.

## Rake Task

```sh
bin/rails public_sources:susb:scaffold
```

Optional year:

```sh
SUSB_YEAR=2021 bin/rails public_sources:susb:scaffold
```

The task registers metadata only. Raw files remain outside Git under ignored
paths such as:

```text
data/raw/susb/2022/us_state_6digitnaics_2022.txt
```

## Fetch And Validate Dry Run

```sh
bin/rails public_sources:susb:fetch_and_validate
```

Optional forced re-fetch:

```sh
SUSB_FORCE_FETCH=true bin/rails public_sources:susb:fetch_and_validate
```

The dry-run task:

- fetches the official public file only when missing or explicitly forced;
- writes raw public data only under ignored `data/raw/`;
- computes SHA-256 and byte size;
- validates the exact header;
- validates required fields;
- counts rows excluding the header;
- checks row width;
- checks duplicate `STATE`/`NAICS`/`ENTRSIZE` keys;
- preserves and counts noise flags;
- reconciles against the tracked manifest metadata;
- updates Rails source, access-path, and intake-manifest metadata;
- writes audit events.

It still does not compute metrics or change claim status.

## Metric Definition Scaffold

Draft metric definitions are documented separately in:

- `research/data/susb_metric_definition_scaffold.md`

Those definitions are disabled scaffolds only. They do not authorize metric
observations, aggregation, analysis, exports, or claim support.

## Staging Parser

Source-native SUSB staging parser design is documented in:

- `research/data/susb_staging_parser.md`

The staging parser loads rows into a Rails staging table only. It does not
compute metric observations, aggregate rows, export artifacts, or support
claims.

## Verified Fields

Required fields:

- `STATE`
- `NAICS`
- `ENTRSIZE`
- `FIRM`
- `ESTB`
- `EMPL`
- `PAYR`
- `EMPLFL_N`
- `PAYRFL_N`
- `STATEDSCR`
- `NAICSDSCR`
- `ENTRSIZEDSCR`

Economic-census-year optional fields:

- `RCPT`
- `RCPTFL_N`

## Guardrails

- SUSB is employer-side public source evidence only.
- SUSB does not measure AI adoption.
- SUSB does not measure nonemployers.
- SUSB does not measure transaction costs.
- SUSB does not measure management layers or hierarchy depth.
- SUSB does not measure one-person firms.
- Enterprise-size categories must not be treated as management layers.
- No metric computation is authorized in this scaffold phase.
- No claim-status effect is authorized.
