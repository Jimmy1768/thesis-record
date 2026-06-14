module PublicSources
  module Susb
    class MetricDefinitionScaffold
      def self.call!(actor:)
        new(actor: actor).call!
      end

      def initialize(actor:)
        @actor = actor
        @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
        @susb_policy = @policy.fetch(:public_ingestion_v1).fetch(:susb_us_state_annual)
      end

      def call!
        MetricDefinition.transaction do
          metric_definitions.map do |key, attributes|
            definition = MetricDefinition.find_or_initialize_by(key: key.to_s)
            definition.assign_attributes(
              name: attributes.fetch(:name),
              formula_status: attributes.fetch(:formula_status),
              formula: attributes.fetch(:formula),
              limitations: guarded_limitations(attributes.fetch(:limitations))
            )
            definition.save!
            record_audit!(definition)
            definition
          end
        end
      end

      private

      attr_reader :actor, :susb_policy

      def metric_definitions
        susb_policy.fetch(:metric_definitions)
      end

      def guarded_limitations(limitations)
        [
          limitations,
          "Scaffold only: no MetricObservation rows, computation, aggregation, claim linkage, or thesis interpretation is authorized."
        ].join(" ")
      end

      def record_audit!(definition)
        Audit::Recorder.record!(
          actor: actor,
          event_type: "metric_definition_changed",
          entity: definition,
          change_summary: "Scaffolded draft-disabled SUSB metric definition #{definition.key}",
          reason_code: "susb_metric_definition_scaffold",
          storage_zone: "production_postgresql",
          privacy_classification: "public",
          claim_status_effect: "unchanged"
        )
      end
    end
  end
end
