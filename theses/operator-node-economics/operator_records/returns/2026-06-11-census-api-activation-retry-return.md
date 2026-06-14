---
record_id: return-2026-06-11-census-api-activation-retry
record_type: return
workflow_id: 2026-06-11-census-api-activation-retry
status: completed
created_at: 2026-06-11T21:14:00+08:00
owner: Research
---

# Return: Census API Activation Retry

## Scope

This Research correction pass retried the Census schema-only row smoke tests
after the user activated the Census API key. It did not run quantitative
analysis, download API datasets into the repo, or edit paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `.gitignore`
- `research/data/acquisition_scaffold.md`
- `research/data/schema_smoke_tests.md`
- `research/empirical_strategy.md`
- `docs/operator/returns/2026-06-11-schema-smoke-test-return.md`
- `docs/operator/returns/2026-06-11-census-api-activation-retry-return.md`

This return builds on still-uncommitted storage, SUSB manifest, and schema
smoke-test files from the preceding Research slices.

## Exact Verification Performed

- Confirmed `.env.local` exists and is ignored.
- Loaded `CENSUS_API_KEY` from ignored `.env.local` without printing the key.
- Confirmed key shape only: 40 characters, no whitespace, no carriage return,
  and no wrapping quotes.
- A neutral Census API validation endpoint returned JSON, confirming the key is
  accepted by Census.
- The original economic API `curl -G --data-urlencode` construction still
  returned Invalid Key HTML for these endpoints.
- Re-ran economic API smoke tests with `key=${CENSUS_API_KEY}` first in the
  query string. Those key-first requests returned JSON.

## Smoke-Test Results

| Target | Result | Header Fields | Rows Excluding Header |
| --- | --- | --- | --- |
| NES 2023 | verified_row_smoke_key_first | `NAME;NAICS2022_LABEL;NESTAB;NRCPTOT;LFO;NAICS2022;RCPSZES;us` | 1 |
| AIES-NES 2023 | verified_row_smoke_key_first | `NAICS2017;NAICS2017_LABEL;NAME;GEO_ID;RCPT_TOT_VAL;RCPT_TOT_VAL_NS;RCPT_TOT_CV;RCPT_TOT_VAL_NS_N;YEAR;us` | 425 |
| BDS basic 2022 | verified_row_smoke_key_first | `NAME;NAICS_LABEL;YEAR;FIRM;ESTAB;EMP;time;NAICS;us` | 1 |
| BDS `BDSFAGEFSIZE` 2022 | verified_combined_query_key_first | `NAME;FIRM;ESTAB;EMP;ESTABS_ENTRY;FIRMDEATH_FIRMS;NAICS;FAGE;EMPSZFI;time;NAICS;FAGE;EMPSZFI;us` | 1 |

## Guardrails Preserved

- No API key or secret was printed, stored in tracked files, or committed.
- `.env.local` is ignored.
- No quantitative analysis was run.
- No Census API response file was committed.
- No Operator Node claim was promoted.
- No decision about the Operator Node hypothesis.
- No prohibited philosophical or religious foundation.

## Remaining Blockers

- Future acquisition scripts must preserve key-first query construction or use
  a reviewed API client that avoids the observed invalid-key path.
- Full BDS `FAGE` and `EMPSZFI` value sets remain unresolved.
- BDS `BDSFAGEFSIZE` is validated only for one U.S.-level 2022 predicate
  combination.
- API ingestion, cleaning, crosswalk selection, and analysis remain future
  work.

## Verification Commands

Run after retry and editing:

```bash
git check-ignore .env.local data/raw/susb/2022/us_state_6digitnaics_2022.txt
git diff -- paper/draft.md
git diff --check
rg -n "philosophical|religious|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" data/README.md data/manifests/README.md data/manifests/susb_2022_manifest.csv research/data/acquisition_scaffold.md research/data/schema_smoke_tests.md research/empirical_strategy.md docs/operator/returns/2026-06-11-schema-smoke-test-return.md docs/operator/returns/2026-06-11-census-api-activation-retry-return.md docs/operator/returns/2026-06-11-susb-first-download-return.md
rg -n "[ \t]+$" .gitignore data/README.md data/manifests/README.md data/manifests/manifest_template.csv data/manifests/susb_2022_manifest.csv research/data/acquisition_scaffold.md research/data/schema_smoke_tests.md research/empirical_strategy.md docs/operator/returns/2026-06-11-schema-smoke-test-return.md docs/operator/returns/2026-06-11-census-api-activation-retry-return.md docs/operator/returns/2026-06-11-susb-first-download-return.md
```

Results:

- `git check-ignore`: returned `.env.local` and the SUSB raw file path.
- `git diff -- paper/draft.md`: no output.
- `git diff --check`: passed with no output.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.

## Commit Status

No commit or push was performed for this slice.
