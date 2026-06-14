# Data Acquisition Scaffold

Status: acquisition planning only. Not a data extract and not analysis.

This file defines conservative acquisition candidates for future empirical
work. It records pull-ready or near-pull-ready public inputs only where source
status and schema status support them. It does not download, transform,
aggregate, or analyze data.

Companion build-plan record:

- `research/data/sector_panel_build_plan.md`

That record defines the first 17-sector acquisition and cleaning design. It is
not a data extract, transformation script, processed panel, or analysis.

## Storage Rule

Do not commit downloaded raw data. Census public datasets can be re-fetched
from official sources; the repo should initially commit only metadata, query
inventories, checksums/manifests, and cleaning code after those are approved.

Local-only layout for future data work:

```text
data/raw/
data/intermediate/
data/processed/
data/manifests/
```

The first three paths are ignored in `.gitignore`. `data/manifests/` is tracked
for reproducibility metadata and contains a manifest template.

## Acquisition Readiness Summary

| Dataset | Acquisition Status | Reason |
| --- | --- | --- |
| NES 2023 API | ingestion_readiness_verified | Exact fields, geography examples, all-class defaults, noise fields, and schema-only U.S. all-class NAICS response verified with activated key loaded from ignored `.env.local`. Future scripts should use the observed key-first query construction. |
| AIES-NES 2023 API | ingestion_readiness_verified | Exact fields, U.S.-only API example, nonemployer noise fields, and schema-only national response verified with activated key loaded from ignored `.env.local`. Future scripts should use the observed key-first query construction and avoid duplicate predicate fields. |
| BDS basic API | row_smoke_verified_key_first_query | Exact fields, official API example, and one U.S.-level row-smoke response verified with activated key loaded from ignored `.env.local`. Future scripts should use the observed key-first query construction. |
| BDS API `BDSFAGEFSIZE` | coverage_validated_2022_contexts_only | Group fields, 2022 U.S. value-label sets, 2022 U.S./state/selected county/metro-micro geography checks, and selected 2022 NAICS checks verified. Tested 2019-2021 and 2023 U.S. all-industry contexts returned HTTP 204/no rows. |
| BDS downloadable sector-age-size CSV | first_raw_file_downloaded_manifested_local_only | Official 2023 BDS datasets page exposes `bds2023_sec_fa_fz.csv` titled "Sector by Firm Age by Firm Size"; schema inspection verified `year`, `sector`, `fage`, and `fsize` fields, 104,880 rows excluding header, and observed years 1978-2023. File is downloaded only under ignored `data/raw/` and recorded in `data/manifests/bds_2023_manifest.csv`. |
| SUSB U.S./state annual files | first_raw_file_downloaded_manifested_local_only | Exact record-layout fields and 2022 U.S./state file paths verified by official page links and HEAD responses; one U.S./state 6-digit NAICS file was downloaded only under ignored `data/raw/` and recorded in `data/manifests/susb_2022_manifest.csv`. |
| BFS API | blocked | `data_type_code` values and `category_code` to NAICS mapping unresolved. |
| BTOS AI supplement | blocked_for_extract | Coverage, tabulations, and question numbers verified; public-use variable names, weights, and extract schema unresolved. |
| Bonney et al. 2026 | context_only | Working paper is source truth for employer AI diffusion context, not a public panel extract in this repo. |
| Bick/Blandin/Deming 2024 | context_only | Worker-level GenAI adoption context only, not a business-boundary extract. |

## Pull Candidates

### NES 2023

Source role:

- Nonemployer establishment and receipt outcomes.
- Business-boundary outcome layer only; no AI exposure.

Verified API metadata:

- Endpoint: `https://api.census.gov/data/2023/nonemp`
- Example metadata confirms `us`, `state`, `county`, metro/micro, and CSA
  geographies.
- Exact fields are documented in `research/data/field_dictionary.md`.

Verified first smoke-test query form:

