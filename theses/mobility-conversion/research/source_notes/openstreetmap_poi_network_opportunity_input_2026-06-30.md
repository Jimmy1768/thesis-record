# Source Note: OpenStreetMap As POI And Network Opportunity Input

Date inspected: 2026-06-30

Verification status: inspected OpenStreetMap source-family documentation as an
open, non-official geospatial data source.

Sources:

- OpenStreetMap, "About OpenStreetMap"
- URL: `https://www.openstreetmap.org/about`

## Source Authority

OpenStreetMap is an open, collaboratively edited geospatial data source. It is
not an official statistical authority.

## What The Source Defines

OpenStreetMap provides mapped features such as streets, paths, transit-related
features, buildings, amenities, shops, healthcare, education, civic places, and
other points or areas of interest where contributors have mapped them.

For Mobility Conversion, the relevant source-family function is open
destination and network inventory input where official destination registries
are unavailable or incomplete.

## Outcome Dimension Fit

Primary fit:

- access to opportunities, for point-of-interest and destination classes;
- walking, cycling, and universal access, for street, path, crossing, and
  facility-network context.

Secondary fit:

- network coverage and service availability, as a supplemental network layer
  only.

## Usefulness For Mobility Conversion

OpenStreetMap is useful for:

- broad destination-class discovery;
- walking and cycling network context;
- street-network routing inputs;
- essential-service destination proxies where official registries are missing;
- auditing whether official datasets omit informal or locally relevant
  destinations.

## Limitations

- OSM is not an official source.
- Completeness varies by country, city, neighborhood, feature type, and mapper
  activity.
- Source-rich or heavily mapped places may appear more accessible than they are.
- Tags are flexible and require careful classification.
- Feature presence does not measure quality, eligibility, cost, hours,
  capacity, safety, accessibility, or cultural suitability.
- OSM-derived opportunity metrics require completeness audits and sensitivity
  checks.

## Suitability Judgment

Suitability: `supplemental_destination_and_network_source_family`.

Candidate outcome dimensions:

- `access_to_opportunities`;
- `walking_cycling_and_universal_access`;
- `network_coverage_and_service_availability`, as supplemental context only.

Not suitable as:

- sole opportunity source;
- MTR denominator;
- official evidence of service quality;
- uncaveated cross-MTR comparison source.

## Methodology Implication

OpenStreetMap may be necessary for global or cross-context opportunity
inventories, but it must carry completeness-bias metadata. If used later, Thesis
2 should record whether an official destination source exists, whether OSM is a
supplement or fallback, and what feature classes are being trusted.
