require "test_helper"

class PublicSources::Bds::PublicFileScaffoldTest < ActiveSupport::TestCase
  setup do
    @operator = create_operator_user
  end

  test "registers BDS public-file metadata scaffold without fetching data" do
    assert_difference -> { DataSource.count }, 1 do
      assert_difference -> { SourceAccessPath.count }, 1 do
        assert_difference -> { IntakeManifest.count }, 1 do
          assert_difference -> { SchemaVersion.count }, 1 do
            @result = PublicSources::Bds::PublicFileScaffold.call!(actor: @operator)
          end
        end
      end
    end

    source = @result.fetch(:data_source)
    access_path = @result.fetch(:source_access_path)
    manifest = @result.fetch(:intake_manifest)
    schema = @result.fetch(:schema_version)

    assert_equal "census_bds_public_file", source.source_kind
    assert_equal "ingestion_scaffold_ready", source.source_status
    assert_equal "context_only", source.claim_status_allowed
    assert_equal "employer_dynamics_context_only", source.metadata.fetch("evidence_class")
    assert_equal "national", source.metadata.fetch("geography_grain")
    assert_equal "sector", source.metadata.fetch("industry_grain")
    assert_equal "official_public_file_metadata", access_path.access_type
    assert_equal "verified_metadata_only_not_fetched", access_path.status
    assert_not manifest.metadata.fetch("raw_file_fetched")
    assert_not manifest.metadata.fetch("data_rows_authorized")
    assert_not manifest.metadata.fetch("metric_observations_authorized")
    assert_not manifest.metadata.fetch("analysis_authorized")
    assert_not manifest.metadata.fetch("prediction_links_authorized")
    assert_equal "verified_public_file_metadata_scaffold", schema.schema_status
    assert_includes schema.schema.fetch("required_columns"), "firmdeath_firms"
    assert_equal %w[year sector fage fsize], schema.schema.fetch("row_grain")
    assert_equal "blocked_no_management_layer_fields", schema.schema.fetch("compatibility_status").fetch("tce_p005")
    assert_includes schema.schema.fetch("unresolved_paths"), "api_bdsfagefsize_multiyear"
    assert_includes schema.schema.fetch("prohibited_use"), "claim_support"
  end

  test "records audit events with unchanged claim status effect" do
    assert_difference -> { AuditEvent.where(claim_status_effect: "unchanged").count }, 4 do
      PublicSources::Bds::PublicFileScaffold.call!(actor: @operator)
    end
  end

  test "is idempotent when scaffold already exists" do
    PublicSources::Bds::PublicFileScaffold.call!(actor: @operator)

    assert_no_difference -> { DataSource.count } do
      assert_no_difference -> { SourceAccessPath.count } do
        assert_no_difference -> { IntakeManifest.count } do
          assert_no_difference -> { SchemaVersion.count } do
            PublicSources::Bds::PublicFileScaffold.call!(actor: @operator)
          end
        end
      end
    end
  end
end
