# TIGER 2024 Processed Geometry Validation

Date: 2026-07-12

Status: feature-level validation passed for the four committed Minneapolis and
Portland processed layers. This record does not accept population values,
accept a denominator, fill a boundary record, create an outcome metric record,
calculate scores, rank places, or support final paper claims.

Validator:

- `theses/mobility-conversion/research/tools/tiger_processed_geometry_validate.py`

Runtime:

```text
PYTHONPATH=/tmp/mobility-geometry-phase3
```

## Scope

This validation covered the four committed processed TIGER layers:

- `minneapolis_ers_cz_tracts`
- `minneapolis_ers_cz_block_groups`
- `portland_cbsa_tracts`
- `portland_cbsa_block_groups`

The validator was read-only. It checked:

- expected `.shp`, `.shx`, `.dbf`, `.prj`, and `.cpg` sidecars;
- sidecar sha256 checksums against the extraction log and manifest;
- record and shape count equality;
- POLYGON shape type;
- required schema fields;
- exact five-digit state-plus-county membership;
- tract and block-group GEOID composition;
- unique GEOIDs;
- non-empty positive-area geometries;
- Shapely feature validity;
- plausible coordinate bounds;
- exact recorded bounding boxes;
- block-group parent tract GEOID membership.

It did not perform geometry repair, planar coverage validation, population
joins, ACS row acquisition, or visual review.

## Results

All four layers passed.

### Minneapolis Tracts

```yaml
layer: minneapolis_ers_cz_tracts
expected_count: 845
observed_count: 845
shape_type: POLYGON
county_fips_set:
  - 27003
  - 27019
  - 27025
  - 27037
  - 27053
  - 27059
  - 27065
  - 27115
  - 27123
  - 27139
  - 27163
  - 55093
  - 55109
geoid_composition: passed
bbox: [-94.012497, 44.471149, -92.134785, 46.419355]
sidecar_checksums: passed
field_validation: passed
geoid_validation: passed
geometry_validation: passed
```

### Minneapolis Block Groups

```yaml
layer: minneapolis_ers_cz_block_groups
expected_count: 2749
observed_count: 2749
shape_type: POLYGON
county_fips_set:
  - 27003
  - 27019
  - 27025
  - 27037
  - 27053
  - 27059
  - 27065
  - 27115
  - 27123
  - 27139
  - 27163
  - 55093
  - 55109
geoid_composition: passed
bbox: [-94.012497, 44.471149, -92.134785, 46.419355]
sidecar_checksums: passed
field_validation: passed
geoid_validation: passed
geometry_validation: passed
parent_tract_membership: passed
```

### Portland Tracts

```yaml
layer: portland_cbsa_tracts
expected_count: 568
observed_count: 568
shape_type: POLYGON
county_fips_set:
  - 41005
  - 41009
  - 41051
  - 41067
  - 41071
  - 53011
  - 53059
geoid_composition: passed
bbox: [-123.785567, 44.885714, -121.51438, 46.388629]
sidecar_checksums: passed
field_validation: passed
geoid_validation: passed
geometry_validation: passed
```

### Portland Block Groups

```yaml
layer: portland_cbsa_block_groups
expected_count: 1663
observed_count: 1663
shape_type: POLYGON
county_fips_set:
  - 41005
  - 41009
  - 41051
  - 41067
  - 41071
  - 53011
  - 53059
geoid_composition: passed
bbox: [-123.785567, 44.885714, -121.51438, 46.388629]
sidecar_checksums: passed
field_validation: passed
geoid_validation: passed
geometry_validation: passed
parent_tract_membership: passed
```

## Exact Checks

The processed sidecar checksum set matched the extraction log and manifest for
all 20 files.

The validator confirmed exact five-digit county_fips_set membership and GEOID
composition for all four layers:

- tracts: `STATEFP+COUNTYFP+TRACTCE`
- block groups: `STATEFP+COUNTYFP+TRACTCE+BLKGRPCE`

The expected counts remained unchanged:

- Minneapolis tracts: 845
- Minneapolis block groups: 2749
- Portland tracts: 568
- Portland block groups: 1663

The validator found:

- zero duplicate GEOIDs;
- zero GEOID composition mismatches;
- zero empty geometries;
- zero nonpositive-area geometries;
- zero invalid Shapely geometries;
- zero missing block-group parent tracts.

## Limits

This record is geometry-only.

It does not admit any MTR, does not accept any population or denominator
value, does not establish empirical tract sufficiency, and does not claim
planar coverage topology or visual review.

The Phase 4 join decision remains pending, with tract geometry accepted only as
the initial population-join geography and block-group geometry retained as the
escalation layer for peripheral or edge sensitivity.
