---
record_id: return-2026-06-11-schema-blocker-closure
record_type: return
workflow_id: 2026-06-11-schema-blocker-closure
status: completed
created_at: 2026-06-11T16:55:54+08:00
owner: Research
---

# Return: Schema Blocker Closure

## Scope

This Research pass attempted to close the remaining schema blockers for the
empirical data inventory. It remained data architecture only and did not run
quantitative analysis.

`paper/draft.md` was not edited.

## Files Changed

- `research/data/schema_mapping.md`
- `research/data/field_dictionary.md`
- `research/data/naics_panel_inventory.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-11-schema-blocker-closure-return.md`

## Sources And API Docs Inspected

- BFS API fields and geography:
  `https://api.census.gov/data/timeseries/eits/bfs/variables.json`
  and `https://api.census.gov/data/timeseries/eits/bfs/geography.json`
- BFS API groups/value-code probes:
  `https://api.census.gov/data/timeseries/eits/bfs/groups.json`,
  `.../variables/data_type_code.json`, `.../variables/category_code.json`,
  and selected API data probes.
- BFS official definitions:
  `https://www.census.gov/econ/bfs/definitions.html`
- BDS API groups and variables:
  `https://api.census.gov/data/timeseries/bds/groups.json`,
  `https://api.census.gov/data/timeseries/bds/groups/BDSFAGEFSIZE.json`,
  and `https://api.census.gov/data/timeseries/bds/variables.json`
- SUSB 2022 dataset page:
  `https://www.census.gov/data/datasets/2022/econ/susb/2022-susb.html`
- SUSB record layout:
  `https://www.census.gov/programs-surveys/susb/technical-documentation/record-layouts.html`
  and
  `https://www2.census.gov/programs-surveys/susb/technical-documentation/record_layout_us_and_state_2007_to_present.txt`
- BTOS data page:
  `https://www.census.gov/data/experimental-data-products/business-trends-and-outlook-survey.html`
- BTOS AI-supplement questionnaire:
  `https://www2.census.gov/data/experimental-data-products/business-trends-and-outlook-survey/questionnaire-ai-supplement.pdf`
- Census NAICS page and 2022 structure file:
  `https://www.census.gov/naics/` and
  `https://www.census.gov/naics/2022NAICS/2022_NAICS_Structure.xlsx`
- BLS NAICS 2022 CES conversion documentation:
  `https://www.bls.gov/ces/naics/naics-2022.htm`

## Blockers Closed

- SUSB U.S./state annual public-use record layout is now verified for
  2007-present fields.
- BDS group metadata is partially closed for firm age by firm size: the
  `BDSFAGEFSIZE` group includes the relevant age, size, NAICS, geography, and
  employer-dynamics fields.
- BTOS coverage, geography/industry tabulation levels, expanded size classes,
  and AI question numbers are verified from official Census sources.
- Official BFS measure abbreviations are verified from the BFS definitions
  page, but not as API value codes.
- Official NAICS reference/concordance access was identified; no crosswalk
  transformation was implemented.

## Blockers Remaining

- BFS `data_type_code` API value mapping remains blocked. The official
  definitions page verifies abbreviations `BA`, `HBA`, `BF4Q`, `BF8Q`,
  `PBF4Q`, and `PBF8Q`, but API probes did not verify them as accepted
  `data_type_code` values.
- BFS `category_code` to industry/NAICS mapping remains blocked.
- BDS direct firm-startup field remains unresolved. `ESTABS_ENTRY` is
  establishment entry; no direct firm-birth/startup field was found in the
  variable scan.
- BDS combined query syntax for NAICS, firm age, firm size, geography, and year
  must be successfully rerun before quantitative work.
- SUSB MSA and other non-U.S./state record layouts remain to verify if those
  geographies are used.
- BTOS public-use variable names, survey period fields, weights, and exact
  extract/download schema remain unresolved. The questionnaire verifies wording
  and question numbers only.
- Exact 2017-to-2022 NAICS transformation rule remains needed before
  mixed-vintage sector joins.
- No nonemployer AI-use field, management-layer field, hidden-contractor
  field, vendor-substitution field, or procurement-friction field was found.

## Exact Fields And Value Mappings Verified

SUSB U.S./state annual record layout:

- `STATE`
- `NAICS`
- `ENTRSIZE`
- `FIRM`
- `ESTB`
- `EMPL`
- `EMPLFL_R`
- `EMPLFL_N`
- `PAYR`
- `PAYRFL_N`
- `RCPT`
- `RCPTFL_N`
- `STATEDSCR`
- `NAICSDSCR`
- `ENTRSIZEDSCR`

