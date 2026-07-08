# TIGER 2024 Processed Geometry Extraction Log

Date: 2026-07-08

Branch: `codex/mobility-geometry-tooling`

Status: processed geometry extraction log. This log does not accept population
values, accept a denominator, fill a boundary record, create an outcome metric
record, calculate scores, rank places, or support final paper claims.

Related manifest:

- `theses/mobility-conversion/evidence/manifests/tiger_2024_subcounty_geometry_overlay_manifest_2026-07-07.md`

Related plan and tooling spike:

- `theses/mobility-conversion/research/tiger_2024_geometry_boundary_alignment_plan_2026-07-07.md`
- `theses/mobility-conversion/research/tiger_2024_geometry_tooling_spike_2026-07-08.md`

Extraction script:

- `theses/mobility-conversion/research/tools/tiger_county_filter_pyshp.py`
- dependency file:
  `theses/mobility-conversion/research/tools/requirements-geometry.txt`

Runtime used:

```text
python3 -m pip install --target /tmp/mobility-pyshp-test pyshp
PYTHONPATH=/tmp/mobility-pyshp-test
```

## Extraction Commands

```text
PYTHONPATH=/tmp/mobility-pyshp-test python3 theses/mobility-conversion/research/tools/tiger_county_filter_pyshp.py minneapolis_tract --output-dir theses/mobility-conversion/evidence/processed/us_census/tiger_2024_subcounty_geometry/minneapolis_ers_cz_tracts
PYTHONPATH=/tmp/mobility-pyshp-test python3 theses/mobility-conversion/research/tools/tiger_county_filter_pyshp.py minneapolis_block_group --output-dir theses/mobility-conversion/evidence/processed/us_census/tiger_2024_subcounty_geometry/minneapolis_ers_cz_block_groups
PYTHONPATH=/tmp/mobility-pyshp-test python3 theses/mobility-conversion/research/tools/tiger_county_filter_pyshp.py portland_tract --output-dir theses/mobility-conversion/evidence/processed/us_census/tiger_2024_subcounty_geometry/portland_cbsa_tracts
PYTHONPATH=/tmp/mobility-pyshp-test python3 theses/mobility-conversion/research/tools/tiger_county_filter_pyshp.py portland_block_group --output-dir theses/mobility-conversion/evidence/processed/us_census/tiger_2024_subcounty_geometry/portland_cbsa_block_groups
```

## Extraction Results

```yaml
tiger_2024_processed_geometry_extraction:
  processed_root: theses/mobility-conversion/evidence/processed/us_census/tiger_2024_subcounty_geometry/
  filter_method: STATEFP_plus_COUNTYFP
  acs_join_performed: false
  population_values_accepted: false
  denominator_values_accepted: false
  outputs:
    minneapolis_ers_cz_tracts:
      source_configs:
        tl_2024_27_tract.zip: 819
        tl_2024_55_tract.zip: 26
      total_records: 845
      shape_type: POLYGON
      bbox: [-94.012497, 44.471149, -92.134785, 46.419355]
      fields_prefix: [STATEFP, COUNTYFP, TRACTCE, GEOID, GEOIDFQ, NAME]
      sidecars: [.cpg, .dbf, .prj, .shp, .shx]
    minneapolis_ers_cz_block_groups:
      source_configs:
        tl_2024_27_bg.zip: 2668
        tl_2024_55_bg.zip: 81
      total_records: 2749
      shape_type: POLYGON
      bbox: [-94.012497, 44.471149, -92.134785, 46.419355]
      fields_prefix: [STATEFP, COUNTYFP, TRACTCE, BLKGRPCE, GEOID, GEOIDFQ]
      sidecars: [.cpg, .dbf, .prj, .shp, .shx]
    portland_cbsa_tracts:
      source_configs:
        tl_2024_41_tract.zip: 448
        tl_2024_53_tract.zip: 120
      total_records: 568
      shape_type: POLYGON
      bbox: [-123.785567, 44.885714, -121.51438, 46.388629]
      fields_prefix: [STATEFP, COUNTYFP, TRACTCE, GEOID, GEOIDFQ, NAME]
      sidecars: [.cpg, .dbf, .prj, .shp, .shx]
    portland_cbsa_block_groups:
      source_configs:
        tl_2024_41_bg.zip: 1340
        tl_2024_53_bg.zip: 323
      total_records: 1663
      shape_type: POLYGON
      bbox: [-123.785567, 44.885714, -121.51438, 46.388629]
      fields_prefix: [STATEFP, COUNTYFP, TRACTCE, BLKGRPCE, GEOID, GEOIDFQ]
      sidecars: [.cpg, .dbf, .prj, .shp, .shx]
```

