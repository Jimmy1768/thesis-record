#!/usr/bin/env python3
"""Validate sector-panel staging outputs without empirical calculations."""

from __future__ import annotations

import csv
import hashlib
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
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

SUSB_STAGING_HEADER = META_FIELDS_FILE + [
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

BDS_STAGING_HEADER = META_FIELDS_FILE + [
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

TABLE_CONTRACTS = {
    "stg_nes_sector_2023": {
        "header": NES_STAGING_HEADER,
        "expected_rows": 17,
        "source_dataset": "NES 2023 API",
        "key": ["canonical_sector"],
    },
    "stg_aies_nes_sector_2023": {
        "header": AIES_STAGING_HEADER,
        "expected_rows": 425,
        "source_dataset": "AIES-NES 2023 API",
        "key": [
            "canonical_sector",
            "NAICS2017",
            "INDLEVEL",
            "SECTOR__predicate",
            "SUBSECTOR",
            "INDGROUP",
        ],
    },
    "stg_susb_sector_2022": {
        "header": SUSB_STAGING_HEADER,
        "expected_rows": 17,
        "source_dataset": "SUSB 2022 U.S./state 6-digit NAICS",
        "key": ["canonical_sector"],
    },
    "stg_bds_sector_age_size": {
        "header": BDS_STAGING_HEADER,
        "expected_rows": 93840,
        "source_dataset": "BDS 2023 sector by firm age by firm size",
        "key": ["year", "canonical_sector", "fage", "fsize"],
    },
    "qa_sector_panel_staging_summary": {
        "header": QA_HEADER,
        "expected_rows": 4,
        "source_dataset": None,
        "key": ["staging_table"],
    },
}


class ValidationError(Exception):
    """Raised when staged-output validation fails."""


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def read_csv(path: Path) -> tuple[list[str], list[dict[str, str]]]:
    with path.open(newline="", encoding="utf-8") as handle:
        reader = csv.DictReader(handle)
        return list(reader.fieldnames or []), list(reader)


def fail_if(condition: bool, message: str) -> None:
    if condition:
        raise ValidationError(message)


def validate_manifest() -> dict[str, dict[str, str]]:
    fail_if(not STAGING_MANIFEST.exists(), f"missing manifest: {STAGING_MANIFEST}")
    header, rows = read_csv(STAGING_MANIFEST)
    fail_if(header != QA_HEADER, "staging manifest header mismatch")
    fail_if(len(rows) != 5, "staging manifest must contain 5 rows")

    seen: dict[str, dict[str, str]] = {}
    for row in rows:
        table = row["staging_table"]
        fail_if(table not in TABLE_CONTRACTS, f"unexpected staging table: {table}")
        fail_if(table in seen, f"duplicate manifest row: {table}")
        fail_if(row["analysis_performed"] != "false", f"{table}: analysis flag not false")
        fail_if(row["header_status"] != "verified", f"{table}: header not verified")
        fail_if(row["checksum_status"] != "verified", f"{table}: checksum not verified")
        fail_if("API_KEY" in row["output_path"], f"{table}: output path leaks secret label")
        fail_if(not row["output_path"].startswith("data/intermediate/sector_panel/"), f"{table}: output outside intermediate directory")
        seen[table] = row

    fail_if(set(seen) != set(TABLE_CONTRACTS), "manifest table set mismatch")
    return seen


def validate_rows(table: str, manifest_row: dict[str, str]) -> int:
    contract = TABLE_CONTRACTS[table]
    output = ROOT / manifest_row["output_path"]
    fail_if(not output.exists(), f"{table}: missing output {output}")
    fail_if(sha256_file(output) != manifest_row["output_sha256"], f"{table}: output sha256 mismatch")

    header, rows = read_csv(output)
    fail_if(header != contract["header"], f"{table}: staging header mismatch")
    fail_if(len(rows) != int(manifest_row["rows_written"]), f"{table}: row count does not match manifest")
    fail_if(len(rows) != contract["expected_rows"], f"{table}: unexpected row count")

    keys: set[tuple[str, ...]] = set()
    for index, row in enumerate(rows, start=2):
        fail_if(set(row) != set(header), f"{table}: row {index} field set mismatch")
        key = tuple(row[field] for field in contract["key"])
        fail_if(key in keys, f"{table}: duplicate staging key {key}")
        keys.add(key)
        source_dataset = contract["source_dataset"]
        if source_dataset:
            fail_if(row["source_dataset"] != source_dataset, f"{table}: bad source dataset")
            fail_if(row["canonical_sector"] not in CANONICAL_SECTORS, f"{table}: bad canonical sector")

    return len(rows)


def validate_table_specific_rules(table: str, manifest_row: dict[str, str]) -> None:
    _, rows = read_csv(ROOT / manifest_row["output_path"])

    if table == "stg_nes_sector_2023":
        sectors = {row["canonical_sector"] for row in rows}
        fail_if(sectors != CANONICAL_SECTORS, "NES: canonical sector coverage mismatch")
        for row in rows:
            fail_if(row["NAICS2022__get"] != row["NAICS2022__predicate"], "NES: duplicate NAICS fields disagree")
            fail_if(row["LFO"] != "001" or row["RCPSZES"] != "001" or row["us"] != "1", "NES: predicate mismatch")
            fail_if(row["reference_year"] != "2023", "NES: reference year mismatch")
            fail_if(row["naics_vintage"] != "2022", "NES: NAICS vintage mismatch")

    if table == "stg_aies_nes_sector_2023":
        sectors = {row["canonical_sector"] for row in rows}
        fail_if(sectors != CANONICAL_SECTORS, "AIES-NES: canonical sector coverage mismatch")
        for row in rows:
            fail_if(row["SECTOR__get"] != row["SECTOR__predicate"], "AIES-NES: duplicate sector fields disagree")
            fail_if(row["YEAR"] != "2023" or row["us"] != "1", "AIES-NES: predicate mismatch")
            fail_if(row["reference_year"] != "2023", "AIES-NES: reference year mismatch")
            fail_if(row["naics_vintage"] != "2017", "AIES-NES: NAICS vintage mismatch")

    if table == "stg_susb_sector_2022":
        sectors = {row["canonical_sector"] for row in rows}
        fail_if(sectors != CANONICAL_SECTORS, "SUSB: canonical sector coverage mismatch")
        for row in rows:
            fail_if(row["STATE"] != "00" or row["ENTRSIZE"] != "01", "SUSB: filter mismatch")
            fail_if(row["NAICS"] != row["canonical_sector"], "SUSB: sector mapping mismatch")
            fail_if(row["reference_year"] != "2022", "SUSB: reference year mismatch")
            fail_if(row["naics_vintage"] != "2017", "SUSB: NAICS vintage mismatch")

    if table == "stg_bds_sector_age_size":
        sectors = {row["canonical_sector"] for row in rows}
        years = {row["year"] for row in rows}
        fail_if(sectors != CANONICAL_SECTORS, "BDS: canonical sector coverage mismatch")
        fail_if(min(years) != "1978" or max(years) != "2023", "BDS: year coverage mismatch")
        for row in rows:
            fail_if(row["sector"] != row["canonical_sector"], "BDS: sector mapping mismatch")
            fail_if(row["reference_year"] != "1978-2023", "BDS: reference period mismatch")
            fail_if(
                row["naics_vintage"] != "2017 sector categories",
                "BDS: sector-category vintage mismatch",
            )

    if table == "qa_sector_panel_staging_summary":
        summary_tables = {row["staging_table"] for row in rows}
        expected = set(TABLE_CONTRACTS) - {"qa_sector_panel_staging_summary"}
        fail_if(summary_tables != expected, "QA summary table set mismatch")
        for row in rows:
            fail_if(row["analysis_performed"] != "false", "QA summary: analysis flag not false")


def main() -> int:
    try:
        manifest = validate_manifest()
        validated_rows = 0
        for table in TABLE_CONTRACTS:
            validated_rows += validate_rows(table, manifest[table])
            validate_table_specific_rules(table, manifest[table])
    except ValidationError as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        return 1

    print("staging_manifest_rows=5")
    print("staging_outputs_validated=5")
    print(f"staging_rows_validated={validated_rows}")
    print("analysis_performed=false")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
