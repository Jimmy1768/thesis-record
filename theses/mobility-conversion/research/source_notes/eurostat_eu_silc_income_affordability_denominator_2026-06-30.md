# Source Note: Eurostat EU-SILC Income As Affordability Denominator

Date inspected: 2026-06-30

Verification status: directly inspected official Eurostat income and living
conditions page.

Sources:

- Eurostat, "Income and living conditions"
- URL: `https://ec.europa.eu/eurostat/web/income-and-living-conditions`

## Source Authority

Eurostat income and living conditions statistics, including EU-SILC source
family.

## What The Source Defines

Eurostat income and living conditions statistics provide income, poverty,
social exclusion, and living-condition context across European statistical
systems.

For Mobility Conversion affordability work, the relevant source-family function
is income and distributional denominator context.

## Outcome Dimension Fit

Primary fit:

- affordability, as an income and distributional denominator.

Secondary fit:

- access to opportunities, if affordability burden is stratified by income or
  deprivation group.

## Usefulness For Mobility Conversion

Eurostat income and living conditions data are useful for:

- income distribution context in European settings;
- poverty and deprivation context;
- pairing transport expenditure or fare costs with ability to pay;
- avoiding nominal fare comparisons that ignore household resources.

## Limitations

- Income and living-condition geographies may not align with MTR boundaries.
- The source does not directly measure transport service, fares, or household
  transport expenditure.
- Country and regional detail must be checked before any MTR use.
- Income does not capture all affordability constraints, including household
  debt, eligibility friction, disability costs, time costs, or constrained mode
  choice.
- Comparability depends on survey design, release vintage, and available
  geography.

## Suitability Judgment

Suitability: `denominator_source_family`.

Candidate outcome dimensions:

- `affordability`;
- `access_to_opportunities`, as distributional context only.

Not suitable as:

- standalone affordability metric;
- transport-cost source;
- MTR denominator;
- proof of transport quality.

## Methodology Implication

European affordability analysis should pair expenditure or fare cost sources
with income and living-condition denominators. EU-SILC-style income context is
necessary for distributional burden, but it is not a transport outcome by
itself.
