# Source Note: GTFS Fares As Affordability Input

Date inspected: 2026-06-28

Verification status: directly inspected official GTFS Schedule documentation,
including fare-related file families.

Sources:

- MobilityData / GTFS, "GTFS Schedule Reference"
- URL: `https://gtfs.org/documentation/schedule/reference/`
- Existing Thesis 2 source note:
  `theses/mobility-conversion/research/source_notes/mobilitydata_gtfs_2026-06-28.md`

## Source Authority

MobilityData-maintained GTFS Schedule documentation.

## What The Source Defines

GTFS Schedule includes fare-related structures for representing public
transport fares.

For Thesis 2 outcome work, relevant fare concepts include:

- fare products;
- fare media;
- rider categories;
- fare rules;
- fare transfers;
- legacy fare attributes and fare rules where still used;
- route, stop, area, network, and time-based fare relationships where supplied.

## Outcome Dimension Fit

Primary fit:

- affordability.

Secondary fit:

- access to opportunities, if generalized cost or money cost is included in
  accessibility models;
- network coverage and service availability, only where fare constraints affect
  practical service usability.

## Usefulness For Mobility Conversion

GTFS fare data can support fare-cost inputs for public transport affordability
where fare data are complete and current.

It can support later proposed metrics such as:

- nominal fare for representative trips;
- transfer penalties;
- concession or rider-category treatment where represented;
- cost of reaching opportunity bundles by public transport;
- comparison between fare burden and income distribution, if income data are
  available at compatible geography.

## Limitations

- GTFS fare data is not guaranteed to be present or complete.
- Fare policy can be complex, capped, discounted, means-tested, or account
  based in ways not fully represented in a feed.
- Nominal fares are not affordability without household income or expenditure
  context.
- Fare feeds do not measure car costs, walking costs, time costs, or informal
  payments.
- Fare data must be checked against agency fare policy documents before use.
- Fare availability may overrepresent formal and source-rich operators.

## Suitability Judgment

Suitability: `indicator_source_family`.

Candidate outcome dimensions:

- `affordability`;
- `access_to_opportunities`, as a cost input only.

Not suitable as:

- standalone affordability metric;
- MTR denominator;
- proof of actual household transport-cost burden without income or expenditure
  data.

## Methodology Implication

GTFS fares should be treated as a public-transport fare input, not as the
affordability outcome. Any later metric should pair fares with income,
household expenditure, concession eligibility, and, where relevant,
car-dependency costs.
