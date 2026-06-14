require "test_helper"
require "tmpdir"

class PublicSources::Bds::ParserDryRunTest < ActiveSupport::TestCase
  setup do
    @tmpdir = Pathname(Dir.mktmpdir)
    @local_path = @tmpdir.join("bds_fixture.csv")
  end

  teardown do
    FileUtils.remove_entry(@tmpdir) if @tmpdir&.exist?
  end

  test "dry-runs fixture file without persisting rows" do
    File.write(@local_path, sample_csv)

    assert_no_difference -> { BdsPublicFileRow.count } do
      @result = PublicSources::Bds::ParserDryRun.call!(local_path: @local_path)
    end

    assert_equal 2, @result.rows_seen
    assert_equal 2, @result.rows_parsed
    assert_equal 0, @result.rows_persisted
    assert_equal 0, @result.bad_width_rows
    assert_equal 0, @result.blank_lines
    assert_equal 0, @result.duplicate_key_count
    assert_equal({ start: 1978, end: 1979 }, @result.observed_year_range)
    assert_equal 2, @result.sector_count
    assert_equal 2, @result.firm_age_count
    assert_equal 2, @result.firm_size_count
    assert_equal 42, @result.numeric_cell_count
    assert_equal({ "D" => 2, "S" => 0, "X" => 2, "N" => 2 }, @result.publication_flag_totals)
    assert_equal 0, @result.bds_public_file_row_count
    assert_equal 0, @result.metric_observations_created
    assert_equal 0, @result.prediction_links_created
    assert_equal "D", @result.publication_flag_counts.fetch("estabs_exit").keys.first
  end

  test "reports duplicate source grain without inserting rows" do
    File.write(@local_path, sample_csv(rows: [ sample_row, sample_row ]))

    result = PublicSources::Bds::ParserDryRun.call!(local_path: @local_path)

    assert_equal 2, result.rows_seen
    assert_equal 1, result.duplicate_key_count
    assert_equal 0, result.rows_persisted
    assert_equal 0, BdsPublicFileRow.count
  end

  test "raises on invalid measure value" do
    File.write(@local_path, sample_csv(rows: [ sample_row(firms: "not-a-number") ]))

    assert_raises(PublicSources::Bds::ParserDryRun::DryRunError) do
      PublicSources::Bds::ParserDryRun.call!(local_path: @local_path)
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
