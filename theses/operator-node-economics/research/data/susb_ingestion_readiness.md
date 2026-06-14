# SUSB CSV Ingestion Readiness

Status: ingestion-readiness record only. Not an ingestion script and not
analysis.

Run date: 2026-06-11.

Purpose: define safe parsing and QA rules for the official Census SUSB 2022
U.S./state 6-digit NAICS CSV before any transformation or analysis.

## Input File

Tracked manifest:

- `data/manifests/susb_2022_manifest.csv`

Ignored local raw file:

- `data/raw/susb/2022/us_state_6digitnaics_2022.txt`

Official source:

- `https://www2.census.gov/programs-surveys/susb/tables/2022/us_state_6digitnaics_2022.txt`

Official record layout inspected:

- `https://www2.census.gov/programs-surveys/susb/technical-documentation/record_layout_us_and_state_2007_to_present.txt`

## Observed Structural QA

Raw-file checks:

- Rows excluding header: 570,105.
- Column count: 14.
- Rows with unexpected column count: 0.
- Blank lines: 0.
- Duplicate `STATE`/`NAICS`/`ENTRSIZE` keys: 0.
- State-code count: 52.
- NAICS-code count: 2,003.
- Enterprise-size category count: 9.

These checks confirm file shape only. They do not compute empirical findings.

## Required Columns

Primary key candidate:

- `STATE`
- `NAICS`
- `ENTRSIZE`

Measure columns:

- `FIRM`
- `ESTB`
- `EMPL`
- `PAYR`
- `RCPT`

Noise-flag columns:

- `EMPLFL_N`
- `PAYRFL_N`
- `RCPTFL_N`

Label columns:

- `STATEDSCR`
- `NAICSDSCR`
- `ENTRSIZEDSCR`

## Enterprise-Size Values Observed

| `ENTRSIZE` | `ENTRSIZEDSCR` |
| --- | --- |
| `01` | `01: Total` |
| `02` | `02: <5` |
| `03` | `03: 5-9` |
| `26` | `04: 10-19` |
| `33` | `05: <20` |
| `34` | `06: 20-99` |
| `35` | `07: 100-499` |
| `37` | `08: <500` |
| `36` | `09: 500+` |

## Noise-Flag Handling

The official U.S./state record layout defines `EMPLFL_N` as the employment
noise flag, `PAYRFL_N` as the payroll noise flag, and `RCPTFL_N` as the
receipts noise flag. For `EMPLFL_N`, the layout defines:

- `G`: low noise applied to cell value.
- `H`: medium noise applied to cell value.
- `J`: high noise applied to cell value.
- `D`: data withheld and value set to 0 to avoid disclosure of individual
  businesses; data are included in higher-level totals.
- `S`: data withheld and value set to 0 because data do not meet publication
  standards; data are included in higher-level totals.

The same record layout names `PAYRFL_N` and `RCPTFL_N` as payroll and receipts
noise flags. Treat the same flag-preservation rules as applying to those flag
columns unless a later official layout says otherwise for a specific extract.

Parser rules:

- Preserve `EMPLFL_N`, `PAYRFL_N`, and `RCPTFL_N` before numeric coercion.
- Treat `G`, `H`, and `J` as noise-quality flags, not as numeric values.
- Treat any observed `D` or `S` as withheld cells whose numeric value may be
  set to 0 in the publication but should not be interpreted as a true zero.
- Do not impute withheld or high-noise cells in ingestion.
- Do not combine rows, compare size classes, or compute ratios without a
  declared flag-propagation rule.
- Carry `year=2022` from the file vintage; no year column is present in this
  extract.

Observed in `us_state_6digitnaics_2022.txt`:

- `G`, `H`, and `J` appear in all three noise-flag columns.
- `D` and `S` were not observed in this file but remain official flag values
  and must be handled.
- `EMPLFL_R` is absent from this 2022 file, consistent with the record-layout
  note that it is no longer used starting with 2018.

## Marker Counts By Column

These are QA counts of publication flags, not business outcomes.

| Column | G | H | J | D | S |
| --- | ---: | ---: | ---: | ---: | ---: |
| `EMPLFL_N` | 277,234 | 167,925 | 124,946 | 0 | 0 |
| `PAYRFL_N` | 332,347 | 170,712 | 67,046 | 0 | 0 |
| `RCPTFL_N` | 313,670 | 181,566 | 74,869 | 0 | 0 |

Numeric measure QA:

| Column | Non-numeric values observed |
| --- | ---: |
| `FIRM` | 0 |
| `ESTB` | 0 |
| `EMPL` | 0 |
| `PAYR` | 0 |
| `RCPT` | 0 |

## Minimum Future Ingestion QA

Before creating any processed panel:

- Verify SHA-256 against `data/manifests/susb_2022_manifest.csv`.
- Verify the exact header and column count.
- Verify zero bad-width rows.
- Verify `STATE`, `NAICS`, and `ENTRSIZE` form the expected row grain.
- Verify no duplicate rows at the intended key.
- Preserve all noise flags in separate fields.
- Convert measure columns to numeric nullable fields only after flag capture.
- Treat `RCPT` as an economic-census-year receipts field; this 2022 file has
  receipts, but intervening annual files may not.
- Carry `year=2022` from file metadata unless a future extract contains a
  verified year field.

## Companion File Decision

The companion SUSB detailed-size file was not downloaded in this slice.

The current U.S./state 6-digit NAICS file already contains the verified
enterprise-size classes listed above. A future architecture pass should pull
the detailed-size file only if narrower enterprise-size categories are needed
for a specific prediction design.

## Guardrails

- This record does not authorize analysis.
- This SUSB file is employer-establishment and employer-firm evidence only.
- It does not measure nonemployers, AI adoption, transaction costs,
  management layers, vendor substitution, contractor use, or one-person firms.
- Enterprise-size classes are not hierarchy-depth measures and do not support
  TCE-P005.
