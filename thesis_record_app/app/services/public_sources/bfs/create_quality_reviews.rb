module PublicSources
  module Bfs
    class CreateQualityReviews
      class ReviewError < StandardError; end

      Result = Data.define(
        :observations_reviewed,
        :reviews_upserted,
        :status_counts,
        :prediction_links_created,
        :exports_created
      )

      BATCH_SIZE = 5_000
      POLICY_VERSION = "bfs_quality_review_policy_v1"

      def self.call!(actor:)
        new(actor: actor).call!
      end

      def initialize(actor:)
        @actor = actor
        @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
        @bfs_policy = @policy.fetch(:public_ingestion_v1).fetch(:bfs_monthly_api)
        @review_policy = @bfs_policy.fetch(:quality_review_policy_v1)
      end

      def call!
        ensure_review_policy_allowed!
        before_counts = guardrail_counts
        counters = create_reviews!
        record_audit!(counters)
        after_counts = guardrail_counts
        validate_guardrails!(before_counts, after_counts)

        Result.new(
          observations_reviewed: counters.fetch(:observations_reviewed),
          reviews_upserted: counters.fetch(:reviews_upserted),
          status_counts: counters.fetch(:status_counts),
          prediction_links_created: after_counts.fetch(:prediction_links) - before_counts.fetch(:prediction_links),
          exports_created: after_counts.fetch(:exports) - before_counts.fetch(:exports)
        )
      end

      private

      attr_reader :actor, :bfs_policy, :review_policy

      def ensure_review_policy_allowed!
        result = PublicSources::Bfs::QualityReviewPolicyCheck.call
        raise ReviewError, result.failures.join("; ") unless result.passed
      end

      def create_reviews!
        counters = {
          observations_reviewed: 0,
          reviews_upserted: 0,
          status_counts: Hash.new(0)
        }

        observation_scope.find_each(batch_size: BATCH_SIZE).each_slice(BATCH_SIZE) do |observations|
          rows = observations.map { |observation| review_attributes_for(observation) }
          MetricQualityReview.upsert_all(rows, unique_by: "index_metric_quality_reviews_on_observation") if rows.any?
          counters[:observations_reviewed] += observations.size
          counters[:reviews_upserted] += rows.size
          rows.each { |row| counters.fetch(:status_counts)[row.fetch(:review_status)] += 1 }
        end

        counters
      end

      def observation_scope
        MetricObservation
          .joins(:data_source)
          .where(data_sources: { source_kind: bfs_policy.fetch(:source_kind) })
          .where(metric_status: status_mapping.keys.map(&:to_s))
          .where("quality_metadata ->> 'source_table' = ?", "bfs_api_rows")
          .order(:id)
      end

      def review_attributes_for(observation)
        timestamp = Time.current
        review_status = status_mapping.fetch(observation.metric_status.to_sym)
        {
          metric_observation_id: observation.id,
          data_source_id: observation.data_source_id,
          policy_version: POLICY_VERSION,
          source_metric_status: observation.metric_status,
          review_status: review_status,
          review_reason_code: review_reason_code_for(observation.metric_status),
          reviewed_by: actor,
          reviewed_at: timestamp,
          review_metadata: review_metadata_for(observation, review_status),
          created_at: timestamp,
          updated_at: timestamp
        }
      end

      def review_reason_code_for(metric_status)
        case metric_status
        when "staged_context"
          "source_native_context_verified"
        else
          "unsupported_metric_status"
        end
      end

      def review_metadata_for(observation, review_status)
        source_metadata = observation.quality_metadata
        {
          policy_status: review_policy.fetch(:status),
          metric_key: source_metadata.fetch("metric_key"),
          source_table: source_metadata.fetch("source_table"),
          source_row_id: source_metadata.fetch("source_row_id"),
          source_row_hash: source_metadata.fetch("source_row_hash"),
          source_cell_value_raw: source_metadata.fetch("source_cell_value_raw"),
          source_error_data: source_metadata.fetch("source_error_data"),
          source_metric_status: observation.metric_status,
          review_status: review_status,
          claim_status_effect: "unchanged",
          ratios_computed: false,
          trends_computed: false,
          aggregation_computed: false,
          exports_created: false,
          prediction_links_created: false,
          claim_support_authorized: false,
          guardrail: "Quality review preserves BFS source-native context only; no export, prediction link, claim support, AI, Operator Node, nonemployer conversion, trend, ratio, or aggregation authorization."
        }
      end

      def status_mapping
        @status_mapping ||= review_policy.fetch(:eligible_observation_statuses)
      end

      def record_audit!(counters)
        Audit::Recorder.record_system!(
          actor: actor,
          event_type: "review_approved",
          entity_type: "MetricQualityReview",
          entity_id: POLICY_VERSION,
          change_summary: "Upserted #{counters.fetch(:reviews_upserted)} BFS metric quality reviews",
          reason_code: "bfs_quality_review_creation",
          claim_status_effect: "unchanged",
          export_allowed: false
        )
      end

      def validate_guardrails!(before_counts, after_counts)
        %i[prediction_links exports].each do |key|
          next if before_counts.fetch(key) == after_counts.fetch(key)

          raise ReviewError, "BFS quality review creation changed #{key}"
        end
      end

      def guardrail_counts
        {
          prediction_links: PredictionLink.joins(metric_observation: :data_source).where(data_sources: { source_kind: bfs_policy.fetch(:source_kind) }).count,
          exports: AuditEvent.where(event_type: "export_created").count
        }
      end
    end
  end
end
