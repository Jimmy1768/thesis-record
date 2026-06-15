module Evidence
  class AnnualSnapshotCandidateJob < ApplicationJob
    queue_as :maintenance

    def perform(as_of: Time.current)
      result = Evidence::AnnualSnapshotCandidate.call(as_of: as_of)

      Audit::Recorder.record_system!(
        actor: self.class.name,
        event_type: "annual_snapshot_candidate_requested",
        entity_type: "SchedulerCheckpoint",
        entity_id: "annual_snapshot_candidate:#{result.snapshot_period}",
        change_summary: change_summary(result),
        reason_code: "scheduled_annual_snapshot_candidate"
      )
    end

    private

    def change_summary(result)
      [
        "Annual evidence snapshot candidate recorded",
        "as_of=#{result.as_of.utc.iso8601}",
        "current_period=#{result.current_period}",
        "snapshot_period=#{result.snapshot_period}",
        "first_snapshot_period=#{result.first_snapshot_period || '(missing)'}",
        "snapshot_index=#{result.snapshot_index || '(not_applicable)'}",
        "status=#{result.candidate_status}",
        "forecast_count=#{result.forecast_count}",
        "source_rows=#{format_counts(result.source_row_counts)}",
        "protected_counts=#{format_counts(result.protected_counts)}",
        "warnings=#{result.warnings.empty? ? '(none)' : result.warnings.join('|')}",
        "effects=#{result.effects.join(',')}"
      ].join("; ")
    end

    def format_counts(counts)
      counts.map { |name, count| "#{name}=#{count}" }.join(",")
    end
  end
end
