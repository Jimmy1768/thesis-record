# Source Note: NCES EDGE School Locations As Education Opportunity Input

Date inspected: 2026-06-30

Verification status: inspected official National Center for Education
Statistics EDGE school-location source family.

Sources:

- National Center for Education Statistics, EDGE geographic school-location
  resources
- URL: `https://nces.ed.gov/programs/edge/Geographic/SchoolLocations`

## Source Authority

U.S. National Center for Education Statistics Education Demographic and
Geographic Estimates program.

## What The Source Defines

The NCES EDGE school-location source family provides geographic school-location
resources for U.S. education institutions, depending on release and dataset.

For Mobility Conversion, the relevant source-family function is education
destination inventory input.

## Outcome Dimension Fit

Primary fit:

- access to opportunities, for education destination access.

Secondary fit:

- walking, cycling, and universal access, if school access is tested with
  age-sensitive, caregiver, sidewalk, crossing, and safety constraints.

## Usefulness For Mobility Conversion

NCES EDGE school locations are useful for:

- adding a non-job opportunity class;
- testing access to education destinations;
- checking whether an access metric is too employment-centered;
- linking destinations to travel-time, safety, walking, and population sources.

## Limitations

- The source is U.S.-specific.
- School presence does not measure seat availability, quality, eligibility,
  catchment assignment, affordability, disability access, language fit, or
  enrollment constraints.
- Education access differs by age group and household structure.
- MTR boundary crosswalks are required.
- School access requires travel-time, walking, cycling, transit, road, safety,
  and universal-access assumptions.

## Suitability Judgment

Suitability: `destination_inventory_source_family`.

Candidate outcome dimensions:

- `access_to_opportunities`;
- `walking_cycling_and_universal_access`, as a partial context only.

Not suitable as:

- full opportunity bundle;
- MTR denominator;
- global source family;
- standalone access metric.

## Methodology Implication

Education destination inventories are necessary if access to opportunities is
broader than jobs. However, destination presence is not usable access unless
eligibility, time, cost, safety, and physical usability are handled or explicitly
caveated.
