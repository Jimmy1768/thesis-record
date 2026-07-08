# TIGER 2024 Geometry Extraction Tooling Check

Date: 2026-07-07

Status: tooling check, superseded in branch by 2026-07-08 pyshp spike. No
processed geometry was created in the repo.

Related boundary-alignment plan:

- `theses/mobility-conversion/research/tiger_2024_geometry_boundary_alignment_plan_2026-07-07.md`

## Check Result

Processed TIGER geometry extraction is not ready in the current local runtime.

```yaml
geometry_extraction_tooling_check:
  system_ogrinfo: unavailable
  system_python_pyshp: unavailable
  system_python_fiona: unavailable
  system_python_geopandas: unavailable
  bundled_python_pyshp: unavailable
  bundled_python_fiona: unavailable
  bundled_python_geopandas: unavailable
  bundled_python_pyogrio: unavailable
  processed_geometry_created: false
  extraction_decision: blocked_until_extraction_tooling_available_or_script_added_and_tested
```

The raw ZIPs were already archived, checksummed, ZIP-tested, and reviewed at
schema/header level. The missing tooling affects processed extraction only.

Branch follow-up:

- `theses/mobility-conversion/research/tiger_2024_geometry_tooling_spike_2026-07-08.md`

The branch spike shows that the blocker is solvable with `pyshp` installed into
an isolated temporary target. Formal processed-output extraction still needs its
own log and manifest update before repo evidence outputs are created.

## Acceptable Next Tooling Paths

Choose one later:

- install or expose a standard GIS CLI such as GDAL/OGR;
- install or expose a Python shapefile/GIS library such as pyshp, Fiona,
  GeoPandas, or Pyogrio;
- add a small local extraction script only if it can be tested against all
  eight source ZIPs and preserve `.shp`, `.shx`, `.dbf`, `.prj`, `.cpg`, and
  metadata sidecars correctly.

## Guardrail

Do not create processed geometry, boundary records, metric records, accepted
population values, accepted denominators, scores, rankings, or final claims
from the raw TIGER files until extraction tooling is available and the
processed-output step has its own log or manifest update.
