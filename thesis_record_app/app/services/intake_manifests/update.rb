module IntakeManifests
  class Update
    def self.call!(intake_manifest:, attributes:, actor:, reason_code: "intake_manifest_update")
      IntakeManifest.transaction do
        intake_manifest.update!(attributes)
        Audit::Recorder.record!(
          actor: actor,
          event_type: "intake_manifest_changed",
          entity: intake_manifest,
          change_summary: "Updated intake manifest #{intake_manifest.name}",
          reason_code: reason_code,
          storage_zone: intake_manifest.storage_zone,
          privacy_classification: intake_manifest.privacy_classification,
          claim_status_effect: "unchanged",
          export_allowed: intake_manifest.public_repo_allowed?,
          source_id: intake_manifest.data_source_id
        )
        intake_manifest
      end
    end
  end
end
