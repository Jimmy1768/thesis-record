# NAICS Code-List QA

Status: data architecture QA only. Not a crosswalk, transformation script, or
analysis.

Run date: 2026-06-11.

Purpose: apply the conservative NAICS harmonization rule to the actual
candidate dataset code lists before any empirical panel construction.

Rule applied:

- `research/data/naics_harmonization_rule.md`

## Sources Inspected Or Reused

Official/source-truth inputs:

- Census 2022 NAICS structure workbook:
  `https://www.census.gov/naics/2022NAICS/2022_NAICS_Structure.xlsx`
- NES 2023 API:
  `https://api.census.gov/data/2023/nonemp`
- AIES-NES 2023 API:
  `https://api.census.gov/data/2023/aiesnonemp`
- BDS API:
  `https://api.census.gov/data/timeseries/bds`
- SUSB 2022 U.S./state local-only raw file:
  `data/raw/susb/2022/us_state_6digitnaics_2022.txt`
- BDS local-only sector-age-size raw file:
  `data/raw/bds/2023/bds2023_sec_fa_fz.csv`

Local-only files were used for code-list inspection only and remain ignored by
git.

## Queries And Extracts

NES 2023 U.S. all-class code-list query:

```text
get=NAICS2022,NAICS2022_LABEL&LFO=001&RCPSZES=001&for=us:1
```

AIES-NES 2023 national code-list query:

```text
get=NAICS2017,NAICS2017_LABEL,INDLEVEL,SECTOR,SUBSECTOR,INDGROUP&YEAR=2023&for=us:1
```

BDS API 2022 tested-context code-list query:

```text
get=NAICS,NAICS_LABEL&time=2022&FAGE=001&EMPSZFI=001&for=us:1
```

SUSB code list:

- Unique `NAICS` values from rows with `STATE=00` and `ENTRSIZE=01`.

BDS sector CSV code list:

- Unique `sector` values from the manifested local-only CSV.

These checks inspect code-list coverage and join readiness only. They do not
compute receipts, employment, firms, rates, shares, trends, rankings, or
prediction outcomes.

## Code-List Counts

| Source | Code Count | Native Vintage | Inspection Basis |
| --- | ---: | --- | --- |
| NES 2023 U.S. all-class | 452 | 2022 NAICS | API code-list query |
| AIES-NES 2023 U.S. | 425 | 2017 NAICS | API code-list query |
| SUSB 2022 U.S. total `ENTRSIZE=01` | 2,003 | 2017 NAICS | Local ignored raw file |
| BDS API 2022 tested context | 394 | 2017 NAICS | API code-list query |
| BDS sector-age-size CSV | 19 | 2017 sector categories | Local ignored raw file |

## Code-Level Counts

| Source | Total/Range | 2-digit | 3-digit | 4-digit | 5-digit | 6-digit |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| NES 2023 | 4 | 15 | 79 | 169 | 162 | 23 |
| AIES-NES 2023 | 3 | 12 | 78 | 152 | 154 | 26 |
| SUSB 2022 U.S. total | 4 | 17 | 86 | 288 | 638 | 970 |
| BDS API 2022 tested context | 4 | 16 | 86 | 288 | 0 | 0 |
| BDS sector-age-size CSV | 3 | 16 | 0 | 0 | 0 | 0 |

Total/range counts include all-sector codes such as `00` or `--` and combined
range sectors such as `31-33`, `44-45`, and `48-49`.

## NES 2022 Change-Indicator Counts

For the 452 NES 2023 U.S. all-class `NAICS2022` codes:

| 2022 Change Indicator | Count |
| --- | ---: |
| blank | 368 |
| `*` | 12 |
| `**` | 58 |
| `***` | 5 |
| `****` | 5 |
| total/range not in structure workbook | 4 |

Interpretation:

- 380 NES codes are stable or title-only by the conservative rule.
- 68 NES codes are changed-code cells for first-pass mixed-vintage panels.
- 4 NES total/range codes require explicit handling as aggregate context.

## Fine-Code Join Readiness Against NES

The following counts classify 2017-vintage source code lists against the NES
2023 `NAICS2022` list and the 2022 Census change indicators.

| Source | Native/Sector Context | Same-Code Stable Or Title-Only | Changed Indicator Blocked | Absent From NES 2023 Code List |
| --- | ---: | ---: | ---: | ---: |
| AIES-NES 2023 | 3 | 338 | 9 | 75 |
| SUSB 2022 U.S. total | 4 | 380 | 10 | 1,609 |
| BDS API 2022 tested context | 4 | 231 | 9 | 150 |

