#!/usr/bin/env python3
"""Calculate approved sector-panel descriptive measures without claim updates."""

from __future__ import annotations

import csv
import hashlib
import subprocess
import sys
from datetime import datetime, timezone
from decimal import Decimal, InvalidOperation, ROUND_HALF_UP
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
PROCESSED_DIR = ROOT / "data/processed/sector_panel"
ANALYSIS_DIR = ROOT / "data/analysis/sector_panel"
ANALYSIS_MANIFEST = ROOT / "data/manifests/sector_panel_analysis_manifest.csv"
DRY_RUN_VALIDATOR = ROOT / "research/data/sector_panel_analysis_dry_run_validator.py"

BOUNDARY_INPUT = PROCESSED_DIR / "sector_boundary_measure_inputs.csv"
ANALYSIS_OUTPUT = ANALYSIS_DIR / "sector_descriptive_measures.csv"

AIES_MISSING_SECTORS = {"11", "81"}

GUARDRAIL_NOTES = (
    "descriptive measures only; no AI exposure merge, rankings, growth rates, "
    "treatment effects, prediction outcomes, or claim support updates"
)

OUTPUT_HEADER = [
    "canonical_sector",
    "sector_frame_version",
    "join_class",
    "nes_receipts_per_establishment_thousand",
    "nes_receipts_per_establishment_unit",
    "nes_NRCPTOT_N",
    "nes_NRCPTOT_N_F",
    "aies_nonemployer_revenue_share",
    "aies_measure_status",
    "aies_missing_reason",
    "aies_RCPT_TOT_CV",
    "aies_RCPT_TOT_VAL_NS_N",
    "aies_RCPT_TOT_VAL_NS_N_F",
    "susb_payroll_per_employee_thousand",
    "susb_employment_per_firm",
    "susb_establishments_per_firm",
    "susb_EMPLFL_N",
    "susb_PAYRFL_N",
    "susb_RCPTFL_N",
    "ai_exposure_merged",
    "claim_support_updated",
    "interpretation_limit",
    "guardrail_notes",
]

ANALYSIS_MANIFEST_HEADER = [
    "analysis_table",
    "source_processed_tables",
    "output_path",
    "output_sha256",
    "row_count",
    "created_at",
    "timezone",
    "calculations",
    "ai_exposure_merged",
    "claim_support_updated",
    "warnings",
    "guardrail_notes",
]

CALCULATION_LIST = [
    "nes_receipts_per_establishment",
    "aies_nonemployer_revenue_share_available_sectors_only",
    "susb_payroll_per_employee",
    "susb_employment_per_firm",
    "susb_establishments_per_firm",
]


class AnalysisError(Exception):
    """Raised when descriptive analysis cannot proceed."""


