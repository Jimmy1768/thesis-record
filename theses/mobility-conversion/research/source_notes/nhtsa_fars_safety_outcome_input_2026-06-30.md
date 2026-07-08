# Source Note: NHTSA FARS As Safety Input

Date inspected: 2026-06-30

Verification status: directly inspected official NHTSA FARS source pages.

Sources:

- National Highway Traffic Safety Administration, "Fatality Analysis Reporting
  System"
- URL: `https://www.nhtsa.gov/research-data/fatality-analysis-reporting-system-fars`
- NHTSA, "FARS Encyclopedia"
- URL: `https://www-fars.nhtsa.dot.gov/Main/index.aspx`

## Source Authority

U.S. National Highway Traffic Safety Administration fatal-crash data system.

## What The Source Defines

FARS is a U.S. fatal-crash data source. It supports analysis of motor-vehicle
traffic crashes involving fatalities, with records that can include crash,
person, vehicle, roadway, location, and circumstance attributes.

For Mobility Conversion, the relevant source-family function is fatal road
safety event measurement inside or near an MTR boundary where U.S. geography
can be mapped.

## Outcome Dimension Fit

Primary fit:

- transportation safety.

Secondary fit:

- walking, cycling, and universal access, where pedestrian and cyclist fatality
  records can be separated;
- governance fit, only as a later explanatory context when crash responsibility
  and roadway control can be documented.

## Usefulness For Mobility Conversion

FARS is useful for:

- fatal crash event counts;
- pedestrian and cyclist fatality analysis;
- roadway and crash context attributes;
- mapping fatal safety events to an independently defined U.S. MTR boundary;
- separating fatal road safety from transit safety reporting.

## Limitations

- FARS is U.S.-specific.
- It is fatality-focused and does not cover the full burden of serious injury,
  non-injury crashes, near misses, harassment, or perceived safety.
- Fatality rates require exposure denominators such as population, trips,
  vehicle miles, passenger miles, walking/cycling volume, or mode share.
- Geocoding and boundary matching require a separate archive and crosswalk.
- Low event counts can be volatile for smaller areas or short windows.
- A fatality-only metric may miss suppressed walking and cycling demand.

## Suitability Judgment

Suitability: `indicator_source_family`.

Candidate outcome dimensions:

- `transportation_safety`;
- `walking_cycling_and_universal_access`, as a partial vulnerable-road-user
  input.

Not suitable as:

- global safety source;
- full safety metric;
- MTR denominator;
- substitute for serious-injury, transit safety, perceived-safety, or exposure
  data.

## Methodology Implication

FARS can support U.S. safety outcome testing, but any later metric must declare
its fatality-only scope and pair event counts with documented exposure
denominators and boundary crosswalks.
