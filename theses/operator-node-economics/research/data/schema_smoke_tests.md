# Schema Smoke Tests

Status: schema validation record only. Not raw data and not analysis.

Run date: 2026-06-11.

Purpose: validate whether acquisition candidates in
`research/data/acquisition_scaffold.md` can return small schema-level responses
or official file metadata. These checks did not compute results, trends,
shares, ratios, rankings, or prediction outcomes.

## Environment

- `CENSUS_API_KEY`: present when loaded from ignored `.env.local`.
- `CENSUS_KEY`: missing.
- Raw API responses were written only to `/tmp` during inspection and were not
  committed.
- Economic API row queries succeeded only after placing `key` first in the
  query string. The earlier `curl -G --data-urlencode` construction reached
  Census but returned Invalid Key HTML for these economic endpoints.

## Summary

| Target | Result | Interpretation |
| --- | --- | --- |
| NES 2023 API data-row smoke | verified_row_smoke_key_first | Key-first correction query returned JSON with expected requested fields plus predicate columns; one row excluding header. |
| AIES-NES 2023 API data-row smoke | verified_row_smoke_key_first | Key-first correction query returned JSON with expected requested fields plus `YEAR` and `us`; 425 rows excluding header. |
| BDS basic API data-row smoke | verified_row_smoke_key_first | Key-first correction query returned JSON with expected requested fields plus `time`, `NAICS`, and `us`; one row excluding header. |
| BDS `BDSFAGEFSIZE` combined data-row smoke | verified_combined_query_key_first | Key-first correction query with `NAICS=00`, `FAGE=001`, `EMPSZFI=001`, `time=2022`, and `for=us:1` returned JSON; one row excluding header. |
| BDS `FAGE` variable metadata | verified_metadata | Variable metadata returned JSON with label, group, attributes, and predicate type. |
| BDS `EMPSZFI` variable metadata | verified_metadata | Variable metadata returned JSON with label, group, attributes, and predicate type. |
| BDS `FAGE` value labels | verified_2022_us_value_labels | Official API query returned 15 code-label rows for `time=2022`, `NAICS=00`, `EMPSZFI=001`, and `for=us:1`. |
| BDS `EMPSZFI` value labels | verified_2022_us_value_labels | Official API query returned 14 code-label rows for `time=2022`, `NAICS=00`, `FAGE=001`, and `for=us:1`. |
| SUSB 2022 U.S./state 6-digit NAICS file | downloaded_manifested_local_only | Official page link and HEAD response returned HTTP 200 with text/plain content type. File later downloaded only under ignored `data/raw/` and recorded in `data/manifests/susb_2022_manifest.csv`. |
| SUSB 2022 U.S./state detailed-size file | verified_head_only | Official page link and HEAD response returned HTTP 200 with text/plain content type. File not downloaded. |

## API Row Smoke Attempts

### NES 2023

Query attempted:

```text
https://api.census.gov/data/2023/nonemp?key=${CENSUS_API_KEY}&get=NAME,NAICS2022_LABEL,NESTAB,NRCPTOT&LFO=001&NAICS2022=00&RCPSZES=001&for=us:1
```

Command result:

- Initial request without redirect following returned HTTP 302.
- Redirect-following request returned HTTP 200 with a 399-byte HTML response.
- Response title: Missing Key.
- Correction run with `CENSUS_API_KEY` loaded from ignored `.env.local`
  returned HTTP 200 with a 6,971-byte HTML response.
- Correction response title: Invalid Key.
- Activated-key retry using key-first query construction returned HTTP 200,
  `application/json;charset=utf-8`, and a 168-byte JSON response.
- Header fields:
  `NAME;NAICS2022_LABEL;NESTAB;NRCPTOT;LFO;NAICS2022;RCPSZES;us`.
- Rows excluding header: 1.

Status:

- Row smoke test verified. Do not treat this as analysis or as a validated
  acquisition template for larger pulls until query construction is scripted
  and reviewed.

### AIES-NES 2023

Query attempted:

```text
https://api.census.gov/data/2023/aiesnonemp?key=${CENSUS_API_KEY}&get=NAICS2017,NAICS2017_LABEL,NAME,GEO_ID,RCPT_TOT_VAL,RCPT_TOT_VAL_NS,RCPT_TOT_CV,RCPT_TOT_VAL_NS_N&YEAR=2023&for=us:1
```

Command result:

- Initial request without redirect following returned HTTP 302.
- Redirect-following request returned HTTP 200 with a 399-byte HTML response.
- Response title: Missing Key.
- Correction run with `CENSUS_API_KEY` loaded from ignored `.env.local`
  returned HTTP 200 with a 6,971-byte HTML response.
- Correction response title: Invalid Key.
- Activated-key retry using key-first query construction returned HTTP 200,
  `application/json;charset=utf-8`, and a 50,517-byte JSON response.
- Header fields:
  `NAICS2017;NAICS2017_LABEL;NAME;GEO_ID;RCPT_TOT_VAL;RCPT_TOT_VAL_NS;RCPT_TOT_CV;RCPT_TOT_VAL_NS_N;YEAR;us`.
- Rows excluding header: 425.

Status:

- Row smoke test verified. Do not compute employer/nonemployer shares until
  acquisition and cleaning scripts are approved.

### BDS Basic

Query attempted:

```text
https://api.census.gov/data/timeseries/bds?key=${CENSUS_API_KEY}&get=NAME,NAICS_LABEL,YEAR,FIRM,ESTAB,EMP&time=2022&NAICS=00&for=us:1
```

Command result:

- Initial request without redirect following returned HTTP 302.
- Redirect-following request returned HTTP 200 with a 399-byte HTML response.
- Response title: Missing Key.
- Correction run with `CENSUS_API_KEY` loaded from ignored `.env.local`
  returned HTTP 200 with a 6,971-byte HTML response.
