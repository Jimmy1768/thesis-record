require "test_helper"

class SealedRelationManifestTest < ActiveSupport::TestCase
  test "sealed manifest verifies exact original members after append-only growth" do
    first = create_definition("seal-test-a")
    second = create_definition("seal-test-b")
    result = Evidence::SealedRelationManifest.build(MetricDefinition.where(id: [ first.id, second.id ]))

    assert_equal 2, result.manifest.fetch("row_count")
    assert_equal [ [ first.id, second.id ] ], result.manifest.fetch("member_id_ranges")
    assert Evidence::SealedRelationManifest.verify!(model: MetricDefinition, manifest: result.manifest)

    create_definition("seal-test-c")
    assert Evidence::SealedRelationManifest.verify!(model: MetricDefinition, manifest: result.manifest)
  end

  test "sealed manifest detects content and relationship changes" do
    definition = create_definition("seal-test-content")
    result = Evidence::SealedRelationManifest.build(MetricDefinition.where(id: definition.id))

    definition.update!(limitations: "changed")

    assert_raises(Evidence::SealedRelationManifest::VerificationError) do
      Evidence::SealedRelationManifest.verify!(model: MetricDefinition, manifest: result.manifest)
    end
  end

  test "Day Zero builder fails closed on count mismatch" do
    config = {
      baseline_key: "test",
      baseline_observed_on: "2026-06-14",
      authority_manifest_paths: [],
      expected_counts: Evidence::DayZeroManifestBuilder::TABLE_MODELS.keys.index_with { 0 },
      historical_provenance: { original_application_commit: "unknown" }
    }
    config[:expected_counts][:metric_definitions] = 1

    error = assert_raises(Evidence::DayZeroManifestBuilder::CountMismatch) do
      Evidence::DayZeroManifestBuilder.call(config: config)
    end
    assert_includes error.message, "metric_definitions expected 1"
  end

  private

  def create_definition(key)
    MetricDefinition.create!(
      key: key,
      name: key,
      formula_status: "draft",
      formula: "source value",
      limitations: "test only"
    )
  end
end
