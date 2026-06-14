#!/usr/bin/env python3
"""Dry-run validator for the sector-panel query inventory.

Default mode is local-only. It validates the tracked inventory, verifies that
API keys are redacted, and checks existing local-file checksums and headers.
Optional fetch mode can write API payloads under ignored data/raw/ paths, but
it still does not compute empirical measures.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
import sys
from datetime import datetime, timezone
from pathlib import Path
from typing import Iterable
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen


ROOT = Path(__file__).resolve().parents[2]
INVENTORY_PATH = ROOT / "data/manifests/sector_panel_query_inventory.csv"
SUSB_MANIFEST_PATH = ROOT / "data/manifests/susb_2022_manifest.csv"
BDS_MANIFEST_PATH = ROOT / "data/manifests/bds_2023_manifest.csv"
ENV_PATH = ROOT / ".env.local"

EXPECTED_COLUMNS = [
    "inventory_id",
    "dataset",
    "source_owner",
    "source_url",
    "query_or_file_url",
    "planned_local_path",
    "expected_header",
    "geography_predicates",
    "sector_predicate",
    "naics_vintage",
    "reference_year_or_period",
    "suppression_or_noise_fields",
    "execution_status",
    "guardrail_notes",
]

API_MANIFEST_COLUMNS = [
    "inventory_id",
    "dataset",
    "source_owner",
    "source_url",
    "query_url_redacted",
    "retrieved_at",
    "timezone",
    "http_status",
    "content_type",
    "content_length",
    "local_path",
    "sha256",
    "rows_excluding_header",
    "row_widths",
    "expected_header",
    "geography_predicates",
    "sector_predicate",
    "naics_vintage",
    "reference_year_or_period",
    "suppression_or_noise_fields",
    "guardrail_notes",
]

API_DATASETS = {"NES 2023 API", "AIES-NES 2023 API"}
LOCAL_FILE_ROWS = {
    "susb_2022_us_state_sector_file": SUSB_MANIFEST_PATH,
    "bds_2023_sector_age_size_file": BDS_MANIFEST_PATH,
}


class ValidationError(Exception):
    """Raised for a dry-run validation failure."""


def read_csv(path: Path) -> list[dict[str, str]]:
    with path.open(newline="", encoding="utf-8") as handle:
        reader = csv.DictReader(handle)
        if reader.fieldnames != EXPECTED_COLUMNS:
            raise ValidationError(
                f"{path}: unexpected columns {reader.fieldnames!r}"
            )
        return list(reader)


def read_manifest(path: Path) -> dict[str, str]:
    with path.open(newline="", encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
    if len(rows) != 1:
        raise ValidationError(f"{path}: expected exactly one manifest row")
    return rows[0]


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def first_csv_header(path: Path) -> str:
    with path.open("r", encoding="latin-1", newline="") as handle:
        reader = csv.reader(handle)
        try:
            header = next(reader)
        except StopIteration as exc:
            raise ValidationError(f"{path}: empty file") from exc
    return ";".join(header)


def load_env_key(path: Path) -> str:
    if not path.exists():
        raise ValidationError(".env.local not found; cannot use --fetch-api")
    key = ""
    with path.open(encoding="utf-8") as handle:
        for line in handle:
            stripped = line.strip()
            if not stripped or stripped.startswith("#") or "=" not in stripped:
                continue
            name, value = stripped.split("=", 1)
            if name.strip() == "CENSUS_API_KEY":
                key = value.strip().strip("'\"")
                break
    if not key:
        raise ValidationError("CENSUS_API_KEY missing from .env.local")
    return key


def ensure_redacted(rows: Iterable[dict[str, str]]) -> None:
    for row in rows:
        url = row["query_or_file_url"]
        if "key=" in url and "${CENSUS_API_KEY}" not in url:
            raise ValidationError(f"{row['inventory_id']}: API key is not redacted")
        if "${CENSUS_API_KEY}" in url and row["dataset"] not in API_DATASETS:
            raise ValidationError(
                f"{row['inventory_id']}: API key placeholder on non-API row"
            )


def validate_inventory(rows: list[dict[str, str]]) -> dict[str, int]:
    if len(rows) != 36:
        raise ValidationError(f"expected 36 inventory rows, found {len(rows)}")

    ids = [row["inventory_id"] for row in rows]
    if len(ids) != len(set(ids)):
        raise ValidationError("inventory_id values are not unique")

    counts = {
        "nes_rows": sum(row["dataset"] == "NES 2023 API" for row in rows),
        "aies_rows": sum(row["dataset"] == "AIES-NES 2023 API" for row in rows),
        "local_file_rows": sum(
            row["execution_status"] == "manifested_local_file" for row in rows
        ),
        "planned_rows": sum(
            row["execution_status"] == "planned_not_run" for row in rows
        ),
    }
    if counts != {
        "nes_rows": 17,
        "aies_rows": 17,
        "local_file_rows": 2,
        "planned_rows": 34,
    }:
        raise ValidationError(f"unexpected inventory counts: {counts!r}")

    ensure_redacted(rows)

    for row in rows:
        if row["dataset"] in API_DATASETS:
            if row["execution_status"] != "planned_not_run":
                raise ValidationError(
                    f"{row['inventory_id']}: API row must be planned_not_run"
                )
            if not row["planned_local_path"].startswith("data/raw/"):
                raise ValidationError(
                    f"{row['inventory_id']}: API payload path must be under data/raw/"
                )
        elif row["inventory_id"] not in LOCAL_FILE_ROWS:
            raise ValidationError(f"{row['inventory_id']}: unknown local row")

    return counts


def validate_local_files(rows: Iterable[dict[str, str]]) -> dict[str, str]:
    checked: dict[str, str] = {}
    for row in rows:
        manifest_path = LOCAL_FILE_ROWS.get(row["inventory_id"])
        if not manifest_path:
            continue
        manifest = read_manifest(manifest_path)
        local_path = ROOT / row["planned_local_path"]
        if not local_path.exists():
            raise ValidationError(f"{row['inventory_id']}: missing {local_path}")
        expected_sha = manifest["sha256"]
        actual_sha = sha256_file(local_path)
        if actual_sha != expected_sha:
            raise ValidationError(
                f"{row['inventory_id']}: sha256 mismatch for {row['planned_local_path']}"
            )
        expected_header = row["expected_header"]
        actual_header = first_csv_header(local_path)
        if actual_header != expected_header:
            raise ValidationError(
                f"{row['inventory_id']}: header mismatch for {row['planned_local_path']}"
            )
        checked[row["inventory_id"]] = actual_sha
    return checked


def fetch_api_rows(
    rows: list[dict[str, str]], limit: int | None, inventory_ids: list[str]
) -> list[dict[str, str]]:
    key = load_env_key(ENV_PATH)
    fetched_rows: list[dict[str, str]] = []
    selected_ids = set(inventory_ids)
    if selected_ids:
        api_ids = {
            row["inventory_id"] for row in rows if row["dataset"] in API_DATASETS
        }
        unknown = selected_ids - api_ids
        if unknown:
            unknown_list = ", ".join(sorted(unknown))
            raise ValidationError(f"unknown or non-API inventory_id: {unknown_list}")

    for row in rows:
        if row["dataset"] not in API_DATASETS:
            continue
        if selected_ids and row["inventory_id"] not in selected_ids:
            continue
        if limit is not None and len(fetched_rows) >= limit:
            break

        redacted_url = row["query_or_file_url"]
        url = redacted_url.replace("${CENSUS_API_KEY}", key)
        request = Request(url, headers={"Accept": "application/json"})
        try:
            with urlopen(request, timeout=30) as response:
                body = response.read()
                content_type = response.headers.get("content-type", "")
                http_status = response.status
        except (HTTPError, URLError, TimeoutError) as exc:
            raise ValidationError(f"{row['inventory_id']}: fetch failed") from exc

        if "json" not in content_type.lower():
            raise ValidationError(
                f"{row['inventory_id']}: expected JSON content type, got {content_type!r}"
            )

        try:
            payload = json.loads(body.decode("utf-8"))
        except json.JSONDecodeError as exc:
            raise ValidationError(f"{row['inventory_id']}: malformed JSON") from exc

        if not isinstance(payload, list) or not payload:
            raise ValidationError(f"{row['inventory_id']}: empty or non-list JSON")

        header = ";".join(str(value) for value in payload[0])
        if header != row["expected_header"]:
            raise ValidationError(f"{row['inventory_id']}: fetched header mismatch")

        for index, payload_row in enumerate(payload[1:], start=2):
            if not isinstance(payload_row, list) or len(payload_row) != len(payload[0]):
                raise ValidationError(
                    f"{row['inventory_id']}: bad row width at JSON row {index}"
                )

        local_path = ROOT / row["planned_local_path"]
        local_path.parent.mkdir(parents=True, exist_ok=True)
        local_path.write_bytes(body)
        widths = sorted({len(payload_row) for payload_row in payload})
        fetched_rows.append(
            {
                "inventory_id": row["inventory_id"],
                "dataset": row["dataset"],
                "source_owner": row["source_owner"],
                "source_url": row["source_url"],
                "query_url_redacted": redacted_url,
                "retrieved_at": datetime.now(timezone.utc)
                .replace(microsecond=0)
                .isoformat()
                .replace("+00:00", "Z"),
                "timezone": "UTC",
                "http_status": str(http_status),
                "content_type": content_type,
                "content_length": str(len(body)),
                "local_path": row["planned_local_path"],
                "sha256": hashlib.sha256(body).hexdigest(),
                "rows_excluding_header": str(len(payload) - 1),
                "row_widths": ";".join(str(width) for width in widths),
                "expected_header": row["expected_header"],
                "geography_predicates": row["geography_predicates"],
                "sector_predicate": row["sector_predicate"],
                "naics_vintage": row["naics_vintage"],
                "reference_year_or_period": row["reference_year_or_period"],
                "suppression_or_noise_fields": row[
                    "suppression_or_noise_fields"
                ],
                "guardrail_notes": "API payload stored under ignored data/raw/; no analysis performed",
            }
        )

    return fetched_rows


def write_api_manifest(path: Path, rows: list[dict[str, str]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle, fieldnames=API_MANIFEST_COLUMNS, lineterminator="\n"
        )
        writer.writeheader()
        writer.writerows(rows)


def parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Validate sector-panel query inventory without computing empirical "
            "measures."
        )
    )
    parser.add_argument(
        "--fetch-api",
        action="store_true",
        help="Fetch planned API payloads into ignored data/raw/ paths.",
    )
    parser.add_argument(
        "--limit",
        type=int,
        default=None,
        help="Optional maximum number of API rows to fetch in --fetch-api mode.",
    )
    parser.add_argument(
        "--inventory-id",
        action="append",
        default=[],
        help="Specific API inventory_id to fetch; may be repeated.",
    )
    parser.add_argument(
        "--write-api-manifest",
        type=Path,
        default=None,
        help="Write fetched API payload QA metadata to this tracked manifest path.",
    )
    return parser.parse_args(argv)


def main(argv: list[str]) -> int:
    args = parse_args(argv)
    try:
        if args.inventory_id and not args.fetch_api:
            raise ValidationError("--inventory-id requires --fetch-api")
        if args.write_api_manifest and not args.fetch_api:
            raise ValidationError("--write-api-manifest requires --fetch-api")
        rows = read_csv(INVENTORY_PATH)
        counts = validate_inventory(rows)
        local_checks = validate_local_files(rows)
        fetched_rows = (
            fetch_api_rows(rows, args.limit, args.inventory_id)
            if args.fetch_api
            else []
        )
        if args.write_api_manifest:
            write_api_manifest(ROOT / args.write_api_manifest, fetched_rows)
    except ValidationError as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        return 1

    mode = "fetch-api" if args.fetch_api else "local-only"
    print(f"mode={mode}")
    print(f"inventory_rows={len(rows)}")
    for key in ("nes_rows", "aies_rows", "local_file_rows", "planned_rows"):
        print(f"{key}={counts[key]}")
    print(f"local_files_checked={len(local_checks)}")
    print(f"api_payloads_fetched={len(fetched_rows)}")
    if args.write_api_manifest:
        print(f"api_manifest={args.write_api_manifest}")
    print("analysis_performed=false")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
