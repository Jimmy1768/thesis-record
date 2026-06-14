#!/usr/bin/env python3
"""Stage validated sector-panel raw inputs without empirical calculations."""

from __future__ import annotations

import csv
import hashlib
import json
import sys
from datetime import datetime, timezone
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
API_MANIFEST = ROOT / "data/manifests/sector_panel_api_payload_manifest.csv"
SUSB_MANIFEST = ROOT / "data/manifests/susb_2022_manifest.csv"
BDS_MANIFEST = ROOT / "data/manifests/bds_2023_manifest.csv"
STAGING_MANIFEST = ROOT / "data/manifests/sector_panel_staging_manifest.csv"
OUT_DIR = ROOT / "data/intermediate/sector_panel"

CANONICAL_SECTORS = {
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
}

AIES_SECTOR_MAP = {
    "11": "11",
    "21": "21",
    "22": "22",
    "23": "23",
    "31": "31-33",
    "42": "42",
    "44": "44-45",
    "48": "48-49",
    "51": "51",
    "52": "52",
    "53": "53",
    "54": "54",
    "56": "56",
    "62": "62",
    "71": "71",
    "72": "72",
    "81": "81",
}

NES_RAW_HEADER = [
    "NAICS2022",
    "NAICS2022_LABEL",
    "NESTAB",
    "NRCPTOT",
    "NRCPTOT_N",
    "NRCPTOT_N_F",
    "LFO",
    "RCPSZES",
    "NAICS2022",
    "us",
]

AIES_RAW_HEADER = [
    "NAICS2017",
    "NAICS2017_LABEL",
    "GEO_ID",
    "RCPT_TOT_VAL",
    "RCPT_TOT_VAL_NS",
    "RCPT_TOT_CV",
    "RCPT_TOT_VAL_NS_N",
    "RCPT_TOT_VAL_NS_N_F",
    "INDLEVEL",
    "SECTOR",
    "SUBSECTOR",
    "INDGROUP",
    "YEAR",
    "SECTOR",
    "us",
]

SUSB_HEADER = [
    "STATE",
    "NAICS",
    "ENTRSIZE",
    "FIRM",
    "ESTB",
    "EMPL",
    "EMPLFL_N",
    "PAYR",
    "PAYRFL_N",
    "RCPT",
    "RCPTFL_N",
    "STATEDSCR",
    "NAICSDSCR",
    "ENTRSIZEDSCR",
]

BDS_HEADER = [
    "year",
    "sector",
    "fage",
    "fsize",
    "firms",
    "estabs",
    "emp",
    "denom",
    "estabs_entry",
    "estabs_entry_rate",
    "estabs_exit",
    "estabs_exit_rate",
    "job_creation",
    "job_creation_births",
    "job_creation_continuers",
    "job_creation_rate_births",
    "job_creation_rate",
    "job_destruction",
    "job_destruction_deaths",
    "job_destruction_continuers",
    "job_destruction_rate_deaths",
    "job_destruction_rate",
    "net_job_creation",
    "net_job_creation_rate",
    "reallocation_rate",
    "firmdeath_firms",
    "firmdeath_estabs",
    "firmdeath_emp",
]

META_FIELDS_API = [
    "source_dataset",
    "source_inventory_id",
    "source_row_number",
    "raw_local_path",
    "reference_year",
    "naics_vintage",
    "canonical_sector",
]

META_FIELDS_FILE = [
    "source_dataset",
    "source_row_number",
    "raw_local_path",
    "reference_year",
    "naics_vintage",
    "canonical_sector",
]

NES_STAGING_HEADER = META_FIELDS_API + [
    "NAICS2022__get",
    "NAICS2022_LABEL",
    "NESTAB",
    "NRCPTOT",
    "NRCPTOT_N",
    "NRCPTOT_N_F",
    "LFO",
    "RCPSZES",
    "NAICS2022__predicate",
    "us",
]

AIES_STAGING_HEADER = META_FIELDS_API + [
    "NAICS2017",
    "NAICS2017_LABEL",
    "GEO_ID",
    "RCPT_TOT_VAL",
    "RCPT_TOT_VAL_NS",
    "RCPT_TOT_CV",
    "RCPT_TOT_VAL_NS_N",
    "RCPT_TOT_VAL_NS_N_F",
    "INDLEVEL",
    "SECTOR__get",
    "SUBSECTOR",
    "INDGROUP",
    "YEAR",
    "SECTOR__predicate",
    "us",
]

