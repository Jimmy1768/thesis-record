# Source Note: EPA Smart Location Mapping As Accessibility Input

Date inspected: 2026-06-30

Verification status: inspected official U.S. Environmental Protection Agency
Smart Location Mapping / Smart Location Database source family page.

Sources:

- U.S. EPA, "Smart Location Mapping"
- URL: `https://www.epa.gov/smartgrowth/smart-location-mapping`

## Source Authority

U.S. Environmental Protection Agency smart growth data and mapping source
family.

## What The Source Defines

The Smart Location Mapping source family provides U.S. built-environment and
location-efficiency indicators. It includes the Smart Location Database and
related tools that can represent access, density, diversity, design,
destination accessibility, and transit proximity concepts depending on dataset
and version.

For Mobility Conversion, the relevant source-family function is accessibility
method precedent and U.S. indicator input, not final outcome authority.

## Outcome Dimension Fit

Primary fit:

- access to opportunities;
- network coverage and service availability, where transit proximity or service
  variables are present.

## Usefulness For Mobility Conversion

EPA Smart Location source families are useful for:

- showing an official precedent for location-efficiency and accessibility
  indicators;
- testing how jobs, destinations, transit, density, and design can be
  represented as linked variables;
- identifying U.S. small-area accessibility inputs;
- warning that accessibility metrics often blend outcome and explanatory
  variables unless carefully separated.

## Limitations

- The source is U.S.-specific.
- Some variables may represent built form or explanatory context rather than
  outcome performance.
- Indicator definitions, release vintage, and geography must be reviewed before
  any metric use.
- Accessibility indicators may be relative or modelled rather than direct
  observed access.
- MTR boundary crosswalks are required.
- The source should not be imported as a black-box score or ranking.

## Suitability Judgment

Suitability: `method_precedent_and_indicator_source_family`.

Candidate outcome dimensions:

- `access_to_opportunities`, if specific accessibility variables are inspected;
- `network_coverage_and_service_availability`, if service variables are
  separated from opportunity access.

Not suitable as:

- final Mobility Conversion outcome;
- MTR denominator;
- complete opportunity bundle without variable-level review;
- explanatory-axis shortcut.

## Methodology Implication

EPA Smart Location materials can help design source-linking rules, but Thesis 2
must inspect individual variables before use. The main risk is accidentally
mixing urban form, service supply, and opportunity access into a single
unexamined indicator.