BDS `BDSFAGEFSIZE` group fields:

- `NAICS`
- `FAGE`
- `EMPSZFI`
- `GEO_ID`
- `YEAR`
- `FIRM`
- `ESTAB`
- `EMP`
- `ESTABS_ENTRY`
- `FIRMDEATH_FIRMS`
- `JOB_CREATION_BIRTHS`

BFS official definition abbreviations verified but not API value-code verified:

- `BA`
- `HBA`
- `BF4Q`
- `BF8Q`
- `PBF4Q`
- `PBF8Q`

BTOS AI-supplement question numbers verified but not public-use variable names:

- Question 23: current AI use.
- Question 24: AI use by business function.
- Question 25: employee-task substitution, augmentation, or new-task use.
- Question 28: total employment effect.
- Question 29: operational changes to use AI.
- Question 31: employee generative-AI use.
- Question 32: generative-AI work-task categories.
- Questions 33-34: expected AI use.

## Compatibility Changes

| Dataset | Change |
| --- | --- |
| BFS | Remains blocked for NAICS-year use until `category_code` and API `data_type_code` mappings are verified. BFS employer formations remain only an indirect payroll-transition proxy. |
| BDS | `BDSFAGEFSIZE` group metadata supports firm-age-by-firm-size cells with NAICS and `GEO_ID`; successful query pulls still required before analysis. Direct firm-startup remains unresolved. |
| SUSB | U.S./state NAICS-year and geography-NAICS-year employer cells are now compatible using verified `NAICS`, `STATE`, and file vintage. Other geographies require layout checks. |
| BTOS | Employer-business AI exposure remains possible by 2017 NAICS sector/subsector, state/MSA, and employment-size concepts, but public-use variable names and weights remain unresolved. |
| NAICS crosswalk | Source access identified, but no transformation method selected or implemented. |

## Guardrails Preserved

- No quantitative analysis was run.
- No Operator Node claim was promoted.
- BFS employer formations remain only an indirect payroll-transition proxy.
- Bick/Blandin/Deming remains worker-level GenAI adoption context only.
- ArXiv-only AI entrepreneurship or labor-substitution sources remain outside
  source truth and claim support.
- TCE-P005 remains blocked; no management-layer fields were verified.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
rg -n "data_type_code|category_code|BA|HBA|BF4Q|BF8Q|PBF4Q|PBF8Q|BDSFAGEFSIZE|FIRMDEATH_FIRMS|ESTABS_ENTRY|ENTRSIZE|EMPLFL_N|PAYRFL_N|question 23|Question 23|NAICS-vintage|2022_NAICS_Structure" research/data/schema_mapping.md research/data/field_dictionary.md research/data/naics_panel_inventory.md research/reading_queue.md docs/operator/returns/2026-06-11-schema-blocker-closure-return.md
rg -n "payroll-transition proxy|worker-level GenAI adoption|ArXiv-only|TCE-P005|No quantitative analysis|No Operator Node claim" research/data/schema_mapping.md research/data/naics_panel_inventory.md docs/operator/returns/2026-06-11-schema-blocker-closure-return.md
rg -n "Buddh[i]sm|Tao[i]sm|Sun[y]ata|dependent[ -]originat[i]on|man[i]festo|conclus[i]ons?|obsolet[e]|firm is dea[d]|end of the fir[m]" research/data/schema_mapping.md research/data/field_dictionary.md research/data/naics_panel_inventory.md docs/operator/returns/2026-06-11-schema-blocker-closure-return.md
rg -n "[ \t]+$" research/data/schema_mapping.md research/data/field_dictionary.md research/data/naics_panel_inventory.md research/reading_queue.md docs/operator/returns/2026-06-11-schema-blocker-closure-return.md
git status --short
```

Results:

- `git diff -- paper/draft.md`: no output.
- `git diff --check`: passed with no output.
- Schema/blocker scan: returned expected matches for unresolved BFS mappings,
  BDS `BDSFAGEFSIZE`, SUSB exact fields, BTOS question numbers, and NAICS
  crosswalk status.
- Guardrail scan: returned expected matches for payroll-transition proxy,
  worker-level GenAI context, arXiv-only guardrail, TCE-P005 block, no
  quantitative analysis, and no Operator Node claim promotion.
- Prohibited-foundation/polemical-language scan: no output after self-match
  correction.
- Trailing-whitespace scan: no output.
- `git status --short`: modified research data files and reading queue, plus
  this new return record; no draft file listed.

## Acceptance Readiness

This slice is ready for user review or a later acceptance/commit checkpoint.
No commit or push was performed.
