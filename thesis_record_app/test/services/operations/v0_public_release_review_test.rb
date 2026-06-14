require "test_helper"

class Operations::V0PublicReleaseReviewTest < ActiveSupport::TestCase
  test "passes current unapproved public-release review scaffold" do
    result = Operations::V0PublicReleaseReview.call

    assert result.passed
    assert result.checks.fetch(:v0_public_release_review_scaffold_present)
    assert result.checks.fetch(:v0_public_release_review_unapproved)
    assert result.checks.fetch(:v0_public_release_review_no_approval_effect)
    assert result.checks.fetch(:v0_public_release_required_artifacts_present)
    assert result.checks.fetch(:v0_public_release_prerequisites_listed)
    assert result.checks.fetch(:v0_approval_packet_requires_public_release_review)
    assert result.checks.fetch(:v0_public_release_status_not_public)
    assert result.checks.fetch(:v0_public_path_declared)
    assert result.checks.fetch(:v0_public_release_criteria_pending_human_review)
    assert result.checks.fetch(:v0_public_release_prohibited_effects_present)
    assert_includes result.warnings, "v0_public_release_review_unapproved"
  end

  test "fails when release status is already public" do
    approval_packet = YAML.safe_load_file(
      Rails.root.join("..", "theses", "operator-node-economics", "publication", "v0_approval_packet.yml")
    ).deep_symbolize_keys
    timeline = YAML.safe_load_file(
      Rails.root.join("..", "theses", "operator-node-economics", "publication", "v0_timeline.yml")
    ).deep_symbolize_keys
    approval_packet[:public_release_status] = "public"

    result = Operations::V0PublicReleaseReview.call(approval_packet: approval_packet, timeline: timeline)

    assert_not result.passed
    assert_not result.checks.fetch(:v0_public_release_status_not_public)
    assert_includes result.failures, "v0_public_release_status_not_public"
  end
end
