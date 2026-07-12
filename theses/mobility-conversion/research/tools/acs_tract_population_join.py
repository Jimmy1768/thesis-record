#!/usr/bin/env python3
"""Join ACS 2024 5-year tract population rows to committed tract shapefiles.

This tool is intentionally read-only with respect to the source data. It
verifies the raw capture index and exact county response-byte checksums, reads
the committed Minneapolis and Portland tract shapefiles with pyshp, enforces
exact GEOID coverage, and writes a deterministic provisional CSV plus summary
JSON only to an explicit empty output directory.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from typing import Any

try:
    import shapefile
except ImportError as exc:  # pragma: no cover - environment guard
    raise SystemExit(
        "Missing dependency: pyshp. Install with `python3 -m pip install pyshp` "
        "or set PYTHONPATH to a target directory containing pyshp."
    ) from exc


THESIS_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_RAW_ROOT = THESIS_ROOT / "evidence/raw/us_census/acs_2024_5year_tract_population"
DEFAULT_GEOMETRY_ROOT = THESIS_ROOT / "evidence/processed/us_census/tiger_2024_subcounty_geometry"

SOURCE_FAMILY = "American Community Survey 2024 5-year detailed table B01003"
SOURCE_VINTAGE = "ACS 2024 5-year"
API_BASE = "https://api.census.gov/data/2024/acs/acs5"
REQUESTED_FIELDS = ["NAME", "B01003_001E", "B01003_001M"]
EXPECTED_ACS_HEADERS = ["NAME", "B01003_001E", "B01003_001M", "state", "county", "tract"]
EXPECTED_GEOMETRY_FIELDS = [
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
]
EXPECTED_SIDE_CAR_SUFFIXES = (".shp", ".shx", ".dbf", ".prj", ".cpg")
TIGER_GEOMETRY_MANIFEST_REPO_PATH = (
    "theses/mobility-conversion/evidence/manifests/"
    "tiger_2024_subcounty_geometry_overlay_manifest_2026-07-07.md"
)
COUNTY_SPECS: tuple[dict[str, str], ...] = (
    {"state_fips": "27", "county_fips": "003"},
    {"state_fips": "27", "county_fips": "019"},
    {"state_fips": "27", "county_fips": "025"},
    {"state_fips": "27", "county_fips": "037"},
    {"state_fips": "27", "county_fips": "053"},
    {"state_fips": "27", "county_fips": "059"},
    {"state_fips": "27", "county_fips": "065"},
    {"state_fips": "27", "county_fips": "115"},
    {"state_fips": "27", "county_fips": "123"},
    {"state_fips": "27", "county_fips": "139"},
    {"state_fips": "27", "county_fips": "163"},
    {"state_fips": "55", "county_fips": "093"},
    {"state_fips": "55", "county_fips": "109"},
    {"state_fips": "41", "county_fips": "005"},
    {"state_fips": "41", "county_fips": "009"},
    {"state_fips": "41", "county_fips": "051"},
    {"state_fips": "41", "county_fips": "067"},
    {"state_fips": "41", "county_fips": "071"},
    {"state_fips": "53", "county_fips": "011"},
    {"state_fips": "53", "county_fips": "059"},
)

LAYER_SPECS: dict[str, dict[str, Any]] = {
    "minneapolis_ers_cz_tracts": {
        "expected_row_count": 845,
        "state_county_fips": {
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
    },
    "portland_cbsa_tracts": {
        "expected_row_count": 568,
        "state_county_fips": {"41005", "41009", "41051", "41067", "41071", "53011", "53059"},
    },
}


@dataclass(frozen=True)
class RawCountyPayload:
    state_fips: str
    county_fips: str
    path: Path
    query_url: str
    row_count: int
    sha256: str
    rows: list[dict[str, Any]]


def fail(message: str) -> None:
    raise SystemExit(message)


def ensure_empty_output_dir(output_dir: Path) -> None:
    if output_dir.exists():
        if not output_dir.is_dir():
            fail(f"Output path exists and is not a directory: {output_dir}")
        if any(output_dir.iterdir()):
            fail(f"Refusing to write into non-empty output directory: {output_dir}")
    else:
        output_dir.mkdir(parents=True, exist_ok=False)


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def load_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def load_raw_index(raw_root: Path, expected_counties: int) -> dict[str, Any]:
    index_path = raw_root / "index.json"
    if not index_path.exists():
        fail(f"Missing raw index: {index_path}")
    index = load_json(index_path)
    if index.get("source_family") != SOURCE_FAMILY:
        fail(f"Unexpected raw index source family: {index.get('source_family')!r}")
    if index.get("source_vintage") != SOURCE_VINTAGE:
        fail(f"Unexpected raw index vintage: {index.get('source_vintage')!r}")
    if index.get("api_base") != API_BASE:
        fail(f"Unexpected raw index API base: {index.get('api_base')!r}")
    if index.get("requested_fields") != REQUESTED_FIELDS:
        fail("Unexpected raw index requested fields")
    retrieval_timestamp = index.get("retrieval_timestamp")
    if not isinstance(retrieval_timestamp, str):
        fail("Missing raw index retrieval timestamp")
    try:
        datetime.fromisoformat(retrieval_timestamp.replace("Z", "+00:00"))
    except ValueError as exc:
        fail(f"Malformed raw index retrieval timestamp: {retrieval_timestamp!r}")
    counties = index.get("counties")
    if not isinstance(counties, list) or len(counties) != expected_counties:
        fail(f"Raw index must contain {expected_counties} county entries")
    for county_entry, expected_spec in zip(counties, COUNTY_SPECS, strict=True):
        if not isinstance(county_entry, dict):
            fail(f"Unexpected raw index county entry: {county_entry!r}")
        expected_filename = f"{expected_spec['state_fips']}{expected_spec['county_fips']}.json"
        expected_query_url = (
            f"{API_BASE}?get=NAME,B01003_001E,B01003_001M&for=tract:*"
            f"&in=state:{expected_spec['state_fips']}&in=county:{expected_spec['county_fips']}"
        )
        if county_entry.get("state_fips") != expected_spec["state_fips"]:
            fail(f"Unexpected raw index state FIPS: {county_entry.get('state_fips')!r}")
        if county_entry.get("county_fips") != expected_spec["county_fips"]:
            fail(f"Unexpected raw index county FIPS: {county_entry.get('county_fips')!r}")
        if county_entry.get("county_filename") != expected_filename:
            fail(f"Unexpected raw index county filename: {county_entry.get('county_filename')!r}")
        if county_entry.get("query_url") != expected_query_url:
            fail(f"Unexpected raw index query URL: {county_entry.get('query_url')!r}")
        if not isinstance(county_entry.get("row_count"), int) or county_entry["row_count"] < 0:
            fail(f"Unexpected raw index row count for {expected_filename}: {county_entry.get('row_count')!r}")
        if not isinstance(county_entry.get("sha256"), str) or len(county_entry["sha256"]) != 64:
            fail(f"Unexpected raw index sha256 for {expected_filename}: {county_entry.get('sha256')!r}")
    return index


def verify_capture_directory(raw_root: Path, expected_counties: int) -> None:
    expected_files = {"index.json"} | {
        f"{spec['state_fips']}{spec['county_fips']}.json" for spec in COUNTY_SPECS
    }
    actual_files = {path.name for path in raw_root.iterdir() if path.is_file()}
    if actual_files != expected_files:
        missing = sorted(expected_files - actual_files)
        extra = sorted(actual_files - expected_files)
        fail(f"Unexpected raw capture file set: missing={missing} extra={extra}")
    if len(actual_files) != expected_counties + 1:
        fail(f"Unexpected raw capture file count: {len(actual_files)}")


def parse_and_normalize_payload_bytes(
    payload_bytes: bytes,
    *,
    state_fips: str,
    county_fips: str,
    path: Path,
) -> list[dict[str, Any]]:
    try:
        data = json.loads(payload_bytes.decode("utf-8"))
    except (UnicodeDecodeError, json.JSONDecodeError) as exc:
        fail(f"Malformed raw county payload in {path}: {exc}")
    if not isinstance(data, list) or not data:
        fail(f"Unexpected raw county payload shape in {path}")
    if not all(isinstance(row, list) for row in data):
        fail(f"Unexpected raw county row container in {path}")
    if data[0] != EXPECTED_ACS_HEADERS:
        fail(f"Unexpected ACS headers in {path}: {data[0]}")

    normalized_rows: list[dict[str, Any]] = []
    seen_tracts: set[str] = set()
    for row in data[1:]:
        if len(row) != len(EXPECTED_ACS_HEADERS):
            fail(f"Unexpected row length in {path}: {row}")
        record = dict(zip(EXPECTED_ACS_HEADERS, row, strict=True))
        if record["state"] != state_fips or record["county"] != county_fips:
            fail(f"Mismatched state/county in {path}: {record}")
        tract = record["tract"]
        if not isinstance(tract, str) or not tract.isdigit() or len(tract) != 6:
            fail(f"Malformed tract code in {path}: {record}")
        if tract in seen_tracts:
            fail(f"Duplicate tract in {path}: {tract}")
        seen_tracts.add(tract)
        normalized = {"NAME": record["NAME"], "state": state_fips, "county": county_fips, "tract": tract}
        if not isinstance(normalized["NAME"], str) or not normalized["NAME"].strip():
            fail(f"Malformed NAME in {path}: {record}")
        for field in ("B01003_001E", "B01003_001M"):
            value = record[field]
            if not isinstance(value, str) or not value.strip() or not value.strip().lstrip("-").isdigit():
                fail(f"Malformed {field} in {path}: {record}")
            number = int(value)
            if number < 0:
                fail(f"Negative {field} in {path}: {record}")
            normalized[field] = number
        normalized_rows.append(normalized)
    return normalized_rows


def validate_raw_payload(raw_root: Path, county_entry: dict[str, Any]) -> RawCountyPayload:
    county_filename = county_entry["county_filename"]
    path = raw_root / county_filename
    if not path.exists():
        fail(f"Missing raw county payload: {path}")
    expected_filename = f"{county_entry['state_fips']}{county_entry['county_fips']}.json"
    if county_filename != expected_filename:
        fail(f"Unexpected county filename in raw index: {county_filename}")
    expected_query_url = (
        f"{API_BASE}"
        f"?get=NAME,B01003_001E,B01003_001M&for=tract:*&in=state:{county_entry['state_fips']}"
        f"&in=county:{county_entry['county_fips']}"
    )
    if county_entry.get("query_url") != expected_query_url:
        fail(f"Unexpected query URL in raw index for {county_filename}: {county_entry.get('query_url')!r}")
    if county_entry.get("state_fips") not in {spec["state_fips"] for spec in COUNTY_SPECS}:
        fail(f"Unexpected state FIPS in raw index: {county_entry.get('state_fips')!r}")
    actual_sha = sha256(path)
    if actual_sha != county_entry["sha256"]:
        fail(f"Checksum mismatch for {path}: expected {county_entry['sha256']}, got {actual_sha}")
    payload_bytes = path.read_bytes()
    normalized_rows = parse_and_normalize_payload_bytes(
        payload_bytes,
        state_fips=county_entry["state_fips"],
        county_fips=county_entry["county_fips"],
        path=path,
    )
    if county_entry.get("row_count") != len(normalized_rows):
        fail(f"Row count mismatch in raw index for {path}: {county_entry.get('row_count')}")
    return RawCountyPayload(
        state_fips=county_entry["state_fips"],
        county_fips=county_entry["county_fips"],
        path=path,
        query_url=county_entry["query_url"],
        row_count=county_entry["row_count"],
        sha256=county_entry["sha256"],
        rows=normalized_rows,
    )


def load_raw_payloads(
    raw_root: Path,
    index: dict[str, Any],
    expected_counties: int,
) -> dict[str, RawCountyPayload]:
    expected_codes = {f"{spec['state_fips']}{spec['county_fips']}" for spec in COUNTY_SPECS}
    payloads: dict[str, RawCountyPayload] = {}
    for county_entry in index["counties"]:
        payload = validate_raw_payload(raw_root, county_entry)
        key = f"{payload.state_fips}{payload.county_fips}"
        if key in payloads:
            fail(f"Duplicate county payload in raw index: {key}")
        payloads[key] = payload
    if set(payloads) != expected_codes:
        fail(
            f"Unexpected raw county coverage: missing={sorted(expected_codes - set(payloads))} "
            f"extra={sorted(set(payloads) - expected_codes)}"
        )
    if len(payloads) != expected_counties:
        fail(f"Raw payload coverage mismatch: expected {expected_counties} counties, got {len(payloads)}")
    return payloads


def read_layer_geometry(layer_name: str, geometry_root: Path, expected_counties: set[str]) -> list[dict[str, Any]]:
    base = geometry_root / layer_name / layer_name
    for suffix in EXPECTED_SIDE_CAR_SUFFIXES:
        if not base.with_suffix(suffix).exists():
            fail(f"Missing geometry sidecar: {base.with_suffix(suffix)}")
    reader = shapefile.Reader(str(base))
    fields = [field[0] for field in reader.fields[1:]]
    if fields != EXPECTED_GEOMETRY_FIELDS:
        fail(f"Unexpected geometry fields for {layer_name}: {fields}")
    if reader.numRecords != reader.numShapes:
        fail(f"Record/shape count mismatch for {layer_name}")
    seen_geoids: set[str] = set()
    rows: list[dict[str, Any]] = []
    for shape_record in reader.iterShapeRecords():
        record = shape_record.record.as_dict()
        state_fips = record["STATEFP"]
        county_fips = record["COUNTYFP"]
        tract = record["TRACTCE"]
        geoid = record["GEOID"]
        if f"{state_fips}{county_fips}" not in expected_counties:
            fail(f"Unexpected county in {layer_name}: {state_fips}{county_fips}")
        if geoid != f"{state_fips}{county_fips}{tract}":
            fail(f"Unexpected GEOID composition in {layer_name}: {record}")
        if geoid in seen_geoids:
            fail(f"Duplicate geometry GEOID in {layer_name}: {geoid}")
        seen_geoids.add(geoid)
        rows.append(
            {
                "STATEFP": state_fips,
                "COUNTYFP": county_fips,
                "TRACTCE": tract,
                "GEOID": geoid,
                "NAME": record["NAME"],
                "NAMELSAD": record["NAMELSAD"],
            }
        )
    return rows


def join_layer(
    layer_name: str,
    geometry_rows: list[dict[str, Any]],
    payloads: dict[str, RawCountyPayload],
) -> list[dict[str, Any]]:
    joined: list[dict[str, Any]] = []
    geometry_geoids = {row["GEOID"] for row in geometry_rows}
    acs_rows: dict[str, dict[str, Any]] = {}
    for payload in payloads.values():
        for row in payload.rows:
            geoid = f"{row['state']}{row['county']}{row['tract']}"
            if geoid in acs_rows:
                fail(f"Duplicate ACS GEOID across counties: {geoid}")
            acs_rows[geoid] = row

    if geometry_geoids != set(acs_rows):
        missing = sorted(geometry_geoids - set(acs_rows))
        extra = sorted(set(acs_rows) - geometry_geoids)
        fail(
            f"One-to-one coverage failed for {layer_name}: missing={missing[:5]} extra={extra[:5]}"
        )

    geometry_lookup = {row["GEOID"]: row for row in geometry_rows}
    for geoid in sorted(geometry_geoids):
        geometry = geometry_lookup[geoid]
        acs = acs_rows[geoid]
        joined.append(
            {
                "layer": layer_name,
                "state_fips": geometry["STATEFP"],
                "county_fips": geometry["COUNTYFP"],
                "tract": geometry["TRACTCE"],
                "geoid": geoid,
                "geometry_name": geometry["NAME"],
                "geometry_namelsad": geometry["NAMELSAD"],
                "acs_name": acs["NAME"],
                "b01003_001e": acs["B01003_001E"],
                "b01003_001m": acs["B01003_001M"],
            }
        )
    return joined


def write_outputs(output_dir: Path, rows: list[dict[str, Any]], summary: dict[str, Any]) -> tuple[Path, Path]:
    csv_path = output_dir / "acs_2024_5year_tract_population_join.csv"
    summary_path = output_dir / "acs_2024_5year_tract_population_join_summary.json"
    csv_fields = [
        "layer",
        "state_fips",
        "county_fips",
        "tract",
        "geoid",
        "geometry_name",
        "geometry_namelsad",
        "acs_name",
        "b01003_001e",
        "b01003_001m",
    ]
    with csv_path.open("w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=csv_fields)
        writer.writeheader()
        for row in sorted(rows, key=lambda item: (item["layer"], item["geoid"])):
            writer.writerow(row)
    csv_digest = sha256(csv_path)
    summary["joined_csv"] = csv_path.name
    summary["joined_csv_sha256"] = csv_digest
    summary_path.write_text(json.dumps(summary, indent=2, sort_keys=True, ensure_ascii=False) + "\n", encoding="utf-8")
    return csv_path, summary_path


def build_summary(index: dict[str, Any], raw_root: Path) -> dict[str, Any]:
    return {
        "acs_source_family": index["source_family"],
        "acs_source_vintage": index["source_vintage"],
        "capture_retrieval_timestamp": index["retrieval_timestamp"],
        "raw_index_sha256": sha256(raw_root / "index.json"),
        "tiger_geometry_manifest_repo_path": TIGER_GEOMETRY_MANIFEST_REPO_PATH,
        "status": "provisional",
        "accepted_population_value": False,
        "accepted_denominator_value": False,
        "one_to_one_coverage": True,
        "layers": {},
    }


def run_join(raw_root: Path, geometry_root: Path, output_dir: Path) -> tuple[Path, Path]:
    ensure_empty_output_dir(output_dir)
    expected_counties = len(set().union(*(set(spec["state_county_fips"]) for spec in LAYER_SPECS.values())))
    verify_capture_directory(raw_root, expected_counties)
    index = load_raw_index(raw_root, expected_counties)
    payloads = load_raw_payloads(raw_root, index, expected_counties)

    summary = build_summary(index, raw_root)

    all_rows: list[dict[str, Any]] = []
    for layer_name, layer_spec in LAYER_SPECS.items():
        expected_counties = set(layer_spec["state_county_fips"])
        layer_geometry_rows = read_layer_geometry(layer_name, geometry_root, expected_counties)
        if len(layer_geometry_rows) != layer_spec["expected_row_count"]:
            fail(
                f"Unexpected geometry row count for {layer_name}: "
                f"{len(layer_geometry_rows)}"
            )
        layer_payloads = {
            key: value
            for key, value in payloads.items()
            if key in expected_counties
        }
        if len(layer_payloads) != len(expected_counties):
            fail(f"Missing raw counties for {layer_name}")
        joined_rows = join_layer(layer_name, layer_geometry_rows, layer_payloads)
        summary["layers"][layer_name] = {
            "expected_counties": sorted(expected_counties),
            "expected_geometry_row_count": layer_spec["expected_row_count"],
            "geometry_row_count": len(layer_geometry_rows),
            "raw_row_count": sum(payload.row_count for payload in layer_payloads.values()),
            "joined_row_count": len(joined_rows),
        }
        all_rows.extend(joined_rows)

    summary["row_count"] = len(all_rows)
    return write_outputs(output_dir, all_rows, summary)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--raw-dir", default=str(DEFAULT_RAW_ROOT))
    parser.add_argument("--geometry-root", default=str(DEFAULT_GEOMETRY_ROOT))
    parser.add_argument("--output-dir", required=True)
    args = parser.parse_args()
    run_join(Path(args.raw_dir), Path(args.geometry_root), Path(args.output_dir))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
