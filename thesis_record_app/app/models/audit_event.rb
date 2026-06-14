class AuditEvent < ApplicationRecord
  EVENT_TYPES = %w[
    source_registered
    source_registry_changed
    source_status_changed
    source_access_path_changed
    intake_manifest_created
    intake_manifest_changed
    schema_version_created
    schema_version_changed
    storage_zone_classified
    privacy_classification_changed
    private_file_registered
    private_file_hash_changed
    retention_rule_changed
    redaction_status_changed
    minimum_cell_check_completed
    collection_started
    collection_completed
    collection_failed
    validation_started
    validation_completed
    validation_failed
    suppression_or_missingness_flagged
    metric_definition_created
    metric_definition_changed
    metric_observation_created
    metric_observation_recomputed
    evidence_classified
    quality_flag_created
    quality_flag_resolved
    review_requested
    review_approved
    review_rejected
    review_reopened
    claim_status_change_requested
    claim_status_changed
    claim_status_change_rejected
    export_requested
    export_blocked
    export_created
    export_approved
    export_published_to_git
    snapshot_created
    snapshot_frozen
    snapshot_superseded
    backup_completed
    backup_failed
    restore_test_completed
    restore_test_failed
    secret_rotated
    operator_admin_bootstrapped
    operations_policy_checked
    job_failed
    source_release_check_requested
    quarterly_checkpoint_requested
    annual_snapshot_candidate_requested
  ].freeze

  validates :occurred_at, :actor_type, :event_type, :entity_type, :entity_id,
            :change_summary, :reason_code, :storage_zone,
            :privacy_classification, :claim_status_effect, presence: true
  validates :event_type, inclusion: { in: EVENT_TYPES }
end