```text
https://api.census.gov/data/2023/nonemp?key=${CENSUS_API_KEY}&get=NAME,NAICS2022_LABEL,NESTAB,NRCPTOT&LFO=001&NAICS2022=00&RCPSZES=001&for=us:1
```

Observed row-smoke result:

- HTTP 200.
- Content type: `application/json;charset=utf-8`.
- Header fields:
  `NAME;NAICS2022_LABEL;NESTAB;NRCPTOT;LFO;NAICS2022;RCPSZES;us`.
- Rows excluding header: 1.

Ingestion-readiness record:

- `research/data/nes_aies_api_ingestion_readiness.md`

Additional schema-only checks:

- `LFO=001` label verified as `All establishments`.
- `RCPSZES=001` label verified as `All establishments`.
- `NRCPTOT_N` and `NRCPTOT_N_F` verified as nonemployer receipt noise range
  and flag fields.
- U.S. all-class NAICS query returned 452 rows excluding header, zero
  bad-width rows, and observed `NRCPTOT_N_F=G` in all checked rows.

Candidate acquisition units after smoke test:

- U.S.-NAICS-year.
- State-NAICS-year.
- County-NAICS-year only after cell-size/noise review.
- Metro/micro-NAICS-year only after geography comparability review.

Required QA before analysis:

- Use the observed key-first query construction in future scripts unless a
  more robust API client is approved.
- Preserve `NRCPTOT_N` and `NRCPTOT_N_F` before numeric coercion.
- Preserve appended predicate columns for `LFO`, `RCPSZES`, and geography.
- Record NAICS vintage as 2022.
- Preserve the 2022 methodology-change warning.

### AIES-NES 2023

Source role:

- National employer/nonemployer revenue comparison.
- Business-boundary comparison layer only; no AI exposure.

Verified API metadata:

- Endpoint: `https://api.census.gov/data/2023/aiesnonemp`
- Example metadata confirms U.S.-only geography.
- Exact fields include `NAICS2017`, `RCPT_TOT_VAL`, `RCPT_TOT_VAL_NS`,
  `RCPT_TOT_CV`, and `RCPT_TOT_VAL_NS_N`.

Verified first smoke-test query form:

```text
https://api.census.gov/data/2023/aiesnonemp?key=${CENSUS_API_KEY}&get=NAICS2017,NAICS2017_LABEL,NAME,GEO_ID,RCPT_TOT_VAL,RCPT_TOT_VAL_NS,RCPT_TOT_CV,RCPT_TOT_VAL_NS_N&YEAR=2023&for=us:1
```

Observed row-smoke result:

- HTTP 200.
- Content type: `application/json;charset=utf-8`.
- Header fields:
  `NAICS2017;NAICS2017_LABEL;NAME;GEO_ID;RCPT_TOT_VAL;RCPT_TOT_VAL_NS;RCPT_TOT_CV;RCPT_TOT_VAL_NS_N;YEAR;us`.
- Rows excluding header: 425.

Ingestion-readiness record:

- `research/data/nes_aies_api_ingestion_readiness.md`

Additional schema-only checks:

- `RCPT_TOT_VAL_NS_N` and `RCPT_TOT_VAL_NS_N_F` verified as nonemployer
  revenue noise range and flag fields.
- Cleaner national query returned 425 rows excluding header, zero bad-width
  rows, and observed `RCPT_TOT_VAL_NS_N_F=G` in all checked rows.
- Requesting `YEAR` in `get=` while also using `YEAR=2023` as a predicate
  creates a duplicate `YEAR` header; future ingestion should avoid that query
  form or explicitly preserve both raw columns before canonical mapping.

Candidate acquisition unit:

- U.S.-NAICS-year only.

Required QA before analysis:

- Use the observed key-first query construction in future scripts unless a
  more robust API client is approved.
- Record NAICS vintage as 2017.
- Confirm revenue concept compatibility with NES and SUSB before deriving any
  employer/nonemployer share.
