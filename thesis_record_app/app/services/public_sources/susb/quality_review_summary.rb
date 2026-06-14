module PublicSources
  module Susb
    class QualityReviewSummary
      Result = Data.define(
        :review_count,
        :review_status_counts,
        :source_metric_status_counts,
        :metric_key_counts,
        :policy_version_counts,
        :reviewable_observation_count,
        :unreviewed_observation_count,
        :guardrail_flag_counts,
        :prediction_link_count,
        :export_created_audit_event_count,
        :policy_check_passed,
        :policy_check_failures
      )

      HARD_FALSE_FLAGS = %w[
        ratios_computed
        trends_computed
        aggregation_computed
        exports_created
        claim_support_authorized
      ].freeze

      def self.call
        new.call
      end

      def call
        policy_check = PublicSources::Susb::QualityReviewPolicyCheck.call

        Result.new(
          review_count: review_scope.count,
          review_status_counts: sorted_counts(review_scope.group(:review_status).count),
          source_metric_status_counts: sorted_counts(review_scope.group(:source_metric_status).count),
          metric_key_counts: sorted_counts(review_scope.group("review_metadata ->> 'metric_key'").count),
          policy_version_counts: sorted_counts(review_scope.group(:policy_version).count),
          reviewable_observation_count: observation_scope.count,
          unreviewed_observation_count: unreviewed_observation_scope.count,
          guardrail_flag_counts: guardrail_flag_counts,
          prediction_link_count: prediction_link_count,
          export_created_audit_event_count: AuditEvent.where(event_type: "export_created").count,
          policy_check_passed: policy_check.passed,
          policy_check_failures: policy_check.failures
        )
      end

      private

      def review_scope
        return MetricQualityReview.none if susb_source_ids.empty?

        @review_scope ||= MetricQualityReview
                          .where(data_source_id: susb_source_ids)
                          .where("metric_quality_reviews.review_metadata ->> 'source_table' = ?", "susb_public_file_rows")
      end

      def observation_scope
        return MetricObservation.none if susb_source_ids.empty?

        @observation_scope ||= MetricObservation
                               .where(data_source_id: susb_source_ids)
                               .where(metric_status: status_mapping.keys.map(&:to_s))
                               .where("quality_metadata ->> 'source_table' = ?", "susb_public_file_rows")
      end

      def unreviewed_observation_scope
        observation_scope.left_joins(:metric_quality_review).where(metric_quality_reviews: { id: nil })
      end

      def prediction_link_count
        return 0 if susb_source_ids.empty?

        PredictionLink.where(data_source_id: susb_source_ids).count
      end

      def guardrail_flag_counts
        HARD_FALSE_FLAGS.index_with do |flag|
          review_scope.where("metric_quality_reviews.review_metadata ->> ? = ?", flag, "true").count
        end
      end

      def status_mapping
        @status_mapping ||= Rails.application.config_for(:thesis_record_policy)
                                 .deep_symbolize_keys
                                 .fetch(:public_ingestion_v1)
                                 .fetch(:susb_us_state_annual)
                                 .fetch(:quality_review_policy_v1)
                                 .fetch(:eligible_observation_statuses)
      end

      def sorted_counts(counts)
        counts.sort.to_h
      end

      def susb_source_ids
        @susb_source_ids ||= DataSource.where(source_kind: "census_susb_public_file").pluck(:id)
      end
    end
  end
end
