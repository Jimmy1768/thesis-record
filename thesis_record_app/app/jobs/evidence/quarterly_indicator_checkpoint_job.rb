module Evidence
  class QuarterlyIndicatorCheckpointJob < ApplicationJob
    queue_as :maintenance

    def perform
      Audit::Recorder.record_system!(
        actor: self.class.name,
        event_type: "quarterly_checkpoint_requested",
        entity_type: "SchedulerCheckpoint",
        entity_id: "quarterly_indicator_checkpoint",
        change_summary: "Quarterly indicator checkpoint scaffold requested; no analysis performed",
        reason_code: "scheduled_scaffold"
      )
    end
  end
end
