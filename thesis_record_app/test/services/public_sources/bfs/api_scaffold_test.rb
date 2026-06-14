require "test_helper"

class PublicSources::Bfs::ApiScaffoldTest < ActiveSupport::TestCase
  setup do
    @operator = create_operator_user
  end

  test "registers BFS API metadata scaffold without querying data" do
    assert_difference -> { DataSource.count }, 1 do
      assert_difference -> { SourceAccessPath.count }, 1 do
        assert_difference -> { IntakeManifest.count }, 1 do
          assert_difference -> { SchemaVersion.count }, 1 do
            @result = PublicSources::Bfs::ApiScaffold.call!(actor: @operator)
          end
        end
      end
    end

    source = @result.fetch(:data_source)
    access_path = @result.fetch(:source_access_path)
    manifest = @result.fetch(:intake_manifest)
    schema = @result.fetch(:schema_version)

    assert_equal "census_bfs_api", source.source_kind
    assert_equal "ingestion_scaffold_ready", source.source_status
    assert_equal "context_only", source.claim_status_allowed
    assert_equal "indirect_payroll_transition_proxy_only", source.metadata.fetch("evidence_class")
    assert_equal "official_census_api_metadata", access_path.access_type
    assert_equal "verified_metadata_only_not_queried", access_path.status
    assert_not manifest.metadata.fetch("api_data_queried")
    assert_not manifest.metadata.fetch("analysis_authorized")
    assert_equal "verified_api_metadata_scaffold", schema.schema_status
    assert_includes schema.schema.fetch("exact_fields"), "cell_value"
    assert_equal "BA_BA", schema.schema.fetch("target_data_type_codes").fetch("business_applications")
    assert_equal "BF_PBF4Q", schema.schema.fetch("target_data_type_codes").fetch("projected_business_formations_within_four_quarters")
    assert_equal "Total for All NAICS", schema.schema.fetch("verified_category_codes").fetch("TOTAL")
    assert_equal "Manufacturing", schema.schema.fetch("verified_category_codes").fetch("NAICSMNF")
    assert_equal 5_544, schema.schema.fetch("api_example_query_shape").fetch("observed_2012_row_count")
    assert_includes schema.schema.fetch("prohibited_use"), "claim_support"
  end

  test "records audit events with unchanged claim status effect" do
    assert_difference -> { AuditEvent.where(claim_status_effect: "unchanged").count }, 4 do
      PublicSources::Bfs::ApiScaffold.call!(actor: @operator)
    end
  end

  test "is idempotent when scaffold already exists" do
    PublicSources::Bfs::ApiScaffold.call!(actor: @operator)

    assert_no_difference -> { DataSource.count } do
      assert_no_difference -> { SourceAccessPath.count } do
        assert_no_difference -> { IntakeManifest.count } do
          assert_no_difference -> { SchemaVersion.count } do
            PublicSources::Bfs::ApiScaffold.call!(actor: @operator)
          end
        end
      end
    end
  end
end
