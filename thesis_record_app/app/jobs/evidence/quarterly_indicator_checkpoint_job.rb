module Evidence
  class QuarterlyIndicatorCheckpointJob < ApplicationJob
    queue_as :maintenance

    def perform(as_of: Time.current)
      result = Evidence::QuarterlyIndicatorCheckpointCandidate.call(as_of: as_of)

      Audit::Recorder.record_system!(
        actor: self.class.name,
        event_type: "quarterly_checkpoint_requested",
        entity_type: "SchedulerCheckpoint",
        entity_id: "quarterly_indicator_checkpoint:#{result.current_period}",
        change_summary: change_summary(result),
        reason_code: "scheduled_quarterly_checkpoint_candidate"
      )
    end

    private

    def change_summary(result)
      [
        "Quarterly indicator checkpoint candidate recorded",
        "as_of=#{result.as_of.utc.iso8601}",
        "period=#{result.current_period}",
        "first_measurement_period=#{result.first_measurement_period || '(missing)'}",
        "measurement_index=#{result.measurement_index || '(not_started)'}",
        "status=#{result.candidate_status}",
        "checkpoint_ref=#{result.checkpoint_ref || '(none)'}",
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
