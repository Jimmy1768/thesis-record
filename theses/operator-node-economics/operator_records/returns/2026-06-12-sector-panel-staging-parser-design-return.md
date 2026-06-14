---
record_id: return-2026-06-12-sector-panel-staging-parser-design
record_type: return
workflow_id: 2026-06-12-sector-panel-staging-parser-design
status: completed
created_at: 2026-06-12T13:20:00+08:00
owner: Research
---

# Return: Sector Panel Staging Parser Design

## Scope

This Research pass designed the staging parser contract for validated NES,
AIES-NES, SUSB, and BDS raw inputs. It defined staging table schemas,
duplicate-header handling, sector mapping rules, QA summary requirements, and a
tracked staging manifest template.

It did not implement a parser, create intermediate outputs, create a processed
panel, run quantitative analysis, merge AI exposure, or write paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/sector_panel_staging_parser_design.md`
- `data/manifests/sector_panel_staging_manifest_template.csv`
- `research/data/sector_panel_build_plan.md`
- `research/empirical_strategy.md`
- `docs/operator/returns/2026-06-12-sector-panel-staging-parser-design-return.md`

## Design Summary

Staging outputs designed:

- `stg_nes_sector_2023`
- `stg_aies_nes_sector_2023`
- `stg_susb_sector_2022`
- `stg_bds_sector_age_size`
- `qa_sector_panel_staging_summary`

Key rules:

- Preserve duplicate API predicate fields with deterministic suffixes:
  `NAICS2022__get`, `NAICS2022__predicate`, `SECTOR__get`, and
  `SECTOR__predicate`.
- Stop if duplicate requested/predicate fields disagree.
- Preserve all noise, suppression, coefficient-of-variation, and publication
  marker fields.
- Add `canonical_sector` only after row-level mapping validation.
- Keep staging outputs under ignored `data/intermediate/`.
- Keep `data/processed/` blocked.
- Do not compute empirical measures.

Manifest row-count cross-check:

```text
NES rows excluding headers across API payloads: 17
AIES-NES rows excluding headers across API payloads: 425
```

## Remaining Blockers

- No staging parser implementation exists.
- No staging outputs exist.
- No processed panel exists.
- No AI-exposure merge exists.
- No empirical findings are authorized.

## Guardrails Preserved

- No `paper/draft.md` edit.
- No paper prose.
- No quantitative analysis.
- No parser implementation.
- No intermediate outputs.
- No processed panel.
- No API key or secret recorded.
- No AI-exposure merge.
- No Operator Node claim promoted.
- No decision about the Operator Node hypothesis.
- No prohibited philosophical or religious foundation.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
rg -n "sector_panel_staging_parser_design|stg_nes_sector_2023|stg_aies_nes_sector_2023|stg_susb_sector_2022|stg_bds_sector_age_size|analysis_performed|No quantitative analysis|No processed panel" research/data/sector_panel_staging_parser_design.md data/manifests/sector_panel_staging_manifest_template.csv research/data/sector_panel_build_plan.md research/empirical_strategy.md docs/operator/returns/2026-06-12-sector-panel-staging-parser-design-return.md
rg -n "philosophical|religious|man[i]festo|conclus[i]ons?|firm is dea[d]|end of the fir[m]" research/data/sector_panel_staging_parser_design.md research/data/sector_panel_build_plan.md research/empirical_strategy.md docs/operator/returns/2026-06-12-sector-panel-staging-parser-design-return.md
rg -n "[ \t]+$" research/data/sector_panel_staging_parser_design.md data/manifests/sector_panel_staging_manifest_template.csv research/data/sector_panel_build_plan.md research/empirical_strategy.md docs/operator/returns/2026-06-12-sector-panel-staging-parser-design-return.md
python3 - <<'PY'
import csv
from pathlib import Path
rows = list(csv.DictReader(Path("data/manifests/sector_panel_api_payload_manifest.csv").open(newline="")))
print(sum(int(r["rows_excluding_header"]) for r in rows if r["dataset"] == "NES 2023 API"))
print(sum(int(r["rows_excluding_header"]) for r in rows if r["dataset"] == "AIES-NES 2023 API"))
PY
```

Expected results:

- `git diff -- paper/draft.md`: no output.
- `git diff --check`: pass with no output.
- Parser-design scan returns expected matches.
- Prohibited-foundation/polemical-language scan: no output.
- Trailing-whitespace scan: no output.
- API payload manifest row-count check prints `17` and `425`.

## Commit Status

This slice is ready to commit after verification.
