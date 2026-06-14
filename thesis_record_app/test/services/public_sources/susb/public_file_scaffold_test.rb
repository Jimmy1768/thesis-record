require "test_helper"

class PublicSources::Susb::PublicFileScaffoldTest < ActiveSupport::TestCase
  setup do
    @operator = create_operator_user
  end

  test "registers SUSB public-file scaffold without fetching raw data" do
    assert_difference -> { DataSource.count }, 1 do
      assert_difference -> { SourceAccessPath.count }, 1 do
        assert_difference -> { IntakeManifest.count }, 1 do
          assert_difference -> { SchemaVersion.count }, 1 do
            @result = PublicSources::Susb::PublicFileScaffold.call!(actor: @operator)
          end
        end
      end
    end

    source = @result.fetch(:data_source)
    manifest = @result.fetch(:intake_manifest)
    schema = @result.fetch(:schema_version)

    assert_equal "census_susb_public_file", source.source_kind
    assert_equal "ingestion_scaffold_ready", source.source_status
    assert_equal "context_only", source.claim_status_allowed
    assert_equal "public", source.privacy_classification
    assert source.public_repo_allowed?
    assert_not manifest.metadata.fetch("raw_file_fetched")
    assert_not manifest.metadata.fetch("metrics_authorized")
    assert_equal %w[STATE NAICS ENTRSIZE], schema.schema.fetch("row_grain")
  end

  test "records audit events without claim status effect" do
    assert_difference -> { AuditEvent.where(claim_status_effect: "unchanged").count }, 4 do
      PublicSources::Susb::PublicFileScaffold.call!(actor: @operator)
    end
  end

  test "carries requested year into source url and local path" do
    result = PublicSources::Susb::PublicFileScaffold.call!(actor: @operator, year: 2021)

    access_path = result.fetch(:source_access_path)
    manifest = result.fetch(:intake_manifest)

    assert_includes access_path.uri_or_reference, "/2021/"
    assert_includes access_path.uri_or_reference, "_2021.txt"
    assert_equal "data/raw/susb/2021/us_state_6digitnaics_2021.txt", manifest.metadata.fetch("local_raw_path")
  end
end
