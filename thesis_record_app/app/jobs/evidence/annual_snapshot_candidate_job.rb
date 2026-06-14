module Evidence
  class AnnualSnapshotCandidateJob < ApplicationJob
    queue_as :maintenance

    def perform
      Audit::Recorder.record_system!(
        actor: self.class.name,
        event_type: "annual_snapshot_candidate_requested",
        entity_type: "SchedulerCheckpoint",
        entity_id: "annual_snapshot_candidate",
        change_summary: "Annual evidence snapshot candidate scaffold requested; no publication performed",
        reason_code: "scheduled_scaffold"
      )
    end
  end
end
