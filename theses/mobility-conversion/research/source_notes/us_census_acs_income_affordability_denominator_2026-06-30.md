# Source Note: U.S. Census ACS Income As Affordability Denominator

Date inspected: 2026-06-30

Verification status: directly inspected official U.S. Census Bureau American
Community Survey page.

Sources:

- U.S. Census Bureau, "American Community Survey"
- URL: `https://www.census.gov/programs-surveys/acs`

## Source Authority

U.S. Census Bureau American Community Survey.

## What The Source Defines

The ACS source family provides U.S. demographic, social, economic, and housing
information across many geographic summary levels.

For Mobility Conversion affordability work, the relevant source-family function
is household income and distributional denominator context, not transport cost
measurement by itself.

## Outcome Dimension Fit

Primary fit:

- affordability, as an income denominator and distributional context.

Secondary fit:

- access to opportunities, where income stratification is needed to assess
  unequal access burden.

## Usefulness For Mobility Conversion

ACS income data are useful for:

- income distribution context;
- poverty and low-income subgroup analysis;
- geographic crosswalks to U.S. MTR boundaries;
- pairing fare or expenditure data with household ability to pay;
- auditing whether average affordability hides distributional burden.

## Limitations

- ACS is U.S.-specific.
- Income geography may still require crosswalks to MTR boundaries.
- ACS income does not directly measure transport expenditure or fare burden.
- Multi-year estimates and margins of error require explicit treatment.
- Income is not the same as liquid budget, eligibility for concessions, wealth,
  debt burden, household needs, or time poverty.
- Using income alone can make affordability look better than it feels for
  households with high fixed costs or constrained mode choice.

## Suitability Judgment

Suitability: `denominator_source_family`.

Candidate outcome dimensions:

- `affordability`;
- `access_to_opportunities`, as distributional context only.

Not suitable as:

- standalone affordability metric;
- transport cost source;
- global source family;
- explanatory-axis shortcut for transport quality.

## Methodology Implication

Affordability metrics need income denominators. ACS can provide those
denominators in U.S. settings, but it must be paired with fare, expenditure, or
transport-cost sources and explicit uncertainty metadata.
