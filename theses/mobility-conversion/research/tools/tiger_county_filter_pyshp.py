#!/usr/bin/env python3
"""Filter archived TIGER shapefiles by county FIPS for geometry-only overlays.

This script is intentionally narrow. It reads the raw TIGER ZIPs already
archived under the evidence manifest and writes filtered shapefiles for the
Minneapolis ERS CZ and Portland CBSA county sets. It does not join ACS data,
calculate population, create boundary records, or admit any MTR.

Dependency:
  python3 -m pip install pyshp
"""

from __future__ import annotations

import argparse
from pathlib import Path
import zipfile

try:
    import shapefile
except ImportError as exc:  # pragma: no cover - environment guard
    raise SystemExit(
        "Missing dependency: pyshp. Install with `python3 -m pip install pyshp` "
        "or set PYTHONPATH to a target directory containing pyshp."
    ) from exc


THESIS_ROOT = Path(__file__).resolve().parents[2]
RAW_ROOT = THESIS_ROOT / "evidence/raw/us_census/tiger_2024_subcounty_geometry"

CONFIGS = {
    "minneapolis_tract": {
        "sources": {
            "tl_2024_27_tract.zip": {"state": "27", "counties": {
                "003", "019", "025", "037", "053", "059", "065", "115",
                "123", "139", "163",
            }},
            "tl_2024_55_tract.zip": {"state": "55", "counties": {"093", "109"}},
        },
        "output_name": "minneapolis_ers_cz_tracts",
    },
    "minneapolis_block_group": {
        "sources": {
            "tl_2024_27_bg.zip": {"state": "27", "counties": {
                "003", "019", "025", "037", "053", "059", "065", "115",
                "123", "139", "163",
            }},
            "tl_2024_55_bg.zip": {"state": "55", "counties": {"093", "109"}},
        },
        "output_name": "minneapolis_ers_cz_block_groups",
    },
    "portland_tract": {
        "sources": {
            "tl_2024_41_tract.zip": {"state": "41", "counties": {
                "005", "009", "051", "067", "071",
            }},
            "tl_2024_53_tract.zip": {"state": "53", "counties": {"011", "059"}},
        },
        "output_name": "portland_cbsa_tracts",
    },
    "portland_block_group": {
        "sources": {
            "tl_2024_41_bg.zip": {"state": "41", "counties": {
                "005", "009", "051", "067", "071",
            }},
            "tl_2024_53_bg.zip": {"state": "53", "counties": {"011", "059"}},
        },
        "output_name": "portland_cbsa_block_groups",
    },
}


def copy_sidecars(zip_path: Path, output_base: Path) -> None:
    with zipfile.ZipFile(zip_path) as archive:
        names = archive.namelist()
        for extension in [".prj", ".cpg"]:
            matches = [name for name in names if name.endswith(extension)]
            if not matches:
                continue
            output_base.with_suffix(extension).write_bytes(archive.read(matches[0]))


def filter_config(config_name: str, output_dir: Path, dry_run: bool) -> int:
    config = CONFIGS[config_name]
    output_dir.mkdir(parents=True, exist_ok=True)
    output_base = output_dir / config["output_name"]
    writer = None
    total = 0
    first_zip_path = None

    for zip_name, source_config in config["sources"].items():
        zip_path = RAW_ROOT / zip_name
        if first_zip_path is None:
            first_zip_path = zip_path
        reader = shapefile.Reader(str(zip_path))
        selected = []
        for shape_record in reader.iterShapeRecords():
            record = shape_record.record.as_dict()
            if (
                record.get("STATEFP") == source_config["state"]
                and record.get("COUNTYFP") in source_config["counties"]
            ):
                selected.append(shape_record)

        print(f"{config_name}: {zip_name}: selected {len(selected)}")
        total += len(selected)

        if dry_run:
            continue

        if writer is None:
            writer = shapefile.Writer(str(output_base), shapeType=reader.shapeType)
            for field in reader.fields[1:]:
                writer.field(*field)

        for shape_record in selected:
            writer.shape(shape_record.shape)
            writer.record(*list(shape_record.record))

    if writer is not None:
        writer.close()
        if first_zip_path is not None:
            copy_sidecars(first_zip_path, output_base)

    print(f"{config_name}: total selected {total}")
    return total


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("config", choices=sorted(CONFIGS))
    parser.add_argument("--output-dir", required=True)
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    output_dir = Path(args.output_dir)
    if output_dir.exists() and not args.dry_run and any(output_dir.iterdir()):
        raise SystemExit(f"Refusing to write into non-empty output directory: {output_dir}")

    filter_config(args.config, output_dir, args.dry_run)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
