# Source Note: FTA NTD Safety And Security As Transit Safety Input

Date inspected: 2026-06-30

Verification status: directly inspected official FTA / NTD data and reporting
pages.

Sources:

- Federal Transit Administration, "NTD Data"
- URL: `https://www.transit.dot.gov/ntd/ntd-data`
- Federal Transit Administration, National Transit Database reporting and data
  materials
- URL: `https://www.transit.dot.gov/ntd`

## Source Authority

U.S. Federal Transit Administration / National Transit Database.

## What The Source Defines

The NTD source family includes U.S. transit agency reporting. For safety and
security, it can include transit incidents, fatalities, injuries, security
events, and related operating denominators depending on dataset, year, and
reporting module.

For Mobility Conversion, the relevant source-family function is transit safety
measurement, separate from road crash data.

## Outcome Dimension Fit

Primary fit:

- transportation safety.

Secondary fit:

- travel time and reliability, where safety or security incidents cause service
  disruption;
- asset condition and resilience, where incident patterns relate to system
  condition, but only with additional evidence.

## Usefulness For Mobility Conversion

FTA / NTD safety and security data are useful for:

- distinguishing transit safety from general road safety;
- connecting incidents to agencies, modes, and operating context;
- pairing safety events with transit denominators such as trips, vehicle
  revenue miles, or passenger miles when available;
- auditing whether an MTR safety picture overweights road crash data and misses
  transit-specific harms.

## Limitations

- NTD is U.S.-specific.
- Agency reporting geography does not automatically equal an MTR boundary.
- Agency service areas may cross, split, or omit MTR areas.
- Incident definitions and reporting thresholds require detailed year-specific
  review before metric use.
- Transit safety data do not cover road crashes outside transit operations,
  walking and cycling safety, harassment not captured by reporting, or perceived
  safety.
- Multi-agency MTRs require operator completeness checks.

## Suitability Judgment

Suitability: `indicator_source_family`.

Candidate outcome dimensions:

- `transportation_safety`;
- `asset_condition_and_resilience`, as a partial disruption/incident input only.

Not suitable as:

- MTR denominator;
- complete safety metric;
- replacement for road crash data;
- global source family.

## Methodology Implication

Transit safety must be handled as its own source family. A road-fatality metric
alone would miss transit incident risk, and a transit safety metric alone would
miss the largest road-user safety burdens in many MTRs.
