module IntakeManifests
  class Create
    def self.call!(data_source:, attributes:, actor:, reason_code: "intake_manifest_created")
      IntakeManifest.transaction do
        manifest = data_source.intake_manifests.create!(attributes)
        Audit::Recorder.record!(
          actor: actor,
          event_type: "intake_manifest_created",
          entity: manifest,
          change_summary: "Created intake manifest #{manifest.name} for #{data_source.name}",
          reason_code: reason_code,
          storage_zone: manifest.storage_zone,
          privacy_classification: manifest.privacy_classification,
          claim_status_effect: "unchanged",
          export_allowed: manifest.public_repo_allowed?,
          source_id: data_source.id
        )
        manifest
      end
    end
  end
end
