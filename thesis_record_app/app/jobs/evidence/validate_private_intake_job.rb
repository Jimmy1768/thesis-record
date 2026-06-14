module Evidence
  class ValidatePrivateIntakeJob < ApplicationJob
    queue_as :evidence_validation

    def perform(intake_manifest_id)
      manifest = IntakeManifest.find(intake_manifest_id)
      Audit::Recorder.record!(
        actor: self.class.name,
        event_type: "validation_started",
        entity: manifest,
        change_summary: "Private intake validation requested for #{manifest.name}",
        reason_code: "privacy_review",
        storage_zone: manifest.storage_zone,
        privacy_classification: manifest.privacy_classification,
        claim_status_effect: "unchanged",
        source_id: manifest.data_source_id,
        review_required: true
      )
    end
  end
end
