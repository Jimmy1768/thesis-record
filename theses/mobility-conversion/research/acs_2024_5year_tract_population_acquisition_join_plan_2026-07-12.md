# ACS 2024 5-Year Tract Population Acquisition and Join Plan

Date: 2026-07-12

Status: bounded Phase 4 acquisition and join plan. This plan does not accept
population values, accept a denominator, fill a boundary record, create an
outcome metric record, calculate scores, rank places, or support final paper
claims.

Related manifest:

- `theses/mobility-conversion/evidence/manifests/acs_2024_5year_tract_population_overlay_manifest_2026-07-12.md`

Related geometry manifest:

- `theses/mobility-conversion/evidence/manifests/tiger_2024_subcounty_geometry_overlay_manifest_2026-07-07.md`

Related source note:

- `theses/mobility-conversion/research/source_notes/us_census_acs_tiger_subcounty_overlay_sources_2026-07-06.md`

## Purpose

Define a read-only, checksum-verified ACS tract population capture and join
workflow for Minneapolis and Portland Phase 4 work.

The plan is provisional and input-only. It does not authorize any accepted
population value or denominator value.

## Acquisition Scope

```yaml
acquisition_scope:
  source_family: American Community Survey 2024 5-year detailed table B01003
  source_authority: U.S. Census Bureau
  api_base: https://api.census.gov/data/2024/acs/acs5
  requested_fields:
    - NAME
    - B01003_001E
    - B01003_001M
  geography: tract
  county_filter_method: exact_state_and_county
  join_key: STATEFP_plus_COUNTYFP_plus_TRACTCE
  vintage_alignment:
    census_population_vintage: ACS 2024 5-year
    geometry_vintage: TIGER/Line 2024 tract layers
  accepted_population_value: false
  accepted_denominator_value: false
```

## County Scope

```yaml
county_scope:
  total_counties: 20
  minneapolis_counties:
    - "27003"
    - "27019"
    - "27025"
    - "27037"
    - "27053"
    - "27059"
    - "27065"
    - "27115"
    - "27123"
    - "27139"
    - "27163"
    - "55093"
    - "55109"
  portland_counties:
    - "41005"
    - "41009"
    - "41051"
    - "41067"
    - "41071"
    - "53011"
    - "53059"
```

## Raw Capture Rules

The fetch step must:

- query the official Census API once for each exact county;
- emit only the exact row fields requested by this plan;
- reject malformed, negative, noninteger, or sentinel estimate/MOE values;
- reject rows whose returned state or county does not match the requested
  state and county;
- validate all 20 county payloads before writing any raw capture file;
- write one exact-response county JSON file per county plus one stable-order
  capture index file;
- record retrieval timestamp, query URL, row count, and sha256 in the index;
- preserve exact Census API response bytes for each county file;
- refuse to write into a nonempty output directory;
- support `--dry-run` without network access by printing the 20 encoded query
  URLs only;
- never require or log an API key.

### Raw Layout

```yaml
raw_layout:
  root: theses/mobility-conversion/evidence/raw/us_census/acs_2024_5year_tract_population/
  county_json_pattern: "<STATEFP><COUNTYFP>.json"
  index_file: index.json
  county_payload_contract: exact_census_api_response_bytes
  metadata_fields:
    - state_fips
    - county_fips
    - source_family
    - source_vintage
    - api_base
    - requested_fields
    - query_url
    - row_count
    - sha256
    - retrieval_timestamp
```

## Join Rules

The join step must:

- verify the raw capture index and each county response-byte checksum before
  reading rows;
- verify the exact 20 county files plus index.json, rejecting missing or extra
  files;
- parse the exact raw response bytes as Census API list-of-lists JSON only in
  memory;
- verify all 20 exact county files and exact tract response headers;
- validate the committed TIGER tract schema exactly as:
  `STATEFP`, `COUNTYFP`, `TRACTCE`, `GEOID`, `GEOIDFQ`, `NAME`, `NAMELSAD`,
  `MTFCC`, `FUNCSTAT`, `ALAND`, `AWATER`, `INTPTLAT`, `INTPTLON`;
- verify exact county membership for every returned row;
- verify exact GEOID composition as `STATEFP+COUNTYFP+TRACTCE`;
- read the committed Minneapolis and Portland tract shapefiles with pyshp;
- enforce one-to-one GEOID coverage between geometry and ACS rows;
- preserve both estimate and MOE per tract;
- reject duplicates, unmatched rows, missing rows, and any aggregation;
- write a single deterministic provisional joined CSV plus summary JSON only to
  an explicit empty output directory.

### Processed Layout

```yaml
processed_layout:
  root: theses/mobility-conversion/evidence/processed/us_census/acs_2024_5year_tract_population/
  joined_csv: acs_2024_5year_tract_population_join.csv
  summary_json: acs_2024_5year_tract_population_join_summary.json
  geometry_layers:
    - minneapolis_ers_cz_tracts
    - portland_cbsa_tracts
  summary_provenance_fields:
    - acs_source_family
    - acs_source_vintage
    - capture_retrieval_timestamp
    - raw_index_sha256
    - tiger_geometry_manifest_repo_path
    - status
    - accepted_population_value
    - accepted_denominator_value
    - one_to_one_coverage
    - layers
  prohibited_summary_fields:
    - raw_root
    - geometry_root
    - absolute_local_paths
    - temporary_directory_paths
```

## Guardrails

The plan does not authorize:

- accepted population values;
- accepted denominator values;
- tract aggregation;
- block-group aggregation;
- comparison;
- scoring;
- ranking;
- publication claims;
- boundary-record admission.

It also does not authorize raw evidence creation until the external-environment
ACS row capture is complete and checksum-verified.

## Next Allowed Outputs

Choose one:

- external-environment ACS tract row capture under the manifest;
- local checksum-verified read-only provisional join after raw capture exists.
