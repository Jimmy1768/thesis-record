---
record_id: return-2026-06-11-bds-multiyear-path
record_type: return
workflow_id: 2026-06-11-bds-multiyear-path
status: completed
created_at: 2026-06-11T22:45:00+08:00
owner: Research
---

# Return: BDS Multi-Year Firm-Age-By-Size Path

## Scope

This Research pass searched for an official multi-year BDS firm-age-by-size
path after API `BDSFAGEFSIZE` checks validated only selected 2022 contexts. It
found and inspected an official Census downloadable CSV. It did not run
quantitative analysis, create an analysis dataset, or write paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/bds_multiyear_firm_age_size_path.md`
- `research/source_notes/census_2023_business_dynamics_statistics.md`
- `research/data/bds_coverage_validation.md`
- `research/data/acquisition_scaffold.md`
- `research/data/schema_mapping.md`
- `research/data/naics_panel_inventory.md`
- `research/empirical_strategy.md`
- `research/reading_queue.md`
- `paper/evidence_requirements.md`
- `docs/operator/returns/2026-06-11-bds-multiyear-path-return.md`

## Sources Inspected

- Official Census BDS datasets page:
  `https://www.census.gov/data/datasets/time-series/econ/bds/bds-datasets.html`
- Official Census CSV:
  `https://www2.census.gov/programs-surveys/bds/tables/time-series/2023/bds2023_sec_fa_fz.csv`

The CSV was downloaded only to `/tmp` for schema inspection and was not
committed.

## Blocker Closed

An official multi-year firm-age-by-size source path exists:

- Title/link text: Sector by Firm Age by Firm Size.
- File: `bds2023_sec_fa_fz.csv`.
- HTTP status: 200.
- Content type: `text/csv`.
- Content length: 12,606,118 bytes.
- Last modified: Thu, 25 Sep 2025 12:02:41 GMT.
- Rows excluding header: 104,880.
- Observed years: 1978-2023.
- Observed sector values: 19.
- Observed firm-age categories: 12.
- Observed firm-size categories: 10.

## Schema Verified

Exact header:

```text
year;sector;fage;fsize;firms;estabs;emp;denom;estabs_entry;estabs_entry_rate;estabs_exit;estabs_exit_rate;job_creation;job_creation_births;job_creation_continuers;job_creation_rate_births;job_creation_rate;job_destruction;job_destruction_deaths;job_destruction_continuers;job_destruction_rate_deaths;job_destruction_rate;net_job_creation;net_job_creation_rate;reallocation_rate;firmdeath_firms;firmdeath_estabs;firmdeath_emp
```

## Guardrail Added

The multi-year path is sector-level only. It does not close:

- six-digit NAICS firm-age-by-size coverage;
- subnational firm-age-by-size coverage;
- API `BDSFAGEFSIZE` multi-year coverage;
- nonemployer-to-employer conversion evidence;
- AI exposure, management-layer, transaction-cost, vendor-substitution, or
  one-person firm evidence.

## Remaining Decisions

- Decide whether sector-level multi-year BDS age/size coverage is sufficient
  for the empirical strategy.
- If this CSV is acquired for analysis, create a manifest first and download it
  only under ignored `data/raw/`.
- Keep API `BDSFAGEFSIZE` scoped to verified 2022 contexts unless a separate
  API multi-year route is found.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
git check-ignore .env.local data/raw/susb/2022/us_state_6digitnaics_2022.txt
rg -n "bds2023_sec_fa_fz|Sector by Firm Age by Firm Size|1978-2023|sector-level|multi-year|six-digit|subnational|BDS downloadable sector-age-size CSV" research/data/bds_multiyear_firm_age_size_path.md research/source_notes/census_2023_business_dynamics_statistics.md research/data/bds_coverage_validation.md research/data/acquisition_scaffold.md research/data/schema_mapping.md research/data/naics_panel_inventory.md research/empirical_strategy.md research/reading_queue.md paper/evidence_requirements.md docs/operator/returns/2026-06-11-bds-multiyear-path-return.md
rg -n "Buddh[i]sm|Tao[i]sm|Sun[y]ata|dependent[ -]originat[i]on|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" research/data/bds_multiyear_firm_age_size_path.md research/source_notes/census_2023_business_dynamics_statistics.md research/data/bds_coverage_validation.md research/data/acquisition_scaffold.md research/data/schema_mapping.md research/data/naics_panel_inventory.md research/empirical_strategy.md research/reading_queue.md paper/evidence_requirements.md docs/operator/returns/2026-06-11-bds-multiyear-path-return.md
rg -n "[ \t]+$" research/data/bds_multiyear_firm_age_size_path.md research/source_notes/census_2023_business_dynamics_statistics.md research/data/bds_coverage_validation.md research/data/acquisition_scaffold.md research/data/schema_mapping.md research/data/naics_panel_inventory.md research/empirical_strategy.md research/reading_queue.md paper/evidence_requirements.md docs/operator/returns/2026-06-11-bds-multiyear-path-return.md
```

Results:

- `git diff -- paper/draft.md`: no output.
- `git diff --check`: passed with no output.
- `git check-ignore`: returned `.env.local` and the SUSB raw file path.
- BDS path scan returned expected matches.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.

## Commit Status

This slice is ready to commit after verification.
