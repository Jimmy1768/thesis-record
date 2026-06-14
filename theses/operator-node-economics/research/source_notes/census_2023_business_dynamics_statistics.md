# U.S. Census Bureau, Business Dynamics Statistics

## Verification Status

Status: verified_primary_source

Verification source: U.S. Census Bureau Business Dynamics Statistics program
page directly inspected on 2026-06-11; BDS 2023 datasets page and the official
`bds2023_sec_fa_fz.csv` file path directly inspected on 2026-06-11.

Inspection basis: program description, data availability, measured concepts,
2023 dataset/table availability, and multi-year sector by firm age by firm
size CSV schema inspected.

## Bibliographic Reference

U.S. Census Bureau, "Business Dynamics Statistics (BDS)," 2023 data product.

## Source Type

Official government statistical data product.

## Evidence Category

- Task productivity: no.
- Transaction-cost evidence: no.
- Firm-boundary evidence: employer-firm and establishment dynamics
  measurement infrastructure; not AI-specific and not nonemployer evidence.
- Management-layer evidence: no.

## Core Claims

- BDS provides annual measures of business dynamics, including job creation
  and destruction, establishment births and deaths, and firm startups and
  shutdowns.
- BDS aggregates by establishment and firm characteristics.
- 2023 BDS datasets are available in downloadable CSV format, with tables
  available through data.census.gov for 1978-2023.
- The official 2023 BDS datasets page exposes `bds2023_sec_fa_fz.csv`, titled
  "Sector by Firm Age by Firm Size"; local schema inspection showed
  `year`, `sector`, `fage`, and `fsize` fields with observed years 1978-2023.

## Evidence Used

The Census program page states that BDS provides annual measures such as job
creation, job destruction, establishment births/deaths, and firm
startups/shutdowns for the economy overall and by establishment and firm
characteristics.

The official 2023 BDS datasets page exposes a downloadable CSV path for sector
by firm age by firm size:
`https://www2.census.gov/programs-surveys/bds/tables/time-series/2023/bds2023_sec_fa_fz.csv`.
Schema inspection of that CSV recorded a 1978-2023 year range and sector,
firm-age, and firm-size fields.

## Relevance To Operator Node Hypothesis

BDS can support empirical strategy for employer-firm dynamics, especially firm
startup/shutdown, age, size, and employment changes in AI-exposed sectors. It
does not directly observe nonemployer one-human businesses or AI adoption.

## Objections Or Limitations

- BDS is an employer-business dynamics source, not a nonemployer source.
- It does not identify AI use or AI-enabled firm-boundary mechanisms.
- It does not measure management layers, span of control, support-staff ratios,
  contractors, vendor substitution, or transaction costs.
- The verified multi-year firm-age-by-size CSV is sector-level, not six-digit
  NAICS and not subnational.
- API `BDSFAGEFSIZE` checks remain narrower than the CSV path: tested API
  age/size contexts are verified only for 2022.

## Useful Short Quotations

- "job creation and destruction"
- "firm startups and shutdowns"
- "establishment births and deaths"

## Related Claims

- TCE-CLAIM-013
