module PublicSources
  module Bfs
    class MetricDefinitionScaffold
      class ScaffoldError < StandardError; end

      Result = Data.define(
        :definitions,
        :metric_definitions_created,
        :metric_observations_created,
        :prediction_links_created,
        :exports_created
      )

      def self.call!(actor:)
        new(actor: actor).call!
      end

      def initialize(actor:)
        @actor = actor
        @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
        @bfs_policy = @policy.fetch(:public_ingestion_v1).fetch(:bfs_monthly_api)
        @scaffold = @bfs_policy.fetch(:metric_definition_scaffold_v1)
      end

      def call!
        ensure_scaffold_allowed!
        before_counts = guardrail_counts
        definitions = upsert_definitions!
        after_counts = guardrail_counts
        validate_guardrails!(before_counts, after_counts)

        Result.new(
          definitions: definitions,
          metric_definitions_created: after_counts.fetch(:metric_definitions) - before_counts.fetch(:metric_definitions),
          metric_observations_created: after_counts.fetch(:metric_observations) - before_counts.fetch(:metric_observations),
          prediction_links_created: after_counts.fetch(:prediction_links) - before_counts.fetch(:prediction_links),
          exports_created: after_counts.fetch(:exports) - before_counts.fetch(:exports)
        )
      end

      private

      attr_reader :actor, :bfs_policy, :scaffold

      def ensure_scaffold_allowed!
        design_result = PublicSources::Bfs::MetricComputationDesignCheck.call(require_no_bfs_observations: true)
        raise ScaffoldError, design_result.failures.join("; ") unless design_result.passed
        raise ScaffoldError, "metric definition scaffold status is not authorized" unless scaffold.fetch(:status) == "definition_scaffold_authorized"
        raise ScaffoldError, "metric definitions not authorized" unless scaffold.fetch(:metric_definitions_authorized) == true

        %i[metric_observations_authorized quality_reviews_authorized exports_authorized prediction_links_authorized].each do |flag|
          raise ScaffoldError, "#{flag} must remain false" unless scaffold.fetch(flag) == false
        end
      end

      def upsert_definitions!
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

      def metric_definitions
        bfs_policy.fetch(:metric_definitions)
      end

      def guarded_limitations(limitations)
        [
          limitations,
          "Scaffold only: no MetricObservation rows, quality reviews, prediction links, exports, claim support, aggregation, trend analysis, or thesis interpretation is authorized."
        ].join(" ")
      end

      def record_audit!(definition)
        Audit::Recorder.record!(
          actor: actor,
          event_type: "metric_definition_changed",
          entity: definition,
          change_summary: "Scaffolded draft-disabled BFS metric definition #{definition.key}",
          reason_code: "bfs_metric_definition_scaffold",
          storage_zone: "production_postgresql",
          privacy_classification: "public",
          claim_status_effect: scaffold.fetch(:claim_status_effect)
        )
      end

      def validate_guardrails!(before_counts, after_counts)
        %i[metric_observations prediction_links exports].each do |key|
          next if before_counts.fetch(key) == after_counts.fetch(key)

          raise ScaffoldError, "BFS metric definition scaffold changed #{key}"
        end
      end

      def guardrail_counts
        {
          metric_definitions: MetricDefinition.where("key LIKE ?", "bfs_%").count,
          metric_observations: MetricObservation.joins(:data_source).where(data_sources: { source_kind: bfs_policy.fetch(:source_kind) }).count,
          prediction_links: PredictionLink.joins(metric_observation: :data_source).where(data_sources: { source_kind: bfs_policy.fetch(:source_kind) }).count,
          exports: AuditEvent.where(event_type: "export_created").count
        }
      end
    end
  end
end