- Correction response title: Invalid Key.
- Activated-key retry using key-first query construction returned HTTP 200,
  `application/json;charset=utf-8`, and a 170-byte JSON response.
- Header fields:
  `NAME;NAICS_LABEL;YEAR;FIRM;ESTAB;EMP;time;NAICS;us`.
- Rows excluding header: 1.

Status:

- Row smoke test verified.

### BDS `BDSFAGEFSIZE`

Query attempted:

```text
https://api.census.gov/data/timeseries/bds?key=${CENSUS_API_KEY}&get=NAME,FIRM,ESTAB,EMP,ESTABS_ENTRY,FIRMDEATH_FIRMS,NAICS,FAGE,EMPSZFI&time=2022&NAICS=00&FAGE=001&EMPSZFI=001&for=us:1
```

Command result:

- Redirect-following request returned HTTP 200 with a 399-byte HTML response.
- Response title: Missing Key.
- Correction run with `CENSUS_API_KEY` loaded from ignored `.env.local`
  returned HTTP 200 with a 6,971-byte HTML response.
- Correction response title: Invalid Key.
- Activated-key retry using key-first query construction returned HTTP 200,
  `application/json;charset=utf-8`, and a 240-byte JSON response.
- Header fields:
  `NAME;FIRM;ESTAB;EMP;ESTABS_ENTRY;FIRMDEATH_FIRMS;NAICS;FAGE;EMPSZFI;time;NAICS;FAGE;EMPSZFI;us`.
- Rows excluding header: 1.

Status:

- Combined query validated for one U.S.-level 2022 predicate combination:
  `NAICS=00`, `FAGE=001`, `EMPSZFI=001`.
- `FAGE` and `EMPSZFI` 2022 U.S. value-label sets were subsequently verified
  and recorded in `research/data/bds_value_sets.md`.

## Metadata Checks

### BDS `FAGE`

Endpoint:

```text
https://api.census.gov/data/timeseries/bds/variables/FAGE.json
```

Verified metadata:

- Name: `FAGE`.
- Label: Firm age code.
- Group: `BDSFAGEFSIZE,BDSFAGEIFSIZE,BDSFAGE`.
- Attribute: `FAGE_LABEL`.
- Predicate type: string.
- Limit: 0.

Limitation from metadata endpoint alone:

- This endpoint did not provide the valid value set.

Value-label query:

```text
https://api.census.gov/data/timeseries/bds?key=${CENSUS_API_KEY}&get=FAGE,FAGE_LABEL&time=2022&NAICS=00&EMPSZFI=001&for=us:1
```

Result:

- HTTP 200.
- Content type: `application/json;charset=utf-8`.
- Header fields: `FAGE;FAGE_LABEL;time;NAICS;EMPSZFI;us`.
- Rows excluding header: 15.
- Code labels recorded in `research/data/bds_value_sets.md`.

### BDS `EMPSZFI`

Endpoint:

```text
https://api.census.gov/data/timeseries/bds/variables/EMPSZFI.json
```

Verified metadata:

- Name: `EMPSZFI`.
- Label: Employment size of firms code.
- Group: `BDSFAGEFSIZE,BDSFSIZE`.
- Attribute: `EMPSZFI_LABEL`.
- Predicate type: string.
- Limit: 0.

Limitation from metadata endpoint alone:

- This endpoint did not provide the valid value set.

Value-label query:

```text
https://api.census.gov/data/timeseries/bds?key=${CENSUS_API_KEY}&get=EMPSZFI,EMPSZFI_LABEL&time=2022&NAICS=00&FAGE=001&for=us:1
```

Result:

- HTTP 200.
- Content type: `application/json;charset=utf-8`.
- Header fields: `EMPSZFI;EMPSZFI_LABEL;time;NAICS;FAGE;us`.
- Rows excluding header: 14.
- Code labels recorded in `research/data/bds_value_sets.md`.

## SUSB File-Path Checks

Official page inspected:

```text
https://www.census.gov/data/datasets/2022/econ/susb/2022-susb.html
```

The page exposes these U.S./state links:

```text
https://www2.census.gov/programs-surveys/susb/tables/2022/us_state_6digitnaics_2022.txt
https://www2.census.gov/programs-surveys/susb/tables/2022/us_state_naics_detailedsizes_2022.txt
```

HEAD results:

| URL | HTTP | Content Type | Content Length | Last Modified |
| --- | --- | --- | --- | --- |
| `https://www2.census.gov/programs-surveys/susb/tables/2022/us_state_6digitnaics_2022.txt` | 200 | `text/plain` | 56,000,447 | Thu, 10 Apr 2025 13:17:09 GMT |
| `https://www2.census.gov/programs-surveys/susb/tables/2022/us_state_naics_detailedsizes_2022.txt` | 200 | `text/plain` | 6,995,555 | Thu, 10 Apr 2025 13:16:08 GMT |

Status:

- Durable 2022 U.S./state file paths are verified by official page links and
  HEAD responses.
- The U.S./state 6-digit NAICS file was later downloaded under ignored
  `data/raw/` and recorded in `data/manifests/susb_2022_manifest.csv`.
- The detailed-size file remains not downloaded.

## Guardrails

- No quantitative analysis was run.
- No raw datasets were committed.
- Census data-row API smoke tests are verified only for the narrow key-first
  test queries listed above.
- BDS `BDSFAGEFSIZE` combined query and 2022 U.S. `FAGE`/`EMPSZFI` value-label
  sets are validated only for the narrow contexts recorded above.
- SUSB 2022 U.S./state 6-digit NAICS raw file is local-only and ignored by git.
- No Operator Node claim is supported by this smoke-test record.
