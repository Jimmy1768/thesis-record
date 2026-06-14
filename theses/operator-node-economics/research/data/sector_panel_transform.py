#!/usr/bin/env python3
"""Build conservative sector-panel processed inputs without analysis."""

from __future__ import annotations

import csv
import hashlib
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
STAGING_DIR = ROOT / "data/intermediate/sector_panel"
PROCESSED_DIR = ROOT / "data/processed/sector_panel"
PROCESSED_MANIFEST = ROOT / "data/manifests/sector_panel_processed_manifest.csv"
STAGING_VALIDATOR = ROOT / "research/data/sector_panel_staging_validator.py"

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

SECTOR_FRAME_VERSION = "2026-06-12_17_sector_all_source_overlap"
JOIN_CLASS = "sector_stable"
NO_ANALYSIS_NOTE = (
    "source-native field carry-forward only; no ratios, shares, growth, "
    "rankings, treatment effects, prediction outcomes, or claim status computed"
)

SOURCE_INDEX_HEADER = [
    "canonical_sector",
    "sector_frame_version",
    "nes_2023_available",
    "aies_nes_2023_available",
    "aies_nes_sector_row_available",
    "susb_2022_available",
    "bds_sector_age_size_available",
    "nes_naics_vintage",
    "aies_nes_naics_vintage",
    "susb_naics_vintage",
    "bds_sector_category_vintage",
    "join_class",
    "guardrail_notes",
]

BOUNDARY_INPUT_HEADER = [
    "canonical_sector",
    "sector_frame_version",
    "join_class",
    "nes_source_row_number",
    "nes_reference_year",
    "nes_naics_vintage",
    "nes_NESTAB",
    "nes_NRCPTOT",
    "nes_NRCPTOT_N",
    "nes_NRCPTOT_N_F",
    "nes_LFO",
    "nes_RCPSZES",
    "aies_sector_row_available",
    "aies_source_row_number",
    "aies_reference_year",
    "aies_naics_vintage",
    "aies_NAICS2017",
    "aies_INDLEVEL",
    "aies_SECTOR__predicate",
    "aies_RCPT_TOT_VAL",
    "aies_RCPT_TOT_VAL_NS",
    "aies_RCPT_TOT_CV",
    "aies_RCPT_TOT_VAL_NS_N",
    "aies_RCPT_TOT_VAL_NS_N_F",
    "susb_source_row_number",
    "susb_reference_year",
    "susb_naics_vintage",
    "susb_ENTRSIZE",
    "susb_FIRM",
    "susb_ESTB",
    "susb_EMPL",
    "susb_EMPLFL_N",
    "susb_PAYR",
    "susb_PAYRFL_N",
    "susb_RCPT",
    "susb_RCPTFL_N",
    "guardrail_notes",
]

BDS_EXTRA_FIELDS = [
    "sector_frame_version",
    "join_class",
    "guardrail_notes",
]

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


class TransformError(Exception):
    """Raised when conservative transformation cannot proceed."""


