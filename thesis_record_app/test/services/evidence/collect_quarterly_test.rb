require "test_helper"
require "csv"
require "json"
require "minitest/mock"

class CollectQuarterlyTest < ActiveSupport::TestCase
  Response = Struct.new(:code, :body)

  setup do
    travel_to Time.utc(2027, 1, 2)
    @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    @registries = {}
    Evidence::PeriodicSourceReleases::SCOPES.each_key do |kind|
      source = DataSource.create!(name: "periodic #{kind}", source_kind: kind,
                                  source_status: "staged_context", storage_zone: "production_postgresql",
                                  privacy_classification: "public", retention_rule: "test")
      manifest = IntakeManifest.create!(data_source: source, name: "periodic #{kind}",
                                         manifest_status: "staged_context",
                                         storage_zone: "production_postgresql",
                                         privacy_classification: "public", retention_rule: "test")
      schema = SchemaVersion.create!(data_source: source, intake_manifest: manifest,
                                      version: "periodic-test-v1", schema_status: "validated")
      @registries[kind] = { "data_source_id" => source.id, "intake_manifest_id" => manifest.id,
                            "schema_version_id" => schema.id }
    end
    Evidence::PeriodicSourceNativeResults.metric_keys(policy: @policy).each do |key|
      MetricDefinition.create!(key: key, name: key, formula_status: "draft", formula: "source value")
    end
  end

  teardown { travel_back }

  test "three-source quarter completes, retries, reuses unchanged results, and revises corrections" do
    registration = register_synthetic_day_zero
    first = collect("2026-Q3")
    assert_equal "completed", first.status
    assert_equal 3, first.periodic_captures.count
    assert_equal 16, first.quarterly_result_set.observation_count
    assert_equal 16, first.quarterly_result_set.review_count
    assert_not_includes PeriodicCapture.all.map(&:attributes).to_json, "sentinel"
    assert_not_includes PeriodicSourceCheck.all.map(&:attributes).to_json, "sentinel"
    assert_equal "periodic_source_native_v1",
      first.quarterly_result_set.method_manifest.fetch("method").fetch("version")
    assert first.quarterly_result_set.method_manifest.fetch("method").fetch("susb").key?("mapping")
    assert first.quarterly_result_set.method_manifest.fetch("definitions").key?("bfs_business_applications")
    assert_equal [ "pending" ], MetricQualityReview.distinct.pluck(:review_status)
    assert_equal 0, MetricObservation.where(quarterly_result_set_id: nil).count
    assert Evidence::RegisterDayZero.verify!(registration)

    assert_equal first.id, collect("2026-Q3").id
    assert_equal 16, MetricObservation.count
    assert_equal 3, PeriodicCapture.count
    assert Evidence::RegisterDayZero.verify!(registration)
    next_quarter = collect("2026-Q4")
    assert_not_equal first.id, next_quarter.id
    assert_equal first.quarterly_result_set_id, next_quarter.quarterly_result_set_id
    assert Evidence::RegisterDayZero.verify!(registration)

    revised = collect("2026-Q3", bds_firms: "2")
    assert_equal 2, revised.revision
    assert_not_equal first.quarterly_result_set_id, revised.quarterly_result_set_id
    assert_equal first.id, Evidence::QuarterlyCollectionReader.find!(quarter: "2026-Q3", revision: 1).id
    assert_equal revised.id, Evidence::QuarterlyCollectionReader.find!(quarter: "2026-Q3", revision: 2).id
    assert_raises(ActiveRecord::RecordNotFound) do
      Evidence::QuarterlyCollectionReader.find!(quarter: "2026-Q3", revision: 3)
    end
    assert_equal 4, PeriodicCapture.count
    assert_equal 32, MetricObservation.count
    assert_equal 32, MetricQualityReview.count
    assert Evidence::RegisterDayZero.verify!(registration)
  end

  test "later source failure cannot complete a quarter" do
    fetcher = lambda do |uri|
      if uri.host == "api.census.gov"
        Response.new("503", "service unavailable")
      else
        response_for(uri)
      end
    end
    error = assert_raises(Evidence::PeriodicSourceReleases::ReleaseError) do
      Evidence::CollectQuarterly.call!(**options("2026-Q3"), fetcher: fetcher,
                                       environment: { "CENSUS_API_KEY" => "sentinel" })
    end
    assert_match(/HTTP 503/, error.message)
    assert_equal 0, QuarterlyCollection.count
    assert_equal 0, MetricObservation.count
    assert_equal "failed", PeriodicSourceCheck.last.status
    assert_equal 2, PeriodicCapture.count
  end

  test "quarter cutoff and close are checked before source retrieval" do
    calls = 0
    fetcher = ->(_uri) { calls += 1; Response.new("200", "response") }
    error = assert_raises(Evidence::CollectQuarterly::CollectionError) do
      Evidence::CollectQuarterly.call!(**options("2026-Q3").merge(cutoff_at: Time.utc(2026, 9, 30)),
                                       fetcher: fetcher)
    end
    assert_match(/cutoff/, error.message)

    travel_to Time.utc(2026, 9, 30, 23, 59, 59) do
      error = assert_raises(Evidence::CollectQuarterly::CollectionError) do
        Evidence::CollectQuarterly.call!(**options("2026-Q3"), fetcher: fetcher)
      end
      assert_match(/not closed/, error.message)
    end
    assert_equal 0, calls

    travel_to Time.utc(2026, 10, 1) do
      assert_equal "completed", collect("2026-Q3").status
    end
  end

  test "a lagged BFS month is recorded without claiming September coverage" do
    collection = collect("2026-Q3", bfs_month: "2026-08")
    assert_equal "completed", collection.status
    assert_equal [ "2026-08" ], BfsApiRow.pluck(:period_month)
  end

  test "job delegates only the explicit quarter and registry identifiers" do
    expected = options("2026-Q3")
    Evidence::CollectQuarterly.stub(:call!, ->(**args) {
      assert_equal expected[:quarter], args[:quarter]
      assert_equal expected[:cutoff_at], args[:cutoff_at]
      assert_equal expected[:registry_ids], args[:registry_ids]
    }) do
      Evidence::QuarterlyDatabaseCollectionJob.new.perform(
        quarter: "2026-Q3", cutoff_at: "2026-10-01T00:00:00Z", registry_ids: @registries)
    end
  end

  test "production collection requires the exact authorization before retrieval" do
    calls = 0
    fetcher = ->(_uri) { calls += 1; Response.new("200", "") }
    Rails.stub(:env, ActiveSupport::StringInquirer.new("production")) do
      [ nil, "false" ].each do |authorization|
        ENV.stub(:[], ->(key) { key == "THESIS_RECORD_ALLOW_QUARTERLY_COLLECTION" ? authorization : ENV.fetch(key, nil) }) do
          assert_raises(Evidence::CollectQuarterly::CollectionError) do
            Evidence::CollectQuarterly.call!(**options("2026-Q3"), fetcher: fetcher)
          end
        end
      end

      ENV.stub(:[], ->(key) { key == "THESIS_RECORD_ALLOW_QUARTERLY_COLLECTION" ? "true" : ENV.fetch(key, nil) }) do
        error = assert_raises(Evidence::CollectQuarterly::CollectionError) do
          Evidence::CollectQuarterly.call!(**options("invalid"), fetcher: fetcher)
        end
        assert_match(/quarter is invalid/, error.message)
      end
    end
    assert_equal 0, calls

    bad = @registries.deep_dup
    bad.fetch("census_susb_public_file")["intake_manifest_id"] =
      bad.fetch("census_bds_public_file").fetch("intake_manifest_id")
    assert_raises(Evidence::CollectQuarterly::CollectionError) do
      Evidence::CollectQuarterly.call!(**options("2026-Q3").merge(registry_ids: bad),
                                       fetcher: fetcher)
    end
    assert_equal 0, calls
  end

  private

  def options(quarter)
    { quarter: quarter, cutoff_at: QuarterlyCollection.cutoff_for(quarter), registry_ids: @registries }
  end

  def register_synthetic_day_zero
    Evidence::RegisterDayZero.call!(config: {
      baseline_key: "synthetic-quarterly-test",
      baseline_observed_on: "2026-06-14",
      authority_manifest_paths: [],
      historical_provenance: { original_application_commit: "unknown" },
      expected_counts: Evidence::DayZeroManifestBuilder::TABLE_MODELS.transform_values(&:count)
    })
  end

  def collect(quarter, bds_firms: "1", bfs_month: "2026-09")
    fetcher = ->(uri) { response_for(uri, bds_firms: bds_firms, bfs_month: bfs_month) }
    Evidence::CollectQuarterly.call!(**options(quarter), fetcher: fetcher,
                                     environment: { "CENSUS_API_KEY" => "sentinel" })
  end

  def response_for(uri, bds_firms: "1", bfs_month: "2026-09")
    return Response.new("404", "") if uri.host != "api.census.gov" && uri.path.include?("2026")

    body = case uri.host
    when "api.census.gov" then bfs_response(bfs_month)
    else uri.path.include?("susb") ? susb_response : bds_response(bds_firms)
    end
    Response.new("200", body)
  end

  def susb_response
    header = @policy.fetch(:public_ingestion_v1).fetch(:susb_us_state_annual).fetch(:expected_header).map(&:to_s)
    row = header.index_with { "1" }.merge(
      "STATE" => "00", "NAICS" => "11", "ENTRSIZE" => "01",
      "EMPLFL_N" => "G", "PAYRFL_N" => "H", "RCPTFL_N" => "G",
      "STATEDSCR" => "United States", "NAICSDSCR" => "Agriculture",
      "ENTRSIZEDSCR" => "Total")
    CSV.generate_line(header) + CSV.generate_line(header.map { |field| row.fetch(field) })
  end

  def bds_response(firms)
    header = @policy.fetch(:public_ingestion_v1).fetch(:bds_sector_age_size_public_file)
                    .fetch(:required_columns).map(&:to_s)
    row = header.index_with { "1" }.merge("year" => "2025", "sector" => "11",
                                           "fage" => "a) 0", "fsize" => "a) 1 to 4",
                                           "firms" => firms)
    CSV.generate_line(header) + CSV.generate_line(header.map { |field| row.fetch(field) })
  end

  def bfs_response(month)
    header = @policy.fetch(:public_ingestion_v1).fetch(:bfs_monthly_api)
                    .fetch(:dry_run_v1).fetch(:expected_response_header)
    JSON.generate([ header, [ "BA_BA", "0", "no", "NAICS11", "42", "no", month, "1" ] ])
  end
end
