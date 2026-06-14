require "test_helper"

class IntakeManifestWorkflowTest < ActionDispatch::IntegrationTest
  setup do
    @operator = create_operator_user
    @source = DataSources::Create.call!(attributes: source_attributes, actor: @operator)
    sign_in_as(@operator)
  end

  test "research operator creates intake manifest through audited workflow" do
    assert_difference -> { IntakeManifest.count }, 1 do
      assert_difference -> { AuditEvent.where(event_type: "intake_manifest_created").count }, 1 do
        post data_source_intake_manifests_path(@source), params: { intake_manifest: manifest_attributes }
      end
    end

    manifest = IntakeManifest.last
    assert_redirected_to data_source_intake_manifest_path(@source, manifest)
    assert_equal "empty_manifest", manifest.manifest_status
  end

  test "research operator updates intake manifest through audited workflow" do
    manifest = IntakeManifests::Create.call!(
      data_source: @source,
      attributes: manifest_attributes,
      actor: @operator
    )

    assert_difference -> { AuditEvent.where(event_type: "intake_manifest_changed").count }, 1 do
      patch data_source_intake_manifest_path(@source, manifest), params: {
        intake_manifest: manifest_attributes.merge(manifest_status: "schema_pending")
      }
    end

    assert_redirected_to data_source_intake_manifest_path(@source, manifest)
    assert_equal "schema_pending", manifest.reload.manifest_status
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

  def manifest_attributes
    {
      name: "Quarterly public schema manifest",
      manifest_status: "empty_manifest",
      storage_zone: "production_postgresql",
      privacy_classification: "internal",
      public_repo_allowed: false,
      structured_private_allowed: true,
      private_file_storage_allowed: false,
      secret_material_present: false,
      redaction_required: true,
      minimum_cell_rule_required: true,
      human_review_required: true,
      retention_rule: "retain_until_reviewed"
    }
  end
end
