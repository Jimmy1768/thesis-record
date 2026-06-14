---
record_id: return-2026-06-11-schema-mapping
record_type: return
workflow_id: 2026-06-11-schema-mapping
status: completed
created_at: 2026-06-11T16:38:44+08:00
owner: Research
---

# Return: Schema Mapping

## Scope

This Research pass closed exact schema-mapping gaps where official Census API
metadata was available. It did not run quantitative analysis.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/schema_mapping.md`
- `research/data/field_dictionary.md`
- `research/data/naics_panel_inventory.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-11-schema-mapping-return.md`

## Sources And API Docs Inspected

- Census API catalog:
  `https://api.census.gov/data.json`
- BFS variables:
  `https://api.census.gov/data/timeseries/eits/bfs/variables.json`
- BFS geography:
  `https://api.census.gov/data/timeseries/eits/bfs/geography.json`
- BDS variables:
  `https://api.census.gov/data/timeseries/bds/variables.json`
- BDS geography:
  `https://api.census.gov/data/timeseries/bds/geography.json`
- AIES-NES variables:
  `https://api.census.gov/data/2023/aiesnonemp/variables.json`
- AIES-NES geography:
  `https://api.census.gov/data/2023/aiesnonemp/geography.json`
- Existing accepted source notes for NES, BFS, BDS, SUSB, BTOS, Bonney et al.
  2026, and Bick/Blandin/Deming 2024.

## Exact Fields Verified

NES exact fields were already mapped and preserved:

- `YEAR`, `NAICS2022`, `NESTAB`, `NRCPTOT`, `NRCPTOT_N`, `RCPSZES`, `LFO`,
  `SECTOR`, `SUBSECTOR`, `GEO_ID`, `STATE`, `COUNTY`, `CBSA`, `CSA`.

BFS exact API structural fields verified:

- `time`, `data_type_code`, `time_slot_id`, `seasonally_adj`, `program_code`,
  `category_code`, `geo_level_code`, `time_slot_date`, `time_slot_name`,
  `cell_value`, `error_data`.

BDS exact fields verified:

- `time`, `YEAR`, `NAICS`, `FIRM`, `ESTAB`, `EMP`, `ESTABS_ENTRY`,
  `ESTABS_EXIT`, `FIRMDEATH_FIRMS`, `JOB_CREATION`,
  `JOB_CREATION_BIRTHS`, `JOB_DESTRUCTION`, `JOB_DESTRUCTION_DEATHS`,
  `NET_JOB_CREATION`, `FAGE`, `EMPSZFI`, `EMPSZES`, `GEO_ID`, `STATE`,
  `COUNTY`, `CBSA`.

AIES-NES exact fields verified:

- `YEAR`, `NAICS2017`, `RCPT_TOT_VAL`, `RCPT_TOT_VAL_NS`, `RCPT_TOT_CV`,
  `RCPT_TOT_VAL_NS_N`, `SECTOR`, `SUBSECTOR`, `INDGROUP`, `INDLEVEL`,
  `GEO_ID`, `NATION`.

## Fields Still Unresolved

- BFS exact `data_type_code` values for business applications,
  high-propensity applications, four-quarter formations, eight-quarter
  formations, and projected formations.
- BFS `category_code` to NAICS mapping.
- BDS direct firm-startup field distinct from establishment entry; firm exits
  are mapped via `FIRMDEATH_FIRMS`.
- BDS group/table constraints for combining NAICS, firm age, firm size, and
  geography.
- SUSB exact public-use/API/download schema fields.
- BTOS AI supplement exact public-use/API field names, survey-period fields,
  industry fields, size fields, geography fields, and weights.
- AIES-NES years beyond the 2023 endpoint.

## Compatibility Matrix Summary

| Dataset | NAICS-Year | Geography-NAICS-Year | Employer/Nonemployer Cells | Exposure Cells |
| --- | --- | --- | --- | --- |
| NES | Yes, with 2022 NAICS and methodology caveat | Yes for U.S./state/county/metro/CSA where available | Nonemployer side only | No |
| AIES-NES | Yes for 2023 national 2017 NAICS | No, U.S.-only in inspected API metadata | Yes, national employer/nonemployer revenue fields | No |
| BFS | Blocked until `category_code` mapping is verified | Blocked in inspected API metadata; U.S.-only geography confirmed | No | No |
| BDS | Yes for employer dynamics using 2017 NAICS | Potentially yes for U.S./state/county/metro, subject to query groups | Employer side only | No |
| SUSB | Plausible, but exact schema unresolved | Plausible, but exact schema/geography unresolved | Employer side only | No |
| BTOS AI supplement | Possible only after industry and period schema verified | Unresolved | Employer businesses only | Yes, employer-business AI adoption |
| Bonney et al. 2026 | Context only, not public panel schema in repo | No | Employer firms only | Yes, employer-firm AI diffusion context |
| Bick/Blandin/Deming 2024 | No NAICS panel role | No | No | Worker-level GenAI adoption context only |

## Guardrails Preserved

- BFS employer formations remain only an indirect payroll-transition proxy.
- Bick/Blandin/Deming remains worker-level GenAI adoption context only.
- ArXiv-only AI entrepreneurship or labor-substitution sources remain outside
  source truth and claim support.
- TCE-P005 remains blocked; no management-layer fields were verified.
- No quantitative analysis was run.
- No Operator Node claim was promoted.

## Remaining Blockers

- Exact SUSB schema/access path.
- Exact BTOS AI supplement schema/access path.
- BFS value-code mapping for `data_type_code` and `category_code`.
- BDS group/table constraints and direct firm-startup variable status.
- NAICS-vintage crosswalks, especially 2017 NAICS versus 2022 NAICS.
- Any direct AI-use field for nonemployers.
- Any management-layer fields for TCE-P005.
- Any vendor-substitution or procurement-friction fields.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
rg -n "data_type_code|category_code|FIRMDEATH_FIRMS|ESTABS_ENTRY|RCPT_TOT_VAL_NS|NAICS2017|NAICS2022|concept_field|verified_exact" research/data/schema_mapping.md research/data/field_dictionary.md research/data/naics_panel_inventory.md
rg -n "payroll-transition proxy|worker-level GenAI adoption|arXiv-only|TCE-P005|No quantitative analysis|No Operator Node claim" research/data/schema_mapping.md docs/operator/returns/2026-06-11-schema-mapping-return.md
rg -n "SUSB|BTOS|value-code|group constraints|NAICS-vintage|management-layer" research/reading_queue.md research/data/schema_mapping.md
```

Expected results:

- `paper/draft.md` should show no diff.
- `git diff --check` should pass.
- Schema files should show exact verified fields and unresolved blockers.

## Acceptance Readiness

This slice is ready for Company Operator acceptance review. It should not be
committed until accepted or explicitly approved by the user.
