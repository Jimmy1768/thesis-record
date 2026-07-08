# Evidence Manifest Template

Status: template only. Do not treat this file as evidence.

Use this template only after a concrete source artifact is being acquired for a
documented Thesis 2 method test, boundary record, source bundle, or proposed
metric record.

```yaml
manifest_id:
manifest_status: draft
created:
updated:
operator_thread: Thesis 2

artifact_identity:
  source_family:
  source_name:
  source_authority:
  source_url_or_access_path:
  acquisition_mode:
  retrieval_date:
  source_vintage:
  latest_known_release:
  geography:
  source_note_path:

intended_use:
  use_class:
  related_boundary_record:
  related_metric_record:
  related_method_test:
  mtr_dependency:
  outcome_dimension:
  source_role:

storage:
  raw_archive_path:
  processed_path:
  checksum:
  checksum_method:
  file_format:
  file_size:
  license_or_reuse_notes:
  redistribution_allowed:
  repo_storage_allowed:

boundary_and_geography:
  geographic_unit:
  mtr_boundary_compatibility:
  requires_crosswalk:
  crosswalk_method:
  known_boundary_mismatch:
  denominator_risk:

vintage_and_refresh:
  source_release_cadence:
  intended_refresh_cadence:
  vintage_alignment_class:
  volatility_flag:
  refresh_trigger:

quality_review:
  verification_status:
  completeness_notes:
  missingness_class:
  comparability_class:
  source_rich_region_bias_risk:
  informal_or_unreported_activity_bias_risk:
  known_limitations:

admissibility:
  allowed_for_source_note: false
  allowed_for_method_test: false
  allowed_for_boundary_record: false
  allowed_for_metric_record: false
  allowed_for_final_evidence: false
  decision:
  decision_date:
  rationale:
  required_follow_up:
```

Allowed `manifest_status` values:

- `draft`
- `needs_source_verification`
- `needs_license_review`
- `needs_boundary_review`
- `needs_quality_review`
- `accepted_for_method_test`
- `accepted_for_boundary_record`
- `accepted_for_metric_record`
- `rejected`

No manifest status authorizes scoring, ranking, or final paper claims.
