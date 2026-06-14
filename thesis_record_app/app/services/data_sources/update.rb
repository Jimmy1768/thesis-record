module DataSources
  class Update
    def self.call!(data_source:, attributes:, actor:, reason_code: "source_registry_update")
      DataSource.transaction do
        data_source.update!(attributes)
        Audit::Recorder.record!(
          actor: actor,
          event_type: "source_registry_changed",
          entity: data_source,
          change_summary: "Updated data source #{data_source.name}",
          reason_code: reason_code,
          storage_zone: data_source.storage_zone,
          privacy_classification: data_source.privacy_classification,
          claim_status_effect: "unchanged",
          export_allowed: data_source.public_repo_allowed?
        )
        data_source
      end
    end
  end
end
