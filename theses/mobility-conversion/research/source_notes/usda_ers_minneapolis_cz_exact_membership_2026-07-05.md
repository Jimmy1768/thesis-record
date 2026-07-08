# USDA ERS Minneapolis-St. Paul CZ Exact Membership Source Note

Date inspected: 2026-07-05

Verification status: `directly_inspected_official_source`

Source:

- Title or dataset: 2020 Commuting Zones CSV
- Authority or publisher: USDA Economic Research Service
- URL, DOI, document identifier, archive path, API endpoint, or access path:
  - `https://www.ers.usda.gov/media/6968/2020-commuting-zones.csv?v=92446`
- Release date, source vintage, or version:
  - 2020 commuting zones source family.
  - HTTP response served `content-disposition:
    attachment; filename="commuting-zones-2020.csv"`.

Status: independently inspected source note. This note does not admit an MTR,
accept an outcome metric, create an evidence manifest, authorize raw data
archiving, calculate scores, rank MTRs, or make final paper claims.

## Source Authority

USDA Economic Research Service publishes the commuting zones and labor-market
area source family used here.

## What The Source Defines

The official ERS CSV was inspected transiently outside the repo. The relevant
fields are:

```yaml
fields:
  - FIPStxt
  - CountyName
  - StateName
  - CZ2020
  - CZName
  - CZContainment
  - CZAvgContainment
```

The inspected rows identify the Minneapolis commuting zone:

```yaml
commuting_zone:
  CZ2020: "258"
  CZName: "Minneapolis city, MN"
  CZAvgContainment: "94"
  raw_csv_archived_in_repo: false
```

The inspected county membership is:

```yaml
counties:
  - FIPStxt: "27003"
    CountyName: Anoka County
    StateName: Minnesota
    CZContainment: "97.34"
  - FIPStxt: "27019"
    CountyName: Carver County
    StateName: Minnesota
    CZContainment: "95.39"
  - FIPStxt: "27025"
    CountyName: Chisago County
    StateName: Minnesota
    CZContainment: "96.31"
  - FIPStxt: "27037"
    CountyName: Dakota County
    StateName: Minnesota
    CZContainment: "96.3"
  - FIPStxt: "27053"
    CountyName: Hennepin County
    StateName: Minnesota
    CZContainment: "98.17"
  - FIPStxt: "27059"
    CountyName: Isanti County
    StateName: Minnesota
    CZContainment: "91.23"
  - FIPStxt: "27065"
    CountyName: Kanabec County
    StateName: Minnesota
    CZContainment: "86.88"
  - FIPStxt: "27115"
    CountyName: Pine County
    StateName: Minnesota
    CZContainment: "85.62"
  - FIPStxt: "27123"
    CountyName: Ramsey County
    StateName: Minnesota
    CZContainment: "99.02"
  - FIPStxt: "27139"
    CountyName: Scott County
    StateName: Minnesota
    CZContainment: "96.55"
  - FIPStxt: "27163"
    CountyName: Washington County
    StateName: Minnesota
    CZContainment: "98.3"
  - FIPStxt: "55093"
    CountyName: Pierce County
    StateName: Wisconsin
    CZContainment: "86.03"
  - FIPStxt: "55109"
    CountyName: St. Croix County
    StateName: Wisconsin
    CZContainment: "94.86"
```

## Source Function For Mobility Conversion

- `boundary_source_family`
- `population_denominator_source`
- `methodology_reference`

## Boundary / Denominator Role

- MTR boundary source: candidate primary boundary source family for the
  Minneapolis-St. Paul ERS CZ lead, pending county-coarseness and boundary-fit
  review.
- Resident-population denominator source: candidate denominator aggregation
  geography only; this note does not verify or accept ACS population values.
- Overlay or input only: FTA/NTD, GTFS, agency service areas, and routes remain
  overlays only.
- Service-derived denominator risk: downstream only if transit service coverage
  replaces the independent county-based CZ boundary.

## Outcome / Axis Role

- Outcome dimensions supported: none directly.
- Explanatory axes supported: possible future demand-intensity or
  growth/maturity context after separate methodology gates.
- Risk of confusing outcome with explanatory axis: low in this source note.

## Data Availability

- Geography: 2020 commuting zone.
- Spatial unit: county rows.
- Time period or release vintage: 2020 CZ source family.
- Update frequency: not reviewed beyond the inspected source file.
- Access method: public CSV download. The CSV was inspected transiently and not
  archived in the repo.
- License or usage constraint: not fully reviewed in this note.

## Relevance To Mobility Conversion

This note independently verifies the exact ERS CZ code/name and county
membership for the Minneapolis-St. Paul lead. It supports later population
aggregation, county-coarseness review, and service-overlay planning.

It does not decide whether this county-based commuting zone is acceptable as an
MTR denominator.

## Limitations

- The CSV was inspected transiently and not archived in the repo.
- County geometries were not acquired or archived.
- ACS population denominator, MOE handling, and aggregation method remain
  unresolved.
- County coarseness is material, especially for Kanabec, Pine, Pierce, Isanti,
  Chisago, and other peripheral counties.
- Cross-state service-source coverage between Minnesota and Wisconsin remains
  unresolved.
- NTD/GTFS current agency/feed inventory was not verified in this note.

## Suitability Judgment

Suitability: `candidate_primary_boundary`

Rationale:

USDA ERS is the official source authority for this commuting-zone source
family, and the inspected CSV directly verifies `CZ2020 = 258` and 13 county
membership rows. Suitability remains conditional on raw source manifesting,
county geometry, population aggregation, county-coarseness review, and service
overlay.

## Extraction Decision

```yaml
minneapolis_ers_cz_exact_membership_extraction:
  lead_id: mtr_src_004
  working_name: Minneapolis-St. Paul ERS CZ
  source_authority: USDA Economic Research Service
  exact_name: Minneapolis city, MN
  exact_code: "258"
  geography_type: 2020_commuting_zone
  source_file: "commuting-zones-2020.csv"
  county_membership_status: verified_from_transient_official_csv_inspection
  boundary_geometry_status: not_archived
  population_product: unresolved
  population_field: unresolved
  accepted_denominator_value: false
  service_overlay_source: unresolved
  service_coverage_against_boundary: unresolved
  evidence_manifest_status: not_created
  extraction_decision: exact_membership_verified_county_population_and_service_blocked
  blockers:
    - raw_ERS_csv_not_archived
    - county_geometry_not_archived
    - ACS_population_denominator_not_verified
    - county_coarseness_review_not_done
    - cross_state_service_overlay_unresolved
```

## Methodology Implication

Minneapolis-St. Paul should not return to ChatGPT for the exact ERS CZ
membership question. The next work should define the county-coarseness screen
and ACS aggregation method before any not-admitted boundary record is drafted.

## Next Allowed Output

Choose one:

- source-note follow-up.

Specific next follow-up:

- verify county geometry source and acquisition path;
- verify ACS county population denominator and MOE aggregation;
- run county-coarseness readiness review;
- inventory current NTD/GTFS and local service-source coverage against the CZ.

## Prohibited Outputs

This source note does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted population value;
- filled boundary record;
- raw data archive without manifest.
