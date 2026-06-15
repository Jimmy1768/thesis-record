require "test_helper"

class Operations::V0CanonicalCollectionPreflightTest < ActiveSupport::TestCase
  setup do
    @tmpdir = Pathname(Dir.mktmpdir)
    @manifest_root = @tmpdir.join("theses/operator-node-economics/evidence/manifests")
    FileUtils.mkdir_p(@manifest_root)
    @manifest_path = @manifest_root.join("v0_canonical_collection_bfs_test.yml")
    write_manifest(valid_manifest)
  end

  teardown do
    FileUtils.remove_entry(@tmpdir) if @tmpdir&.exist?
  end

  test "passes for a fully gated one-source production manifest" do
    result = call_preflight

    assert result.passed
    assert_empty result.blockers
    assert_equal "census_bfs_api", result.source_kind
    assert result.checks.fetch(:env_gate_enabled)
    assert result.checks.fetch(:rails_env_production)
    assert result.checks.fetch(:manifest_status_ready)
    assert result.checks.fetch(:source_unique_index_present)
    assert result.checks.fetch(:expected_count_delta_reconciles)
    assert result.checks.fetch(:protected_row_deltas_zero)
    assert result.checks.fetch(:no_claim_or_publication_effects)
    assert_includes result.warnings, "canonical_collection_gate_enabled"
  end

  test "fails closed without the explicit collection env gate" do
    result = call_preflight(env: {})

    assert_not result.passed
    assert_includes result.blockers, "env_gate_enabled"
  end

  test "fails outside production" do
    result = call_preflight(rails_env: "development")

    assert_not result.passed
    assert_includes result.blockers, "rails_env_production"
  end

  test "fails when manifest is a draft template" do
    write_manifest(valid_manifest.merge(status: "draft_template"))

    result = call_preflight

    assert_not result.passed
    assert_includes result.blockers, "manifest_status_ready"
    assert_includes result.warnings, "manifest_status_not_ready"
  end

  test "fails when source-specific required env is missing" do
    result = call_preflight(env: valid_env.except("CENSUS_API_KEY"))

    assert_not result.passed
    assert_includes result.blockers, "required_env_present"
  end

  test "fails when the backup record is incomplete" do
    manifest = valid_manifest
    manifest[:pre_collection_backup][:completed] = false
    manifest[:pre_collection_backup][:sha256] = "pending"
    write_manifest(manifest)

    result = call_preflight

    assert_not result.passed
    assert_includes result.blockers, "backup_completed"
    assert_includes result.blockers, "backup_sha256_present"
  end

  test "fails when expected row delta does not reconcile" do
    manifest = valid_manifest
    manifest[:expected_counts][:source_rows_after] = 13
    write_manifest(manifest)

    result = call_preflight

    assert_not result.passed
    assert_includes result.blockers, "expected_count_delta_reconciles"
  end

  test "fails when protected rows would change" do
    manifest = valid_manifest
    manifest[:expected_counts][:protected_row_deltas][:claim_reviews] = 1
    write_manifest(manifest)

    result = call_preflight

    assert_not result.passed
    assert_includes result.blockers, "protected_row_deltas_zero"
  end

  test "production source writes are blocked when preflight is absent" do
    error = assert_raises Operations::V0CanonicalCollectionPreflight::PreflightError do
      Operations::V0CanonicalCollectionPreflight.enforce_source_write_allowed!(
        source_kind: "census_bfs_api",
        env: {},
        rails_env: "production"
      )
    end

    assert_includes error.message, "env_gate_enabled"
  end

  test "non-production source writes remain available for rehearsal" do
    assert Operations::V0CanonicalCollectionPreflight.enforce_source_write_allowed!(
      source_kind: "census_bfs_api",
      env: {},
      rails_env: "test"
    )
  end

  private

  def call_preflight(env: valid_env, rails_env: "production")
    Operations::V0CanonicalCollectionPreflight.call(
      env: env,
      rails_env: rails_env,
      manifest_path: @manifest_path,
      manifest_root: @manifest_root
    )
  end

  def valid_env
    {
      Operations::V0CanonicalCollectionPreflight::COLLECTION_ENV_GATE => "true",
      "CENSUS_API_KEY" => "test-key"
    }
  end

  def write_manifest(manifest)
    File.write(@manifest_path, manifest.deep_stringify_keys.to_yaml)
  end

  def valid_manifest
    {
      version: "v0_canonical_collection_manifest_v1",
      status: "ready_for_canonical_ingestion",
      thesis_slug: "operator-node-economics",
      run_mode: "canonical_ingestion_candidate",
      source_kind: "census_bfs_api",
      source_table: "bfs_api_rows",
      natural_key: %w[
        data_source_id
        period_month
        data_type_code
        category_code
        seasonally_adj
        geography_level
        geography_code
      ],
      idempotency_strategy: "upsert_all_unique_index",
      operator_approval: {
        approval_status: "approved",
        approved_by: "test_operator",
        approved_at_utc: "2026-06-15T00:00:00Z"
      },
      required_env: %w[
        CENSUS_API_KEY
      ],
      pre_collection_backup: {
        completed: true,
        path: "/var/backups/thesis-record/thesis-record/test.dump",
        sha256: "a" * 64,
        completed_at_utc: "2026-06-15T00:05:00Z"
      },
      restore_or_integrity_check: {
        completed: true,
        check_kind: "backup_integrity_check",
        completed_at_utc: "2026-06-15T00:10:00Z"
      },
      expected_counts: {
        source_rows_before: 10,
        source_rows_after: 12,
        source_row_count_delta: 2,
        duplicate_natural_key_count_after: 0,
        protected_row_deltas: {
          metric_definitions: 0,
          metric_observations: 0,
          metric_quality_reviews: 0,
          prediction_links: 0,
          claim_reviews: 0,
          export_artifacts: 0
        }
      },
      authorized_effects: {
        source_row_writes: true,
        metric_computation: false,
        quality_review_creation: false,
        prediction_link_creation: false,
        claim_review_creation: false,
        export_creation: false,
        paper_prose_change: false,
        publication: false,
        thesis_verdict: false
      },
      post_collection_required_checks: %w[
        production_summary
        v0_baseline_summary
        v0_readiness
      ],
      prohibited_effects: %w[
        claim_status_change
        prediction_link_creation
        claim_review_creation
        export_creation
        paper_prose_change
        thesis_verdict
        publication
      ]
    }
  end
end
