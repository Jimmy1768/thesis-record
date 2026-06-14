module Evidence
  class RedactAndAggregateExportJob < ApplicationJob
    queue_as :exports

    def perform(export_artifact_id)
      artifact = ExportArtifact.find(export_artifact_id)
      Audit::Recorder.record!(
        actor: self.class.name,
        event_type: "export_requested",
        entity: artifact,
        change_summary: "Reviewed export requested for #{artifact.artifact_kind}",
        reason_code: "export_review",
        storage_zone: "git_repository",
        privacy_classification: "redacted_public",
        claim_status_effect: "unchanged",
        export_allowed: artifact.reviewed_for_public_repo?,
        snapshot_id: artifact.evidence_snapshot_id,
        review_required: true
      )
    end
  end
end