def run_staging_validator() -> None:
    result = subprocess.run(
        [sys.executable, str(STAGING_VALIDATOR)],
        cwd=ROOT,
        check=False,
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        raise TransformError(result.stderr.strip() or result.stdout.strip())


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def read_csv(path: Path) -> tuple[list[str], list[dict[str, str]]]:
    if not path.exists():
        raise TransformError(f"missing input: {path}")
    with path.open(newline="", encoding="utf-8") as handle:
        reader = csv.DictReader(handle)
        return list(reader.fieldnames or []), list(reader)


def write_rows(path: Path, header: list[str], rows: list[dict[str, str]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=header, lineterminator="\n")
        writer.writeheader()
        writer.writerows(rows)


def index_by_sector(rows: list[dict[str, str]], source_name: str) -> dict[str, dict[str, str]]:
    indexed: dict[str, dict[str, str]] = {}
    for row in rows:
        sector = row["canonical_sector"]
        if sector in indexed:
            raise TransformError(f"{source_name}: duplicate sector {sector}")
        indexed[sector] = row
    missing = sorted(set(CANONICAL_SECTORS) - set(indexed))
    if missing:
        raise TransformError(f"{source_name}: missing sectors {','.join(missing)}")
    return indexed


def select_aies_sector_rows(rows: list[dict[str, str]]) -> tuple[dict[str, dict[str, str]], list[str]]:
    selected: dict[str, dict[str, str]] = {}
    for row in rows:
        if row["INDLEVEL"] != "2":
            continue
        if row["NAICS2017"] != row["canonical_sector"]:
            continue
        sector = row["canonical_sector"]
        if sector in selected:
            raise TransformError(f"AIES-NES: duplicate sector row {sector}")
        selected[sector] = row
    missing = [sector for sector in CANONICAL_SECTORS if sector not in selected]
    return selected, missing


def build_source_index(
    nes: dict[str, dict[str, str]],
    aies_all: list[dict[str, str]],
    aies_sector_rows: dict[str, dict[str, str]],
    susb: dict[str, dict[str, str]],
    bds_rows: list[dict[str, str]],
) -> list[dict[str, str]]:
    aies_any = {row["canonical_sector"] for row in aies_all}
    bds_any = {row["canonical_sector"] for row in bds_rows}
    rows: list[dict[str, str]] = []
    for sector in CANONICAL_SECTORS:
        rows.append(
            {
                "canonical_sector": sector,
                "sector_frame_version": SECTOR_FRAME_VERSION,
                "nes_2023_available": str(sector in nes).lower(),
                "aies_nes_2023_available": str(sector in aies_any).lower(),
                "aies_nes_sector_row_available": str(sector in aies_sector_rows).lower(),
                "susb_2022_available": str(sector in susb).lower(),
                "bds_sector_age_size_available": str(sector in bds_any).lower(),
                "nes_naics_vintage": nes[sector]["naics_vintage"],
                "aies_nes_naics_vintage": "2017",
                "susb_naics_vintage": susb[sector]["naics_vintage"],
                "bds_sector_category_vintage": "2017 sector categories",
                "join_class": JOIN_CLASS,
                "guardrail_notes": NO_ANALYSIS_NOTE,
            }
        )
    return rows


def build_boundary_inputs(
    nes: dict[str, dict[str, str]],
    aies_sector_rows: dict[str, dict[str, str]],
    susb: dict[str, dict[str, str]],
) -> list[dict[str, str]]:
    rows: list[dict[str, str]] = []
    for sector in CANONICAL_SECTORS:
        nes_row = nes[sector]
        aies_row = aies_sector_rows.get(sector, {})
        susb_row = susb[sector]
        rows.append(
            {
                "canonical_sector": sector,
                "sector_frame_version": SECTOR_FRAME_VERSION,
                "join_class": JOIN_CLASS,
                "nes_source_row_number": nes_row["source_row_number"],
                "nes_reference_year": nes_row["reference_year"],
                "nes_naics_vintage": nes_row["naics_vintage"],
                "nes_NESTAB": nes_row["NESTAB"],
                "nes_NRCPTOT": nes_row["NRCPTOT"],
                "nes_NRCPTOT_N": nes_row["NRCPTOT_N"],
                "nes_NRCPTOT_N_F": nes_row["NRCPTOT_N_F"],
                "nes_LFO": nes_row["LFO"],
                "nes_RCPSZES": nes_row["RCPSZES"],
                "aies_sector_row_available": str(bool(aies_row)).lower(),
                "aies_source_row_number": aies_row.get("source_row_number", ""),
                "aies_reference_year": aies_row.get("reference_year", ""),
                "aies_naics_vintage": aies_row.get("naics_vintage", ""),
                "aies_NAICS2017": aies_row.get("NAICS2017", ""),
                "aies_INDLEVEL": aies_row.get("INDLEVEL", ""),
                "aies_SECTOR__predicate": aies_row.get("SECTOR__predicate", ""),
                "aies_RCPT_TOT_VAL": aies_row.get("RCPT_TOT_VAL", ""),
                "aies_RCPT_TOT_VAL_NS": aies_row.get("RCPT_TOT_VAL_NS", ""),
                "aies_RCPT_TOT_CV": aies_row.get("RCPT_TOT_CV", ""),
                "aies_RCPT_TOT_VAL_NS_N": aies_row.get("RCPT_TOT_VAL_NS_N", ""),
                "aies_RCPT_TOT_VAL_NS_N_F": aies_row.get("RCPT_TOT_VAL_NS_N_F", ""),
                "susb_source_row_number": susb_row["source_row_number"],
                "susb_reference_year": susb_row["reference_year"],
                "susb_naics_vintage": susb_row["naics_vintage"],
                "susb_ENTRSIZE": susb_row["ENTRSIZE"],
                "susb_FIRM": susb_row["FIRM"],
                "susb_ESTB": susb_row["ESTB"],
                "susb_EMPL": susb_row["EMPL"],
                "susb_EMPLFL_N": susb_row["EMPLFL_N"],
                "susb_PAYR": susb_row["PAYR"],
                "susb_PAYRFL_N": susb_row["PAYRFL_N"],
                "susb_RCPT": susb_row["RCPT"],
                "susb_RCPTFL_N": susb_row["RCPTFL_N"],
                "guardrail_notes": NO_ANALYSIS_NOTE,
            }
        )
    return rows


def build_bds_inputs(header: list[str], rows: list[dict[str, str]]) -> tuple[list[str], list[dict[str, str]]]:
    output_header = header + BDS_EXTRA_FIELDS
    output_rows = []
    for row in rows:
        output = dict(row)
        output["sector_frame_version"] = SECTOR_FRAME_VERSION
        output["join_class"] = JOIN_CLASS
        output["guardrail_notes"] = NO_ANALYSIS_NOTE
        output_rows.append(output)
    return output_header, output_rows


def manifest_row(
    processed_table: str,
    source_staging_tables: str,
    output_path: Path,
    row_count: int,
    created_at: str,
    warnings: str,
) -> dict[str, str]:
    return {
        "processed_table": processed_table,
        "source_staging_tables": source_staging_tables,
        "output_path": output_path.relative_to(ROOT).as_posix(),
        "output_sha256": sha256_file(output_path),
        "row_count": str(row_count),
        "created_at": created_at,
        "timezone": "UTC",
        "analysis_performed": "false",
        "guardrail_notes": NO_ANALYSIS_NOTE,
        "warnings": warnings,
    }


def main() -> int:
    try:
        run_staging_validator()
        _, nes_rows = read_csv(STAGING_DIR / "stg_nes_sector_2023.csv")
        _, aies_rows = read_csv(STAGING_DIR / "stg_aies_nes_sector_2023.csv")
        _, susb_rows = read_csv(STAGING_DIR / "stg_susb_sector_2022.csv")
        bds_header, bds_rows = read_csv(STAGING_DIR / "stg_bds_sector_age_size.csv")

        nes_by_sector = index_by_sector(nes_rows, "NES")
        susb_by_sector = index_by_sector(susb_rows, "SUSB")
        aies_sector_rows, missing_aies_sector_rows = select_aies_sector_rows(aies_rows)
        warnings = ""
        if missing_aies_sector_rows:
            warnings = "missing_aies_sector_rows=" + ";".join(missing_aies_sector_rows)

        created_at = (
            datetime.now(timezone.utc)
            .replace(microsecond=0)
            .isoformat()
            .replace("+00:00", "Z")
        )

        source_index = build_source_index(
            nes_by_sector,
            aies_rows,
            aies_sector_rows,
            susb_by_sector,
            bds_rows,
        )
        boundary_inputs = build_boundary_inputs(nes_by_sector, aies_sector_rows, susb_by_sector)
        bds_output_header, bds_output_rows = build_bds_inputs(bds_header, bds_rows)

        source_index_path = PROCESSED_DIR / "sector_source_index.csv"
        boundary_inputs_path = PROCESSED_DIR / "sector_boundary_measure_inputs.csv"
        bds_inputs_path = PROCESSED_DIR / "sector_bds_age_size_inputs.csv"

        write_rows(source_index_path, SOURCE_INDEX_HEADER, source_index)
        write_rows(boundary_inputs_path, BOUNDARY_INPUT_HEADER, boundary_inputs)
        write_rows(bds_inputs_path, bds_output_header, bds_output_rows)

        manifest_rows = [
            manifest_row(
                "sector_source_index",
                "stg_nes_sector_2023;stg_aies_nes_sector_2023;stg_susb_sector_2022;stg_bds_sector_age_size",
                source_index_path,
                len(source_index),
                created_at,
                warnings,
            ),
            manifest_row(
                "sector_boundary_measure_inputs",
                "stg_nes_sector_2023;stg_aies_nes_sector_2023;stg_susb_sector_2022",
                boundary_inputs_path,
                len(boundary_inputs),
                created_at,
                warnings,
            ),
            manifest_row(
                "sector_bds_age_size_inputs",
                "stg_bds_sector_age_size",
                bds_inputs_path,
                len(bds_output_rows),
                created_at,
                "",
            ),
        ]
        write_rows(PROCESSED_MANIFEST, PROCESSED_MANIFEST_HEADER, manifest_rows)
    except TransformError as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        return 1

    print("processed_tables_written=3")
    print("processed_manifest_rows=3")
    print("analysis_performed=false")
    if missing_aies_sector_rows:
        print("missing_aies_sector_rows=" + ";".join(missing_aies_sector_rows))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
