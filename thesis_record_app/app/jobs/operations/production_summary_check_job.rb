module Operations
  class ProductionSummaryCheckJob < ApplicationJob
    queue_as :maintenance

    def perform
      summary = ProductionSummary.call

      Audit::Recorder.record_system!(
        actor: self.class.name,
        event_type: "production_summary_checked",
        entity_type: "OperationsCheck",
        entity_id: "production_summary",
        change_summary: "Read-only production summary check completed; health_passed=#{summary.health_passed}",
        reason_code: "scheduled_read_only_check"
      )
    end
  end
end
