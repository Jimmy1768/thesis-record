require "test_helper"

class Operations::V0SourceFreshnessDryRunTest < ActiveSupport::TestCase
  FakeResponse = Data.define(:code, :headers) do
    def [](key)
      headers[key.downcase]
    end
  end

  class FakeHttpClient
    def self.start(_host, _port, use_ssl:)
      raise "expected ssl" unless use_ssl

      yield new
    end

    def request(_request)
      FakeResponse.new(
        "200",
        {
          "content-type" => "text/csv",
          "last-modified" => "Mon, 15 Jun 2026 00:00:00 GMT",
          "content-length" => "123"
        }
      )
    end
  end

  test "reports all three sources from policy without network by default" do
    result = Operations::V0SourceFreshnessDryRun.call

    assert result.passed
    assert_not result.network_enabled
    assert_empty result.blockers
    assert_equal %w[
      census_susb_public_file
      census_bfs_api
      census_bds_public_file
    ], result.sources.map(&:source_kind)
    assert result.sources.all? { |source| source.checks.fetch(:source_kind_matches) }
    assert result.sources.all? { |source| source.checks.fetch(:endpoints_configured) }
    assert result.sources.all? { |source| source.checks.fetch(:no_rows_authorized) }
    assert result.sources.all? { |source| source.checks.fetch(:no_claim_effect) }
    assert result.sources.flat_map(&:endpoints).none?(&:network_checked)
    assert_includes result.warnings, "network_check_disabled"
    assert_includes result.warnings, "dry_run_only_no_rows_written"
  end

  test "can run network checks through an injected client without writing rows" do
    result = Operations::V0SourceFreshnessDryRun.call(
      network_enabled: true,
      http_client: FakeHttpClient
    )

    assert result.passed
    assert result.network_enabled
    endpoints = result.sources.flat_map(&:endpoints)
    assert endpoints.all?(&:network_checked)
    assert endpoints.all? { |endpoint| endpoint.status == 200 }
    assert endpoints.all? { |endpoint| endpoint.last_modified == "Mon, 15 Jun 2026 00:00:00 GMT" }
    assert_not_includes result.warnings, "network_check_disabled"
    assert_includes result.warnings, "dry_run_only_no_rows_written"
  end

  test "fails if a source endpoint is removed from policy" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    policy[:public_ingestion_v1][:bfs_monthly_api].delete(:variables_url)

    result = Operations::V0SourceFreshnessDryRun.call(policy: policy)

    assert_not result.passed
    assert_includes result.blockers, "census_bfs_api.endpoints_configured"
  end
end
