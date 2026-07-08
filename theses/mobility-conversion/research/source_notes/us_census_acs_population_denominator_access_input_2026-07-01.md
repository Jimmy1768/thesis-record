# Source Note: U.S. Census ACS As Access Population Denominator

Date inspected: 2026-07-01

Verification status: directly inspected official U.S. Census Bureau American
Community Survey page.

Sources:

- U.S. Census Bureau, "American Community Survey"
- URL: `https://www.census.gov/programs-surveys/acs`
- Related Thesis 2 source note:
  `theses/mobility-conversion/research/source_notes/us_census_acs_income_affordability_denominator_2026-06-30.md`

## Source Authority

U.S. Census Bureau American Community Survey.

## What The Source Defines

The ACS source family provides U.S. demographic, social, economic, housing, and
transportation information across many geographic summary levels.

For Mobility Conversion access metrics, the relevant source-family function is
resident population denominator and distributional context.

## Outcome Dimension Fit

Primary fit:

- access to opportunities, as resident population denominator;
- network coverage and service availability, as resident population denominator.

Secondary fit:

- affordability, as income and household context through the related ACS income
  note;
- walking, cycling, and universal access, where age, disability, household, or
  commute-mode context is required and available.

## Usefulness For Mobility Conversion

ACS population data are useful for:

- resident population denominators inside U.S. MTRs;
- small-area population distributions where geography permits;
- subgroup visibility by age, disability, income, household type, race/ethnicity,
  commute mode, and other ACS topics where methodologically appropriate;
- denominator crosswalks from source geography to a documented MTR boundary;
- preventing access metrics from counting only served or source-visible people.

## Limitations

- The source is U.S.-specific.
- ACS estimates have margins of error and vintage choices that must be recorded.
- Small-area geographies may require multi-year estimates.
- ACS resident population does not measure daytime population, visitors,
  informal residents, commuters entering the MTR, tourists, or transient users.
- Source geography still requires MTR boundary crosswalks.
- ACS does not itself measure reachable jobs, destinations, service, travel
  time, affordability, safety, or universal access.

## Suitability Judgment

Suitability: `denominator_source_family`.

Candidate outcome dimensions:

- `access_to_opportunities`;
- `network_coverage_and_service_availability`;
- `affordability`, through related income fields and source notes;
- `walking_cycling_and_universal_access`, as subgroup context only.

Not suitable as:

- standalone access metric;
- destination inventory;
- travel-time source;
- global source family;
- MTR boundary source.

## Methodology Implication

ACS resident population can address the population-denominator blocker for
U.S. access-metric tests, but not the MTR-boundary blocker. A future metric
must record source vintage, estimate type, geography, margin-of-error handling,
and the crosswalk from ACS geography into the independently defined MTR.
