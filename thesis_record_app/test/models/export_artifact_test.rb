require "test_helper"

class ExportArtifactTest < ActiveSupport::TestCase
  test "published Git exports require public repo review" do
    export = ExportArtifact.new(
      artifact_kind: "redacted_aggregate",
      export_status: "published_to_git",
      privacy_review_status: "approved",
      reviewed_for_public_repo: false
    )

    assert_not export.valid?
    assert_includes export.errors[:reviewed_for_public_repo],
                    "must be true before publishing to Git"
  end
end
