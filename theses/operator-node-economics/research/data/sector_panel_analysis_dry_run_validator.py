#!/usr/bin/env python3
"""Dry-run checks for future sector-panel analysis without calculations."""

from __future__ import annotations

import csv
import hashlib
import sys
from decimal import Decimal, InvalidOperation
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
PROCESSED_MANIFEST = ROOT / "data/manifests/sector_panel_processed_manifest.csv"
PROCESSED_DIR = ROOT / "data/processed/sector_panel"

CANONICAL_SECTORS = [
    "11",
    "21",
    "22",
    "23",
    "31-33",
    "42",
    "44-45",
    "48-49",
    "51",
    "52",
    "53",
    "54",
    "56",
    "62",
    "71",
    "72",
    "81",
]

AIES_MISSING_SECTORS = {"11", "81"}

PROCESSED_MANIFEST_HEADER = [
    "processed_table",
    "source_staging_tables",
    "output_path",
    "output_sha256",
    "row_count",
    "created_at",
    "timezone",
    "analysis_performed",
    "guardrail_notes",
    "warnings",
]

EXPECTED_TABLES = {
    "sector_source_index": {
        "path": "data/processed/sector_panel/sector_source_index.csv",
        "row_count": 17,
    },
    "sector_boundary_measure_inputs": {
        "path": "data/processed/sector_panel/sector_boundary_measure_inputs.csv",
        "row_count": 17,
    },
    "sector_bds_age_size_inputs": {
        "path": "data/processed/sector_panel/sector_bds_age_size_inputs.csv",
        "row_count": 93840,
    },
}


class DryRunError(Exception):
    """Raised when future analysis preflight checks fail."""


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def read_csv(path: Path) -> tuple[list[str], list[dict[str, str]]]:
    if not path.exists():
        raise DryRunError(f"missing file: {path}")
    with path.open(newline="", encoding="utf-8") as handle:
        reader = csv.DictReader(handle)
        return list(reader.fieldnames or []), list(reader)


def require(condition: bool, message: str) -> None:
    if not condition:
        raise DryRunError(message)


def numeric_positive(value: str, field: str, sector: str) -> Decimal:
    require(value != "", f"{sector}: {field} is blank")
    try:
        parsed = Decimal(value)
    except InvalidOperation as exc:
        raise DryRunError(f"{sector}: {field} is nonnumeric: {value}") from exc
    require(parsed > 0, f"{sector}: {field} is not positive")
    return parsed


def numeric_nonnegative(value: str, field: str, sector: str) -> Decimal:
    require(value != "", f"{sector}: {field} is blank")
    try:
        parsed = Decimal(value)
    except InvalidOperation as exc:
        raise DryRunError(f"{sector}: {field} is nonnumeric: {value}") from exc
    require(parsed >= 0, f"{sector}: {field} is negative")
    return parsed


def validate_manifest() -> dict[str, dict[str, str]]:
    header, rows = read_csv(PROCESSED_MANIFEST)
    require(header == PROCESSED_MANIFEST_HEADER, "processed manifest header mismatch")
    require(len(rows) == 3, "processed manifest must contain 3 rows")
    manifest: dict[str, dict[str, str]] = {}
    for row in rows:
        table = row["processed_table"]
        require(table in EXPECTED_TABLES, f"unexpected processed table: {table}")
        require(table not in manifest, f"duplicate processed table: {table}")
        expected = EXPECTED_TABLES[table]
        require(row["output_path"] == expected["path"], f"{table}: output path mismatch")
        require(row["row_count"] == str(expected["row_count"]), f"{table}: row count mismatch")
        require(row["analysis_performed"] == "false", f"{table}: analysis flag not false")
        output = ROOT / row["output_path"]
        require(output.exists(), f"{table}: output missing")
        require(sha256_file(output) == row["output_sha256"], f"{table}: sha256 mismatch")
        manifest[table] = row
    require(set(manifest) == set(EXPECTED_TABLES), "processed manifest table set mismatch")
    return manifest


def validate_source_index() -> tuple[int, int]:
    _, rows = read_csv(PROCESSED_DIR / "sector_source_index.csv")
    sectors = {row["canonical_sector"] for row in rows}
    require(sectors == set(CANONICAL_SECTORS), "source index sector coverage mismatch")
    aies_missing = 0
    for row in rows:
        sector = row["canonical_sector"]
        require(row["join_class"] == "sector_stable", f"{sector}: join class mismatch")
        require(row["nes_2023_available"] == "true", f"{sector}: NES unavailable")
        require(row["aies_nes_2023_available"] == "true", f"{sector}: AIES unavailable")
        require(row["susb_2022_available"] == "true", f"{sector}: SUSB unavailable")
        require(row["bds_sector_age_size_available"] == "true", f"{sector}: BDS unavailable")
        if sector in AIES_MISSING_SECTORS:
            require(row["aies_nes_sector_row_available"] == "false", f"{sector}: AIES missing-sector flag mismatch")
            aies_missing += 1
        else:
            require(row["aies_nes_sector_row_available"] == "true", f"{sector}: AIES sector row unavailable")
    return len(rows), aies_missing


