require "test_helper"
require "tempfile"

class PublicSources::Susb::FetchAndValidatePublicFileTest < ActiveSupport::TestCase
  setup do
    @operator = create_operator_user
    @tmpdir = Pathname(Dir.mktmpdir)
    @raw_path = @tmpdir.join("data/raw/susb/2022/us_state_6digitnaics_2022.txt")
    @manifest_path = @tmpdir.join("data/manifests/susb_2022_manifest.csv")
    FileUtils.mkdir_p(@raw_path.dirname)
    FileUtils.mkdir_p(@manifest_path.dirname)
  end

  teardown do
    FileUtils.remove_entry(@tmpdir) if @tmpdir&.exist?
  end

  test "fetches missing file, validates structure, reconciles manifest, and updates registry metadata" do
    payload = sample_csv
    write_manifest_for(payload)
    fetcher = ->(_url, destination) { File.write(destination, payload) }

    result = PublicSources::Susb::FetchAndValidatePublicFile.call!(
      actor: @operator,
      fetcher: fetcher,
      local_path: @raw_path,
      manifest_path: @manifest_path
    )

    assert result.fetched_this_run
    assert result.manifest_reconciled
    assert_equal 2, result.row_count_excluding_header
    assert_equal 0, result.duplicate_key_count
    assert_equal "raw_file_validated", result.data_source.source_status
    assert_equal "raw_file_validated", result.intake_manifest.manifest_status
    assert_not result.intake_manifest.metadata.fetch("metrics_authorized")
  end

  test "does not fetch when local file exists and force fetch is false" do
    File.write(@raw_path, sample_csv)
    write_manifest_for(sample_csv)
    fetcher_called = false
    fetcher = ->(_url, _destination) { fetcher_called = true }

    result = PublicSources::Susb::FetchAndValidatePublicFile.call!(
      actor: @operator,
      fetcher: fetcher,
      local_path: @raw_path,
      manifest_path: @manifest_path
    )

    assert_not fetcher_called
    assert_not result.fetched_this_run
  end

  test "accepts binary-compatible Census text payloads during fetch validation" do
    payload = sample_csv(rows: [
      "00,111110,01,1,1,1,G,1,G,1,G,United States,Men\x92s Farming,01: Total".b,
      "01,111110,01,1,1,1,H,1,H,1,H,Alabama,Soybean Farming,01: Total"
    ])
    write_manifest_for(payload)
    fetcher = ->(_url, destination) { File.binwrite(destination, payload) }

    result = PublicSources::Susb::FetchAndValidatePublicFile.call!(
      actor: @operator,
      force_fetch: true,
      fetcher: fetcher,
      local_path: @raw_path,
      manifest_path: @manifest_path
    )

    assert result.fetched_this_run
    assert result.manifest_reconciled
    assert_equal Digest::SHA256.hexdigest(payload), result.sha256
  end

  test "raises on duplicate row grain" do
    duplicate_payload = sample_csv(rows: [
      "00,111110,01,1,1,1,G,1,G,1,G,United States,Soybean Farming,01: Total",
      "00,111110,01,1,1,1,G,1,G,1,G,United States,Soybean Farming,01: Total"
    ])
    File.write(@raw_path, duplicate_payload)
    write_manifest_for(duplicate_payload)

    assert_raises(PublicSources::Susb::FetchAndValidatePublicFile::ValidationError) do
      PublicSources::Susb::FetchAndValidatePublicFile.call!(
        actor: @operator,
        local_path: @raw_path,
        manifest_path: @manifest_path
      )
    end
  end

  test "raises on manifest checksum mismatch" do
    File.write(@raw_path, sample_csv)
    write_manifest_for(sample_csv, sha256: "wrong")

    assert_raises(PublicSources::Susb::FetchAndValidatePublicFile::ValidationError) do
      PublicSources::Susb::FetchAndValidatePublicFile.call!(
        actor: @operator,
        local_path: @raw_path,
        manifest_path: @manifest_path
      )
    end
  end

  private

  def sample_csv(rows: nil)
    rows ||= [
      "00,111110,01,1,1,1,G,1,G,1,G,United States,Soybean Farming,01: Total",
      "01,111110,01,1,1,1,H,1,H,1,H,Alabama,Soybean Farming,01: Total"
    ]

    ([ expected_header.join(",") ] + rows).join("\n") + "\n"
  end

  def write_manifest_for(payload, sha256: nil)
    sha256 ||= Digest::SHA256.hexdigest(payload)
    File.write(
      @manifest_path,
      [
        "dataset,content_length,local_path,sha256,row_count,field_list",
        "SUSB 2022 U.S./state 6-digit NAICS,#{payload.bytesize},#{@raw_path.relative_path_from(Rails.root.parent)},#{sha256},#{payload.lines.count},#{expected_header.join(';')}"
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
