module Operations
  class OperatorStatusSummary
    EventSummary = Data.define(:event_type, :event_id, :occurred_at, :reason_code, :entity_id, :change_summary)
    Result = Data.define(:generated_at, :latest_events, :table_counts, :warnings)

    EVENT_TYPES = {
      source_release_check: "source_release_check_completed",
      quarterly_checkpoint: "quarterly_checkpoint_requested",
      annual_snapshot: "annual_snapshot_candidate_requested",
      production_summary: "production_summary_checked",
      v0_readiness: "v0_readiness_checked"
    }.freeze

    TABLE_MODELS = {
      audit_events: AuditEvent,
      source_rows_susb: SusbPublicFileRow,
      source_rows_bfs: BfsApiRow,
      source_rows_bds: BdsPublicFileRow,
      metric_observations: MetricObservation,
      metric_quality_reviews: MetricQualityReview,
      prediction_links: PredictionLink,
      claim_reviews: ClaimReview,
      export_artifacts: ExportArtifact,
      evidence_snapshots: EvidenceSnapshot,
      failure_records: FailureRecord
    }.freeze

    def self.call
      new.call
    end

    def call
      latest_events = EVENT_TYPES.transform_values { |event_type| summarize_event(event_type) }

      Result.new(
        generated_at: Time.current,
        latest_events: latest_events,
        table_counts: TABLE_MODELS.transform_values(&:count),
        warnings: warnings(latest_events)
      )
    end

    private

    def summarize_event(event_type)
      event = AuditEvent.where(event_type: event_type).order(occurred_at: :desc, id: :desc).first
      return nil unless event

      EventSummary.new(
        event_type: event.event_type,
        event_id: event.id,
        occurred_at: event.occurred_at,
        reason_code: event.reason_code,
        entity_id: event.entity_id,
        change_summary: event.change_summary
      )
    end

    def warnings(latest_events)
      latest_events.filter_map do |name, event|
        "missing_#{name}_event" if event.nil?
      end
    end
  end
end