Examples of blocked changed-indicator codes:

- `441`, `4413`, `444`, `4442`, `445`, `4451`, `4452`, `4453`, `519`.

Examples of absent-from-NES codes:

- AIES-NES: `441228`, `442`, `4421`, `44211`, `4422`, `443`, `4431`,
  `44314`.
- SUSB: `1131`, `11311`, `113110`, `1132`, `11321`, `113210`, `1133`,
  `11331`.
- BDS API: `1131`, `1132`, `1133`, `2211`, `2212`, `2213`, `3121`,
  `3122`.

Interpretation:

- Fine-code comparison is not first-pass ready across the main sources.
- Stable same-code joins can be retained as a future QA subset.
- Changed or absent fine-code cells require exclusion, aggregation to a stable
  parent, or a later approved many-to-many allocation source.

## Canonical Sector Readiness

Canonical sectors used for QA:

```text
11;21;22;23;31-33;42;44-45;48-49;51;52;53;54;55;56;61;62;71;72;81
```

Observed canonical sector coverage:

| Source | Covered Canonical Sectors | Missing Canonical Sectors |
| --- | --- | --- |
| NES 2023 | 18 | `55` |
| AIES-NES 2023 | 17 | `55`; `61` |
| SUSB 2022 U.S. total | 19 | none |
| BDS API 2022 tested context | 19 | none |
| BDS sector-age-size CSV | 19 | none |

All-source canonical overlap for NES, AIES-NES, SUSB, and BDS API:

```text
11;21;22;23;31-33;42;44-45;48-49;51;52;53;54;56;62;71;72;81
```

All-source sector exclusions for first-pass comparison:

- `55`: absent from NES and AIES-NES inspected code lists.
- `61`: absent from AIES-NES inspected code list.

## Join-Class Assignments

`native_only`:

- All datasets can be retained in native-vintage form for code-list and
  dataset-specific QA.

`sector_stable`:

- First-pass mixed-vintage panel design should use canonical sector-level
  cells.
- The broad all-source sector overlap is available for 17 sectors listed
  above.

`same_code_stable_or_title_only`:

- Available only as a future fine-code subset after creating a code-list QA
  table for the specific panel.
- Current same-code stable/title-only counts are 338 for AIES-NES, 380 for
  SUSB U.S. total, and 231 for the tested BDS API context.

`changed_blocked`:

- Any `**`, `***`, or `****` 2022 change-indicator cell.
- Any fine code absent from one side of the comparison.
- Any many-to-many split, merge, or reused-code case without a selected
  allocation rule.

## Dataset Implications

NES/AIES-NES:

- Sector-level employer/nonemployer comparison is structurally cleaner than
  fine-code comparison.
- AIES-NES lacks inspected `55` and `61` sector coverage, so all-source sector
  comparisons should exclude those sectors unless a later source path closes
  the gap.

NES/SUSB:

- SUSB has much broader fine-code coverage than NES. Most SUSB fine codes are
  absent from the inspected NES U.S. all-class code list, so fine-code joins
  should not be assumed.
- Sector-level aggregation is the safer first-pass role for SUSB employer
  baselines.

NES/BDS:

- The BDS API tested context has 4-digit-or-higher coverage limits relative to
  NES and many absent fine codes.
- The BDS sector CSV is naturally aligned with a sector-level role.

BTOS/Bonney:

- Keep BTOS/Bonney AI adoption evidence at sector or documented-size/sector
  context until public extract schema is verified.
- Do not force BTOS into fine-code joins based on article-level sector claims.

BFS:

- Still blocked for industry panels because `category_code` to NAICS mapping
  remains unresolved.

## Remaining Blockers

- Many-to-many 2017-to-2022 allocation-weight source remains unselected.
- No actual panel code-list table has been generated or committed.
- State/county/metro code-list QA remains undone.
- BTOS public-use extract schema remains unresolved.
- BFS `category_code` to NAICS mapping remains unresolved.

## Guardrails

- This file does not authorize quantitative analysis.
- This file does not create a crosswalk or processed panel.
- Code-list overlap is not economic evidence.
- Sector availability does not establish AI effects, transaction-cost change,
  firm-boundary change, or Operator Node performance.
