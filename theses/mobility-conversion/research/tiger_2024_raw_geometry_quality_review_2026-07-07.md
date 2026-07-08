# TIGER 2024 Raw Geometry Quality Review

Date: 2026-07-07

Status: raw geometry quality review. This note does not create processed
geometry, accept population values, accept a denominator, fill a boundary
record, create an outcome metric record, calculate scores, rank places, or
support final paper claims.

Related manifest:

- `theses/mobility-conversion/evidence/manifests/tiger_2024_subcounty_geometry_overlay_manifest_2026-07-07.md`

Related acquisition log:

- `theses/mobility-conversion/research/tiger_2024_raw_geometry_acquisition_log_2026-07-07.md`

Raw archive root:

- `theses/mobility-conversion/evidence/raw/us_census/tiger_2024_subcounty_geometry/`

## Review Method

The ZIP archives were inspected without extracting or transforming geometry.
The review used:

- ZIP integrity tests;
- DBF header parsing for feature counts and fields;
- SHP header parsing for geometry type and bounding boxes;
- PRJ text inspection for coordinate reference system.

No topology validation, spatial overlay, feature-level geometry repair,
processed layer creation, or ACS population join was performed.

## Schema And Feature Counts

```yaml
tiger_2024_raw_geometry_quality_review:
  coordinate_reference_system:
    prj_name: GCS_North_American_1983
    datum: D_North_American_1983
    spheroid: GRS_1980
    unit: Degree
  shapefile_shape_type:
    code: 5
    label: Polygon
  tract_schema:
    feature_key_fields:
      - STATEFP
      - COUNTYFP
      - TRACTCE
      - GEOID
      - GEOIDFQ
    contextual_fields:
      - NAME
      - NAMELSAD
      - MTFCC
      - FUNCSTAT
      - ALAND
      - AWATER
      - INTPTLAT
      - INTPTLON
    geoid_length: 11
  block_group_schema:
    feature_key_fields:
      - STATEFP
      - COUNTYFP
      - TRACTCE
      - BLKGRPCE
      - GEOID
      - GEOIDFQ
    contextual_fields:
      - NAMELSAD
      - MTFCC
      - FUNCSTAT
      - ALAND
      - AWATER
      - INTPTLAT
      - INTPTLON
    geoid_length: 12
  files:
    tl_2024_27_bg.zip:
      geography: Minnesota block group
      records: 4706
      shape_type: Polygon
      bbox: [-97.239093, 43.499361, -89.483385, 49.384479]
      schema_review: passed
    tl_2024_27_tract.zip:
      geography: Minnesota tract
      records: 1505
      shape_type: Polygon
      bbox: [-97.239093, 43.499361, -89.483385, 49.384479]
      schema_review: passed
    tl_2024_41_bg.zip:
      geography: Oregon block group
      records: 2970
      shape_type: Polygon
      bbox: [-124.703541, 41.992082, -116.463262, 46.299099]
      schema_review: passed
    tl_2024_41_tract.zip:
      geography: Oregon tract
      records: 1001
      shape_type: Polygon
      bbox: [-124.703541, 41.992082, -116.463262, 46.299099]
      schema_review: passed
    tl_2024_53_bg.zip:
      geography: Washington block group
      records: 5311
      shape_type: Polygon
      bbox: [-124.848974, 45.543541, -116.916071, 49.002439]
      schema_review: passed
    tl_2024_53_tract.zip:
      geography: Washington tract
      records: 1784
      shape_type: Polygon
      bbox: [-124.848974, 45.543541, -116.916071, 49.002439]
      schema_review: passed
    tl_2024_55_bg.zip:
      geography: Wisconsin block group
      records: 4692
      shape_type: Polygon
      bbox: [-92.889433, 42.49172, -86.249548, 47.309822]
      schema_review: passed
    tl_2024_55_tract.zip:
      geography: Wisconsin tract
      records: 1542
      shape_type: Polygon
      bbox: [-92.889433, 42.49172, -86.249548, 47.309822]
      schema_review: passed
```

## Quality Decision

The raw TIGER geometry ZIPs pass the current archive-level quality gate:

- all expected ZIPs are present;
- each ZIP passed integrity testing;
- each ZIP contains the expected shapefile sidecar set;
- each DBF has the expected tract or block-group key fields;
- each SHP header reports polygon geometry;
- each PRJ reports NAD83 geographic coordinates.

This is not yet a spatial-method approval. The geometry still needs a boundary
alignment plan before any processed extraction or overlay. The ACS population
tables remain unavailable in this environment, so no population overlay can be
created.

## Next Required Gate

Next local work should prepare a boundary-alignment and extraction plan for
geometry only:

- identify the exact county FIPS set for the Minneapolis ERS CZ lead and
  Portland CBSA lead from already verified boundary source notes;
- define whether tract-first geometry can be filtered by `STATEFP` and
  `COUNTYFP` before any spatial overlay;
- define when block-group detail is required;
- define the processed-output path, if any;
- keep ACS population tables deferred until API row verification succeeds.

## Prohibited Outputs

This quality review does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- accepted population value;
- accepted denominator value;
- filled boundary record;
- outcome metric record;
- score;
- ranking;
- final paper claim.
