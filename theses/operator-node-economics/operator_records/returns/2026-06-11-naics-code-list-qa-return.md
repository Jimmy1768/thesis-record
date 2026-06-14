---
record_id: return-2026-06-11-naics-code-list-qa
record_type: return
workflow_id: 2026-06-11-naics-code-list-qa
status: completed
created_at: 2026-06-11T23:55:00+08:00
owner: Research
---

# Return: NAICS Code-List QA

## Scope

This Research pass applied the committed NAICS harmonization rule to actual
candidate dataset code lists. It inspected NES, AIES-NES, BDS API, SUSB
U.S./state raw file code lists, and BDS sector CSV code lists. It did not run
quantitative analysis, create a crosswalk dataset, create a processed panel,
or write paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/naics_code_list_qa.md`
- `research/data/naics_panel_inventory.md`
- `research/data/schema_mapping.md`
- `research/empirical_strategy.md`
- `paper/evidence_requirements.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-11-naics-code-list-qa-return.md`

## Sources Inspected Or Reused

- Census 2022 NAICS structure workbook.
- NES 2023 API code-list query.
- AIES-NES 2023 API code-list query.
- BDS API 2022 tested-context code-list query.
- SUSB 2022 U.S./state local ignored raw file.
- BDS sector-age-size local ignored raw file.

## Exact Verification Performed

Code-list counts:

| Source | Code Count |
| --- | ---: |
| NES 2023 U.S. all-class | 452 |
| AIES-NES 2023 U.S. | 425 |
| SUSB 2022 U.S. total `ENTRSIZE=01` | 2,003 |
| BDS API 2022 tested context | 394 |
| BDS sector-age-size CSV | 19 |

NES 2022 change-indicator counts:

| Indicator | Count |
| --- | ---: |
| blank | 368 |
| `*` | 12 |
| `**` | 58 |
| `***` | 5 |
| `****` | 5 |
| total/range not in structure workbook | 4 |

Fine-code join readiness against NES:

| Source | Native/Sector Context | Same-Code Stable Or Title-Only | Changed Indicator Blocked | Absent From NES |
| --- | ---: | ---: | ---: | ---: |
| AIES-NES 2023 | 3 | 338 | 9 | 75 |
| SUSB 2022 U.S. total | 4 | 380 | 10 | 1,609 |
| BDS API 2022 tested context | 4 | 231 | 9 | 150 |

Canonical all-source sector overlap for NES, AIES-NES, SUSB, and BDS API:

```text
11;21;22;23;31-33;42;44-45;48-49;51;52;53;54;56;62;71;72;81
```

First-pass all-source sector exclusions:

- `55`: absent from NES and AIES-NES inspected code lists.
- `61`: absent from AIES-NES inspected code list.

## Decision

First-pass mixed-vintage panels should use canonical sector-level joins and
the 17-sector all-source overlap above. Fine-code joins remain architecture
subsets only until a panel-specific code-list QA table and any needed
allocation source are approved.

## Remaining Blockers

- Many-to-many 2017-to-2022 allocation-weight source remains unselected.
- No actual panel code-list table has been generated or committed.
- State/county/metro code-list QA remains undone.
- BTOS public-use extract schema remains unresolved.
- BFS `category_code` to NAICS mapping remains unresolved.

## Guardrails Preserved

- No `paper/draft.md` edit.
- No paper prose.
- No quantitative analysis.
- No transformation script.
- No processed crosswalk or panel.
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
rg -n "naics_code_list_qa|17-sector|same-code|changed|Absent From NES|No quantitative analysis|No transformation|55|61" research/data/naics_code_list_qa.md research/data/naics_panel_inventory.md research/data/schema_mapping.md research/empirical_strategy.md paper/evidence_requirements.md research/reading_queue.md docs/operator/returns/2026-06-11-naics-code-list-qa-return.md
rg -n "philosophical|religious|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" research/data/naics_code_list_qa.md research/data/naics_panel_inventory.md research/data/schema_mapping.md research/empirical_strategy.md paper/evidence_requirements.md research/reading_queue.md docs/operator/returns/2026-06-11-naics-code-list-qa-return.md
rg -n "[ \t]+$" research/data/naics_code_list_qa.md research/data/naics_panel_inventory.md research/data/schema_mapping.md research/empirical_strategy.md paper/evidence_requirements.md research/reading_queue.md docs/operator/returns/2026-06-11-naics-code-list-qa-return.md
```

Expected results:

- `git diff -- paper/draft.md`: no output.
- `git diff --check`: pass with no output.
- `git check-ignore`: returns `.env.local`, BDS raw file, and SUSB raw file.
- Code-list QA scan returns expected matches.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.

## Commit Status

This slice is ready to commit after verification.
