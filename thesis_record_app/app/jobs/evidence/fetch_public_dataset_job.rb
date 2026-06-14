module Evidence
  class FetchPublicDatasetJob < ApplicationJob
    queue_as :evidence_collection

    def perform(data_source_id)
      data_source = DataSource.find(data_source_id)
      Audit::Recorder.record!(
        actor: self.class.name,
        event_type: "collection_started",
        entity: data_source,
        change_summary: "Public dataset fetch requested for #{data_source.name}",
        reason_code: "new_source",
        storage_zone: data_source.storage_zone,
        privacy_classification: data_source.privacy_classification,
        claim_status_effect: "unchanged",
        source_id: data_source.id
      )
    end
  end
end