SUSB_STAGING_HEADER = META_FIELDS_FILE + SUSB_HEADER
BDS_STAGING_HEADER = META_FIELDS_FILE + BDS_HEADER

QA_HEADER = [
    "staging_table",
    "source_type",
    "input_manifest",
    "raw_inputs_checked",
    "raw_rows_seen",
    "rows_written",
    "rows_excluded_outside_sector_frame",
    "duplicate_field_mismatches",
    "header_status",
    "checksum_status",
    "output_path",
    "output_sha256",
    "created_at",
    "timezone",
    "analysis_performed",
    "guardrail_notes",
]


class StagingError(Exception):
    """Raised when staging QA fails."""


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def read_single_manifest(path: Path) -> dict[str, str]:
    with path.open(newline="", encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
    if len(rows) != 1:
        raise StagingError(f"{path}: expected exactly one row")
    return rows[0]


def read_api_manifest() -> list[dict[str, str]]:
    with API_MANIFEST.open(newline="", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def verify_file_manifest(path: Path, manifest: dict[str, str], header: list[str]) -> int:
    if not path.exists():
        raise StagingError(f"missing raw file: {path}")
    if sha256_file(path) != manifest["sha256"]:
        raise StagingError(f"sha256 mismatch: {path}")
    with path.open("r", encoding="latin-1", newline="") as handle:
        reader = csv.reader(handle)
        observed = next(reader)
        if observed != header:
            raise StagingError(f"header mismatch: {path}")
        return sum(1 for _ in reader)


def read_json_payload(row: dict[str, str], expected_header: list[str]) -> list[list[str]]:
    path = ROOT / row["local_path"]
    if not path.exists():
        raise StagingError(f"missing API payload: {path}")
    if sha256_file(path) != row["sha256"]:
        raise StagingError(f"sha256 mismatch: {path}")
    payload = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(payload, list) or not payload:
        raise StagingError(f"bad JSON payload: {path}")
    if payload[0] != expected_header:
        raise StagingError(f"header mismatch: {path}")
    for index, item in enumerate(payload[1:], start=2):
        if not isinstance(item, list) or len(item) != len(expected_header):
            raise StagingError(f"bad row width in {path} at row {index}")
    return payload


def write_rows(path: Path, header: list[str], rows: list[dict[str, str]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=header, lineterminator="\n")
        writer.writeheader()
        writer.writerows(rows)


def manifest_row(
    staging_table: str,
    source_type: str,
    input_manifest: str,
    raw_inputs_checked: int,
    raw_rows_seen: int,
    rows_written: int,
    rows_excluded_outside_sector_frame: int,
    duplicate_field_mismatches: int,
    output_path: Path,
    created_at: str,
) -> dict[str, str]:
    return {
        "staging_table": staging_table,
        "source_type": source_type,
        "input_manifest": input_manifest,
        "raw_inputs_checked": str(raw_inputs_checked),
        "raw_rows_seen": str(raw_rows_seen),
        "rows_written": str(rows_written),
        "rows_excluded_outside_sector_frame": str(
            rows_excluded_outside_sector_frame
        ),
        "duplicate_field_mismatches": str(duplicate_field_mismatches),
        "header_status": "verified",
        "checksum_status": "verified",
        "output_path": output_path.relative_to(ROOT).as_posix(),
        "output_sha256": sha256_file(output_path),
        "created_at": created_at,
        "timezone": "UTC",
        "analysis_performed": "false",
        "guardrail_notes": "staging only; no ratios, shares, growth, rankings, treatment effects, prediction outcomes, or claim status computed",
    }


def stage_nes(api_rows: list[dict[str, str]], created_at: str) -> dict[str, str]:
    staged: list[dict[str, str]] = []
    raw_rows_seen = 0
    duplicate_mismatches = 0
    excluded = 0

    for manifest in api_rows:
        if manifest["dataset"] != "NES 2023 API":
            continue
        payload = read_json_payload(manifest, NES_RAW_HEADER)
        for source_row_number, raw in enumerate(payload[1:], start=1):
            raw_rows_seen += 1
            if raw[0] != raw[8]:
                duplicate_mismatches += 1
                continue
            sector = raw[8]
            if sector not in CANONICAL_SECTORS:
                excluded += 1
                continue
            if raw[6] != "001" or raw[7] != "001" or raw[9] != "1":
                raise StagingError(f"unexpected NES predicate in {manifest['local_path']}")
            staged.append(
                {
                    "source_dataset": "NES 2023 API",
                    "source_inventory_id": manifest["inventory_id"],
                    "source_row_number": str(source_row_number),
                    "raw_local_path": manifest["local_path"],
                    "reference_year": manifest["reference_year_or_period"],
                    "naics_vintage": manifest["naics_vintage"],
                    "canonical_sector": sector,
                    "NAICS2022__get": raw[0],
                    "NAICS2022_LABEL": raw[1],
                    "NESTAB": raw[2],
                    "NRCPTOT": raw[3],
                    "NRCPTOT_N": raw[4],
                    "NRCPTOT_N_F": raw[5],
                    "LFO": raw[6],
                    "RCPSZES": raw[7],
                    "NAICS2022__predicate": raw[8],
                    "us": raw[9],
                }
            )

    if duplicate_mismatches:
        raise StagingError("NES duplicate field mismatch")
    output = OUT_DIR / "stg_nes_sector_2023.csv"
    write_rows(output, NES_STAGING_HEADER, staged)
    return manifest_row(
        "stg_nes_sector_2023",
        "api_json",
        API_MANIFEST.relative_to(ROOT).as_posix(),
        17,
        raw_rows_seen,
        len(staged),
        excluded,
        duplicate_mismatches,
        output,
        created_at,
    )


def stage_aies(api_rows: list[dict[str, str]], created_at: str) -> dict[str, str]:
    staged: list[dict[str, str]] = []
    raw_rows_seen = 0
    duplicate_mismatches = 0
    excluded = 0

    for manifest in api_rows:
        if manifest["dataset"] != "AIES-NES 2023 API":
            continue
        payload = read_json_payload(manifest, AIES_RAW_HEADER)
        for source_row_number, raw in enumerate(payload[1:], start=1):
            raw_rows_seen += 1
            if raw[9] != raw[13]:
                duplicate_mismatches += 1
                continue
            sector = AIES_SECTOR_MAP.get(raw[13])
            if not sector:
                excluded += 1
                continue
            if raw[12] != "2023" or raw[14] != "1":
                raise StagingError(f"unexpected AIES predicate in {manifest['local_path']}")
            staged.append(
                {
                    "source_dataset": "AIES-NES 2023 API",
                    "source_inventory_id": manifest["inventory_id"],
                    "source_row_number": str(source_row_number),
                    "raw_local_path": manifest["local_path"],
                    "reference_year": manifest["reference_year_or_period"],
                    "naics_vintage": manifest["naics_vintage"],
                    "canonical_sector": sector,
                    "NAICS2017": raw[0],
                    "NAICS2017_LABEL": raw[1],
                    "GEO_ID": raw[2],
                    "RCPT_TOT_VAL": raw[3],
                    "RCPT_TOT_VAL_NS": raw[4],
                    "RCPT_TOT_CV": raw[5],
                    "RCPT_TOT_VAL_NS_N": raw[6],
                    "RCPT_TOT_VAL_NS_N_F": raw[7],
                    "INDLEVEL": raw[8],
                    "SECTOR__get": raw[9],
                    "SUBSECTOR": raw[10],
                    "INDGROUP": raw[11],
                    "YEAR": raw[12],
                    "SECTOR__predicate": raw[13],
                    "us": raw[14],
                }
            )

    if duplicate_mismatches:
        raise StagingError("AIES duplicate field mismatch")
    output = OUT_DIR / "stg_aies_nes_sector_2023.csv"
    write_rows(output, AIES_STAGING_HEADER, staged)
    return manifest_row(
        "stg_aies_nes_sector_2023",
        "api_json",
        API_MANIFEST.relative_to(ROOT).as_posix(),
        17,
        raw_rows_seen,
        len(staged),
        excluded,
        duplicate_mismatches,
        output,
        created_at,
    )


def stage_susb(created_at: str) -> dict[str, str]:
    manifest = read_single_manifest(SUSB_MANIFEST)
    raw_path = ROOT / manifest["local_path"]
    raw_rows_seen = verify_file_manifest(raw_path, manifest, SUSB_HEADER)
    staged: list[dict[str, str]] = []
    base_rows = 0
    excluded = 0

    with raw_path.open("r", encoding="latin-1", newline="") as handle:
        reader = csv.DictReader(handle)
        for source_row_number, row in enumerate(reader, start=1):
            if row["STATE"] != "00" or row["ENTRSIZE"] != "01":
                continue
            base_rows += 1
            if row["NAICS"] not in CANONICAL_SECTORS:
                excluded += 1
                continue
            staged_row = {
                "source_dataset": "SUSB 2022 U.S./state 6-digit NAICS",
                "source_row_number": str(source_row_number),
                "raw_local_path": manifest["local_path"],
                "reference_year": manifest["reference_year_or_period"],
                "naics_vintage": manifest["naics_vintage"],
                "canonical_sector": row["NAICS"],
            }
            staged_row.update({field: row[field] for field in SUSB_HEADER})
            staged.append(staged_row)

    output = OUT_DIR / "stg_susb_sector_2022.csv"
    write_rows(output, SUSB_STAGING_HEADER, staged)
    return manifest_row(
        "stg_susb_sector_2022",
        "csv",
        SUSB_MANIFEST.relative_to(ROOT).as_posix(),
        1,
        raw_rows_seen,
        len(staged),
        excluded,
        0,
        output,
        created_at,
    )


def stage_bds(created_at: str) -> dict[str, str]:
    manifest = read_single_manifest(BDS_MANIFEST)
    raw_path = ROOT / manifest["local_path"]
    raw_rows_seen = verify_file_manifest(raw_path, manifest, BDS_HEADER)
    staged: list[dict[str, str]] = []
    excluded = 0

    with raw_path.open("r", encoding="utf-8", newline="") as handle:
        reader = csv.DictReader(handle)
        for source_row_number, row in enumerate(reader, start=1):
            if row["sector"] not in CANONICAL_SECTORS:
                excluded += 1
                continue
            staged_row = {
                "source_dataset": "BDS 2023 sector by firm age by firm size",
                "source_row_number": str(source_row_number),
                "raw_local_path": manifest["local_path"],
                "reference_year": manifest["reference_year_or_period"],
                "naics_vintage": manifest["naics_vintage"],
                "canonical_sector": row["sector"],
            }
            staged_row.update({field: row[field] for field in BDS_HEADER})
            staged.append(staged_row)

    output = OUT_DIR / "stg_bds_sector_age_size.csv"
    write_rows(output, BDS_STAGING_HEADER, staged)
    return manifest_row(
        "stg_bds_sector_age_size",
        "csv",
        BDS_MANIFEST.relative_to(ROOT).as_posix(),
        1,
        raw_rows_seen,
        len(staged),
        excluded,
        0,
        output,
        created_at,
    )


def write_manifest(rows: list[dict[str, str]]) -> None:
    with STAGING_MANIFEST.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=QA_HEADER, lineterminator="\n")
        writer.writeheader()
        writer.writerows(rows)


def main() -> int:
    try:
        created_at = (
            datetime.now(timezone.utc)
            .replace(microsecond=0)
            .isoformat()
            .replace("+00:00", "Z")
        )
        api_rows = read_api_manifest()
        qa_rows = [
            stage_nes(api_rows, created_at),
            stage_aies(api_rows, created_at),
            stage_susb(created_at),
            stage_bds(created_at),
        ]
        summary_output = OUT_DIR / "qa_sector_panel_staging_summary.csv"
        write_rows(summary_output, QA_HEADER, qa_rows)
        qa_rows.append(
            manifest_row(
                "qa_sector_panel_staging_summary",
                "qa_summary",
                "data/manifests/sector_panel_staging_manifest.csv",
                len(qa_rows),
                len(qa_rows),
                len(qa_rows),
                0,
                0,
                summary_output,
                created_at,
            )
        )
        write_manifest(qa_rows)
    except StagingError as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        return 1

    print("staging_tables_written=4")
    print("qa_summary_written=1")
    print("analysis_performed=false")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
