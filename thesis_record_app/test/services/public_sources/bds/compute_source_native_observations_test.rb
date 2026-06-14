require "test_helper"

class PublicSources::Bds::ComputeSourceNativeObservationsTest < ActiveSupport::TestCase
  setup do
    @operator = create_operator_user
    @scaffold = PublicSources::Bds::PublicFileScaffold.call!(actor: @operator)
    create_bds_row
    PublicSources::Bds::MetricDefinitionScaffold.call!(actor: @operator)
  end

  test "computes source-native BDS observations without reviews, links, or exports" do
    create_bds_row(source_row_number: 2, year: 1979, sector_code: "21", firm_age_code: "b) 1", firm_size_code: "b) 5 to 9")

    assert_no_difference -> { MetricQualityReview.count } do
      assert_no_difference -> { PredictionLink.count } do
        assert_no_difference -> { ExportArtifact.count } do
          @result = PublicSources::Bds::ComputeSourceNativeObservations.call!(actor: @operator)
        end
      end
    end

    assert_equal 2, @result.eligible_rows
    assert_equal 16, @result.observations_created
    assert_equal 0, @result.observations_deleted
    assert_equal({ "staged_context" => 16 }, @result.status_counts)
    assert_equal 2, @result.blocked_cells.fetch("bds_establishment_exits")
    assert_equal 2, @result.blocked_cells.fetch("bds_firm_deaths")
    assert_equal 0, @result.quality_reviews_created
    assert_equal 0, @result.prediction_links_created
    assert_equal 0, @result.exports_created

    observation = MetricObservation.joins(:metric_definition).find_by!(metric_definitions: { key: "bds_firms" })
    assert_equal "1978", observation.period
    assert_equal "staged_context", observation.metric_status
    assert_equal 1.to_d, observation.numeric_value
    assert_equal "bds_public_file_rows", observation.quality_metadata.fetch("source_table")
    assert_not observation.quality_metadata.fetch("claim_support_authorized")
  end

  test "rerun replaces existing BDS observations" do
    first = PublicSources::Bds::ComputeSourceNativeObservations.call!(actor: @operator)
    second = PublicSources::Bds::ComputeSourceNativeObservations.call!(actor: @operator)

    assert_equal 8, first.observations_created
    assert_equal 8, second.observations_created
    assert_equal 8, second.observations_deleted
    assert_equal 8, MetricObservation.joins(:data_source).where(data_sources: { source_kind: "census_bds_public_file" }).count
  end

  private

  def create_bds_row(source_row_number: 1, year: 1978, sector_code: "11", firm_age_code: "a) 0", firm_size_code: "a) 1 to 4")
    raw_values = bds_policy.fetch(:required_columns).excluding(*bds_policy.fetch(:row_grain)).index_with { "1" }
    raw_values["estabs_exit"] = "D"
    raw_values["firmdeath_firms"] = "X"
    numeric_values = raw_values.transform_values { |value| %w[D X].include?(value) ? nil : "1.0" }
    publication_flags = raw_values.filter { |_field, value| %w[D X].include?(value) }

    BdsPublicFileRow.create!(
      data_source: @scaffold.fetch(:data_source),
      intake_manifest: @scaffold.fetch(:intake_manifest),
      schema_version: @scaffold.fetch(:schema_version),
      source_row_number: source_row_number,
      year: year,
      sector_code: sector_code,
      firm_age_code: firm_age_code,
      firm_size_code: firm_size_code,
      raw_measure_values: raw_values,
      numeric_measure_values: numeric_values,
      publication_flags: publication_flags,
      row_hash: SecureRandom.hex(32)
    )
  end

  def bds_policy
    @bds_policy ||= Rails.application.config_for(:thesis_record_policy)
                              .deep_symbolize_keys
                              .fetch(:public_ingestion_v1)
                              .fetch(:bds_sector_age_size_public_file)
  end
end