## Processed File Checksums

```yaml
processed_checksums_sha256:
  minneapolis_ers_cz_block_groups:
    cpg: 3ad3031f5503a4404af825262ee8232cc04d4ea6683d42c5dd0a2f2a27ac9824
    dbf: bf7aa27ca52548e7dc3a4f3e3d3f57b0283b4c78fa76cb81ffcfed7e9bd38f63
    prj: 0b9041e921d9ebb43247d314608fe9e38a0b008ee793067fc1806199ea1fb9dd
    shp: 8af7cb7535c36ad12b4592826be441d70d2cca304da3970529cb297766162b55
    shx: 8b487713beaba5cba70313e66d7c81bc4e2898ed265f3655250e62719da56bed
  minneapolis_ers_cz_tracts:
    cpg: 3ad3031f5503a4404af825262ee8232cc04d4ea6683d42c5dd0a2f2a27ac9824
    dbf: e3c0670c7b00073f30f9a8acc2af6547256a8072ff21c01983917cedb66dc31f
    prj: 0b9041e921d9ebb43247d314608fe9e38a0b008ee793067fc1806199ea1fb9dd
    shp: becd5dad0c404205533dab9df1129a24ee1c78cd946f029a9bf035ff6ec4f6cd
    shx: f16c411d27f09261467309437da3398f7f4e1aae34669d912b9437e0c30950b6
  portland_cbsa_block_groups:
    cpg: 3ad3031f5503a4404af825262ee8232cc04d4ea6683d42c5dd0a2f2a27ac9824
    dbf: 2f8ed20f1bef7680a9df0937488b33a20a3dbb89b53e1c9962eba05fb75a7d0d
    prj: 0b9041e921d9ebb43247d314608fe9e38a0b008ee793067fc1806199ea1fb9dd
    shp: 9320900f80b44eb4f1f9ba004b179639ca546ae6ebda36f8ea555eccf7bbae79
    shx: bfaf0988cb08b964e9720341cc62a030bab0ff697a91f43c66877321c65ccc67
  portland_cbsa_tracts:
    cpg: 3ad3031f5503a4404af825262ee8232cc04d4ea6683d42c5dd0a2f2a27ac9824
    dbf: e4a547542a930f7e274d5e24cbecb912631dff7b64d80c9c5c48a16483e9b5ed
    prj: 0b9041e921d9ebb43247d314608fe9e38a0b008ee793067fc1806199ea1fb9dd
    shp: fb61a5fefe3fd9bf0090c19f7c1d675103c4a61cfc3e55f3e2e8a83109003d4f
    shx: 1397614a316697ce3ed413467cdaf74ba61b5019a11a71c6e2910fcbfb49fb52
```

## Limits

The processed geometry is county-filtered TIGER geometry only. It is an overlay
input, not an admitted MTR boundary. It has no ACS population join, no accepted
population value, no accepted denominator value, no service coverage overlay,
and no outcome metric.

The source metadata XML files were not copied into the derived combined
outputs because each processed layer combines state source files. This
extraction log is the derived-output metadata for the processed files.

## Next Required Gate

- review processed geometry output status in the manifest;
- decide whether tract-level geometry is sufficient for the first visual
  boundary-fit sensitivity pass;
- keep ACS API/table work deferred until row access is verified;
- do not create a filled boundary record or metric record from these outputs.
