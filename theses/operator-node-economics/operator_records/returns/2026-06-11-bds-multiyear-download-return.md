---
record_id: return-2026-06-11-bds-multiyear-download
record_type: return
workflow_id: 2026-06-11-bds-multiyear-download
status: completed
created_at: 2026-06-11T22:52:35+08:00
owner: Research
---

# Return: BDS Multi-Year Local Download

## Scope

This Research pass downloaded the official Census BDS sector by firm age by
firm size CSV into ignored local storage and created a tracked manifest. It did
not run quantitative analysis, create a processed panel, or write paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `data/README.md`
- `data/manifests/bds_2023_manifest.csv`
- `research/data/acquisition_scaffold.md`
- `docs/operator/returns/2026-06-11-bds-multiyear-download-return.md`

## Source Acquired

- Dataset: BDS 2023 sector by firm age by firm size
- Source owner: U.S. Census Bureau
- Source page:
  `https://www.census.gov/data/datasets/time-series/econ/bds/bds-datasets.html`
- File URL:
  `https://www2.census.gov/programs-surveys/bds/tables/time-series/2023/bds2023_sec_fa_fz.csv`
- Local path:
  `data/raw/bds/2023/bds2023_sec_fa_fz.csv`
- Git status of local raw file: ignored by `.gitignore`

## Manifest Metadata

- HTTP status: 200
- Content type: `text/csv`
- Content length / byte count: 12,606,118
- SHA-256:
  `c4790ccdf964788a8bbc8404349df69db2a7457f8784411a39ddb228dedfbabd`
- Row count including header: 104,881
- Observed header:
  `year,sector,fage,fsize,firms,estabs,emp,denom,estabs_entry,estabs_entry_rate,estabs_exit,estabs_exit_rate,job_creation,job_creation_births,job_creation_continuers,job_creation_rate_births,job_creation_rate,job_destruction,job_destruction_deaths,job_destruction_continuers,job_destruction_rate_deaths,job_destruction_rate,net_job_creation,net_job_creation_rate,reallocation_rate,firmdeath_firms,firmdeath_estabs,firmdeath_emp`

## Guardrails Preserved

- No `paper/draft.md` edit.
- No paper prose.
- No quantitative analysis.
- No processed panel or transformation script.
- No API key or secret recorded.
- No Operator Node claim promoted.
- No decision about the Operator Node hypothesis.
- No prohibited philosophical or religious foundation.
- Raw data was written only under ignored `data/raw/`.

## Remaining Blockers

- Decide whether sector-level BDS age/size coverage is sufficient for the
  empirical strategy.
- Preserve that this CSV does not close six-digit NAICS or subnational
  firm-age-by-size coverage.
- Any future ingestion must handle `D` and `X` values explicitly.

## Verification Commands

Run after acquisition and editing:

```bash
curl -sL -o data/raw/bds/2023/bds2023_sec_fa_fz.csv -w 'http_status=%{http_code}\ncontent_type=%{content_type}\nsize_download=%{size_download}\n' https://www2.census.gov/programs-surveys/bds/tables/time-series/2023/bds2023_sec_fa_fz.csv
shasum -a 256 data/raw/bds/2023/bds2023_sec_fa_fz.csv
wc -l data/raw/bds/2023/bds2023_sec_fa_fz.csv
wc -c data/raw/bds/2023/bds2023_sec_fa_fz.csv
head -n 1 data/raw/bds/2023/bds2023_sec_fa_fz.csv
git check-ignore data/raw/bds/2023/bds2023_sec_fa_fz.csv
git diff -- paper/draft.md
git diff --check
rg -n "bds2023_sec_fa_fz|bds_2023_manifest|first_raw_file_downloaded_manifested_local_only|D and X|No quantitative analysis|No paper prose" data/README.md data/manifests/bds_2023_manifest.csv research/data/acquisition_scaffold.md docs/operator/returns/2026-06-11-bds-multiyear-download-return.md
rg -n "philosophical|religious|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" data/README.md data/manifests/bds_2023_manifest.csv research/data/acquisition_scaffold.md docs/operator/returns/2026-06-11-bds-multiyear-download-return.md
rg -n "[ \t]+$" data/README.md data/manifests/bds_2023_manifest.csv research/data/acquisition_scaffold.md docs/operator/returns/2026-06-11-bds-multiyear-download-return.md
```

Results:

- Download returned `http_status=200`, `content_type=text/csv`, and
  `size_download=12606118`.
- `shasum -a 256`: returned
  `c4790ccdf964788a8bbc8404349df69db2a7457f8784411a39ddb228dedfbabd`.
- `wc -l`: returned `104881`.
- `wc -c`: returned `12606118`.
- `head -n 1`: returned the observed header recorded above.
- `git check-ignore`: returned the raw file path.
- `git diff -- paper/draft.md`: no output.
- `git diff --check`: passed with no output.
- BDS download scan returned expected matches.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.

## Commit Status

This slice is ready to commit after verification.
