require "test_helper"

class PrivateArtifactTest < ActiveSupport::TestCase
  test "secret material cannot be marked public repo allowed" do
    artifact = PrivateArtifact.new(
      artifact_kind: "contract",
      storage_zone: "private_file_storage",
      privacy_classification: "confidential",
      public_repo_allowed: true,
      structured_private_allowed: false,
      private_file_storage_allowed: true,
      secret_material_present: true,
      redaction_required: true,
      minimum_cell_rule_required: true,
      human_review_required: true,
      storage_pointer: "private://contracts/example.pdf",
      content_hash: "sha256:test",
      retention_rule: "confidential_review_required"
    )

    assert_not artifact.valid?
    assert_includes artifact.errors[:public_repo_allowed],
                    "cannot be true when secret material is present"
  end
end