- Preserve `RCPT_TOT_VAL_NS_N` and `RCPT_TOT_VAL_NS_N_F` before numeric
  coercion.
- Do not treat employer and nonemployer values as row-level business classes;
  they are separate fields.

### BDS Basic API

Source role:

- Employer-firm and employer-establishment dynamics.
- Employer side only; no nonemployer, AI, or management-layer evidence.

Verified API metadata:

- Endpoint: `https://api.census.gov/data/timeseries/bds`
- Official example confirms `NAME`, `NAICS_LABEL`, `YEAR`, `FIRM`, `ESTAB`,
  and `EMP` for `time` and `NAICS` predicates.
- Geography examples include U.S., state, county, and metro/micro.

Verified first smoke-test query form:

```text
https://api.census.gov/data/timeseries/bds?key=${CENSUS_API_KEY}&get=NAME,NAICS_LABEL,YEAR,FIRM,ESTAB,EMP&time=2022&NAICS=00&for=us:1
```

Observed row-smoke result:

- HTTP 200.
- Content type: `application/json;charset=utf-8`.
- Header fields:
  `NAME;NAICS_LABEL;YEAR;FIRM;ESTAB;EMP;time;NAICS;us`.
- Rows excluding header: 1.

Candidate acquisition units after smoke test:

- U.S.-NAICS-year employer cells.
- State-NAICS-year employer cells.
- County or metro/micro cells only after suppression and geography checks.

Required QA before analysis:

- Use the observed key-first query construction in future scripts unless a
  more robust API client is approved.
- Record NAICS vintage as 2017.
- Keep `ESTABS_ENTRY` as establishment entry, not firm startup.
- Keep `FIRMDEATH_FIRMS` as firm exits/shutdowns.
- Do not infer nonemployer transitions from BDS.

### BDS Firm Age By Firm Size

Source role:

- Employer-side age/size dynamics.
- Possible context for node-becomes-firm criticism, not direct nonemployer
  transition evidence.

Verified group metadata:

- Group: `BDSFAGEFSIZE`.
- Fields verified: `NAICS`, `FAGE`, `EMPSZFI`, `GEO_ID`, `YEAR`, `FIRM`,
  `ESTAB`, `EMP`, `ESTABS_ENTRY`, `FIRMDEATH_FIRMS`,
  `JOB_CREATION_BIRTHS`.

Verified combined-query smoke test:

- Query form:
  `https://api.census.gov/data/timeseries/bds?key=${CENSUS_API_KEY}&get=NAME,FIRM,ESTAB,EMP,ESTABS_ENTRY,FIRMDEATH_FIRMS,NAICS,FAGE,EMPSZFI&time=2022&NAICS=00&FAGE=001&EMPSZFI=001&for=us:1`
- HTTP 200.
- Content type: `application/json;charset=utf-8`.
- Header fields:
  `NAME;FIRM;ESTAB;EMP;ESTABS_ENTRY;FIRMDEATH_FIRMS;NAICS;FAGE;EMPSZFI;time;NAICS;FAGE;EMPSZFI;us`.
- Rows excluding header: 1.

Value sets verified in `research/data/bds_value_sets.md`:

- `FAGE`: 15 code-label rows for `time=2022`, `NAICS=00`, `EMPSZFI=001`,
  `for=us:1`.
- `EMPSZFI`: 14 code-label rows for `time=2022`, `NAICS=00`, `FAGE=001`,
  `for=us:1`.
- 2023 value-label checks returned HTTP 204/no rows for the same U.S.-level
  all-industry contexts.

Coverage validated in `research/data/bds_coverage_validation.md`:

- Year checks for the U.S. all-industry/all-age/all-size context returned rows
  only for 2022 among tested years 2019-2023.
- 2022 geography checks returned JSON for U.S., all states, California
  counties, and metro/micro areas.
