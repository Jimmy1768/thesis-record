# BDS Value Sets

Status: schema/value-set record only. Not raw data and not analysis.

Run date: 2026-06-11.

Purpose: record BDS `FAGE` and `EMPSZFI` code labels verified from official
Census API responses for the `BDSFAGEFSIZE` group. These checks did not compute
outcomes, trends, rates, shares, or prediction results.

## Access Paths

Official Census API metadata:

- `https://api.census.gov/data/timeseries/bds/groups/BDSFAGEFSIZE.json`
- `https://api.census.gov/data/timeseries/bds/variables/FAGE.json`
- `https://api.census.gov/data/timeseries/bds/variables/EMPSZFI.json`

Official Census API value-label queries, with the API key loaded from ignored
`.env.local` and placed first in the query string:

- `https://api.census.gov/data/timeseries/bds?key=${CENSUS_API_KEY}&get=FAGE,FAGE_LABEL&time=2022&NAICS=00&EMPSZFI=001&for=us:1`
- `https://api.census.gov/data/timeseries/bds?key=${CENSUS_API_KEY}&get=EMPSZFI,EMPSZFI_LABEL&time=2022&NAICS=00&FAGE=001&for=us:1`

The responses were saved only under `/tmp` during inspection and were not
committed.

## Verified Firm Age Codes

Query context:

- Year predicate: `time=2022`
- Industry predicate: `NAICS=00`
- Firm-size predicate: `EMPSZFI=001`
- Geography predicate: `for=us:1`
- Response: HTTP 200, `application/json;charset=utf-8`
- Header: `FAGE;FAGE_LABEL;time;NAICS;EMPSZFI;us`
- Rows excluding header: 15

| FAGE | FAGE_LABEL |
| --- | --- |
| `001` | Total |
| `010` | 0 years |
| `020` | 1 year |
| `030` | 2 years |
| `040` | 3 years |
| `050` | 4 years |
| `060` | 5 years |
| `065` | 1-5 years |
| `070` | 6-10 years |
| `075` | 11+ years |
| `080` | 11-15 years |
| `090` | 16-20 years |
| `100` | 21-25 years |
| `110` | 26+ years |
| `150` | Left Censored |

## Verified Firm Size Codes

Query context:

- Year predicate: `time=2022`
- Industry predicate: `NAICS=00`
- Firm-age predicate: `FAGE=001`
- Geography predicate: `for=us:1`
- Response: HTTP 200, `application/json;charset=utf-8`
- Header: `EMPSZFI;EMPSZFI_LABEL;time;NAICS;FAGE;us`
- Rows excluding header: 14

| EMPSZFI | EMPSZFI_LABEL |
| --- | --- |
| `001` | All firms |
| `612` | Firms with 1 to 4 employees |
| `620` | Firms with 5 to 9 employees |
| `630` | Firms with 10 to 19 employees |
| `635` | Firms with 1 to 19 employees |
| `640` | Firms with 20 to 99 employees |
| `649` | Firms with 100 to 499 employees |
| `650` | Firms with 20 to 499 employees |
| `657` | Firms with 500 employees or more |
| `658` | Firms with 500 to 999 employees |
| `661` | Firms with 1,000 to 2,499 employees |
| `671` | Firms with 2,500 to 4,999 employees |
| `672` | Firms with 5,000 to 9,999 employees |
| `680` | Firms with 10,000 employees or more |

## Consistency Check

The same value-label queries for `time=2023`, `NAICS=00`, U.S. geography, and
the same all-firms/all-age counterpart predicates returned HTTP 204 with an
empty response body. Do not infer 2023 `BDSFAGEFSIZE` availability from the API
catalog alone without a successful data query.

## Guardrails

- These value sets are BDS employer-firm dimensions only.
- They do not measure nonemployer activity, AI adoption, management layers,
  contractor substitution, transaction costs, or one-person firm formation.
- `FAGE=010` can identify zero-year employer firms in BDS; it is not
  nonemployer-to-employer conversion evidence.
- `EMPSZFI` is firm employment-size class, not hierarchy depth or span of
  control.
- Full acquisition, cleaning, NAICS crosswalk selection, and analysis remain
  future work.
