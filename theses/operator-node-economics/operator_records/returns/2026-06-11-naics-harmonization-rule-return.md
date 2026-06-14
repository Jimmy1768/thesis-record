---
record_id: return-2026-06-11-naics-harmonization-rule
record_type: return
workflow_id: 2026-06-11-naics-harmonization-rule
status: completed
created_at: 2026-06-11T23:30:00+08:00
owner: Research
---

# Return: NAICS Harmonization Rule

## Scope

This Research pass selected a conservative NAICS harmonization rule for future
mixed 2017/2022-vintage empirical panels. It inspected the official Census
NAICS page and the official 2022 NAICS structure workbook. It did not run
quantitative analysis, create a crosswalk dataset, create a transformation
script, or write paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/naics_harmonization_rule.md`
- `research/source_notes/census_2022_naics_reference_files.md`
- `research/data/schema_mapping.md`
- `research/data/field_dictionary.md`
- `research/data/naics_panel_inventory.md`
- `research/empirical_strategy.md`
- `paper/evidence_requirements.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-11-naics-harmonization-rule-return.md`

## Sources Inspected

- Census NAICS page: `https://www.census.gov/naics/`
- Official Census workbook:
  `https://www.census.gov/naics/2022NAICS/2022_NAICS_Structure.xlsx`

Workbook metadata:

- HTTP status: 200.
- Content type:
  `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`.
- Content length: 88,218 bytes.
- Last modified: Thu, 02 Apr 2026 14:22:16 GMT.
- SHA-256:
  `217c9e0d4d74e7517bc288f5f308b73aa0de5ee787976a6dd222412be28ada22`.

## Exact Verification Performed

Workbook inspection:

- Sheet: `2022 NAICS Structure`.
- Rows: 2,147.
- Columns: 6.
- Header fields: `Change Indicator`, `2022 NAICS Code`,
  `2022 NAICS Title`.

Change-indicator definitions recorded:

- blank: no indicated 2022 change.
- `*`: title change, no content change.
- `**`: new code for 2022 NAICS.
- `***`: re-used code, content change, with or without title change.
- `****`: re-used code, content change at lower level with insignificant
  impact at this level, with or without title change.

Indicator counts:

| Indicator | Count |
| --- | ---: |
| blank | 1,896 |
| `*` | 31 |
| `**` | 186 |
| `***` | 7 |
| `****` | 5 |

## Decision

The selected rule is conservative stable-code and aggregation harmonization:

- Preserve native NAICS vintage in every dataset.
- Default mixed 2017/2022 joins to stable sector-level comparison.
- Permit finer same-code comparison only when the 2022 code has a blank or
  `*` title-only change indicator and the same code is present in the
  2017-vintage source.
- Treat `**`, `***`, and `****` codes as changed-code cells that require
  exclusion, aggregation to a stable parent, or a later approved
  concordance/allocation rule.
- Do not split receipts, employment, payroll, firms, establishments, or
  formation counts across changed codes in first-pass architecture.

## Remaining Blockers

- No many-to-many 2017-to-2022 allocation-weight source is selected.
- No code-list QA table has been generated for actual panel datasets.
- BFS `category_code` to NAICS mapping remains unresolved.
- BTOS public-use extract schema remains unresolved.

## Guardrails Preserved

- No `paper/draft.md` edit.
- No paper prose.
- No quantitative analysis.
- No transformation script.
- No processed crosswalk.
- No Operator Node claim promoted.
- No decision about the Operator Node hypothesis.
- No prohibited philosophical or religious foundation.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
rg -n "naics_harmonization_rule|same_code_stable_or_title_only|changed_blocked|2022_NAICS_Structure|Change Indicator|allocation-weight|No quantitative analysis|No transformation" research/data/naics_harmonization_rule.md research/source_notes/census_2022_naics_reference_files.md research/data/schema_mapping.md research/data/field_dictionary.md research/data/naics_panel_inventory.md research/empirical_strategy.md paper/evidence_requirements.md research/reading_queue.md docs/operator/returns/2026-06-11-naics-harmonization-rule-return.md
rg -n "philosophical|religious|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" research/data/naics_harmonization_rule.md research/source_notes/census_2022_naics_reference_files.md research/data/schema_mapping.md research/data/field_dictionary.md research/data/naics_panel_inventory.md research/empirical_strategy.md paper/evidence_requirements.md research/reading_queue.md docs/operator/returns/2026-06-11-naics-harmonization-rule-return.md
rg -n "[ \t]+$" research/data/naics_harmonization_rule.md research/source_notes/census_2022_naics_reference_files.md research/data/schema_mapping.md research/data/field_dictionary.md research/data/naics_panel_inventory.md research/empirical_strategy.md paper/evidence_requirements.md research/reading_queue.md docs/operator/returns/2026-06-11-naics-harmonization-rule-return.md
```

Expected results:

- `git diff -- paper/draft.md`: no output.
- `git diff --check`: pass with no output.
- Harmonization scan returns expected matches.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.

## Commit Status

This slice is ready to commit after verification.
