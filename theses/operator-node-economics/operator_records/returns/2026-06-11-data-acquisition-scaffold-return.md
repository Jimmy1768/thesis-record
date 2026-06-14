---
record_id: return-2026-06-11-data-acquisition-scaffold
record_type: return
workflow_id: 2026-06-11-data-acquisition-scaffold
status: completed
created_at: 2026-06-11T17:28:15+08:00
owner: Research
---

# Return: Data Acquisition Scaffold

## Scope

This Research pass created a conservative data acquisition scaffold for the
empirical strategy. It did not download raw datasets, write ingestion scripts,
or run quantitative analysis.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/acquisition_scaffold.md`
- `research/empirical_strategy.md`
- `docs/operator/returns/2026-06-11-data-acquisition-scaffold-return.md`

## Sources And Metadata Inspected

Reused committed source-truth and schema files:

- `research/data/schema_mapping.md`
- `research/data/field_dictionary.md`
- `research/data/naics_panel_inventory.md`
- `docs/operator/returns/2026-06-11-schema-blocker-closure-return.md`
- `research/source_notes/census_2023_nonemployer_statistics.md`
- `research/source_notes/census_2023_business_dynamics_statistics.md`
- `research/source_notes/census_2022_statistics_us_businesses.md`
- `research/source_notes/census_2026_ai_use_us_businesses.md`

Additional official metadata inspected:

- NES 2023 API examples:
  `https://api.census.gov/data/2023/nonemp/examples.json`
- NES 2023 API geography:
  `https://api.census.gov/data/2023/nonemp/geography.json`
- AIES-NES 2023 API examples:
  `https://api.census.gov/data/2023/aiesnonemp/examples.json`
- BDS API examples:
  `https://api.census.gov/data/timeseries/bds/examples.json`
- SUSB 2022 dataset directory:
  `https://www2.census.gov/programs-surveys/susb/datasets/2022/`
- Guessed SUSB U.S./state file paths checked and rejected after 404 responses.

## Acquisition Readiness Changes

- NES 2023 is classified as `metadata_ready_smoke_test_required`.
- AIES-NES 2023 is classified as `metadata_ready_smoke_test_required`.
- BDS basic API is classified as `metadata_ready_smoke_test_required`.
- BDS `BDSFAGEFSIZE` is classified as
  `group_metadata_ready_query_validation_required`.
- SUSB U.S./state annual is classified as `schema_ready_file_path_required`.
- BFS remains blocked.
- BTOS AI supplement remains blocked for extract acquisition.

## Pull Templates Added

The scaffold records candidate smoke-test query templates for:

- NES 2023 U.S.-level nonemployer receipt/count metadata validation.
- AIES-NES 2023 U.S.-level employer/nonemployer revenue comparison metadata
  validation.
- BDS basic U.S.-level employer-firm metadata validation.

These templates are not results and must be smoke-tested before any bulk pull.

## Explicit Non-Pulls

- BFS: blocked because API `data_type_code` values and `category_code` to
  NAICS mapping remain unresolved.
- BTOS AI supplement: blocked because public-use AI variable names, survey
  period fields, weights, and extract schema remain unresolved.
- Raw SUSB U.S./state files: blocked until a durable file path is verified.

## Empirical Strategy Update

`research/empirical_strategy.md` now marks the NAICS panel inventory, field
dictionary, and acquisition scaffold as completed architecture tasks. The next
data tasks are:

1. Run schema-only API smoke tests for NES 2023, AIES-NES 2023, and BDS basic
   U.S.-level queries.
2. Validate the BDS `BDSFAGEFSIZE` combined query.
3. Verify the durable SUSB U.S./state annual file path.
4. Define high-AI-exposure sectors from verified BTOS/Bonney evidence and only
   later from a separately verified occupation-weighted exposure source.
5. Identify low-asset-specificity, measurable-output sectors.

## Guardrails Preserved

- No quantitative analysis was run.
- No raw data was downloaded or committed.
- No ingestion script was added.
- No Operator Node claim was promoted.
- BFS employer formations remain only an indirect payroll-transition proxy.
- BTOS remains employer-business AI exposure only, not nonemployer AI evidence.
- Bick/Blandin/Deming remains worker-level GenAI adoption context only.
- TCE-P005 remains blocked.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
rg -n "metadata_ready_smoke_test_required|group_metadata_ready_query_validation_required|schema_ready_file_path_required|blocked|No quantitative analysis|No raw data|payroll-transition proxy|TCE-P005" research/data/acquisition_scaffold.md research/empirical_strategy.md docs/operator/returns/2026-06-11-data-acquisition-scaffold-return.md
rg -n "https://api.census.gov/data/2023/nonemp/examples.json|https://api.census.gov/data/2023/aiesnonemp/examples.json|https://api.census.gov/data/timeseries/bds/examples.json|https://www2.census.gov/programs-surveys/susb/datasets/2022/" docs/operator/returns/2026-06-11-data-acquisition-scaffold-return.md
rg -n "Buddh[i]sm|Tao[i]sm|Sun[y]ata|dependent[ -]originat[i]on|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" research/data/acquisition_scaffold.md research/empirical_strategy.md docs/operator/returns/2026-06-11-data-acquisition-scaffold-return.md
rg -n "[ \t]+$" research/data/acquisition_scaffold.md research/empirical_strategy.md docs/operator/returns/2026-06-11-data-acquisition-scaffold-return.md
git status --short
```

Results:

- `git diff -- paper/draft.md`: no output.
- `git diff --check`: passed with no output.
- Readiness/guardrail scan returned expected matches for readiness classes,
  blockers, no-analysis/no-raw-data guardrails, payroll-transition proxy, and
  TCE-P005 block.
- Official metadata path scan returned expected matches for NES, AIES-NES,
  BDS, and SUSB metadata paths.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.
- `git status --short`: includes this Research slice plus separate Writer
  thread changes in `paper/argument_map.md`, `paper/evidence_requirements.md`,
  `paper/outline.md`, and
  `docs/operator/returns/2026-06-11-writer-schema-architecture-awareness-return.md`.
  Those Writer-thread files were not edited by Research.

## Commit Status

No commit or push was performed for this slice.
