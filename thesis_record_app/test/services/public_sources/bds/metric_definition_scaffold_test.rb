require "test_helper"

class PublicSources::Bds::MetricDefinitionScaffoldTest < ActiveSupport::TestCase
  setup do
    @operator = create_operator_user
    @scaffold = PublicSources::Bds::PublicFileScaffold.call!(actor: @operator)
    create_bds_row
  end

  test "creates draft-disabled BDS metric definitions without observations" do
    assert_difference -> { MetricDefinition.where("key LIKE ?", "bds_%").count }, 10 do
      assert_no_difference -> { MetricObservation.count } do
        assert_no_difference -> { MetricQualityReview.count } do
          PublicSources::Bds::MetricDefinitionScaffold.call!(actor: @operator)
        end
      end
    end

    definition = MetricDefinition.find_by!(key: "bds_firms")
    assert_equal "draft_disabled", definition.formula_status
    assert_includes definition.limitations, "no MetricObservation rows"
    assert_includes definition.limitations, "claim support"
  end

  test "is idempotent and records audit events" do
    PublicSources::Bds::MetricDefinitionScaffold.call!(actor: @operator)

    assert_no_difference -> { MetricDefinition.where("key LIKE ?", "bds_%").count } do
      assert_difference -> { AuditEvent.where(event_type: "metric_definition_changed").count }, 10 do
        PublicSources::Bds::MetricDefinitionScaffold.call!(actor: @operator)
      end
    end
  end

  private

  def create_bds_row
    BdsPublicFileRow.create!(
      data_source: @scaffold.fetch(:data_source),
      intake_manifest: @scaffold.fetch(:intake_manifest),
      schema_version: @scaffold.fetch(:schema_version),
      source_row_number: 1,
      year: 1978,
      sector_code: "11",
      firm_age_code: "a) 0",
      firm_size_code: "a) 1 to 4",
      raw_measure_values: { "firms" => "1" },
      numeric_measure_values: { "firms" => "1.0" },
      publication_flags: {},
      row_hash: SecureRandom.hex(32)
    )
  end
end