def validate_boundary_inputs() -> tuple[int, int, int]:
    _, rows = read_csv(PROCESSED_DIR / "sector_boundary_measure_inputs.csv")
    sectors = {row["canonical_sector"] for row in rows}
    require(sectors == set(CANONICAL_SECTORS), "boundary input sector coverage mismatch")
    nes_denominator_ready = 0
    aies_denominator_ready = 0
    susb_denominator_ready = 0
    for row in rows:
        sector = row["canonical_sector"]
        numeric_positive(row["nes_NESTAB"], "nes_NESTAB", sector)
        numeric_nonnegative(row["nes_NRCPTOT"], "nes_NRCPTOT", sector)
        require(row["nes_NRCPTOT_N"] != "", f"{sector}: NES noise range missing")
        require(row["nes_NRCPTOT_N_F"] != "", f"{sector}: NES noise flag missing")
        nes_denominator_ready += 1

        if sector in AIES_MISSING_SECTORS:
            require(row["aies_sector_row_available"] == "false", f"{sector}: AIES missing flag mismatch")
            require(row["aies_RCPT_TOT_VAL"] == "", f"{sector}: AIES employer revenue should be blank")
            require(row["aies_RCPT_TOT_VAL_NS"] == "", f"{sector}: AIES nonemployer revenue should be blank")
        else:
            require(row["aies_sector_row_available"] == "true", f"{sector}: AIES sector row unavailable")
            employer = numeric_nonnegative(row["aies_RCPT_TOT_VAL"], "aies_RCPT_TOT_VAL", sector)
            nonemployer = numeric_nonnegative(row["aies_RCPT_TOT_VAL_NS"], "aies_RCPT_TOT_VAL_NS", sector)
            require(employer + nonemployer > 0, f"{sector}: AIES denominator is not positive")
            require(row["aies_RCPT_TOT_CV"] != "", f"{sector}: AIES CV missing")
            require(row["aies_RCPT_TOT_VAL_NS_N"] != "", f"{sector}: AIES nonemployer noise range missing")
            require(row["aies_RCPT_TOT_VAL_NS_N_F"] != "", f"{sector}: AIES nonemployer noise flag missing")
            aies_denominator_ready += 1

        numeric_positive(row["susb_EMPL"], "susb_EMPL", sector)
        numeric_positive(row["susb_FIRM"], "susb_FIRM", sector)
        numeric_positive(row["susb_ESTB"], "susb_ESTB", sector)
        numeric_nonnegative(row["susb_PAYR"], "susb_PAYR", sector)
        require(row["susb_EMPLFL_N"] != "", f"{sector}: SUSB employment flag missing")
        require(row["susb_PAYRFL_N"] != "", f"{sector}: SUSB payroll flag missing")
        require(row["susb_RCPTFL_N"] != "", f"{sector}: SUSB receipts flag missing")
        susb_denominator_ready += 1
    return nes_denominator_ready, aies_denominator_ready, susb_denominator_ready


def validate_bds_inputs() -> tuple[int, int]:
    _, rows = read_csv(PROCESSED_DIR / "sector_bds_age_size_inputs.csv")
    require(len(rows) == 93840, "BDS input row count mismatch")
    sectors = {row["canonical_sector"] for row in rows}
    require(sectors == set(CANONICAL_SECTORS), "BDS sector coverage mismatch")
    years = {row["year"] for row in rows}
    require(min(years) == "1978" and max(years) == "2023", "BDS year coverage mismatch")
    markers_seen = set()
    for row in rows:
        require(row["sector"] == row["canonical_sector"], "BDS sector mapping mismatch")
        require(row["fage"] != "", "BDS firm age blank")
        require(row["fsize"] != "", "BDS firm size blank")
        for field in (
            "estabs_entry",
            "estabs_exit",
            "job_creation",
            "job_destruction",
            "firmdeath_firms",
        ):
            value = row[field]
            if value in {"D", "X", "N", "S"}:
                markers_seen.add(value)
    return len(rows), len(markers_seen)


def main() -> int:
    try:
        validate_manifest()
        source_rows, aies_missing = validate_source_index()
        nes_ready, aies_ready, susb_ready = validate_boundary_inputs()
        bds_rows, bds_marker_types = validate_bds_inputs()
    except DryRunError as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        return 1

    print("analysis_dry_run_validated=true")
    print("calculations_performed=false")
    print("claim_support_updated=false")
    print(f"source_index_rows={source_rows}")
    print(f"nes_denominator_ready={nes_ready}")
    print(f"aies_denominator_ready={aies_ready}")
    print(f"aies_missing_sector_rows={aies_missing}")
    print(f"susb_denominator_ready={susb_ready}")
    print(f"bds_rows_checked={bds_rows}")
    print(f"bds_publication_marker_types_seen={bds_marker_types}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
