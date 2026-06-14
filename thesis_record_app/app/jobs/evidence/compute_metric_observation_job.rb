module Evidence
  class ComputeMetricObservationJob < ApplicationJob
    queue_as :metrics

    def perform(metric_definition_id)
      definition = MetricDefinition.find(metric_definition_id)
      Audit::Recorder.record!(
        actor: self.class.name,
        event_type: "metric_observation_created",
        entity: definition,
        change_summary: "Metric computation requested for #{definition.key}",
        reason_code: "new_metric_observation",
        storage_zone: "production_postgresql",
        privacy_classification: "internal",
        claim_status_effect: "unchanged",
        review_required: true
      )
    end
  end
end
