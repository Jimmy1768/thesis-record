module Operations
  class ProductionSummary
    Result = Data.define(
      :generated_at,
      :rails_env,
      :relative_url_root,
      :canonical_data_promotion_disabled,
      :health_checks,
      :health_passed,
      :table_counts,
      :latest_audit_event_at,
      :warnings
    )

    TABLE_MODELS = {
      data_sources: DataSource,
      source_access_paths: SourceAccessPath,
      intake_manifests: IntakeManifest,
      schema_versions: SchemaVersion,
      metric_definitions: MetricDefinition,
      metric_observations: MetricObservation,
      metric_quality_reviews: MetricQualityReview,
      susb_public_file_rows: SusbPublicFileRow,
      bfs_api_rows: BfsApiRow,
      bds_public_file_rows: BdsPublicFileRow,
      audit_events: AuditEvent,
      users: User,
      roles: Role
    }.freeze

    def self.call(env: ENV, redis_client: nil)
      new(env: env, redis_client: redis_client).call
    end

    def initialize(env:, redis_client:)
      @env = env
      @redis_client = redis_client
    end

    def call
      health_result = Operations::HealthCheck.call(redis_client: redis_client)
      table_counts = count_tables

      Result.new(
        generated_at: Time.current,
        rails_env: Rails.env.to_s,
        relative_url_root: env["RAILS_RELATIVE_URL_ROOT"],
        canonical_data_promotion_disabled: canonical_data_promotion_disabled?,
        health_checks: health_result.checks,
        health_passed: health_result.passed,
        table_counts: table_counts,
        latest_audit_event_at: AuditEvent.maximum(:occurred_at),
        warnings: warnings(table_counts, health_result)
      )
    end

    private

    attr_reader :env, :redis_client

    def count_tables
      TABLE_MODELS.transform_values(&:count)
    end

    def canonical_data_promotion_disabled?
      env.fetch("THESIS_RECORD_ALLOW_CANONICAL_DATA_PROMOTION", "false") != "true"
    end

    def warnings(table_counts, health_result)
      [].tap do |warnings|
        warnings << "health_checks_failed" unless health_result.passed
        warnings << "canonical_data_promotion_enabled" unless canonical_data_promotion_disabled?
        warnings << "no_production_users" if table_counts.fetch(:users).zero?
        warnings << "no_production_roles" if table_counts.fetch(:roles).zero?
      end
    end
  end
end
