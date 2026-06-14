require "test_helper"

class Operations::V0BaselineSummaryTest < ActiveSupport::TestCase
  FakeProductionSummary = Data.define(:table_counts, :health_passed)
  FakeV0Readiness = Data.define(:passed, :blockers)

  test "summarizes v0 baseline files, source coverage, and approval blockers" do
    production_summary = FakeProductionSummary.new(
      table_counts: {
        data_sources: 3,
        metric_definitions: 21,
        metric_observations: 1_179_605,
        metric_quality_reviews: 1_179_605,
        susb_public_file_rows: 570_105,
        bfs_api_rows: 1_368,
        bds_public_file_rows: 104_880
      },
      health_passed: true
    )
    v0_readiness = FakeV0Readiness.new(
      passed: false,
      blockers: %w[v0_publication_approved v0_claim_set_approved v0_forecast_set_approved]
    )

    summary = Operations::V0BaselineSummary.call(
      production_summary: production_summary,
      v0_readiness: v0_readiness
    )

    assert_equal "operator-node-economics", summary.thesis_slug
    assert summary.baseline_manifest_present
    assert_equal "accepted internal v0 baseline", summary.baseline_status
    assert summary.claim_set_present
    assert_equal "candidate_inventory", summary.claim_set_status
    assert_equal "unapproved", summary.claim_set_approval_status
    assert_equal 15, summary.claim_count
    assert summary.forecast_set_present
    assert_equal "candidate_inventory", summary.forecast_set_status
    assert_equal "unapproved", summary.forecast_set_approval_status
    assert_equal 12, summary.forecast_count
    assert summary.collection_plan_present
    assert summary.timeline_present
    assert summary.source_coverage.fetch("census_susb_public_file")
    assert summary.source_coverage.fetch("census_bfs_api")
    assert summary.source_coverage.fetch("census_bds_public_file")
    assert summary.production_health_passed
    assert_not summary.v0_readiness_passed
    assert_includes summary.v0_readiness_blockers, "v0_publication_approved"
    assert_includes summary.warnings, "claim_set_unapproved"
    assert_includes summary.warnings, "forecast_set_unapproved"
    assert_includes summary.warnings, "v0_not_ready"
  end

  test "reports missing source coverage from table counts" do
    production_summary = FakeProductionSummary.new(
      table_counts: {
        susb_public_file_rows: 1,
        bfs_api_rows: 0,
        bds_public_file_rows: 0
      },
      health_passed: true
    )
    v0_readiness = FakeV0Readiness.new(passed: false, blockers: [])

    summary = Operations::V0BaselineSummary.call(
      production_summary: production_summary,
      v0_readiness: v0_readiness
    )

    assert summary.source_coverage.fetch("census_susb_public_file")
    assert_not summary.source_coverage.fetch("census_bfs_api")
    assert_not summary.source_coverage.fetch("census_bds_public_file")
  end
end
