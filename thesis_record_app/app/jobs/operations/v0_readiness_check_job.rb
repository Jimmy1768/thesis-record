module Operations
  class V0ReadinessCheckJob < ApplicationJob
    queue_as :maintenance

    def perform
      result = V0Readiness.call

      Audit::Recorder.record_system!(
        actor: self.class.name,
        event_type: "v0_readiness_checked",
        entity_type: "OperationsCheck",
        entity_id: "operator_nodes_v0",
        change_summary: "Read-only v0 readiness check completed; passed=#{result.passed}; blockers=#{result.blockers.join(",")}",
        reason_code: "scheduled_read_only_check"
      )
    end
  end
end
