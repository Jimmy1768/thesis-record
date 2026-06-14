---
record_id: return-2026-06-11-bds-ingestion-readiness
record_type: return
workflow_id: 2026-06-11-bds-ingestion-readiness
status: completed
created_at: 2026-06-11T23:18:00+08:00
owner: Research
---

# Return: BDS CSV Ingestion Readiness

## Scope

This Research pass documented ingestion-readiness rules for the official BDS
sector by firm age by firm size CSV. It inspected raw file structure and
official BDS methodology for publication-flag handling. It did not run
quantitative analysis, create an ingestion script, create a processed panel, or
write paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/bds_ingestion_readiness.md`
- `research/data/bds_multiyear_firm_age_size_path.md`
- `research/data/acquisition_scaffold.md`
- `research/data/schema_mapping.md`
- `data/manifests/bds_2023_manifest.csv`
- `docs/operator/returns/2026-06-11-bds-ingestion-readiness-return.md`

## Exact Verification Performed

Raw-file QA:

- Rows excluding header: 104,880.
- Column count: 28.
- Rows with unexpected column count: 0.
- Year count: 46.
- Observed year range: 1978-2023.
- Sector count: 19.
- Firm-age category count: 12.
- Firm-size category count: 10.

Official methodology inspected:

- `https://www.census.gov/programs-surveys/bds/documentation/methodology.html`

Publication-flag interpretation recorded:

- `D`: cells with fewer than three firms.
- `S`: cells with identified data-quality concerns.
- `X`: structurally missing or structurally zero cells.
- `N`: rate cells that cannot be calculated.

Observed in `bds2023_sec_fa_fz.csv`:

- `D`, `X`, and `N` appear.
- `S` was not observed but remains an official flag and must be handled.

## Rules Added

- Treat `D`, `S`, `X`, and `N` as structured flags, not numeric zero.
- Preserve per-cell flags before numeric coercion.
- Coerce flagged measure cells to null unless a later analysis plan explicitly
  chooses a different treatment.
- Do not impute flagged cells during ingestion.
- Verify header, row width, allowed categories, checksum, and key uniqueness
  before any processed panel is created.

## Related Official Paths Not Pulled

The BDS datasets page exposes additional official CSV paths that may be useful
in future architecture passes, including separate firm-age, firm-size, 3-digit
NAICS, 4-digit NAICS, state-sector, and metro/non-metro tables. They were not
downloaded in this slice.

## Guardrails Preserved

- No `paper/draft.md` edit.
- No paper prose.
- No quantitative analysis.
- No ingestion or cleaning script.
- No processed panel.
- No API key or secret recorded.
- No Operator Node claim promoted.
- No decision about the Operator Node hypothesis.
- No prohibited philosophical or religious foundation.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
git check-ignore .env.local data/raw/bds/2023/bds2023_sec_fa_fz.csv data/raw/susb/2022/us_state_6digitnaics_2022.txt
rg -n "D|S|X|N|publication flag|bds_ingestion_readiness|Rows with unexpected column count|No quantitative analysis|No ingestion" research/data/bds_ingestion_readiness.md research/data/bds_multiyear_firm_age_size_path.md research/data/acquisition_scaffold.md research/data/schema_mapping.md data/manifests/bds_2023_manifest.csv docs/operator/returns/2026-06-11-bds-ingestion-readiness-return.md
rg -n "Buddh[i]sm|Tao[i]sm|Sun[y]ata|dependent[ -]originat[i]on|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" research/data/bds_ingestion_readiness.md research/data/bds_multiyear_firm_age_size_path.md research/data/acquisition_scaffold.md research/data/schema_mapping.md data/manifests/bds_2023_manifest.csv docs/operator/returns/2026-06-11-bds-ingestion-readiness-return.md
rg -n "[ \t]+$" research/data/bds_ingestion_readiness.md research/data/bds_multiyear_firm_age_size_path.md research/data/acquisition_scaffold.md research/data/schema_mapping.md data/manifests/bds_2023_manifest.csv docs/operator/returns/2026-06-11-bds-ingestion-readiness-return.md
```

Results:

- `git diff -- paper/draft.md`: no output.
- `git diff --check`: passed with no output.
- `git check-ignore`: returned `.env.local`, BDS raw file, and SUSB raw file.
- Ingestion-readiness scan returned expected matches.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.

## Commit Status

This slice is ready to commit after verification.
