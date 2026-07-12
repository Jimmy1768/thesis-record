#!/usr/bin/env python3
"""Validate the processed TIGER geometry layers without modifying them.

This validator is intentionally read-only. It checks the four committed
Minneapolis and Portland processed layers for:

- required sidecars and sidecar checksums;
- record and shape count equality;
- POLYGON shape type;
- required schema fields;
- exact county membership;
- unique GEOIDs;
- non-empty positive-area geometries;
- Shapely feature validity;
- plausible coordinate bounds and recorded bounding boxes;
- block-group parent GEOID membership in the corresponding tract layer.

It never writes or repairs geometry and exits nonzero on the first invariant
failure.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
from typing import Any

import shapefile
from shapely.geometry import shape as shapely_shape


THESIS_ROOT = Path(__file__).resolve().parents[2]
PROCESSED_ROOT = (
    THESIS_ROOT / "evidence/processed/us_census/tiger_2024_subcounty_geometry"
)

EXPECTED_SIDECARS = (".shp", ".shx", ".dbf", ".prj", ".cpg")
BOUNDS_TOLERANCE = 1e-9


LAYERS: dict[str, dict[str, Any]] = {
    "minneapolis_ers_cz_tracts": {
        "stem": "minneapolis_ers_cz_tracts",
        "expected_count": 845,
        "expected_bbox": [-94.012497, 44.471149, -92.134785, 46.419355],
        "expected_counties": {
            "27003",
            "27019",
            "27025",
            "27037",
            "27053",
            "27059",
            "27065",
            "27115",
            "27123",
            "27139",
            "27163",
            "55093",
            "55109",
        },
        "expected_fields": [
            "STATEFP",
            "COUNTYFP",
            "TRACTCE",
            "GEOID",
            "GEOIDFQ",
            "NAME",
            "NAMELSAD",
            "MTFCC",
            "FUNCSTAT",
            "ALAND",
            "AWATER",
            "INTPTLAT",
            "INTPTLON",
        ],
        "expected_geoid_length": 11,
        "sidecar_checksums": {
            ".cpg": "3ad3031f5503a4404af825262ee8232cc04d4ea6683d42c5dd0a2f2a27ac9824",
            ".dbf": "e3c0670c7b00073f30f9a8acc2af6547256a8072ff21c01983917cedb66dc31f",
            ".prj": "0b9041e921d9ebb43247d314608fe9e38a0b008ee793067fc1806199ea1fb9dd",
            ".shp": "becd5dad0c404205533dab9df1129a24ee1c78cd946f029a9bf035ff6ec4f6cd",
            ".shx": "f16c411d27f09261467309437da3398f7f4e1aae34669d912b9437e0c30950b6",
        },
        "parent_layer": None,
    },
    "minneapolis_ers_cz_block_groups": {
        "stem": "minneapolis_ers_cz_block_groups",
        "expected_count": 2749,
        "expected_bbox": [-94.012497, 44.471149, -92.134785, 46.419355],
        "expected_counties": {
            "27003",
            "27019",
            "27025",
            "27037",
            "27053",
            "27059",
            "27065",
            "27115",
            "27123",
            "27139",
            "27163",
            "55093",
            "55109",
        },
        "expected_fields": [
            "STATEFP",
            "COUNTYFP",
            "TRACTCE",
            "BLKGRPCE",
            "GEOID",
            "GEOIDFQ",
            "NAMELSAD",
            "MTFCC",
            "FUNCSTAT",
            "ALAND",
            "AWATER",
            "INTPTLAT",
            "INTPTLON",
        ],
        "expected_geoid_length": 12,
        "sidecar_checksums": {
            ".cpg": "3ad3031f5503a4404af825262ee8232cc04d4ea6683d42c5dd0a2f2a27ac9824",
            ".dbf": "bf7aa27ca52548e7dc3a4f3e3d3f57b0283b4c78fa76cb81ffcfed7e9bd38f63",
            ".prj": "0b9041e921d9ebb43247d314608fe9e38a0b008ee793067fc1806199ea1fb9dd",
            ".shp": "8af7cb7535c36ad12b4592826be441d70d2cca304da3970529cb297766162b55",
            ".shx": "8b487713beaba5cba70313e66d7c81bc4e2898ed265f3655250e62719da56bed",
        },
        "parent_layer": "minneapolis_ers_cz_tracts",
    },
    "portland_cbsa_tracts": {
        "stem": "portland_cbsa_tracts",
        "expected_count": 568,
        "expected_bbox": [-123.785567, 44.885714, -121.51438, 46.388629],
        "expected_counties": {"41005", "41009", "41051", "41067", "41071", "53011", "53059"},
        "expected_fields": [
            "STATEFP",
            "COUNTYFP",
            "TRACTCE",
            "GEOID",
            "GEOIDFQ",
            "NAME",
            "NAMELSAD",
            "MTFCC",
            "FUNCSTAT",
            "ALAND",
            "AWATER",
            "INTPTLAT",
            "INTPTLON",
        ],
        "expected_geoid_length": 11,
        "sidecar_checksums": {
            ".cpg": "3ad3031f5503a4404af825262ee8232cc04d4ea6683d42c5dd0a2f2a27ac9824",
            ".dbf": "e4a547542a930f7e274d5e24cbecb912631dff7b64d80c9c5c48a16483e9b5ed",
            ".prj": "0b9041e921d9ebb43247d314608fe9e38a0b008ee793067fc1806199ea1fb9dd",
            ".shp": "fb61a5fefe3fd9bf0090c19f7c1d675103c4a61cfc3e55f3e2e8a83109003d4f",
            ".shx": "1397614a316697ce3ed413467cdaf74ba61b5019a11a71c6e2910fcbfb49fb52",
        },
        "parent_layer": None,
    },
    "portland_cbsa_block_groups": {
        "stem": "portland_cbsa_block_groups",
        "expected_count": 1663,
        "expected_bbox": [-123.785567, 44.885714, -121.51438, 46.388629],
        "expected_counties": {"41005", "41009", "41051", "41067", "41071", "53011", "53059"},
        "expected_fields": [
            "STATEFP",
            "COUNTYFP",
            "TRACTCE",
            "BLKGRPCE",
            "GEOID",
            "GEOIDFQ",
            "NAMELSAD",
            "MTFCC",
            "FUNCSTAT",
            "ALAND",
            "AWATER",
            "INTPTLAT",
            "INTPTLON",
        ],
        "expected_geoid_length": 12,
        "sidecar_checksums": {
            ".cpg": "3ad3031f5503a4404af825262ee8232cc04d4ea6683d42c5dd0a2f2a27ac9824",
            ".dbf": "2f8ed20f1bef7680a9df0937488b33a20a3dbb89b53e1c9962eba05fb75a7d0d",
            ".prj": "0b9041e921d9ebb43247d314608fe9e38a0b008ee793067fc1806199ea1fb9dd",
            ".shp": "9320900f80b44eb4f1f9ba004b179639ca546ae6ebda36f8ea555eccf7bbae79",
            ".shx": "bfaf0988cb08b964e9720341cc62a030bab0ff697a91f43c66877321c65ccc67",
        },
        "parent_layer": "portland_cbsa_tracts",
    },
}


def fail(message: str) -> None:
    raise SystemExit(message)


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def validate_sidecars(base: Path, expected_checksums: dict[str, str]) -> None:
    for extension in EXPECTED_SIDECARS:
        path = base.with_suffix(extension)
        if not path.exists():
            fail(f"Missing sidecar: {path}")
        actual = sha256(path)
        expected = expected_checksums[extension]
        if actual != expected:
            fail(f"Checksum mismatch for {path}: expected {expected}, got {actual}")

    actual_files = {path.suffix for path in base.parent.glob(f"{base.name}.*") if path.is_file()}
    if actual_files != set(EXPECTED_SIDECARS):
        fail(
            f"Unexpected sidecar set for {base}: expected {sorted(EXPECTED_SIDECARS)}, "
            f"got {sorted(actual_files)}"
        )

    if base.with_suffix(".cpg").read_text(encoding="utf-8").strip() != "UTF-8":
        fail(f"Unexpected CPG encoding marker in {base.with_suffix('.cpg')}")

    if "North_American_1983" not in base.with_suffix(".prj").read_text(encoding="utf-8"):
        fail(f"Unexpected PRJ content in {base.with_suffix('.prj')}")


def validate_layer(name: str, spec: dict[str, Any], tract_geoid_sets: dict[str, set[str]]) -> dict[str, Any]:
    base = PROCESSED_ROOT / spec["stem"] / spec["stem"]
    validate_sidecars(base, spec["sidecar_checksums"])

    reader = shapefile.Reader(str(base))
    if reader.shapeTypeName != "POLYGON":
        fail(f"{name}: expected POLYGON, got {reader.shapeTypeName}")

    if reader.numRecords != reader.numShapes:
        fail(
            f"{name}: record/shape count mismatch: "
            f"{reader.numRecords} records vs {reader.numShapes} shapes"
        )

    fields = [field[0] for field in reader.fields[1:]]
    if fields != spec["expected_fields"]:
        fail(f"{name}: unexpected fields {fields}")

    seen_geoids: set[str] = set()
    observed_counties: set[str] = set()
    minx = miny = float("inf")
    maxx = maxy = float("-inf")
    invalid = 0
    empty = 0
    nonpositive = 0
    index_geoid = fields.index("GEOID")
    index_statefp = fields.index("STATEFP")
    index_countyfp = fields.index("COUNTYFP")
    index_tractce = fields.index("TRACTCE")
    index_blkgrpce = fields.index("BLKGRPCE") if "BLKGRPCE" in fields else None

    for shape_record in reader.iterShapeRecords():
        record = shape_record.record
        geoid = record[index_geoid]
        county_fips = f"{record[index_statefp]}{record[index_countyfp]}"
        if geoid in seen_geoids:
            fail(f"{name}: duplicate GEOID {geoid}")
        if len(geoid) != spec["expected_geoid_length"]:
            fail(f"{name}: unexpected GEOID length for {geoid}")
        if spec["parent_layer"] is None:
            expected_geoid = f"{county_fips}{record[index_tractce]}"
        else:
            expected_geoid = f"{county_fips}{record[index_tractce]}{record[index_blkgrpce]}"
        if geoid != expected_geoid:
            fail(
                f"{name}: GEOID composition mismatch for {geoid}: "
                f"expected {expected_geoid}"
            )
        seen_geoids.add(geoid)
        observed_counties.add(county_fips)

        geometry = shapely_shape(shape_record.shape.__geo_interface__)
        if geometry.is_empty:
            empty += 1
        if geometry.area <= 0:
            nonpositive += 1
        if not geometry.is_valid:
            invalid += 1

        bounds = geometry.bounds
        minx = min(minx, bounds[0])
        miny = min(miny, bounds[1])
        maxx = max(maxx, bounds[2])
        maxy = max(maxy, bounds[3])

        if not (-180.0 <= bounds[0] <= 180.0 and -180.0 <= bounds[2] <= 180.0):
            fail(f"{name}: implausible longitude bounds for {geoid}: {bounds}")
        if not (-90.0 <= bounds[1] <= 90.0 and -90.0 <= bounds[3] <= 90.0):
            fail(f"{name}: implausible latitude bounds for {geoid}: {bounds}")

    if len(seen_geoids) != spec["expected_count"]:
        fail(f"{name}: expected {spec['expected_count']} GEOIDs, got {len(seen_geoids)}")
    if empty or nonpositive or invalid:
        fail(
            f"{name}: geometry validity failures: empty={empty}, "
            f"nonpositive={nonpositive}, invalid={invalid}"
        )

    expected_counties = set(spec["expected_counties"])
    if observed_counties != expected_counties:
        fail(
            f"{name}: unexpected county set: expected {sorted(expected_counties)}, "
            f"got {sorted(observed_counties)}"
        )

    expected_bbox = spec["expected_bbox"]
    actual_bbox = [minx, miny, maxx, maxy]
    for expected, actual in zip(expected_bbox, actual_bbox, strict=True):
        if abs(expected - actual) > BOUNDS_TOLERANCE:
            fail(f"{name}: bbox mismatch expected {expected_bbox}, got {actual_bbox}")

    if spec["parent_layer"] is not None:
        parent_geoids = tract_geoid_sets[spec["parent_layer"]]
        missing = sorted(
            {
                record[index_geoid][:11]
                for record in reader.records()
                if record[index_geoid][:11] not in parent_geoids
            }
        )
        if missing:
            fail(f"{name}: missing parent tract GEOIDs {missing[:10]}")

    return {
        "expected_count": spec["expected_count"],
        "observed_count": len(seen_geoids),
        "county_fips_set": sorted(observed_counties),
        "geoid_composition": "passed",
        "bbox": actual_bbox,
        "shape_type": reader.shapeTypeName,
        "fields": fields,
        "geoid_length": spec["expected_geoid_length"],
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--json", action="store_true", help="emit machine-readable JSON")
    args = parser.parse_args()

    tract_geoid_sets: dict[str, set[str]] = {}
    for layer_name, spec in LAYERS.items():
        if spec["parent_layer"] is None:
            base = PROCESSED_ROOT / spec["stem"] / spec["stem"]
            reader = shapefile.Reader(str(base))
            geoid_index = [field[0] for field in reader.fields[1:]].index("GEOID")
            tract_geoid_sets[layer_name] = {record[geoid_index] for record in reader.records()}

    results = {
        layer_name: validate_layer(layer_name, spec, tract_geoid_sets)
        for layer_name, spec in LAYERS.items()
    }

    if args.json:
        print(json.dumps(results, indent=2, sort_keys=True))
    else:
        print("processed_geometry_validation: passed")
        print(json.dumps(results, indent=2, sort_keys=True))

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
