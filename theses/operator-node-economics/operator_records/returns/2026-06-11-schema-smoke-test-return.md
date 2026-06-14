---
record_id: return-2026-06-11-schema-smoke-test
record_type: return
workflow_id: 2026-06-11-schema-smoke-test
status: completed
created_at: 2026-06-11T19:08:05+08:00
owner: Research
---

# Return: Schema Smoke Tests

## Scope

This Research pass ran schema-only smoke tests for the empirical acquisition
scaffold. It checked whether small Census API row queries and SUSB file paths
could be validated. It did not download raw datasets or run quantitative
analysis.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/acquisition_scaffold.md`
- `research/data/schema_smoke_tests.md`
- `research/empirical_strategy.md`
- `docs/operator/returns/2026-06-11-schema-smoke-test-return.md`

## Smoke Tests Performed

### Census API Row Queries

The following data-row smoke queries were attempted with `curl -sL` and local
temporary output under `/tmp`:

- NES 2023 U.S.-level query.
- AIES-NES 2023 U.S.-level query.
- BDS basic U.S.-level query.
- BDS `BDSFAGEFSIZE` combined query with `NAICS`, `FAGE`, `EMPSZFI`,
  geography, and year predicates.

Result:

- Each data-row query reached Census after redirect following.
- Each returned HTTP 200 with a 399-byte HTML response titled "Missing Key".
- `CENSUS_API_KEY` and `CENSUS_KEY` were not configured in the shell
  environment.
- Correction run: `CENSUS_API_KEY` was loaded from ignored `.env.local` without
  printing the key. The key value had 40 characters, no whitespace, no carriage
  return, and no wrapping quotes.
- Each correction query reached Census and returned HTTP 200 with a 6,971-byte
  HTML response titled "Invalid Key".
- Activated-key retry using key-first query construction returned JSON for all
  four schema smoke tests.

Interpretation:

- The API key is valid, but these economic endpoints required the observed
  key-first query construction in this shell workflow.
- NES 2023, AIES-NES 2023, BDS basic, and one BDS `BDSFAGEFSIZE` predicate
  combination are now schema-smoke verified.
- No row-level Census data was accepted into source truth from these attempts.

### BDS Metadata Checks

Endpoints inspected:

- `https://api.census.gov/data/timeseries/bds/variables/FAGE.json`
- `https://api.census.gov/data/timeseries/bds/variables/EMPSZFI.json`

Result:

- `FAGE` metadata returned JSON confirming label, group membership,
  `FAGE_LABEL` attribute, string predicate type, and limit 0.
- `EMPSZFI` metadata returned JSON confirming label, group membership,
  `EMPSZFI_LABEL` attribute, string predicate type, and limit 0.
- Neither variable metadata response included a valid value set.

Interpretation:

- BDS `BDSFAGEFSIZE` metadata remains verified.
- Combined data-query validation succeeded for one U.S.-level 2022 predicate
  combination.
- Full `FAGE` and `EMPSZFI` value sets remain unresolved.

### SUSB File-Path Verification

Official page inspected:

- `https://www.census.gov/data/datasets/2022/econ/susb/2022-susb.html`

Verified official page links:

- `https://www2.census.gov/programs-surveys/susb/tables/2022/us_state_6digitnaics_2022.txt`
- `https://www2.census.gov/programs-surveys/susb/tables/2022/us_state_naics_detailedsizes_2022.txt`

HEAD results:

- `us_state_6digitnaics_2022.txt`: HTTP 200, `text/plain`,
  content length 56,000,447, last modified Thu, 10 Apr 2025 13:17:09 GMT.
- `us_state_naics_detailedsizes_2022.txt`: HTTP 200, `text/plain`,
  content length 6,995,555, last modified Thu, 10 Apr 2025 13:16:08 GMT.

Interpretation:

- SUSB 2022 U.S./state file paths are verified by official page links and HEAD
  responses.
- Files were not downloaded.
- Raw SUSB acquisition should wait for an approved raw-data storage rule or
  ignore pattern.

## Files Updated

- `research/data/acquisition_scaffold.md` now marks Census API row smoke tests
  as verified for key-first query construction and SUSB 2022 U.S./state
  6-digit NAICS as downloaded/manifested local-only.
- `research/data/schema_smoke_tests.md` records exact smoke-test outcomes.
- `research/empirical_strategy.md` now lists the next tasks as configuring a
  preserving local-only secret handling, using key-first query construction,
  resolving BDS value sets, and creating manifest rows before any additional
  SUSB downloads.

## Blockers Remaining

- Full BDS `FAGE` and `EMPSZFI` value sets remain unresolved.
- BDS `FAGE` and `EMPSZFI` valid value sets remain unresolved.
- BDS `BDSFAGEFSIZE` combined query is validated only for one U.S.-level 2022
  predicate combination.
- SUSB raw file acquisition has a storage convention; one 2022 U.S./state
  6-digit NAICS file is downloaded under ignored `data/raw/` and manifested.
- BFS remains blocked by unresolved `data_type_code` and `category_code`
  mappings.
- BTOS remains blocked by unresolved public-use AI variables, period fields,
  weights, and extract schema.

## Guardrails Preserved

- No quantitative analysis was run.
- No trends, ratios, growth rates, rankings, treatment effects, or prediction
  outcomes were computed.
- No raw datasets were committed.
- No Operator Node claim was promoted.
- `paper/draft.md` remained untouched.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
rg -n 'Missing Key|Invalid Key|verified_row_smoke_key_first|verified_combined_query_key_first|CENSUS_API_KEY|BDSFAGEFSIZE|us_state_6digitnaics_2022|us_state_naics_detailedsizes_2022|No quantitative analysis|No raw datasets' research/data/acquisition_scaffold.md research/data/schema_smoke_tests.md research/empirical_strategy.md docs/operator/returns/2026-06-11-schema-smoke-test-return.md
rg -n "Buddh[i]sm|Tao[i]sm|Sun[y]ata|dependent[ -]originat[i]on|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" research/data/acquisition_scaffold.md research/data/schema_smoke_tests.md research/empirical_strategy.md docs/operator/returns/2026-06-11-schema-smoke-test-return.md
rg -n "[ \t]+$" research/data/acquisition_scaffold.md research/data/schema_smoke_tests.md research/empirical_strategy.md docs/operator/returns/2026-06-11-schema-smoke-test-return.md
git status --short
```

Results:

- `git diff -- paper/draft.md`: no output.
- `git diff --check`: passed with no output.
- Smoke-test scan returned expected matches for Missing Key and Invalid Key
  historical responses, key-first verification status, `CENSUS_API_KEY` status,
  BDS `BDSFAGEFSIZE`, SUSB file links, no-analysis guardrail, and
  no-raw-datasets guardrail.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.
- `git status --short`: modified acquisition scaffold and empirical strategy;
  new smoke-test results file and return record.

## Commit Status

No commit or push was performed for this slice.
