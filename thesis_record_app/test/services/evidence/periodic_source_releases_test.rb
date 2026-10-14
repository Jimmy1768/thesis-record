require "test_helper"
require "uri"

class PeriodicSourceReleasesTest < ActiveSupport::TestCase
  Response = Struct.new(:code, :body)

  test "three source scopes discover latest available release with configured URLs" do
    seen = []
    fetcher = lambda do |uri|
      seen << uri.to_s
      uri.to_s.include?("2025") ? Response.new("200", "response") : Response.new("404", "")
    end
    %w[census_susb_public_file census_bds_public_file census_bfs_api].each do |kind|
      release = Evidence::PeriodicSourceReleases.latest!(source_kind: kind,
        cutoff_at: Time.utc(2026, 10, 1), fetcher: fetcher,
        environment: { "CENSUS_API_KEY" => "sentinel key" })
      assert_equal "2025", release.release_identity
      assert_equal kind, release.source_kind
      assert_equal "response", release.response
    end
    assert_equal 4, seen.size
    assert seen.any? { |url| url.include?("/tables/2025/us_state_6digitnaics_2025.txt") }
    assert seen.any? { |url| url.include?("/2025/bds2025_sec_fa_fz.csv") }
    assert seen.any? { |url| url.include?("time=from+2026-01+to+2026-09") }
    assert seen.any? { |url| url.include?("time=from+2025-01+to+2025-12") && url.include?("key=sentinel+key") }
    assert seen.none? { |url| url.include?("/tables/2026/") || url.include?("/2026/bds2026_") }
  end

  test "Q4 includes a completed annual year and bounds BFS to December" do
    seen = []
    fetcher = ->(uri) { seen << uri.to_s; Response.new("200", "response") }
    %w[census_susb_public_file census_bds_public_file census_bfs_api].each do |kind|
      release = Evidence::PeriodicSourceReleases.latest!(source_kind: kind,
        cutoff_at: Time.utc(2027, 1, 1), fetcher: fetcher,
        environment: { "CENSUS_API_KEY" => "sentinel key" })
      assert_equal "2026", release.release_identity
    end
    assert seen.any? { |url| url.include?("/tables/2026/us_state_6digitnaics_2026.txt") }
    assert seen.any? { |url| url.include?("/2026/bds2026_sec_fa_fz.csv") }
    assert seen.any? { |url| url.include?("time=from+2026-01+to+2026-12") }
  end

  test "non-quarter cutoff is rejected before source retrieval" do
    calls = 0
    error = assert_raises(Evidence::PeriodicSourceReleases::ReleaseError) do
      Evidence::PeriodicSourceReleases.latest!(source_kind: "census_susb_public_file",
        cutoff_at: Time.utc(2026, 9, 30), fetcher: ->(_uri) { calls += 1 })
    end
    assert_match(/quarter boundary/, error.message)
    assert_equal 0, calls
  end

  test "production retrieval requires the exact quarterly collection authorization" do
    calls = 0
    Rails.stub(:env, ActiveSupport::StringInquirer.new("production")) do
      [ nil, "false" ].each do |authorization|
        ENV.stub(:[], ->(key) { key == "THESIS_RECORD_ALLOW_QUARTERLY_COLLECTION" ? authorization : ENV.fetch(key, nil) }) do
          assert_raises(Evidence::PeriodicSourceReleases::ReleaseError) do
            Evidence::PeriodicSourceReleases.latest!(source_kind: "census_susb_public_file",
              cutoff_at: Time.utc(2026, 10, 1), fetcher: ->(_uri) { calls += 1 })
          end
        end
      end

      ENV.stub(:[], ->(key) { key == "THESIS_RECORD_ALLOW_QUARTERLY_COLLECTION" ? "true" : ENV.fetch(key, nil) }) do
        error = assert_raises(Evidence::PeriodicSourceReleases::ReleaseError) do
          Evidence::PeriodicSourceReleases.latest!(source_kind: "unknown",
            cutoff_at: Time.utc(2026, 10, 1), fetcher: ->(_uri) { calls += 1 })
        end
        assert_match(/unknown periodic source/, error.message)
      end
    end
    assert_equal 0, calls
  end

  test "BFS public release identity excludes the key and missing key stops before fetch" do
    calls = 0
    fetcher = lambda do |_uri|
      calls += 1
      Response.new("200", "response")
    end
    error = assert_raises(Evidence::PeriodicSourceReleases::ReleaseError) do
      Evidence::PeriodicSourceReleases.latest!(source_kind: "census_bfs_api",
        cutoff_at: Time.utc(2026, 10, 1), fetcher: fetcher, environment: {})
    end
    assert_equal 0, calls
    assert_match(/CENSUS_API_KEY/, error.message)

    release = Evidence::PeriodicSourceReleases.latest!(source_kind: "census_bfs_api",
      cutoff_at: Time.utc(2026, 10, 1), fetcher: fetcher,
      environment: { "CENSUS_API_KEY" => "sentinel key" })
    assert_equal 1, calls
    assert_not_includes release.public_url, "sentinel"
    assert_not_includes release.public_url, "key="
  end

  test "HTTP failure does not become an available release" do
    error = assert_raises(Evidence::PeriodicSourceReleases::ReleaseError) do
      Evidence::PeriodicSourceReleases.latest!(source_kind: "census_bds_public_file",
        cutoff_at: Time.utc(2026, 10, 1), fetcher: ->(_uri) { Response.new("500", "internal") })
    end
    assert_match(/HTTP 500/, error.message)
    assert_not_includes error.message, "internal"
  end

  test "request exceptions do not disclose an authenticated BFS URL" do
    secret = "sentinel-secret"
    error = assert_raises(Evidence::PeriodicSourceReleases::ReleaseError) do
      Evidence::PeriodicSourceReleases.latest!(source_kind: "census_bfs_api",
        cutoff_at: Time.utc(2026, 10, 1), environment: { "CENSUS_API_KEY" => secret },
        fetcher: ->(uri) { raise IOError, "failed at #{uri}" })
    end
    assert_match(/IOError/, error.message)
    assert_not_includes error.message, secret
    assert_not_includes error.message, "key="
  end
end
