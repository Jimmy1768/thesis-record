# Source Note: BLS Consumer Expenditure Surveys As Affordability Input

Date inspected: 2026-06-30

Verification status: directly inspected official U.S. Bureau of Labor
Statistics Consumer Expenditure Surveys page.

Sources:

- U.S. Bureau of Labor Statistics, "Consumer Expenditure Surveys"
- URL: `https://www.bls.gov/cex/`

## Source Authority

U.S. Bureau of Labor Statistics household expenditure survey program.

## What The Source Defines

The Consumer Expenditure Surveys source family provides U.S. household
expenditure, income, and consumer-unit information.

For Mobility Conversion, the relevant source-family function is household
transport cost burden context, including transport spending that can include
vehicle ownership and operation, fuel, insurance, public transport, and related
transport expenditure categories depending on table and vintage.

## Outcome Dimension Fit

Primary fit:

- affordability.

Secondary fit:

- access to opportunities, if money cost is included in a generalized-cost
  access model.

## Usefulness For Mobility Conversion

BLS Consumer Expenditure data are useful for:

- transport expenditure burden context;
- distinguishing fare affordability from total household transport cost;
- identifying car ownership and operation cost burdens;
- pairing transport expenditure with household income, where geography permits;
- warning that nominal transit fares are not the whole affordability outcome.

## Limitations

- The source is U.S.-specific.
- Published expenditure geographies may not align with MTR boundaries.
- Sample sizes can limit local or metropolitan analysis.
- Household expenditure reflects observed behavior and constraint, not
  necessarily desired or optimal access.
- Expenditure data may hide foregone trips, suppressed demand, informal costs,
  time costs, accessibility costs, or unpaid caregiving travel burden.
- Transport spending can be high because access is poor, not because transport
  quality is high.

## Suitability Judgment

Suitability: `indicator_source_family`.

Candidate outcome dimensions:

- `affordability`;
- `access_to_opportunities`, as a cost-burden context only.

Not suitable as:

- standalone affordability metric;
- MTR denominator;
- proof of access quality;
- global source family.

## Methodology Implication

Household transport expenditure is necessary but dangerous if read naively.
High expenditure may indicate forced car dependency or inefficient access, not
better transport. Any later metric must combine expenditure with income,
boundary alignment, mode context, and suppressed-demand caveats.
