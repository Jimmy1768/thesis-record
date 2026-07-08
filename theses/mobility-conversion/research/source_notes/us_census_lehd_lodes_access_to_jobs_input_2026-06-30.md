# Source Note: U.S. Census LEHD / LODES As Job-Access Input

Date inspected: 2026-06-30

Verification status: directly inspected official U.S. Census LEHD / LODES data
page.

Sources:

- U.S. Census Bureau, LEHD Origin-Destination Employment Statistics data
- URL: `https://lehd.ces.census.gov/data/`

## Source Authority

U.S. Census Bureau Longitudinal Employer-Household Dynamics program.

## What The Source Defines

The LEHD / LODES source family provides U.S. employment, workplace, residence,
and origin-destination employment statistics at detailed geography.

For Mobility Conversion, the relevant source-family function is job opportunity
location and worker-flow context.

## Outcome Dimension Fit

Primary fit:

- access to opportunities, for job-access analysis.

Secondary fit:

- travel time and reliability, only when paired with network or travel-time
  sources.

## Usefulness For Mobility Conversion

LEHD / LODES is useful for:

- workplace job-location inputs;
- residence-workplace flow context;
- job-access modelling inside U.S. MTR boundaries;
- cross-checking whether access analysis is only service supply or actually
  reaches employment destinations;
- distributional access analysis by residential geography, where population and
  income sources can be linked.

## Limitations

- The source is U.S.-specific.
- Jobs are only one opportunity class.
- Administrative employment data can miss informal work, unpaid work,
  caregiving destinations, education, healthcare, groceries, and civic life.
- Employment locations do not measure job quality, wages, fit, discrimination,
  schedule compatibility, or hiring probability.
- Boundary and geography crosswalks are required before MTR use.
- Job access still requires transport network, mode, travel-time, cost, and
  physical-access assumptions.

## Suitability Judgment

Suitability: `indicator_source_family`.

Candidate outcome dimensions:

- `access_to_opportunities`.

Not suitable as:

- full opportunity bundle;
- MTR denominator;
- global source family;
- standalone access metric.

## Methodology Implication

LEHD / LODES can support U.S. job-access testing, but job access must not become
the whole access-to-opportunities outcome. Any later metric using this source
must declare that it measures employment opportunity access, not overall usable
access.
