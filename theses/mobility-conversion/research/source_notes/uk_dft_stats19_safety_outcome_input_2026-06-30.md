# Source Note: UK DfT Road Casualty Statistics / STATS19 As Safety Input

Date inspected: 2026-06-30

Verification status: directly inspected official UK Department for Transport
road accidents and safety statistics collection page.

Sources:

- UK Department for Transport, "Road accidents and safety statistics"
- URL: `https://www.gov.uk/government/collections/road-accidents-and-safety-statistics`

## Source Authority

UK Department for Transport road casualty statistics.

## What The Source Defines

The UK road accidents and safety statistics source family includes
police-reported road collision and casualty data, commonly associated with
STATS19 reporting.

For Mobility Conversion, this source family is useful as an example of
subnational road casualty data that can potentially be mapped to local or
metropolitan boundaries.

## Outcome Dimension Fit

Primary fit:

- transportation safety.

Secondary fit:

- walking, cycling, and universal access, where pedestrian and cyclist casualty
  records are separable;
- access to opportunities, as a barrier context only, not as opportunity reach.

## Usefulness For Mobility Conversion

This source family is useful for:

- fatal and non-fatal road casualty analysis;
- pedestrian and cyclist casualty subsets;
- geography-aware safety analysis where records can be mapped;
- documenting serious-injury and slight-injury burdens beyond fatalities;
- testing whether safety data can be used at a finer geography than national
  WHO-style context.

## Limitations

- The source is country-specific.
- Police-reported casualty data can suffer from underreporting, especially for
  less severe injuries and some vulnerable-user incidents.
- Reporting definitions, severity coding, and geocoding need year-specific
  documentation.
- Boundary mapping requires a separately defined MTR and spatial crosswalk.
- Exposure denominators are still required for interpretable rates.
- Reported casualties do not capture perceived danger or suppressed walking and
  cycling demand.

## Suitability Judgment

Suitability: `indicator_source_family`.

Candidate outcome dimensions:

- `transportation_safety`;
- `walking_cycling_and_universal_access`, as a vulnerable-user safety input.

Not suitable as:

- global safety source;
- full safety metric;
- MTR denominator;
- substitute for exposure, perceived-safety, or transit safety sources.

## Methodology Implication

Police-reported road casualty datasets can improve on fatality-only safety
measurement, but they require explicit underreporting, severity, geography, and
exposure caveats before any proposed metric can be accepted for candidate
testing.