- A 2022 U.S. NAICS-label query returned 394 code-label rows.
- Direct 2022 U.S. row-shape checks returned JSON for `NAICS=54` and
  `NAICS=5415`; `NAICS=541511` returned HTTP 204/no rows.

Still blocked until:

- API `BDSFAGEFSIZE` is kept scoped to verified 2022 contexts unless a separate
  API multi-year route is found.
- Duplicate predicate/requested columns are handled explicitly in a future
  ingestion design.

### BDS Downloadable Sector By Firm Age By Firm Size CSV

Source role:

- Multi-year employer-side sector by firm age by firm size dynamics.
- Possible sector-level context for employer-firm age/size composition.
- Not a nonemployer, AI, management-layer, or transaction-cost source.

Verified source path:

```text
https://www2.census.gov/programs-surveys/bds/tables/time-series/2023/bds2023_sec_fa_fz.csv
```

Verified schema:

- Page title/link text: Sector by Firm Age by Firm Size.
- HTTP status: 200.
- Content type: `text/csv`.
- Content length: 12,606,118 bytes.
- Rows excluding header: 104,880.
- Observed years: 1978-2023.
- Exact fields:
  `year`, `sector`, `fage`, `fsize`, `firms`, `estabs`, `emp`, `denom`,
  `estabs_entry`, `estabs_entry_rate`, `estabs_exit`, `estabs_exit_rate`,
  `job_creation`, `job_creation_births`, `job_creation_continuers`,
  `job_creation_rate_births`, `job_creation_rate`, `job_destruction`,
  `job_destruction_deaths`, `job_destruction_continuers`,
  `job_destruction_rate_deaths`, `job_destruction_rate`,
  `net_job_creation`, `net_job_creation_rate`, `reallocation_rate`,
  `firmdeath_firms`, `firmdeath_estabs`, `firmdeath_emp`.

First local-only download completed:

- File: `data/raw/bds/2023/bds2023_sec_fa_fz.csv`
- Manifest: `data/manifests/bds_2023_manifest.csv`
- HTTP status: 200
- Content type: `text/csv`
- Content length: 12,606,118 bytes
- SHA-256:
  `c4790ccdf964788a8bbc8404349df69db2a7457f8784411a39ddb228dedfbabd`
- Row count including header: 104,881

Remaining before analysis:

- Decide whether sector-level coverage is sufficient for the planned BDS role.
- Preserve that this path is sector-level, not six-digit NAICS or subnational.
- Follow ingestion-readiness rules in
  `research/data/bds_ingestion_readiness.md`.
- Treat `D`, `S`, `X`, and `N` as official publication flags, not numeric zero.

### SUSB U.S./State Annual

Source role:

- Employer-firm size, establishment, employment, payroll, and receipt baseline.
- Employer side only; no nonemployer, AI, or hierarchy-depth evidence.

Verified schema:

- Record layout: U.S./state annual, 2007-present.
- Exact fields: `STATE`, `NAICS`, `ENTRSIZE`, `FIRM`, `ESTB`, `EMPL`,
  `EMPLFL_R`, `EMPLFL_N`, `PAYR`, `PAYRFL_N`, `RCPT`, `RCPTFL_N`,
  `STATEDSCR`, `NAICSDSCR`, `ENTRSIZEDSCR`.

Verified file paths:

```text
https://www2.census.gov/programs-surveys/susb/tables/2022/us_state_6digitnaics_2022.txt
https://www2.census.gov/programs-surveys/susb/tables/2022/us_state_naics_detailedsizes_2022.txt
```

First local-only download completed:

- File: `data/raw/susb/2022/us_state_6digitnaics_2022.txt`
- Manifest: `data/manifests/susb_2022_manifest.csv`
- HTTP status: 200
- Content type: `text/plain`
- Content length: 56,000,447 bytes
- SHA-256:
  `6f7b2f2b14cbad9dbfeb31d3bfc9f729368a0e971727de4eda88c9f83f77a513`
