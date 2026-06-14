module PublicSources
  class SourceHealthSummary
    SourceResult = Data.define(
      :key,
      :name,
      :source_kind,
      :source_status,
      :claim_status_allowed,
      :source_row_count,
      :metric_definition_count,
      :metric_observation_count,
      :quality_review_count,
      :reviewable_observation_count,
      :unreviewed_observation_count,
      :prediction_link_count,
      :export_created_audit_event_count,
      :guardrail_flag_counts,
      :policy_check_passed,
      :policy_check_failures,
      :evidence_status
    )

    Result = Data.define(
      :sources,
      :total_source_rows,
      :total_metric_definitions,
      :total_metric_observations,
      :total_quality_reviews,
      :total_prediction_links,
      :total_export_created_audit_events,
      :all_policy_checks_passed,
      :overall_evidence_status
    )

    def self.call
      new.call
    end

    def call
      source_results = [
        bfs_result,
        susb_result,
        bds_result
      ]

      Result.new(
        sources: source_results,
        total_source_rows: source_results.sum(&:source_row_count),
        total_metric_definitions: source_results.sum(&:metric_definition_count),
        total_metric_observations: source_results.sum(&:metric_observation_count),
        total_quality_reviews: source_results.sum(&:quality_review_count),
        total_prediction_links: source_results.sum(&:prediction_link_count),
        total_export_created_audit_events: AuditEvent.where(event_type: "export_created").count,
        all_policy_checks_passed: source_results.all?(&:policy_check_passed),
        overall_evidence_status: overall_evidence_status(source_results)
      )
    end

    private

    def bfs_result
      source = DataSource.find_by(source_kind: "census_bfs_api", name: "Census BFS monthly API")
      source_id = source&.id
      policy_check = PublicSources::Bfs::QualityReviewPolicyCheck.call(inspect_observations: false)
      observation_counts = observation_counts_for(source_id, "bfs_api_rows")
      review_counts = review_counts_for(source_id, "bfs_api_rows", PublicSources::Bfs::QualityReviewSummary::HARD_FALSE_FLAGS)

      SourceResult.new(
        key: "bfs",
        name: source&.name || "Census BFS monthly API",
        source_kind: "census_bfs_api",
        source_status: source&.source_status || "missing_source",
        claim_status_allowed: source&.claim_status_allowed || "not_evidence",
        source_row_count: source_id ? BfsApiRow.where(data_source_id: source_id).count : 0,
        metric_definition_count: MetricDefinition.where("key LIKE ?", "bfs_%").count,
        metric_observation_count: observation_counts.fetch(:total),
        quality_review_count: review_counts.fetch(:total),
        reviewable_observation_count: observation_counts.fetch(:total),
        unreviewed_observation_count: observation_counts.fetch(:unreviewed),
        prediction_link_count: source_id ? PredictionLink.where(data_source_id: source_id).count : 0,
        export_created_audit_event_count: AuditEvent.where(event_type: "export_created").count,
        guardrail_flag_counts: review_counts.fetch(:guardrail_flags),
        policy_check_passed: policy_check.passed,
        policy_check_failures: policy_check.failures,
        evidence_status: "reviewed_context_only_not_claim_support"
      )
    end

    def susb_result
      source = DataSource.where(source_kind: "census_susb_public_file").order(updated_at: :desc).first
      source_id = source&.id
      policy_check = PublicSources::Susb::QualityReviewPolicyCheck.call(inspect_observations: false)
      observation_counts = observation_counts_for(source_id, "susb_public_file_rows")
      review_counts = review_counts_for(source_id, "susb_public_file_rows", PublicSources::Susb::QualityReviewSummary::HARD_FALSE_FLAGS)

      SourceResult.new(
        key: "susb",
        name: source&.name || "Census SUSB public file",
        source_kind: "census_susb_public_file",
        source_status: source&.source_status || "missing_source",
        claim_status_allowed: source&.claim_status_allowed || "context_only",
        source_row_count: source_id ? SusbPublicFileRow.where(data_source_id: source_id).count : 0,
        metric_definition_count: MetricDefinition.where("key LIKE ?", "susb_%").count,
        metric_observation_count: observation_counts.fetch(:total),
        quality_review_count: review_counts.fetch(:total),
        reviewable_observation_count: observation_counts.fetch(:total),
        unreviewed_observation_count: observation_counts.fetch(:unreviewed),
        prediction_link_count: source_id ? PredictionLink.where(data_source_id: source_id).count : 0,
        export_created_audit_event_count: AuditEvent.where(event_type: "export_created").count,
        guardrail_flag_counts: review_counts.fetch(:guardrail_flags),
        policy_check_passed: policy_check.passed,
        policy_check_failures: policy_check.failures,
        evidence_status: "reviewed_context_only_not_claim_support"
      )
    end

    def bds_result
      source = DataSource.where(source_kind: "census_bds_public_file").order(updated_at: :desc).first
      source_id = source&.id
      row_policy_check = PublicSources::Bds::RowLoadPolicyCheck.call
      review_policy_check = PublicSources::Bds::QualityReviewPolicyCheck.call(inspect_observations: false)
      observation_counts = observation_counts_for(source_id, "bds_public_file_rows")
      review_counts = review_counts_for(source_id, "bds_public_file_rows", PublicSources::Bds::QualityReviewSummary::HARD_FALSE_FLAGS)

      SourceResult.new(
        key: "bds",
        name: source&.name || "Census BDS public file",
        source_kind: "census_bds_public_file",
        source_status: source&.source_status || "missing_source",
        claim_status_allowed: source&.claim_status_allowed || "context_only",
        source_row_count: source_id ? BdsPublicFileRow.where(data_source_id: source_id).count : 0,
        metric_definition_count: MetricDefinition.where("key LIKE ?", "bds_%").count,
        metric_observation_count: observation_counts.fetch(:total),
        quality_review_count: review_counts.fetch(:total),
        reviewable_observation_count: observation_counts.fetch(:total),
        unreviewed_observation_count: observation_counts.fetch(:unreviewed),
        prediction_link_count: source_id ? PredictionLink.where(data_source_id: source_id).count : 0,
        export_created_audit_event_count: AuditEvent.where(event_type: "export_created").count,
        guardrail_flag_counts: review_counts.fetch(:guardrail_flags),
        policy_check_passed: row_policy_check.passed && review_policy_check.passed,
        policy_check_failures: row_policy_check.failures + review_policy_check.failures,
        evidence_status: bds_evidence_status(observation_counts)
      )
    end

    def bds_evidence_status(observation_counts)
      return "source_rows_loaded_context_only_not_claim_support" if observation_counts.fetch(:total).zero?
      return "reviewed_context_only_not_claim_support" if observation_counts.fetch(:unreviewed).zero?

      "source_native_observations_unreviewed_context_only"
    end

    def observation_counts_for(source_id, source_table)
      return { total: 0, unreviewed: 0 } if source_id.nil?

      row = ActiveRecord::Base.connection.select_one(
        ActiveRecord::Base.sanitize_sql_array(
          [
            <<~SQL.squish,
              SELECT
                COUNT(*) AS total,
                SUM(CASE WHEN metric_quality_reviews.id IS NULL THEN 1 ELSE 0 END) AS unreviewed
              FROM metric_observations
              LEFT OUTER JOIN metric_quality_reviews
                ON metric_quality_reviews.metric_observation_id = metric_observations.id
              WHERE metric_observations.data_source_id = ?
                AND metric_observations.quality_metadata ->> 'source_table' = ?
            SQL
            source_id,
            source_table
          ]
        )
      )
      { total: row.fetch("total").to_i, unreviewed: row.fetch("unreviewed").to_i }
    end

    def review_counts_for(source_id, source_table, flags)
      return { total: 0, guardrail_flags: flags.index_with { 0 } } if source_id.nil?

      flag_selects = flags.map do |flag|
        quoted_flag = ActiveRecord::Base.connection.quote(flag)
        "SUM(CASE WHEN review_metadata ->> #{quoted_flag} = 'true' THEN 1 ELSE 0 END) AS #{flag}"
      end
      sql = ActiveRecord::Base.sanitize_sql_array(
        [
          <<~SQL.squish,
            SELECT COUNT(*) AS total, #{flag_selects.join(", ")}
            FROM metric_quality_reviews
            WHERE data_source_id = ?
              AND review_metadata ->> 'source_table' = ?
          SQL
          source_id,
          source_table
        ]
      )
      row = ActiveRecord::Base.connection.select_one(sql)
      {
        total: row.fetch("total").to_i,
        guardrail_flags: flags.index_with { |flag| row.fetch(flag).to_i }
      }
    end

    def overall_evidence_status(source_results)
      return "blocked_policy_check_failure" unless source_results.all?(&:policy_check_passed)
      return "blocked_prediction_links_present" if source_results.any? { |source| source.prediction_link_count.positive? }

      "context_only_no_claim_links"
    end
  end
end
