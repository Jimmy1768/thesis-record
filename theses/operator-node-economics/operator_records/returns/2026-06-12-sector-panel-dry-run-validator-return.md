---
record_id: return-2026-06-12-sector-panel-dry-run-validator
record_type: return
workflow_id: 2026-06-12-sector-panel-dry-run-validator
status: completed
created_at: 2026-06-12T01:15:00+08:00
owner: Research
---

# Return: Sector Panel Dry-Run Validator

## Scope

This Research pass added a local-only dry-run validator for the 17-sector
query/file inventory. The validator checks inventory shape, planned row counts,
API-key redaction, local-file checksums, and local-file headers. It includes an
optional API-fetch mode for a later slice, but this pass did not run network
fetches.

It did not retrieve API payloads, download new data, create staging tables,
create a processed panel, run quantitative analysis, or write paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/sector_panel_dry_run_validator.py`
- `research/data/sector_panel_query_inventory.md`
- `research/data/sector_panel_build_plan.md`
- `research/empirical_strategy.md`
- `docs/operator/returns/2026-06-12-sector-panel-dry-run-validator-return.md`

## Validator Behavior

Default command:

```bash
python3 research/data/sector_panel_dry_run_validator.py
```

Default mode:

- Reads `data/manifests/sector_panel_query_inventory.csv`.
- Verifies exactly 36 inventory rows.
- Verifies 17 NES rows, 17 AIES-NES rows, 2 local-file rows, and 34 planned
  API rows.
- Verifies unique `inventory_id` values.
- Verifies API-key placeholder redaction.
- Verifies the existing SUSB and BDS raw-file checksums against their tracked
  manifests.
- Verifies the existing SUSB and BDS raw-file headers.
- Does not fetch API payloads.
- Does not compute empirical measures.

Optional later command:

```bash
python3 research/data/sector_panel_dry_run_validator.py --fetch-api
```

Targeted optional command:

```bash
python3 research/data/sector_panel_dry_run_validator.py --fetch-api --inventory-id nes_2023_us_sector_11 --inventory-id aies_nes_2023_us_sector_11
```

Optional fetch mode:

- Loads `CENSUS_API_KEY` from ignored `.env.local`.
- Substitutes the key only in memory.
- Writes API payloads under ignored `data/raw/` paths.
- Validates JSON content type, expected header, and row widths.
- Can target specific API rows with repeated `--inventory-id` flags.
- Does not print, log, or store the literal API key.
- Does not compute empirical measures.

Post-commit correction during API smoke-test preparation:

- AIES-NES planned sector queries must use `SECTOR`, not `NAICS2017`, as the
  API predicate.
- A redacted diagnostic found `NAICS2017=11` returned an empty body, while the
  all-row AIES query and `SECTOR=11` returned valid JSON.
- The query inventory was corrected before the targeted fetch smoke test.

## Verification Results

Local-only validator output:

```text
mode=local-only
inventory_rows=36
nes_rows=17
aies_rows=17
local_file_rows=2
planned_rows=34
local_files_checked=2
api_payloads_fetched=0
analysis_performed=false
```

## Guardrails Preserved

- No `paper/draft.md` edit.
- No paper prose.
- No quantitative analysis.
- No API payload retrieval in this pass.
- No new raw data download in this pass.
- No staging table.
- No processed panel.
- No API key or secret recorded.
- No AI-exposure merge.
- No Operator Node claim promoted.
- No decision about the Operator Node hypothesis.
- No prohibited philosophical or religious foundation.

## Verification Commands

Run after editing:

```bash
python3 research/data/sector_panel_dry_run_validator.py
git diff -- paper/draft.md
git diff --check
rg -n "sector_panel_dry_run_validator|analysis_performed=false|No quantitative analysis|No API payload|No new raw data|No processed panel|--fetch-api" research/data/sector_panel_dry_run_validator.py research/data/sector_panel_query_inventory.md research/data/sector_panel_build_plan.md research/empirical_strategy.md docs/operator/returns/2026-06-12-sector-panel-dry-run-validator-return.md
rg -n "philosophical|religious|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" research/data/sector_panel_dry_run_validator.py research/data/sector_panel_query_inventory.md research/data/sector_panel_build_plan.md research/empirical_strategy.md docs/operator/returns/2026-06-12-sector-panel-dry-run-validator-return.md
rg -n "[ \t]+$" research/data/sector_panel_dry_run_validator.py research/data/sector_panel_query_inventory.md research/data/sector_panel_build_plan.md research/empirical_strategy.md docs/operator/returns/2026-06-12-sector-panel-dry-run-validator-return.md
```

Expected results:

- Validator output matches the local-only output block above.
- `git diff -- paper/draft.md`: no output.
- `git diff --check`: pass with no output.
- Validator/guardrail scan returns expected matches.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.

## Commit Status

This slice is ready to commit after verification.
