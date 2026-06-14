module Evidence
  class SourceReleaseCheckJob < ApplicationJob
    queue_as :maintenance

    def perform
      Audit::Recorder.record_system!(
        actor: self.class.name,
        event_type: "source_release_check_requested",
        entity_type: "SchedulerCheckpoint",
        entity_id: "source_release_check",
        change_summary: "Source-release check scaffold requested; no ingestion performed",
        reason_code: "scheduled_scaffold"
      )
    end
  end
end
