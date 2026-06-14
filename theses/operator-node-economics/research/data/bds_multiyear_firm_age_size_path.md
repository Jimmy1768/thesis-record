# BDS Multi-Year Firm-Age-By-Size Path

Status: schema/source-path record only. Not raw data and not analysis.

Run date: 2026-06-11.

Purpose: identify whether an official multi-year BDS firm-age-by-firm-size path
exists after API `BDSFAGEFSIZE` checks validated only selected 2022 contexts.

## Official Path Found

Official Census BDS datasets page inspected:

- `https://www.census.gov/data/datasets/time-series/econ/bds/bds-datasets.html`

Official CSV path inspected:

- `https://www2.census.gov/programs-surveys/bds/tables/time-series/2023/bds2023_sec_fa_fz.csv`

Official methodology page inspected:

- `https://www.census.gov/programs-surveys/bds/documentation/methodology.html`

Page title/link text:

- Sector by Firm Age by Firm Size

HTTP/header verification:

- HTTP status: 200.
- Content type: `text/csv`.
- Content length: 12,606,118 bytes.
- Last modified: Thu, 25 Sep 2025 12:02:41 GMT.

The CSV was downloaded only to `/tmp` for schema inspection and was not
committed.

## Observed Schema

Header:

```text
year;sector;fage;fsize;firms;estabs;emp;denom;estabs_entry;estabs_entry_rate;estabs_exit;estabs_exit_rate;job_creation;job_creation_births;job_creation_continuers;job_creation_rate_births;job_creation_rate;job_destruction;job_destruction_deaths;job_destruction_continuers;job_destruction_rate_deaths;job_destruction_rate;net_job_creation;net_job_creation_rate;reallocation_rate;firmdeath_firms;firmdeath_estabs;firmdeath_emp
```

Observed coverage:

- Rows excluding header: 104,880.
- Year range: 1978-2023.
- Year count: 46.
- Sector count: 19.
- Firm-age category count: 12.
- Firm-size category count: 10.

## Sector Values

Observed `sector` values:

```text
11;21;22;23;31-33;42;44-45;48-49;51;52;53;54;55;56;61;62;71;72;81
```

## Firm Age Values

Observed `fage` values:

```text
a) 0;b) 1;c) 2;d) 3;e) 4;f) 5;g) 6 to 10;h) 11 to 15;i) 16 to 20;j) 21 to 25;k) 26+;l) Left Censored
```

## Firm Size Values

Observed `fsize` values:

```text
a) 1 to 4;b) 5 to 9;c) 10 to 19;d) 20 to 99;e) 100 to 499;f) 500 to 999;g) 1000 to 2499;h) 2500 to 4999;i) 5000 to 9999;j) 10000+
```

## Compatibility Interpretation

This path closes a multi-year firm-age-by-size source path for:

- Year-sector-firm-age-firm-size cells.
- Employer-side BDS dynamics from 1978 through 2023.
- Sector-level tests using 2017 NAICS sector categories where compatible with
  the BDS 2023 release.

This path does not close:

- Six-digit NAICS firm-age-by-size coverage.
- Subnational firm-age-by-size coverage.
- API `BDSFAGEFSIZE` multi-year coverage.
- Nonemployer-to-employer conversion evidence.
- AI exposure, management-layer, vendor-substitution, or transaction-cost
  evidence.

## Guardrails

- Treat `bds2023_sec_fa_fz.csv` as the official multi-year path for
  sector-level BDS firm-age-by-firm-size work.
- Keep API `BDSFAGEFSIZE` scoped to verified 2022 contexts unless a separate
  API multi-year path is verified.
- Treat `D`, `S`, `X`, and `N` as official publication flags, not numeric zero.
- Do not infer one-human or nonemployer transitions from employer firm age.
- Do not use this file for quantitative findings until acquisition,
  manifesting, cleaning, QA, and analysis are explicitly completed.
