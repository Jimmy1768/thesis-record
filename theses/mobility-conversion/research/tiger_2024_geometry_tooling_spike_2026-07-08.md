# TIGER 2024 Geometry Tooling Spike

Date: 2026-07-08

Branch: `codex/mobility-geometry-tooling`

Status: tooling spike completed. This spike established a repo-local pyshp
workflow, and the accepted follow-on branch work wrote processed geometry
outputs into the repo as recorded in
`theses/mobility-conversion/research/tiger_2024_processed_geometry_extraction_log_2026-07-08.md`
and commit `5e43b41`.

## Question

Can the TIGER geometry extraction blocker be addressed without installing GDAL
globally or changing the main branch?

## Findings

No existing system or bundled GIS tooling was available:

```yaml
unavailable_existing_tools:
  cli:
    - ogrinfo
    - ogr2ogr
    - gdalinfo
    - mapshaper
    - qgis
    - spatialite
  python_system:
    - shapefile
    - fiona
    - geopandas
    - pyogrio
    - osgeo
  python_bundled:
    - shapefile
    - fiona
    - geopandas
    - pyogrio
    - osgeo
  node_system:
    - shapefile
    - shpjs
    - "@mapbox/shp-write"
  node_bundled:
    - shapefile
    - shpjs
    - "@mapbox/shp-write"
```

Homebrew is present, but GDAL is not installed under `/opt/homebrew`, and
sandboxed `brew list` attempts are blocked because Homebrew tries to write cache
metadata outside the workspace.

## Working Tool

`pyshp` installed successfully into an isolated temporary target:

```text
python3 -m pip install --target /tmp/mobility-pyshp-test pyshp
```

Using:

```text
PYTHONPATH=/tmp/mobility-pyshp-test
```

`pyshp` successfully read the archived TIGER ZIP directly:

```yaml
read_test:
  source_zip: tl_2024_27_tract.zip
  records: 1505
  shape_type: POLYGON
  fields:
    - STATEFP
    - COUNTYFP
    - TRACTCE
    - GEOID
    - GEOIDFQ
    - NAME
    - NAMELSAD
    - MTFCC
    - FUNCSTAT
    - ALAND
    - AWATER
    - INTPTLAT
    - INTPTLON
```

It also successfully wrote a temporary Minneapolis Minnesota tract subset to
`/tmp/mobility-geometry-tool-test/`:

```yaml
write_test:
  config: minneapolis_ers_cz_mn_tracts_test
  selected_records: 819
  output_sidecars:
    - .cpg
    - .dbf
    - .prj
    - .shp
    - .shx
  readback_records: 819
  readback_shape_type: POLYGON
  readback_bbox: [-94.012497, 44.471149, -92.29239, 46.419355]
```

The reusable branch script then passed dry-run and write-mode tests for all
configured extraction targets:

```yaml
script_test:
  script: theses/mobility-conversion/research/tools/tiger_county_filter_pyshp.py
  dependency_mode: PYTHONPATH=/tmp/mobility-pyshp-test
  dry_run_results:
    minneapolis_tract:
      minnesota_selected: 819
      wisconsin_selected: 26
      total_selected: 845
    minneapolis_block_group:
      minnesota_selected: 2668
      wisconsin_selected: 81
      total_selected: 2749
    portland_tract:
      oregon_selected: 448
      washington_selected: 120
      total_selected: 568
    portland_block_group:
      oregon_selected: 1340
      washington_selected: 323
      total_selected: 1663
  write_mode_output_root: /tmp/mobility-write-test/
  readback_results:
    minneapolis_tract:
      records: 845
      shape_type: POLYGON
      bbox: [-94.012497, 44.471149, -92.134785, 46.419355]
    minneapolis_block_group:
      records: 2749
      shape_type: POLYGON
      bbox: [-94.012497, 44.471149, -92.134785, 46.419355]
    portland_tract:
      records: 568
      shape_type: POLYGON
      bbox: [-123.785567, 44.885714, -121.51438, 46.388629]
    portland_block_group:
      records: 1663
      shape_type: POLYGON
      bbox: [-123.785567, 44.885714, -121.51438, 46.388629]
```

## Branch Artifact

Added reusable script:

- `theses/mobility-conversion/research/tools/tiger_county_filter_pyshp.py`

The script supports dry-run and write modes for:

- `minneapolis_tract`
- `minneapolis_block_group`
- `portland_tract`
- `portland_block_group`

It filters by `STATEFP` and `COUNTYFP` only. It does not join ACS data,
calculate population, create boundary records, admit MTRs, create scores, or
rank places.

## Decision

The TIGER geometry extraction blocker is solvable with `pyshp`.

Completed next step on this branch:

- used documented temporary runtime setup with `PYTHONPATH=/tmp/mobility-pyshp-test`;
- ran write mode to the processed evidence path;
- created a processed-geometry extraction log and manifest update.

Current next step:

- perform processed geometry topology or visual sanity review;
- decide whether tract-level geometry is sufficient for the first sensitivity
  pass.

ACS remains separately blocked by local TLS/API failures.
