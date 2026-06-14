# BDS Coverage Validation

Status: schema coverage record only. Not raw data and not analysis.

Run date: 2026-06-11.

Purpose: validate the coverage envelope for `BDSFAGEFSIZE` before any full BDS
age/size pull. These checks inspected official Census API responses for row
shape, headers, geography support, year availability, and NAICS code coverage.
They did not compute outcomes, trends, rates, shares, rankings, or prediction
results.

## Access Pattern

All data-row checks used the observed key-first query construction:

```text
https://api.census.gov/data/timeseries/bds?key=${CENSUS_API_KEY}&...
```

The API key was loaded from ignored `.env.local`. The key was not printed or
recorded. Responses were written only to `/tmp` during inspection and were not
committed.

## Year Coverage Checks

All year checks used:

- `NAICS=00`
- `FAGE=001`
- `EMPSZFI=001`
- `for=us:1`

| Year | HTTP Status | Content Type | Rows Excluding Header | Schema Interpretation |
| --- | --- | --- | --- | --- |
| 2019 | 204 | `application/json;charset=utf-8` | 0 | No rows returned for tested context. |
| 2020 | 204 | `application/json;charset=utf-8` | 0 | No rows returned for tested context. |
| 2021 | 204 | `application/json;charset=utf-8` | 0 | No rows returned for tested context. |
| 2022 | 200 | `application/json;charset=utf-8` | 1 | Tested context returned JSON. |
| 2023 | 204 | `application/json;charset=utf-8` | 0 | No rows returned for tested context. |

Guardrail:

- Do not infer multi-year `BDSFAGEFSIZE` availability from the broad BDS API
  catalog. The tested age/size query context is verified only for 2022.

## Geography Coverage Checks

All geography checks used:

- `time=2022`
- `NAICS=00`
- `FAGE=001`
- `EMPSZFI=001`

| Geography Query | HTTP Status | Rows Excluding Header | Header |
| --- | --- | --- | --- |
| `for=us:1` | 200 | 1 | `NAME;FIRM;ESTAB;EMP;NAICS;FAGE;EMPSZFI;time;NAICS;FAGE;EMPSZFI;us` |
| `for=state:*` | 200 | 51 | `NAME;FIRM;ESTAB;EMP;NAICS;FAGE;EMPSZFI;time;NAICS;FAGE;EMPSZFI;state` |
| `for=county:*&in=state:06` | 200 | 58 | `NAME;FIRM;ESTAB;EMP;NAICS;FAGE;EMPSZFI;time;NAICS;FAGE;EMPSZFI;state;county` |
| `for=metropolitan statistical area/micropolitan statistical area:*` | 200 | 925 | `NAME;FIRM;ESTAB;EMP;NAICS;FAGE;EMPSZFI;time;NAICS;FAGE;EMPSZFI;metropolitan statistical area/micropolitan statistical area` |

Guardrails:

- These are schema coverage checks only.
- State, county, and metro/micro coverage is verified only for the tested 2022
  all-industry/all-age/all-size context.
- Subnational analysis would still need suppression handling, geography
  stability checks, and an approved acquisition/cleaning script.

## NAICS Coverage Checks

The 2022 U.S. NAICS-label query used:

```text
https://api.census.gov/data/timeseries/bds?key=${CENSUS_API_KEY}&get=NAICS,NAICS_LABEL&time=2022&FAGE=001&EMPSZFI=001&for=us:1
```

Result:

- HTTP 200.
- Content type: `application/json;charset=utf-8`.
- Header: `NAICS;NAICS_LABEL;time;FAGE;EMPSZFI;us`.
- Rows excluding header: 394.

Selected verified labels from the returned code set:

| NAICS | NAICS_LABEL |
| --- | --- |
| `00` | Total for all sectors |
| `51` | Information |
| `518` | Data processing, hosting, and related services |
| `5182` | Data processing, hosting, and related services |
| `54` | Professional, scientific, and technical services |
| `541` | Professional, scientific, and technical services |
| `5415` | Computer systems design and related services |

Direct row-shape checks:

| NAICS | HTTP Status | Rows Excluding Header | Schema Interpretation |
| --- | --- | --- | --- |
| `54` | 200 | 1 | Tested sector returned JSON. |
| `5415` | 200 | 1 | Tested industry group returned JSON. |
| `541511` | 204 | 0 | No rows returned for tested six-digit code. |

Guardrail:

- Do not assume six-digit NAICS coverage in `BDSFAGEFSIZE`. Use only the code
  set returned by a verified NAICS-label query, and preserve the 2017 NAICS
  vintage warning.

## Remaining Blockers

- Official multi-year sector-level firm-age-by-size coverage was later found
  at `bds2023_sec_fa_fz.csv` and recorded in
  `research/data/bds_multiyear_firm_age_size_path.md`.
- API `BDSFAGEFSIZE` remains scoped to verified 2022 contexts unless a separate
  API multi-year route is verified.
- Resolve direct employer firm-startup/birth field status; `ESTABS_ENTRY`
  remains establishment entry, not firm startup.
- Future ingestion must handle duplicate predicate/requested columns in Census
  API responses.
- No BDS evidence here measures nonemployers, AI adoption, management layers,
  transaction costs, vendor substitution, or one-person firm formation.
