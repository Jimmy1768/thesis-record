# BDS CSV Ingestion Readiness

Status: ingestion-readiness record only. Not an ingestion script and not
analysis.

Run date: 2026-06-11.

Purpose: define safe parsing and QA rules for the official Census BDS 2023
sector by firm age by firm size CSV before any transformation or analysis.

## Input File

Tracked manifest:

- `data/manifests/bds_2023_manifest.csv`

Ignored local raw file:

- `data/raw/bds/2023/bds2023_sec_fa_fz.csv`

Official source:

- `https://www2.census.gov/programs-surveys/bds/tables/time-series/2023/bds2023_sec_fa_fz.csv`

Official methodology page inspected:

- `https://www.census.gov/programs-surveys/bds/documentation/methodology.html`

## Observed Structural QA

Raw-file checks:

- Rows excluding header: 104,880.
- Column count: 28.
- Rows with unexpected column count: 0.
- Year count: 46.
- Observed year range: 1978-2023.
- Sector count: 19.
- Firm-age category count: 12.
- Firm-size category count: 10.

These checks confirm file shape only. They do not compute empirical findings.

## Required Columns

Primary key candidate:

- `year`
- `sector`
- `fage`
- `fsize`

Measure columns:

- `firms`
- `estabs`
- `emp`
- `denom`
- `estabs_entry`
- `estabs_entry_rate`
- `estabs_exit`
- `estabs_exit_rate`
- `job_creation`
- `job_creation_births`
- `job_creation_continuers`
- `job_creation_rate_births`
- `job_creation_rate`
- `job_destruction`
- `job_destruction_deaths`
- `job_destruction_continuers`
- `job_destruction_rate_deaths`
- `job_destruction_rate`
- `net_job_creation`
- `net_job_creation_rate`
- `reallocation_rate`
- `firmdeath_firms`
- `firmdeath_estabs`
- `firmdeath_emp`

## Category Values

Allowed `sector` values:

```text
11;21;22;23;31-33;42;44-45;48-49;51;52;53;54;55;56;61;62;71;72;81
```

Allowed `fage` values:

```text
a) 0;b) 1;c) 2;d) 3;e) 4;f) 5;g) 6 to 10;h) 11 to 15;i) 16 to 20;j) 21 to 25;k) 26+;l) Left Censored
```

Allowed `fsize` values:

```text
a) 1 to 4;b) 5 to 9;c) 10 to 19;d) 20 to 99;e) 100 to 499;f) 500 to 999;g) 1000 to 2499;h) 2500 to 4999;i) 5000 to 9999;j) 10000+
```

## Publication Flag Handling

Official BDS methodology states that cells with fewer than three firms are
flagged `D`; cells with identified data-quality concerns are flagged `S`;
structurally missing or zero cells are flagged `X`; and rate cells that cannot
be calculated are flagged `N`.

Parser rules:

- Treat `D`, `S`, `X`, and `N` as structured flags, not numeric zero.
- Preserve a per-cell flag value before any numeric coercion.
- Coerce flagged measure cells to null in numeric columns unless a later
  analysis plan explicitly chooses a different treatment.
- Do not impute suppressed, structurally missing, or non-calculable cells in
  ingestion.
- Do not combine rates or counts without first defining how flags propagate.

Observed in `bds2023_sec_fa_fz.csv`:

- `D` appears in count and rate columns.
- `X` appears in count and rate columns.
- `N` appears in rate columns.
- `S` was not observed in this file but remains an official flag and must be
  handled.

## Marker Counts By Column

These are QA counts of publication flags, not business outcomes.

| Column | D | X | N |
| --- | ---: | ---: | ---: |
| `firms` | 8,235 | 16,150 | 0 |
| `estabs` | 8,235 | 16,150 | 0 |
| `emp` | 8,235 | 16,150 | 0 |
| `denom` | 8,500 | 16,150 | 0 |
| `estabs_entry` | 17,404 | 16,150 | 0 |
| `estabs_entry_rate` | 17,404 | 16,150 | 14,748 |
| `estabs_exit` | 15,247 | 24,890 | 0 |
| `estabs_exit_rate` | 15,247 | 24,890 | 11,172 |
| `job_creation` | 8,235 | 16,150 | 0 |
| `job_creation_births` | 17,404 | 16,150 | 0 |
| `job_creation_continuers` | 7,871 | 24,890 | 0 |
| `job_creation_rate_births` | 17,404 | 16,150 | 14,748 |
| `job_creation_rate` | 8,235 | 16,150 | 14,748 |
| `job_destruction` | 7,829 | 24,890 | 0 |
| `job_destruction_deaths` | 15,247 | 24,890 | 0 |
| `job_destruction_continuers` | 7,871 | 24,890 | 0 |
| `job_destruction_rate_deaths` | 15,247 | 24,890 | 11,172 |
| `job_destruction_rate` | 7,829 | 24,890 | 11,172 |
| `net_job_creation` | 8,500 | 16,150 | 0 |
| `net_job_creation_rate` | 8,500 | 16,150 | 14,748 |
| `reallocation_rate` | 7,559 | 24,890 | 11,172 |
| `firmdeath_firms` | 5,515 | 24,890 | 0 |
| `firmdeath_estabs` | 5,515 | 24,890 | 0 |
| `firmdeath_emp` | 5,515 | 24,890 | 0 |

## Minimum Future Ingestion QA

Before creating any processed panel:

- Verify SHA-256 against `data/manifests/bds_2023_manifest.csv`.
- Verify the exact header and column count.
- Verify zero bad-width rows.
- Verify allowed `sector`, `fage`, and `fsize` values.
- Preserve raw flag values in separate flag columns.
- Convert measure columns to numeric nullable fields only after flag extraction.
- Confirm `year`, `sector`, `fage`, and `fsize` form the expected row grain.
- Confirm no duplicate rows at the intended key before analysis.

## Related Official BDS Paths Not Pulled

The official BDS datasets page exposes additional CSVs that may be useful in
future architecture passes:

- `bds2023_fa_fz.csv`: Firm Age by Firm Size.
- `bds2023_vcn3_fa.csv`: 3-digit NAICS by Firm Age.
- `bds2023_vcn3_fz.csv`: 3-digit NAICS by Firm Size.
- `bds2023_vcn4_fa.csv`: 4-digit NAICS by Firm Age.
- `bds2023_vcn4_fz.csv`: 4-digit NAICS by Firm Size.
- `bds2023_st_sec_fa.csv`: State by Sector by Firm Age.
- `bds2023_st_sec_fz.csv`: State by Sector by Firm Size.

These paths were not downloaded in this slice. They do not change the current
manifested input.

## Guardrails

- This record does not authorize analysis.
- This BDS file is employer-firm evidence only.
- It does not measure nonemployers, AI adoption, transaction costs,
  management layers, vendor substitution, or one-person firms.
- Sector-age-size cells are not direct evidence for the Operator Node
  hypothesis.
