module Evidence
  class GenerateEvidenceSnapshotJob < ApplicationJob
    queue_as :exports

    def perform(evidence_snapshot_id)
      snapshot = EvidenceSnapshot.find(evidence_snapshot_id)
      Audit::Recorder.record!(
        actor: self.class.name,
        event_type: "snapshot_frozen",
        entity: snapshot,
        change_summary: "Evidence snapshot freeze requested for #{snapshot.version_label}",
        reason_code: "forecast_snapshot",
        storage_zone: "production_postgresql",
        privacy_classification: "internal",
        claim_status_effect: "unchanged",
        snapshot_id: snapshot.id,
        review_required: true
      )
    end
  end
end
