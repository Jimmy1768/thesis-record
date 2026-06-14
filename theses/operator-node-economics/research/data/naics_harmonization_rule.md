# NAICS Harmonization Rule

Status: data architecture rule only. Not a transformation script and not
analysis.

Run date: 2026-06-11.

Purpose: define the conservative rule for comparing datasets that use
different NAICS vintages before any cross-dataset panel analysis.

## Inspected Official Source

Official Census NAICS page:

- `https://www.census.gov/naics/`

Official Census 2022 NAICS structure workbook:

- `https://www.census.gov/naics/2022NAICS/2022_NAICS_Structure.xlsx`

Local inspection copy:

- `/tmp/2022_NAICS_Structure.xlsx`
- Not committed to the repo.

Workbook metadata from inspection:

- HTTP status: 200.
- Content type:
  `application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`.
- Content length: 88,218 bytes.
- Last modified: Thu, 02 Apr 2026 14:22:16 GMT.
- SHA-256:
  `217c9e0d4d74e7517bc288f5f308b73aa0de5ee787976a6dd222412be28ada22`.

Workbook structure:

- Sheet: `2022 NAICS Structure`.
- Rows: 2,147.
- Columns: 6.
- Header fields: `Change Indicator`, `2022 NAICS Code`,
  `2022 NAICS Title`.

## Change Indicator Meaning

The official workbook note defines:

- blank: no indicated 2022 change.
- `*`: title change, no content change.
- `**`: new code for 2022 NAICS.
- `***`: re-used code, content change, with or without title change.
- `****`: re-used code, content change at lower level with insignificant
  impact at this level, with or without title change.

Observed indicator counts in the inspected workbook:

| Indicator | Count |
| --- | ---: |
| blank | 1,896 |
| `*` | 31 |
| `**` | 186 |
| `***` | 7 |
| `****` | 5 |

Observed counts by code length:

| Indicator | 2-digit | 3-digit | 4-digit | 5-digit | 6-digit |
| --- | ---: | ---: | ---: | ---: | ---: |
| blank | 17 | 82 | 277 | 619 | 901 |
| `*` | 0 | 2 | 3 | 11 | 15 |
| `**` | 0 | 8 | 23 | 61 | 94 |
| `***` | 0 | 1 | 3 | 1 | 2 |
| `****` | 0 | 3 | 2 | 0 | 0 |

These are source-structure checks only, not economic findings.

## Decision

Use a conservative stable-code and aggregation rule. Do not implement a
weighted or many-to-many crosswalk in the first panel architecture.

Default hierarchy:

1. Preserve native NAICS vintage in every raw and parsed dataset.
2. Prefer sector-level comparisons where 2017 and 2022 sector definitions are
   stable for the planned comparison.
3. Allow finer NAICS comparisons only where the 2022 code has a blank change
   indicator or a `*` title-only indicator and the corresponding 2017 code is
   present with the same code value in the 2017-vintage source.
4. Treat `**`, `***`, and `****` codes as changed-code cells for first-pass
   panels. They require explicit exclusion, aggregation to a stable parent, or
   a later approved concordance/allocation rule before analysis.
5. Do not split receipts, employment, payroll, firms, establishments, or
   formation counts across changed codes without an approved allocation
   source and sensitivity design.

## Allowed Join Classes

`native_only`:

- Dataset is analyzed in its own NAICS vintage.
- No cross-vintage comparison is made.

`sector_stable`:

- Join at 2-digit sector level after verifying no sector-level content-change
  problem for the planned cells.
- This is the default first-pass join class for NES 2022 NAICS against
  AIES-NES/SUSB/BDS/BTOS 2017 NAICS.

`same_code_stable_or_title_only`:

- Join only when the 2022 code appears in the official workbook with blank or
  `*` indicator and the same code exists in the 2017-vintage source.
- This is allowed for exploratory architecture but still needs a pre-analysis
  code-list QA table.

`changed_blocked`:

- Any code with `**`, `***`, or `****` in the 2022 workbook.
- Any code that is absent from one side of the comparison.
- Any many-to-many, split, merge, or reused-code case without a selected
  official concordance/allocation rule.

## Dataset Implications

NES:

- Native NAICS vintage: 2022.
- Use `NAICS2022`.
- Compare to 2017-vintage sources only through `sector_stable` or
  `same_code_stable_or_title_only` joins.

AIES-NES:

- Native NAICS vintage: 2017.
- National employer/nonemployer revenue comparison remains native 2017 unless
  joined to NES or another 2022-vintage source.

BDS:

- Native NAICS vintage: 2017 in inspected API metadata.
- The downloadable sector-age-size file is already sector-level and can be
  kept as sector context, not six-digit NAICS evidence.

SUSB:

- Native NAICS vintage: 2017 in inspected 2022 data page/source note.
- U.S./state 6-digit `NAICS` can be used natively or aggregated to stable
  sectors for comparison with NES 2023.

BTOS:

- Native NAICS vintage: 2017 in inspected docs.
- Use as employer-business AI exposure only after extract schema is verified.

BFS:

- January 2026 release restated the series to 2022 NAICS, but `category_code`
  mapping remains unresolved.
- BFS industry joins remain blocked until `category_code` mapping is verified.

## Pre-Analysis QA Required

Before any cross-vintage panel:

- Build a code-list QA table for every dataset included.
- Record native NAICS vintage and industry level for every row.
- Assign each potential join cell one of the allowed join classes above.
- Exclude or aggregate `changed_blocked` cells before analysis.
- Document whether aggregation is to sector, subsector, or another stable
  parent.
- Keep NES 2022 methodology-change caveat separate from NAICS-vintage
  harmonization; both constraints apply.

## Remaining Blocker

An official many-to-many 2017-to-2022 concordance or allocation-weight source
has not been selected. This rule deliberately avoids artificial precision. If
future analysis needs six-digit changed-code comparisons, Research must verify
a durable source and add a separate transformation design.

## Guardrails

- This rule does not authorize analysis.
- This rule does not create a processed crosswalk.
- This rule does not claim that nonemployer outcomes are AI effects.
- This rule does not promote any Operator Node claim.
