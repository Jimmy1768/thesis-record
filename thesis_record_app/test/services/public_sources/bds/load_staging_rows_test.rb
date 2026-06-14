require "test_helper"
require "tmpdir"

class PublicSources::Bds::LoadStagingRowsTest < ActiveSupport::TestCase
  setup do
    @operator = create_operator_user
    @tmpdir = Pathname(Dir.mktmpdir)
    @local_path = @tmpdir.join("bds_fixture.csv")
    File.write(@local_path, sample_csv)
    @scaffold = PublicSources::Bds::PublicFileScaffold.call!(actor: @operator)
  end

  teardown do
    FileUtils.remove_entry(@tmpdir) if @tmpdir&.exist?
  end

  test "loads source-native BDS rows without creating downstream evidence records" do
    assert_no_difference -> { MetricDefinition.count } do
      assert_no_difference -> { MetricObservation.count } do
        assert_no_difference -> { MetricQualityReview.count } do
          assert_no_difference -> { PredictionLink.count } do
            assert_no_difference -> { ExportArtifact.count } do
              @result = load_fixture
            end
          end
        end
      end
    end

    assert_equal 2, @result.rows_read
    assert_equal 2, @result.rows_inserted
    assert_equal 0, @result.rows_deleted_before_load
    assert_equal 2, BdsPublicFileRow.count

    row = BdsPublicFileRow.order(:source_row_number).first
    assert_equal 1978, row.year
    assert_equal "11", row.sector_code
    assert_equal "D", row.publication_flags.fetch("estabs_exit")
    assert_nil row.numeric_measure_values.fetch("estabs_exit")
    assert_equal @result.load_id, row.metadata.fetch("load_id")
    assert_not row.metadata.fetch("metric_observations_authorized")
    assert_not row.metadata.fetch("quality_reviews_authorized")
    assert_not row.metadata.fetch("prediction_links_authorized")
    assert_equal "unchanged", row.metadata.fetch("claim_status_effect")
    assert_equal "staging_rows_loaded", @result.intake_manifest.manifest_status
  end

  test "reload is idempotent through cleanup and reinsert" do
    first = load_fixture(load_id: "first-load")
    second = load_fixture(load_id: "second-load")

    assert_equal 2, first.rows_inserted
    assert_equal 2, second.rows_inserted
    assert_equal 2, second.rows_deleted_before_load
    assert_equal 2, BdsPublicFileRow.count
    assert_equal [ "second-load" ], BdsPublicFileRow.pluck(:metadata).map { |metadata| metadata.fetch("load_id") }.uniq
  end

  private

  def load_fixture(load_id: "test-load")
    PublicSources::Bds::LoadStagingRows.call!(
      actor: @operator,
      local_path: @local_path,
      load_id: load_id,
      policy: fixture_policy,
      validator: -> { validation_result }
    )
  end

  def validation_result
    PublicSources::Bds::FetchAndValidatePublicFile::Result.new(
      data_source: @scaffold.fetch(:data_source),
      source_access_path: @scaffold.fetch(:source_access_path),
      intake_manifest: @scaffold.fetch(:intake_manifest),
      schema_version: @scaffold.fetch(:schema_version),
      local_path: @local_path.to_s,
      fetched_this_run: false,
      sha256: Digest::SHA256.file(@local_path).hexdigest,
      byte_size: @local_path.size,
      row_count_including_header: 3,
      row_count_excluding_header: 2,
      bad_width_rows: 0,
      blank_lines: 0,
      duplicate_key_count: 0,
      observed_year_range: { start: 1978, end: 1979 },
      sector_count: 2,
      firm_age_count: 2,
      firm_size_count: 2,
      publication_flag_counts: {},
      manifest_reconciled: true,
      metric_definitions_created: 0,
      metric_observations_created: 0,
      quality_reviews_created: 0,
      prediction_links_created: 0,
      exports_created: 0
    )
  end

  def fixture_policy
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys.deep_dup
    bds_policy = policy.fetch(:public_ingestion_v1).fetch(:bds_sector_age_size_public_file)
    bds_policy[:observed_row_count_excluding_header] = 2
    bds_policy[:observed_year_range] = { start: 1978, end: 1979 }
    bds_policy[:allowed_sector_values] = %w[11 21]
    bds_policy[:allowed_fage_values] = [ "a) 0", "b) 1" ]
    bds_policy[:allowed_fsize_values] = [ "a) 1 to 4", "b) 5 to 9" ]
    qa_policy = bds_policy.fetch(:parser_design_v1).fetch(:row_load_qa_policy_v1)
    qa_policy[:expected_source_rows] = 2
    qa_policy[:require_observed_year_range] = { start: 1978, end: 1979 }
    qa_policy[:require_sector_count] = 2
    qa_policy[:require_firm_age_count] = 2
    qa_policy[:require_firm_size_count] = 2
    policy
  end

  def sample_csv
    rows = [
      sample_row,
      sample_row(year: "1979", sector: "21", fage: "b) 1", fsize: "b) 5 to 9")
    ]
    ([ expected_header.join(delimiter) ] + rows).join("\n") + "\n"
  end

  def sample_row(year: "1978", sector: "11", fage: "a) 0", fsize: "a) 1 to 4")
    values = expected_header.index_with { "1" }
    values["year"] = year
    values["sector"] = sector
    values["fage"] = fage
    values["fsize"] = fsize
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
