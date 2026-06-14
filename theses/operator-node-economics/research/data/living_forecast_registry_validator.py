#!/usr/bin/env python3
"""Validate living-forecast registry templates and populated public registries."""

from __future__ import annotations

import csv
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
MANIFEST_DIR = ROOT / "data/manifests"

REGISTRY_SCHEMAS = {
    "exposure_source_registry_template.csv": [
        "registry_id",
        "track",
        "exposure_source",
        "source_owner",
        "source_type",
        "source_status",
        "verification_source",
        "source_url",
        "access_path",
        "exposure_tier",
        "exposure_unit",
        "exposure_period",
        "naics_vintage",
        "sector_or_industry_field",
        "occupation_field",
        "geography_field",
        "firm_size_field",
        "ai_measure_fields",
        "outcome_linkage_available",
        "nonemployer_ai_use_observed",
        "node_use_observed",
        "limitations",
        "review_status",
        "claim_status_allowed",
        "privacy_classification",
        "created_at",
        "review_notes",
    ],
    "node_case_registry_template.csv": [
        "case_id",
        "node_id",
        "case_source",
        "source_owner",
        "source_status",
        "privacy_classification",
        "disclosure_status",
        "node_operator_count",
        "employee_count",
        "manager_count",
        "subcontractor_count",
        "hidden_labor_flag",
        "payroll_started_flag",
        "legal_entity_type",
        "ai_systems_used",
        "workflow_automation_level",
        "institutional_memory_system",
        "audit_trail_available",
        "human_review_required",
        "client_count",
        "repeat_client_count",
        "project_count",
        "revenue_period",
        "revenue_amount",
        "revenue_currency",
        "output_unit",
        "output_count",
        "quality_measure",
        "rework_count",
        "delivery_time",
        "node_status",
        "conversion_status",
        "review_status",
        "claim_status_allowed",
        "created_at",
        "review_notes",
    ],
    "transaction_cost_metric_registry_template.csv": [
        "metric_id",
        "transaction_track_source",
        "source_owner",
        "source_status",
        "privacy_classification",
        "transaction_unit",
        "supplier_type",
        "comparison_vendor_type",
        "service_category",
        "asset_specificity_score_field",
        "liability_risk_score_field",
        "output_measurability_score_field",
        "search_time_field",
        "proposal_cost_field",
        "lead_to_contract_time_field",
        "legal_review_time_field",
        "procurement_cycle_time_field",
        "monitoring_time_field",
        "change_order_count_field",
        "dispute_count_field",
        "rework_count_field",
        "payment_delay_days_field",
        "repeat_purchase_field",
        "client_retention_field",
        "measurement_directness",
        "baseline_available",
        "review_status",
        "claim_status_allowed",
        "created_at",
        "review_notes",
    ],
}

POPULATED_REGISTRIES = {
    "exposure_source_registry.csv": REGISTRY_SCHEMAS[
        "exposure_source_registry_template.csv"
    ],
}

ALLOWED_REVIEW_STATUSES = {
    "raw_collected",
    "schema_validated",
    "indicator_computed",
    "review_pending",
    "accepted_for_baseline",
    "accepted_for_forecast_check",
    "rejected_or_superseded",
}

ALLOWED_CLAIM_STATUS_ALLOWED = {
    "not_evidence",
    "forecast_baseline",
    "leading_indicator",
    "feasibility_case",
    "diffusion_evidence",
}

ALLOWED_PRIVACY_CLASSES = {
    "public",
    "internal",
    "confidential",
    "aggregated_public",
    "redacted_public",
}


class RegistryValidationError(Exception):
    """Raised when a registry template or populated row is invalid."""


def read_rows(path: Path) -> tuple[list[str], list[dict[str, str]]]:
    with path.open(newline="", encoding="utf-8") as handle:
        reader = csv.DictReader(handle)
        return list(reader.fieldnames or []), list(reader)


def validate_registry(filename: str, expected_header: list[str]) -> int:
    path = MANIFEST_DIR / filename
    if not path.exists():
        raise RegistryValidationError(f"missing registry: {filename}")
    header, rows = read_rows(path)
    if header != expected_header:
        raise RegistryValidationError(f"{filename}: header mismatch")
    for index, row in enumerate(rows, start=2):
        review_status = row.get("review_status", "")
        claim_status = row.get("claim_status_allowed", "")
        privacy = row.get("privacy_classification", "")
        if review_status and review_status not in ALLOWED_REVIEW_STATUSES:
            raise RegistryValidationError(
                f"{filename}:{index}: bad review_status {review_status}"
            )
        if claim_status and claim_status not in ALLOWED_CLAIM_STATUS_ALLOWED:
            raise RegistryValidationError(
                f"{filename}:{index}: bad claim_status_allowed {claim_status}"
            )
        if privacy and privacy not in ALLOWED_PRIVACY_CLASSES:
            raise RegistryValidationError(
                f"{filename}:{index}: bad privacy_classification {privacy}"
            )
    return len(rows)


def main() -> int:
    try:
        row_counts = {
            filename: validate_registry(filename, header)
            for filename, header in REGISTRY_SCHEMAS.items()
        }
        populated_counts = {
            filename: validate_registry(filename, header)
            for filename, header in POPULATED_REGISTRIES.items()
            if (MANIFEST_DIR / filename).exists()
        }
    except RegistryValidationError as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        return 1

    print("registry_templates_validated=3")
    for filename in sorted(row_counts):
        print(f"{filename}_rows={row_counts[filename]}")
    print(f"populated_registries_validated={len(populated_counts)}")
    for filename in sorted(populated_counts):
        print(f"{filename}_rows={populated_counts[filename]}")
    print("data_ingested=false")
    print("claim_support_updated=false")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