def run_dry_validator() -> None:
    result = subprocess.run(
        [sys.executable, str(DRY_RUN_VALIDATOR)],
        cwd=ROOT,
        check=False,
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        raise AnalysisError(result.stderr.strip() or result.stdout.strip())


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def read_csv(path: Path) -> list[dict[str, str]]:
    if not path.exists():
        raise AnalysisError(f"missing input: {path}")
    with path.open(newline="", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def write_rows(path: Path, header: list[str], rows: list[dict[str, str]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=header, lineterminator="\n")
        writer.writeheader()
        writer.writerows(rows)


def decimal_value(value: str, field: str, sector: str) -> Decimal:
    try:
        return Decimal(value)
    except InvalidOperation as exc:
        raise AnalysisError(f"{sector}: {field} is nonnumeric: {value}") from exc


def divide(numerator: Decimal, denominator: Decimal, sector: str, field: str) -> str:
    if denominator <= 0:
        raise AnalysisError(f"{sector}: denominator for {field} is not positive")
    return str((numerator / denominator).quantize(Decimal("0.000001"), rounding=ROUND_HALF_UP))


def build_descriptive_rows(rows: list[dict[str, str]]) -> list[dict[str, str]]:
    output_rows: list[dict[str, str]] = []
    for row in rows:
        sector = row["canonical_sector"]
        nes_receipts = decimal_value(row["nes_NRCPTOT"], "nes_NRCPTOT", sector)
        nes_establishments = decimal_value(row["nes_NESTAB"], "nes_NESTAB", sector)
        susb_payroll = decimal_value(row["susb_PAYR"], "susb_PAYR", sector)
        susb_employment = decimal_value(row["susb_EMPL"], "susb_EMPL", sector)
        susb_firms = decimal_value(row["susb_FIRM"], "susb_FIRM", sector)
        susb_establishments = decimal_value(row["susb_ESTB"], "susb_ESTB", sector)

        aies_share = ""
        aies_status = "available"
        aies_missing_reason = ""
        if sector in AIES_MISSING_SECTORS:
            if row["aies_sector_row_available"] != "false":
                raise AnalysisError(f"{sector}: expected missing AIES sector row")
            aies_status = "missing"
            aies_missing_reason = "missing_aies_sector_row"
        else:
            employer = decimal_value(row["aies_RCPT_TOT_VAL"], "aies_RCPT_TOT_VAL", sector)
            nonemployer = decimal_value(row["aies_RCPT_TOT_VAL_NS"], "aies_RCPT_TOT_VAL_NS", sector)
            aies_share = divide(
                nonemployer,
                employer + nonemployer,
                sector,
                "aies_nonemployer_revenue_share",
            )

        output_rows.append(
            {
                "canonical_sector": sector,
                "sector_frame_version": row["sector_frame_version"],
                "join_class": row["join_class"],
                "nes_receipts_per_establishment_thousand": divide(
                    nes_receipts,
                    nes_establishments,
                    sector,
                    "nes_receipts_per_establishment_thousand",
                ),
                "nes_receipts_per_establishment_unit": "thousand_dollars_per_nonemployer_establishment",
                "nes_NRCPTOT_N": row["nes_NRCPTOT_N"],
                "nes_NRCPTOT_N_F": row["nes_NRCPTOT_N_F"],
                "aies_nonemployer_revenue_share": aies_share,
                "aies_measure_status": aies_status,
                "aies_missing_reason": aies_missing_reason,
                "aies_RCPT_TOT_CV": row["aies_RCPT_TOT_CV"],
                "aies_RCPT_TOT_VAL_NS_N": row["aies_RCPT_TOT_VAL_NS_N"],
                "aies_RCPT_TOT_VAL_NS_N_F": row["aies_RCPT_TOT_VAL_NS_N_F"],
                "susb_payroll_per_employee_thousand": divide(
                    susb_payroll,
                    susb_employment,
                    sector,
                    "susb_payroll_per_employee_thousand",
                ),
                "susb_employment_per_firm": divide(
                    susb_employment,
                    susb_firms,
                    sector,
                    "susb_employment_per_firm",
                ),
                "susb_establishments_per_firm": divide(
                    susb_establishments,
                    susb_firms,
                    sector,
                    "susb_establishments_per_firm",
                ),
                "susb_EMPLFL_N": row["susb_EMPLFL_N"],
                "susb_PAYRFL_N": row["susb_PAYRFL_N"],
                "susb_RCPTFL_N": row["susb_RCPTFL_N"],
                "ai_exposure_merged": "false",
                "claim_support_updated": "false",
                "interpretation_limit": "descriptive baseline only; not AI, causal, one-human, transaction-cost, or firm-boundary evidence",
                "guardrail_notes": GUARDRAIL_NOTES,
            }
        )
    return output_rows


def write_manifest(row_count: int, created_at: str) -> None:
    row = {
        "analysis_table": "sector_descriptive_measures",
        "source_processed_tables": "sector_boundary_measure_inputs",
        "output_path": ANALYSIS_OUTPUT.relative_to(ROOT).as_posix(),
        "output_sha256": sha256_file(ANALYSIS_OUTPUT),
        "row_count": str(row_count),
        "created_at": created_at,
        "timezone": "UTC",
        "calculations": ";".join(CALCULATION_LIST),
        "ai_exposure_merged": "false",
        "claim_support_updated": "false",
        "warnings": "missing_aies_sector_rows=11;81",
        "guardrail_notes": GUARDRAIL_NOTES,
    }
    write_rows(ANALYSIS_MANIFEST, ANALYSIS_MANIFEST_HEADER, [row])


def main() -> int:
    try:
        run_dry_validator()
        boundary_rows = read_csv(BOUNDARY_INPUT)
        output_rows = build_descriptive_rows(boundary_rows)
        created_at = (
            datetime.now(timezone.utc)
            .replace(microsecond=0)
            .isoformat()
            .replace("+00:00", "Z")
        )
        write_rows(ANALYSIS_OUTPUT, OUTPUT_HEADER, output_rows)
        write_manifest(len(output_rows), created_at)
    except AnalysisError as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        return 1

    print("analysis_tables_written=1")
    print(f"analysis_rows_written={len(output_rows)}")
    print("ai_exposure_merged=false")
    print("claim_support_updated=false")
    print("missing_aies_sector_rows=11;81")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
