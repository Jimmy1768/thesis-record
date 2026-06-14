require "yaml"

module Operations
  class V0BaselineSummary
    Result = Data.define(
      :generated_at,
      :thesis_slug,
      :baseline_manifest_present,
      :claim_set_present,
      :forecast_set_present,
      :timeline_present,
      :baseline_status,
      :claim_set_status,
      :claim_set_approval_status,
      :claim_count,
      :forecast_set_status,
      :forecast_set_approval_status,
      :forecast_count,
      :collection_plan_present,
      :table_counts,
      :source_coverage,
      :production_health_passed,
      :v0_readiness_passed,
      :v0_readiness_blockers,
      :warnings
    )

    THESIS_SLUG = "operator-node-economics"
    THESIS_ROOT = Rails.root.join("..", "theses", THESIS_SLUG).expand_path
    BASELINE_MANIFEST_PATH = THESIS_ROOT.join("evidence", "manifests", "v0_baseline_snapshot_2026-06-14.md")
    CLAIM_SET_PATH = THESIS_ROOT.join("publication", "v0_claim_set.yml")
    FORECAST_SET_PATH = THESIS_ROOT.join("publication", "v0_forecast_set.yml")
    TIMELINE_PATH = THESIS_ROOT.join("publication", "v0_timeline.yml")
    COLLECTION_PLAN_PATH = THESIS_ROOT.join("publication", "v0_collection_plan.yml")

    SOURCE_COVERAGE_TABLES = {
      susb_public_file_rows: "census_susb_public_file",
      bfs_api_rows: "census_bfs_api",
      bds_public_file_rows: "census_bds_public_file"
    }.freeze

    def self.call(production_summary: Operations::ProductionSummary.call,
                  v0_readiness: Operations::V0Readiness.call)
      new(production_summary: production_summary, v0_readiness: v0_readiness).call
    end

    def initialize(production_summary:, v0_readiness:)
      @production_summary = production_summary
      @v0_readiness = v0_readiness
    end

    def call
      claim_set = yaml_file(CLAIM_SET_PATH)
      forecast_set = yaml_file(FORECAST_SET_PATH)

      Result.new(
        generated_at: Time.current,
        thesis_slug: THESIS_SLUG,
        baseline_manifest_present: BASELINE_MANIFEST_PATH.exist?,
        claim_set_present: CLAIM_SET_PATH.exist?,
        forecast_set_present: FORECAST_SET_PATH.exist?,
        timeline_present: TIMELINE_PATH.exist?,
        baseline_status: baseline_status,
        claim_set_status: claim_set.fetch(:status, nil),
        claim_set_approval_status: claim_set.fetch(:approval_status, nil),
        claim_count: claim_set.fetch(:claims, []).count,
        forecast_set_status: forecast_set.fetch(:status, nil),
        forecast_set_approval_status: forecast_set.fetch(:approval_status, nil),
        forecast_count: forecast_set.fetch(:forecasts, []).count,
        collection_plan_present: COLLECTION_PLAN_PATH.exist?,
        table_counts: production_summary.table_counts,
        source_coverage: source_coverage,
        production_health_passed: production_summary.health_passed,
        v0_readiness_passed: v0_readiness.passed,
        v0_readiness_blockers: v0_readiness.blockers,
        warnings: warnings(claim_set, forecast_set)
      )
    end

    private

    attr_reader :production_summary, :v0_readiness

    def yaml_file(path)
      return {} unless path.exist?

      YAML.safe_load_file(path).deep_symbolize_keys
    end

    def baseline_status
      return nil unless BASELINE_MANIFEST_PATH.exist?

      status_line = BASELINE_MANIFEST_PATH.readlines.find { |line| line.start_with?("Status:") }
      status_line&.delete_prefix("Status:")&.strip&.delete_suffix(".")
    end

    def source_coverage
      SOURCE_COVERAGE_TABLES.each_with_object({}) do |(table_name, source_kind), coverage|
        coverage[source_kind] = production_summary.table_counts.fetch(table_name, 0).positive?
      end
    end

    def warnings(claim_set, forecast_set)
      [].tap do |warnings|
        warnings << "baseline_manifest_missing" unless BASELINE_MANIFEST_PATH.exist?
        warnings << "claim_set_unapproved" unless claim_set.fetch(:approval_status, nil) == "approved"
        warnings << "forecast_set_unapproved" unless forecast_set.fetch(:approval_status, nil) == "approved"
        warnings << "production_health_failed" unless production_summary.health_passed
        warnings << "v0_not_ready" unless v0_readiness.passed
      end
    end
  end
end
