require "test_helper"
require "tmpdir"

class PublicSources::Bds::FetchAndValidatePublicFileTest < ActiveSupport::TestCase
  setup do
    @operator = create_operator_user
    @tmpdir = Pathname(Dir.mktmpdir)
    @raw_path = @tmpdir.join("data/raw/bds/2023/bds2023_sec_fa_fz.csv")
    @manifest_path = @tmpdir.join("data/manifests/bds_2023_manifest.csv")
    FileUtils.mkdir_p(@raw_path.dirname)
    FileUtils.mkdir_p(@manifest_path.dirname)
  end

  teardown do
    FileUtils.remove_entry(@tmpdir) if @tmpdir&.exist?
  end

  test "validates existing BDS file, reconciles manifest, and updates registry without downstream effects" do
    payload = sample_csv
    File.write(@raw_path, payload)
    write_manifest_for(payload)

    assert_no_difference -> { MetricDefinition.count } do
      assert_no_difference -> { MetricObservation.count } do
        assert_no_difference -> { MetricQualityReview.count } do
          assert_no_difference -> { PredictionLink.count } do
            assert_no_difference -> { ExportArtifact.count } do
              @result = PublicSources::Bds::FetchAndValidatePublicFile.call!(
                actor: @operator,
                local_path: @raw_path,
                manifest_path: @manifest_path,
                strict: false
              )
            end
          end
        end
      end
    end

    assert_not @result.fetched_this_run
    assert @result.manifest_reconciled
    assert_equal 2, @result.row_count_excluding_header
    assert_equal 0, @result.duplicate_key_count
    assert_equal "raw_file_validated", @result.data_source.source_status
    assert_equal "raw_file_validated", @result.intake_manifest.manifest_status
    assert_equal "fetched_and_validated", @result.source_access_path.status
    assert @result.intake_manifest.metadata.fetch("parser_authorized")
    assert @result.intake_manifest.metadata.fetch("row_load_authorized")
    assert_not @result.intake_manifest.metadata.fetch("analysis_authorized")
    assert_not @result.intake_manifest.metadata.fetch("exports_authorized")
    assert_equal "unchanged", @result.intake_manifest.metadata.fetch("claim_status_effect")
  end

  test "fetches missing file only when force fetch is true" do
    payload = sample_csv
    write_manifest_for(payload)
    fetcher_called = false
    fetcher = lambda do |_url, destination|
      fetcher_called = true
      File.write(destination, payload)
    end

    result = PublicSources::Bds::FetchAndValidatePublicFile.call!(
      actor: @operator,
      force_fetch: true,
      fetcher: fetcher,
      local_path: @raw_path,
      manifest_path: @manifest_path,
      strict: false
    )

    assert fetcher_called
    assert result.fetched_this_run
  end

  test "raises on duplicate row grain" do
    duplicate_payload = sample_csv(rows: [ sample_row, sample_row ])
    File.write(@raw_path, duplicate_payload)
    write_manifest_for(duplicate_payload)

    assert_raises(PublicSources::Bds::FetchAndValidatePublicFile::ValidationError) do
      PublicSources::Bds::FetchAndValidatePublicFile.call!(
        actor: @operator,
        local_path: @raw_path,
        manifest_path: @manifest_path,
        strict: false
      )
    end
  end

  test "raises on manifest checksum mismatch" do
    File.write(@raw_path, sample_csv)
    write_manifest_for(sample_csv, sha256: "wrong")

    assert_raises(PublicSources::Bds::FetchAndValidatePublicFile::ValidationError) do
      PublicSources::Bds::FetchAndValidatePublicFile.call!(
        actor: @operator,
        local_path: @raw_path,
        manifest_path: @manifest_path,
        strict: false
      )
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

  def write_manifest_for(payload, sha256: nil)
    sha256 ||= Digest::SHA256.hexdigest(payload)
    File.write(
      @manifest_path,
      [
        "dataset,content_length,local_path,sha256,row_count,field_list",
        "BDS 2023 sector by firm age by firm size,#{payload.bytesize},#{@raw_path.relative_path_from(Rails.root.parent)},#{sha256},#{payload.lines.count},#{expected_header.join(';')}"
      ].join("\n") + "\n"
    )
  end

  def expected_header
    Rails.application.config_for(:thesis_record_policy)
         .deep_symbolize_keys
         .fetch(:public_ingestion_v1)
         .fetch(:bds_sector_age_size_public_file)
         .fetch(:required_columns)
  end

  def delimiter
    Rails.application.config_for(:thesis_record_policy)
         .deep_symbolize_keys
         .fetch(:public_ingestion_v1)
         .fetch(:bds_sector_age_size_public_file)
         .fetch(:acquisition_design_v1)
         .fetch(:expected_delimiter)
  end
end
