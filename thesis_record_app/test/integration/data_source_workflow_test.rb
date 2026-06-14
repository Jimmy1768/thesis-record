require "test_helper"

class DataSourceWorkflowTest < ActionDispatch::IntegrationTest
  setup do
    @operator = create_operator_user
    sign_in_as(@operator)
  end

  test "research operator registers data source through audited workflow" do
    assert_difference -> { DataSource.count }, 1 do
      assert_difference -> { AuditEvent.where(event_type: "source_registered").count }, 1 do
        post data_sources_path, params: { data_source: source_attributes }
      end
    end

    source = DataSource.last
    assert_redirected_to data_source_path(source)
    assert_equal "not_evidence", source.claim_status_allowed
    assert_equal "internal", source.privacy_classification
  end

  test "research operator updates data source through audited workflow" do
    source = DataSources::Create.call!(attributes: source_attributes, actor: @operator)

    assert_difference -> { AuditEvent.where(event_type: "source_registry_changed").count }, 1 do
      patch data_source_path(source), params: {
        data_source: source_attributes.merge(source_status: "schema_pending")
      }
    end

    assert_redirected_to data_source_path(source)
    assert_equal "schema_pending", source.reload.source_status
  end

  private

  def source_attributes
    {
      name: "Census Test Source",
      source_kind: "public_census_dataset",
      source_status: "source_registered",
      storage_zone: "production_postgresql",
      privacy_classification: "internal",
      public_repo_allowed: false,
      structured_private_allowed: true,
      private_file_storage_allowed: false,
      secret_material_present: false,
      redaction_required: true,
      minimum_cell_rule_required: true,
      human_review_required: true,
      retention_rule: "retain_until_reviewed",
      claim_status_allowed: "not_evidence"
    }
  end
end
