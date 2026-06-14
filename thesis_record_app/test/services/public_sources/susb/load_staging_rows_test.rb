require "test_helper"

class PublicSources::Susb::LoadStagingRowsTest < ActiveSupport::TestCase
  setup do
    @operator = create_operator_user
    @tmpdir = Pathname(Dir.mktmpdir)
    @raw_path = @tmpdir.join("data/raw/susb/2022/us_state_6digitnaics_2022.txt")
    @manifest_path = @tmpdir.join("data/manifests/susb_2022_manifest.csv")
    FileUtils.mkdir_p(@raw_path.dirname)
    FileUtils.mkdir_p(@manifest_path.dirname)
    File.write(@raw_path, sample_csv)
    write_manifest_for(sample_csv)
  end

  teardown do
    FileUtils.remove_entry(@tmpdir) if @tmpdir&.exist?
  end

  test "loads source-native rows into staging without metric observations" do
    assert_difference -> { SusbPublicFileRow.count }, 2 do
      assert_no_difference -> { MetricObservation.count } do
        @result = PublicSources::Susb::LoadStagingRows.call!(
          actor: @operator,
          local_path: @raw_path,
          manifest_path: @manifest_path
        )
      end
    end

    assert_equal 2, @result.rows_read
    assert_equal 0, @result.metric_observations_created
    row = SusbPublicFileRow.find_by!(state_code: "01", naics_code: "111110", enterprise_size_code: "01")
    assert_equal 1, row.firm_count
    assert_equal "H", row.employment_noise_flag
    assert_equal "Alabama", row.state_name
    assert_not row.metadata.fetch("metrics_authorized")
  end

  test "is idempotent by source year state naics and enterprise size" do
    PublicSources::Susb::LoadStagingRows.call!(actor: @operator, local_path: @raw_path, manifest_path: @manifest_path)

    assert_no_difference -> { SusbPublicFileRow.count } do
      PublicSources::Susb::LoadStagingRows.call!(actor: @operator, local_path: @raw_path, manifest_path: @manifest_path)
    end
  end

  private

  def sample_csv
    [
      expected_header.join(","),
      "00,111110,01,1,1,1,G,1,G,1,G,United States,Soybean Farming,01: Total",
      "01,111110,01,1,1,1,H,1,H,1,H,Alabama,Soybean Farming,01: Total"
    ].join("\n") + "\n"
  end

  def write_manifest_for(payload)
    File.write(
      @manifest_path,
      [
        "dataset,content_length,local_path,sha256,row_count,field_list",
        "SUSB 2022 U.S./state 6-digit NAICS,#{payload.bytesize},#{@raw_path.relative_path_from(Rails.root.parent)},#{Digest::SHA256.hexdigest(payload)},#{payload.lines.count},#{expected_header.join(';')}"
      ].join("\n") + "\n"
    )
  end

  def expected_header
    Rails.application.config_for(:thesis_record_policy)
         .deep_symbolize_keys
         .fetch(:public_ingestion_v1)
         .fetch(:susb_us_state_annual)
         .fetch(:expected_header)
  end
end
