# Batch O2C Access-To-Opportunities Source Verification Summary

Date: 2026-06-30

Status: source-family verification summary. No outcome metric is accepted. No
metric record is filled. No score, ranking, weight, or MTR comparison is
authorized.

## Sources Inspected

- U.S. Census LEHD / LODES
- U.S. EPA Smart Location Mapping / Smart Location Database source family
- NCES EDGE school-location source family
- OpenStreetMap open geospatial source family
- Existing GTFS Schedule and GTFS Realtime source notes from Batch O1

Source notes:

- `theses/mobility-conversion/research/source_notes/us_census_lehd_lodes_access_to_jobs_input_2026-06-30.md`
- `theses/mobility-conversion/research/source_notes/epa_smart_location_accessibility_input_2026-06-30.md`
- `theses/mobility-conversion/research/source_notes/nces_edge_school_locations_opportunity_input_2026-06-30.md`
- `theses/mobility-conversion/research/source_notes/openstreetmap_poi_network_opportunity_input_2026-06-30.md`
- `theses/mobility-conversion/research/source_notes/gtfs_schedule_outcome_input_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/gtfs_realtime_outcome_input_2026-06-28.md`

## Core Finding

Access to opportunities is not a jobs metric.

The inspected sources separate into five roles:

- opportunity inventories;
- population or household denominators;
- network and travel-time inputs;
- accessibility model precedents;
- supplemental open POI and network data.

Jobs are a critical opportunity class, but they do not cover education,
healthcare, groceries, public services, caregiving, civic life, or social
destinations. A later metric must either define a narrow job-access outcome
honestly or build a broader opportunity bundle with explicit source coverage.

## Verified Position Updates

### LEHD / LODES

LEHD / LODES can support U.S. job-access analysis and worker-flow context. It
should not be treated as the whole access-to-opportunities outcome.

### EPA Smart Location

EPA Smart Location source families provide useful accessibility method
precedents and U.S. small-area indicators. They require variable-level review
because some variables may describe urban form or service supply rather than
outcome access.

### NCES EDGE School Locations

NCES EDGE school locations can support education-destination access as a
non-job opportunity class. School presence still does not measure eligibility,
capacity, quality, catchment rules, or physical usability.

### OpenStreetMap

OpenStreetMap can support POI and network inventories where official sources
are absent or incomplete. It is not official and must carry completeness-bias
metadata.

### Network And Travel-Time Inputs

Opportunity inventories do not measure access until linked to network,
travel-time, cost, safety, and physical-usability assumptions. GTFS Schedule,
GTFS Realtime, street networks, walking/cycling networks, and road travel-time
sources remain separate input families.

## Outcome-Design Implications

Batch O2C supports the following formation-stage rules:

- job access must not silently stand in for all opportunity access;
- every opportunity class needs an inventory source and a source-quality caveat;
- destination presence is not usable access without time, cost, safety,
  eligibility, and physical-usability context;
- accessibility model outputs must be decomposed into destination, network,
  travel-time, cost, and denominator inputs before use;
- open POI sources require completeness-bias review;
- official destination registries are preferred where available, but they may
  be country-specific and incomplete for cross-MTR comparison.

## Required Metadata For Later Access Metric Records

Any later proposed access-to-opportunities metric record should include:

- opportunity class: jobs, education, healthcare, groceries, public services,
  civic/social destinations, or bundle;
- destination source and authority;
- destination inclusion and exclusion rules;
- destination quality, eligibility, capacity, and hours caveats;
- population denominator source;
- covered modes;
- travel-time method and source;
- cost method and source, if any;
- safety or physical-usability constraints, if any;
- geography and MTR crosswalk method;
- data vintage and observation window;
- distributional breakdown availability;
- open-data completeness caveat;
- whether the metric measures destination presence, reachable destinations, or
  usable access under constraints.

## Recommended Next Work

The Tier 1 source-family verification cycle is now sufficient to draft an
outcome metric pre-admission matrix.

That matrix should translate O1, O2A, O2B, and O2C into gates for proposed
metric records before any metric is filled or accepted for candidate testing.

## What This Batch Does Not Authorize

Batch O2C does not authorize:

- filling outcome metric records;
- accepting any access-to-opportunities metric for candidate testing;
- calculating access scores;
- comparing MTRs;
- treating job access as full opportunity access;
- treating POI presence as usable access;
- treating modelled accessibility scores as final outcomes without decomposing
  inputs;
- using open POI completeness as if it were neutral.
