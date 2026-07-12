#!/usr/bin/env python3
"""Fetch ACS 2024 5-year tract population rows one county at a time.

This tool is intentionally stdlib-only. It queries the official Census API once
per exact county, validates the returned headers and geography, rejects
malformed or sentinel estimate/MOE values, and writes the exact Census API
response bytes plus a capture index.

Live capture requires `CENSUS_API_KEY` from the environment; dry-run does not.
No CLI key is accepted, and the key is never persisted or logged. It refuses
to write into a nonempty output directory.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from typing import Iterable
from urllib.error import HTTPError, URLError
from urllib.parse import quote, urlencode
from urllib.request import Request, urlopen


API_BASE = "https://api.census.gov/data/2024/acs/acs5"
SOURCE_FAMILY = "American Community Survey 2024 5-year detailed table B01003"
SOURCE_VINTAGE = "ACS 2024 5-year"
REQUESTED_FIELDS = ["NAME", "B01003_001E", "B01003_001M"]
EXPECTED_HEADERS = ["NAME", "B01003_001E", "B01003_001M", "state", "county", "tract"]
GEOGRAPHY = "tract"
CENSUS_API_KEY_ENV = "CENSUS_API_KEY"

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


@dataclass(frozen=True)
class CountyCapture:
    state_fips: str
    county_fips: str
    query_url: str
    county_filename: str
    row_count: int
    sha256: str
    payload_bytes: bytes


def build_query_url(state_fips: str, county_fips: str) -> str:
    return (
        f"{API_BASE}?get={quote(','.join(REQUESTED_FIELDS), safe=',')}"
        f"&for=tract:*&in=state:{state_fips}&in=county:{county_fips}"
    )


def build_county_filename(state_fips: str, county_fips: str) -> str:
    return f"{state_fips}{county_fips}.json"


def require_census_api_key() -> str:
    api_key = os.environ.get(CENSUS_API_KEY_ENV)
    if not api_key:
        raise SystemExit(
            f"Missing required environment variable {CENSUS_API_KEY_ENV} for live Census capture"
        )
    return api_key


def build_authenticated_request_url(public_query_url: str, api_key: str) -> str:
    return f"{public_query_url}&{urlencode({'key': api_key})}"


def ensure_empty_output_dir(output_dir: Path) -> None:
    if output_dir.exists():
        if not output_dir.is_dir():
            raise SystemExit(f"Output path exists and is not a directory: {output_dir}")
        if any(output_dir.iterdir()):
            raise SystemExit(f"Refusing to write into non-empty output directory: {output_dir}")
    else:
        output_dir.mkdir(parents=True, exist_ok=False)


def parse_json_response(payload: bytes) -> list[list[str]]:
    data = json.loads(payload.decode("utf-8"))
    if not isinstance(data, list) or not data:
        raise SystemExit("Unexpected Census API response shape")
    if not all(isinstance(row, list) for row in data):
        raise SystemExit("Unexpected Census API response rows")
    return data


def coerce_nonnegative_int(value: object, *, field: str, state_fips: str, county_fips: str, tract: str) -> int:
    if isinstance(value, bool) or value is None:
        raise SystemExit(
            f"Malformed {field} value for {state_fips}{county_fips}{tract}: {value!r}"
        )
    if isinstance(value, int):
        number = value
    elif isinstance(value, str) and value.strip() and value.strip().lstrip("-").isdigit():
        number = int(value)
    else:
        raise SystemExit(
            f"Malformed {field} value for {state_fips}{county_fips}{tract}: {value!r}"
        )
    if number < 0:
        raise SystemExit(
            f"Negative {field} value for {state_fips}{county_fips}{tract}: {number}"
        )
    return number


def validate_response_rows(rows: list[list[str]], state_fips: str, county_fips: str) -> int:
    headers = rows[0]
    if headers != EXPECTED_HEADERS:
        raise SystemExit(
            f"Unexpected Census API headers for {state_fips}{county_fips}: {headers}"
        )

    seen_tracts: set[str] = set()
    for row in rows[1:]:
        if len(row) != len(headers):
            raise SystemExit(
                f"Unexpected row length for {state_fips}{county_fips}: {row}"
            )
        record = dict(zip(headers, row, strict=True))
        if record["state"] != state_fips or record["county"] != county_fips:
            raise SystemExit(
                f"Mismatched state/county in Census API response for {state_fips}{county_fips}: {record}"
            )
        tract = record["tract"]
        if not isinstance(tract, str) or not tract.isdigit() or len(tract) != 6:
            raise SystemExit(
                f"Malformed tract code for {state_fips}{county_fips}: {tract!r}"
            )
        if tract in seen_tracts:
            raise SystemExit(
                f"Duplicate tract in Census API response for {state_fips}{county_fips}: {tract}"
            )
        seen_tracts.add(tract)
        estimate = coerce_nonnegative_int(
            record["B01003_001E"], field="B01003_001E", state_fips=state_fips, county_fips=county_fips, tract=tract
        )
        moe = coerce_nonnegative_int(
            record["B01003_001M"], field="B01003_001M", state_fips=state_fips, county_fips=county_fips, tract=tract
        )
        name = record["NAME"]
        if not isinstance(name, str) or not name.strip():
            raise SystemExit(
                f"Malformed NAME value for {state_fips}{county_fips}{tract}: {name!r}"
            )
    return len(rows) - 1


def fetch_county(state_fips: str, county_fips: str, opener=urlopen) -> CountyCapture:
    query_url = build_query_url(state_fips, county_fips)
    authenticated_url = build_authenticated_request_url(query_url, require_census_api_key())
    request = Request(authenticated_url, headers={"User-Agent": "codex-thesis-record/1.0"})
    try:
        with opener(request) as response:
            payload = response.read()
    except HTTPError as exc:  # pragma: no cover - network failure is environment-specific
        raise SystemExit(
            f"Failed to fetch {query_url}: HTTPError status={exc.code}"
        ) from exc
    except URLError as exc:  # pragma: no cover - network failure is environment-specific
        reason = exc.reason.__class__.__name__ if exc.reason is not None else "URLError"
        raise SystemExit(
            f"Failed to fetch {query_url}: {reason}"
        ) from exc
    except OSError as exc:  # pragma: no cover - network failure is environment-specific
        raise SystemExit(
            f"Failed to fetch {query_url}: {exc.__class__.__name__}"
        ) from exc

    rows = parse_json_response(payload)
    row_count = validate_response_rows(rows, state_fips, county_fips)
    filename = build_county_filename(state_fips, county_fips)
    return CountyCapture(
        state_fips=state_fips,
        county_fips=county_fips,
        query_url=query_url,
        county_filename=filename,
        row_count=row_count,
        sha256=hashlib.sha256(payload).hexdigest(),
        payload_bytes=payload,
    )


def write_capture_files(output_dir: Path, captures: Iterable[CountyCapture]) -> None:
    for capture in captures:
        (output_dir / capture.county_filename).write_bytes(capture.payload_bytes)


def write_index(output_dir: Path, retrieval_timestamp: str, captures: Iterable[CountyCapture]) -> Path:
    index = {
        "source_family": SOURCE_FAMILY,
        "source_vintage": SOURCE_VINTAGE,
        "api_base": API_BASE,
        "requested_fields": REQUESTED_FIELDS,
        "retrieval_timestamp": retrieval_timestamp,
        "counties": [
            {
                "state_fips": capture.state_fips,
                "county_fips": capture.county_fips,
                "query_url": capture.query_url,
                "county_filename": capture.county_filename,
                "row_count": capture.row_count,
                "sha256": capture.sha256,
            }
            for capture in captures
        ],
    }
    path = output_dir / "index.json"
    path.write_text(json.dumps(index, indent=2, sort_keys=True, ensure_ascii=False) + "\n", encoding="utf-8")
    return path


def print_dry_run_urls() -> None:
    for spec in COUNTY_SPECS:
        print(build_query_url(spec["state_fips"], spec["county_fips"]))


def run_fetch(output_dir: Path, opener=urlopen) -> None:
    ensure_empty_output_dir(output_dir)
    retrieval_timestamp = datetime.now(timezone.utc).isoformat().replace("+00:00", "Z")
    captures: list[CountyCapture] = []
    for spec in COUNTY_SPECS:
        state_fips = spec["state_fips"]
        county_fips = spec["county_fips"]
        captures.append(fetch_county(state_fips, county_fips, opener=opener))
    write_capture_files(output_dir, captures)
    write_index(output_dir, retrieval_timestamp, captures)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output-dir")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    if args.dry_run:
        print_dry_run_urls()
        return 0
    if not args.output_dir:
        raise SystemExit("--output-dir is required unless --dry-run is used")
    run_fetch(Path(args.output_dir))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
