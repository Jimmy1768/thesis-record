require "test_helper"

class PublicSources::Bds::ParserSkeletonTest < ActiveSupport::TestCase
  test "parses fixture rows in memory without persisting BDS rows" do
    assert_no_difference -> { BdsPublicFileRow.count } do
      @result = PublicSources::Bds::ParserSkeleton.call!(csv_text: sample_csv)
    end

    assert_equal 2, @result.rows_seen
    assert_equal 0, @result.rows_persisted

    row = @result.parsed_rows.first
    assert_equal 1, row.source_row_number
    assert_equal 1978, row.year
    assert_equal "11", row.sector_code
    assert_equal "a) 0", row.firm_age_code
    assert_equal "a) 1 to 4", row.firm_size_code
    assert_equal "1", row.raw_measure_values.fetch("firms")
    assert_equal "1.0", row.numeric_measure_values.fetch("firms")
    assert_nil row.numeric_measure_values.fetch("estabs_exit")
    assert_equal "D", row.publication_flags.fetch("estabs_exit")
    assert_equal "X", row.publication_flags.fetch("firmdeath_firms")
    assert_equal "N", row.publication_flags.fetch("net_job_creation_rate")
    assert row.metadata.fetch(:parser_authorized)
    assert row.metadata.fetch(:row_load_authorized)
  end

  test "rejects non-fixture parser execution" do
    assert_raises(PublicSources::Bds::ParserSkeleton::ParserError) do
      PublicSources::Bds::ParserSkeleton.call!(csv_text: sample_csv, fixture_only: false)
    end
  end

  test "raises on unexpected measure value" do
    bad_csv = sample_csv(rows: [ sample_row(firms: "not-a-number") ])

    assert_raises(PublicSources::Bds::ParserSkeleton::ParserError) do
      PublicSources::Bds::ParserSkeleton.call!(csv_text: bad_csv)
    end
  end

  private

  def sample_csv(rows: nil)
    rows ||= [
      sample_row,
      sample_row(year: "1979", sector: "21", fage: "b) 1", fsize: "b) 5 to 9")
    ]

    ([ expected_header.join(delimiter) ] + rows).join("\n") + "\n"
  end

  def sample_row(year: "1978", sector: "11", fage: "a) 0", fsize: "a) 1 to 4", firms: "1")
    values = expected_header.index_with { "1" }
    values["year"] = year
    values["sector"] = sector
    values["fage"] = fage
    values["fsize"] = fsize
    values["firms"] = firms
    values["estabs_exit"] = "D"
    values["firmdeath_firms"] = "X"
    values["net_job_creation_rate"] = "N"
    expected_header.map { |field| values.fetch(field) }.join(delimiter)
  end

  def expected_header
    bds_policy.fetch(:required_columns)
  end

  def delimiter
    bds_policy.fetch(:acquisition_design_v1).fetch(:expected_delimiter)
  end

  def bds_policy
    @bds_policy ||= Rails.application.config_for(:thesis_record_policy)
                              .deep_symbolize_keys
                              .fetch(:public_ingestion_v1)
                              .fetch(:bds_sector_age_size_public_file)
  end
end
