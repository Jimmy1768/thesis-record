# U.S. Census Bureau, 2022 NAICS Reference Files

## Verification Status

Status: verified_primary_source

Verification source: U.S. Census Bureau NAICS page and official 2022 NAICS
structure workbook directly inspected on 2026-06-11.

Inspection basis: official NAICS page text, official workbook URL, HTTP
metadata, workbook sheet/header structure, change-indicator definitions, and
indicator counts inspected.

## Bibliographic Reference

U.S. Census Bureau, "North American Industry Classification System - NAICS,"
and "2022 NAICS Structure with Change Indicator."

## Source Type

Official government classification reference file.

## Evidence Category

- Task productivity: no.
- Transaction-cost evidence: no.
- Firm-boundary evidence: no.
- Data architecture: yes, for NAICS-vintage harmonization.

## Core Claims

- NAICS is the standard used by federal statistical agencies to classify
  business establishments for collecting, analyzing, and publishing U.S.
  business-economy statistics.
- The Census NAICS page provides access to NAICS reference files.
- The official 2022 NAICS structure workbook includes a `Change Indicator`,
  `2022 NAICS Code`, and `2022 NAICS Title`.
- The workbook defines blank, `*`, `**`, `***`, and `****` indicators for
  no indicated change, title-only change, new 2022 code, reused code with
  content change, and reused code with lower-level content change.

## Evidence Used

The Census NAICS page states that NAICS is used by federal statistical
agencies for classifying business establishments and that the site provides
access to NAICS reference files and tools.

The inspected workbook is the official Census `2022_NAICS_Structure.xlsx`
file. It contains one sheet, `2022 NAICS Structure`, with the fields
`Change Indicator`, `2022 NAICS Code`, and `2022 NAICS Title`.

## Relevance To Operator Node Hypothesis

This source supports empirical data architecture only. It helps prevent
incorrect joins between NES 2022 NAICS and 2017-vintage employer-side or AI
adoption sources. It does not support or reject the Operator Node hypothesis.

## Objections Or Limitations

- The inspected workbook is a 2022 structure file with change indicators, not
  an allocation-weighted 2017-to-2022 concordance.
- It does not provide economic data or outcome measures.
- It cannot justify splitting receipts, employment, payroll, or counts across
  changed industries.

## Useful Short Quotations

- "standard used by Federal statistical agencies"
- "Change Indicator"
- "title change, no content change"
- "new code for 2022 NAICS"

## Related Data Files

- `research/data/naics_harmonization_rule.md`
