---
record_id: return-2026-06-11-susb-first-download
record_type: return
workflow_id: 2026-06-11-susb-first-download
status: completed
created_at: 2026-06-11T20:36:43+08:00
owner: Research
---

# Return: SUSB First Local Download

## Scope

This Research pass performed the first local-only SUSB acquisition after the
raw-data storage convention was added. It downloaded one official Census SUSB
file into ignored `data/raw/`, created a tracked manifest row, and updated the
acquisition scaffold. It did not run quantitative analysis.

`paper/draft.md` was not edited.

## Files Changed

- `data/manifests/susb_2022_manifest.csv`
- `research/data/acquisition_scaffold.md`
- `docs/operator/returns/2026-06-11-susb-first-download-return.md`

This pass builds on still-uncommitted storage/scaffold files from the preceding
Research slices.

## Source Acquired

- Dataset: SUSB 2022 U.S./state 6-digit NAICS file
- Source owner: U.S. Census Bureau
- Source page:
  `https://www.census.gov/data/datasets/2022/econ/susb/2022-susb.html`
- File URL:
  `https://www2.census.gov/programs-surveys/susb/tables/2022/us_state_6digitnaics_2022.txt`
- Local path:
  `data/raw/susb/2022/us_state_6digitnaics_2022.txt`
- Git status of local raw file: ignored by `.gitignore`

## Manifest Metadata

- HTTP status: 200
- Content type: `text/plain`
- Content length / byte count: 56,000,447
- SHA-256:
  `6f7b2f2b14cbad9dbfeb31d3bfc9f729368a0e971727de4eda88c9f83f77a513`
- Row count including header: 570,106
- Observed header:
  `STATE,NAICS,ENTRSIZE,FIRM,ESTB,EMPL,EMPLFL_N,PAYR,PAYRFL_N,RCPT,RCPTFL_N,STATEDSCR,NAICSDSCR,ENTRSIZEDSCR`

## Schema Notes

- The downloaded file directly exposes employer-side SUSB fields for state,
  NAICS, enterprise-size class, firm count, establishment count, employment,
  annual payroll, receipts, flag fields, and labels.
- The broader SUSB record-layout note had listed `EMPLFL_R`, but the observed
  2022 U.S./state 6-digit NAICS header does not include it. The manifest records
  the file header exactly.
- This file remains employer-side context only. It does not measure nonemployer
  activity, AI exposure, contractor substitution, management-layer thinning, or
  one-person firm formation.

## Guardrails Preserved

- No `paper/draft.md` edit.
- No paper prose.
- No quantitative analysis.
- No Operator Node claim promotion.
- No decision about the Operator Node hypothesis.
- No prohibited philosophical or religious foundation.
- No API keys, secrets, or local credentials recorded.
- Raw data was written only under ignored `data/raw/`.

## Remaining Blockers

- Census API row smoke tests still require a valid activated `CENSUS_API_KEY`
  that Census accepts.
- The BDS `BDSFAGEFSIZE` combined query is validated only for one U.S.-level
  2022 predicate combination; full value sets remain unresolved.
- SUSB ingestion, QA, and any aggregation remain future work.
- The companion SUSB detailed-size file has not been downloaded; create a
  separate manifest row before any acquisition.

## Verification Commands

Run after acquisition and editing:

```bash
curl -sL -w 'http_status=%{http_code}\ncontent_type=%{content_type}\nsize_download=%{size_download}\n' -o data/raw/susb/2022/us_state_6digitnaics_2022.txt https://www2.census.gov/programs-surveys/susb/tables/2022/us_state_6digitnaics_2022.txt
shasum -a 256 data/raw/susb/2022/us_state_6digitnaics_2022.txt
wc -l data/raw/susb/2022/us_state_6digitnaics_2022.txt
wc -c data/raw/susb/2022/us_state_6digitnaics_2022.txt
head -n 1 data/raw/susb/2022/us_state_6digitnaics_2022.txt
git check-ignore data/raw/susb/2022/us_state_6digitnaics_2022.txt
git status --short
git diff -- paper/draft.md
git diff --check
rg -n "philosophical|religious|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" data/README.md data/manifests/README.md data/manifests/susb_2022_manifest.csv research/data/acquisition_scaffold.md docs/operator/returns/2026-06-11-susb-first-download-return.md
rg -n "[ \t]+$" data/manifests/susb_2022_manifest.csv research/data/acquisition_scaffold.md docs/operator/returns/2026-06-11-susb-first-download-return.md
```

Results:

- Download command returned `http_status=200`, `content_type=text/plain`, and
  `size_download=56000447`.
- `shasum -a 256`: returned
  `6f7b2f2b14cbad9dbfeb31d3bfc9f729368a0e971727de4eda88c9f83f77a513`.
- `wc -l`: returned `570106`.
- `wc -c`: returned `56000447`.
- `head -n 1`: returned the observed header recorded above.
- `git check-ignore`: returned
  `data/raw/susb/2022/us_state_6digitnaics_2022.txt`.
- `git status --short --ignored data/raw/susb/2022/us_state_6digitnaics_2022.txt`:
  returned `!! data/raw/`.
- `git diff -- paper/draft.md`: no output.
- `git diff --check`: passed with no output.
- Prohibited-foundation/polemical-language scan: no output after replacing one
  false-positive guardrail phrase.
- Trailing-whitespace scan: no output.

## Commit Status

No commit or push was performed for this slice.