- Row count including header: 570,106
- Observed header:
  `STATE,NAICS,ENTRSIZE,FIRM,ESTB,EMPL,EMPLFL_N,PAYR,PAYRFL_N,RCPT,RCPTFL_N,STATEDSCR,NAICSDSCR,ENTRSIZEDSCR`

Remaining before analysis:

- Do not compute SUSB aggregates or trends until an ingestion/QA script is
  approved.
- Follow ingestion-readiness rules in
  `research/data/susb_ingestion_readiness.md`.
- Preserve `EMPLFL_N`, `PAYRFL_N`, and `RCPTFL_N` before numeric coercion.
- Treat `G`, `H`, and `J` as noise-quality flags and any observed `D` or `S`
  as withheld cells, not true zeros.
- Pull the companion detailed-size file only if narrower enterprise-size
  categories are needed for a specific prediction design; create a separate
  manifest row before any download.
- The broader record-layout note includes `EMPLFL_R`, but this downloaded 2022
  U.S./state 6-digit NAICS header did not expose that field. Treat the observed
  header as source truth for this file.

Observed access-path issue now resolved:

- The initial inspected 2022 Census SUSB dataset directory exposed MSA files at
  the checked path. The official 2022 SUSB dataset page later exposed U.S./state
  table links under `/programs-surveys/susb/tables/2022/`, and those links
  returned HTTP 200 to HEAD requests.

## Explicit Non-Pulls

### BFS

Do not acquire BFS data yet.

Blocked fields:

- API `data_type_code` value mapping.
- `category_code` to industry/NAICS mapping.

Verified but insufficient:

- Official BFS definitions verify `BA`, `HBA`, `BF4Q`, `BF8Q`, `PBF4Q`, and
  `PBF8Q` abbreviations, but this repo has not verified them as API
  `data_type_code` values.

Guardrail:

- BFS employer formations remain only an indirect payroll-transition proxy.

### BTOS AI Supplement

Do not acquire BTOS tabular data yet.

Blocked fields:

- Public-use AI variable names.
- Survey period fields.
- Weights.
- Exact extract/download schema.

Verified but insufficient:

- Employer-business coverage, 2017 NAICS sector/subsector tabulations, state
  and large-MSA tabulations, expanded employment-size classes, and AI question
  numbers.

Guardrail:

- BTOS is employer-business AI exposure, not nonemployer AI use and not a
  boundary outcome.

## Manifest Fields For Future Pulls

Each future acquisition should create a manifest entry with:

- Dataset.
- Source URL.
- Retrieval date/time and timezone.
- Query URL or file URL.
- HTTP status.
- File size or row count for raw response.
- SHA-256 checksum for downloaded files.
- Field list requested.
- Geography predicates.
- NAICS vintage.
- Reference year or period.
- Known suppression/noise fields.
- Source-note status.
- Guardrail notes.

## First Safe Execution Order

1. Preserve `.env.local` as an ignored local-only secret file.
2. Record key-first Census API query construction in any future acquisition
   script; do not print or log the key.
3. Follow `research/data/sector_panel_build_plan.md` for the first 17-sector
   all-source acquisition and cleaning design.
4. Decide whether BDS age/size acquisition should use the verified multi-year
   sector-level CSV or remain scoped to API-verified 2022 contexts.
5. Keep the SUSB detailed-size file unpulled unless a future prediction design
   needs narrower enterprise-size categories; create a separate manifest row
   first if it is pulled.
6. If additional SUSB files are needed, create a separate manifest row first
   and download each selected file into ignored `data/raw/`.
7. Only after API smoke tests and file acquisition QA pass, decide whether to
   create ingestion scripts.

## Analysis Prohibition

Future smoke tests may retrieve a small number of rows only to validate schema,
field availability, predicates, and metadata. They must not compute trends,
shares, ratios, growth rates, rankings, treatment effects, or prediction
outcomes until a separate analysis slice is explicitly approved.
