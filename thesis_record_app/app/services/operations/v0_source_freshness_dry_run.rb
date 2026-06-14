require "net/http"
require "uri"

module Operations
  class V0SourceFreshnessDryRun
    SourceResult = Data.define(:source_kind, :policy_key, :checks, :endpoints)
    EndpointResult = Data.define(:name, :url, :configured, :network_checked, :status, :content_type, :last_modified, :content_length, :error)
    Result = Data.define(:passed, :network_enabled, :sources, :blockers, :warnings)

    SOURCE_CONFIGS = [
      {
        source_kind: "census_susb_public_file",
        policy_key: :susb_us_state_annual,
        endpoint_keys: %i[source_url record_layout_url]
      },
      {
        source_kind: "census_bfs_api",
        policy_key: :bfs_monthly_api,
        endpoint_keys: %i[variables_url geography_url examples_url monthly_data_dictionary_url]
      },
      {
        source_kind: "census_bds_public_file",
        policy_key: :bds_sector_age_size_public_file,
        endpoint_keys: %i[source_url dataset_page_url methodology_url]
      }
    ].freeze

    def self.call(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys,
                  network_enabled: false,
                  http_client: Net::HTTP)
      new(policy: policy, network_enabled: network_enabled, http_client: http_client).call
    end

    def initialize(policy:, network_enabled:, http_client:)
      @policy = policy.deep_symbolize_keys
      @network_enabled = !!network_enabled
      @http_client = http_client
    end

    def call
      sources = SOURCE_CONFIGS.map { |config| source_result(config) }
      blockers = source_blockers(sources)

      Result.new(
        passed: blockers.empty?,
        network_enabled: network_enabled,
        sources: sources,
        blockers: blockers,
        warnings: warnings
      )
    end

    private

    attr_reader :policy, :network_enabled, :http_client

    def source_result(config)
      source_policy = policy.fetch(:public_ingestion_v1).fetch(config.fetch(:policy_key))
      endpoints = config.fetch(:endpoint_keys).map do |endpoint_key|
        endpoint_result(endpoint_key, source_policy.fetch(endpoint_key, nil))
      end

      SourceResult.new(
        source_kind: config.fetch(:source_kind),
        policy_key: config.fetch(:policy_key),
        checks: {
          source_kind_matches: source_policy.fetch(:source_kind, nil) == config.fetch(:source_kind),
          endpoints_configured: endpoints.all?(&:configured),
          no_rows_authorized: rows_disabled?(source_policy),
          no_claim_effect: source_policy.fetch(:claim_status_effect, "unchanged") == "unchanged"
        },
        endpoints: endpoints
      )
    end

    def endpoint_result(name, url)
      return EndpointResult.new(name: name, url: url, configured: false, network_checked: false, status: nil, content_type: nil, last_modified: nil, content_length: nil, error: nil) if url.blank?

      return EndpointResult.new(name: name, url: url, configured: true, network_checked: false, status: nil, content_type: nil, last_modified: nil, content_length: nil, error: nil) unless network_enabled

      response = head(url)
      EndpointResult.new(
        name: name,
        url: url,
        configured: true,
        network_checked: true,
        status: response.code.to_i,
        content_type: response["content-type"],
        last_modified: response["last-modified"],
        content_length: response["content-length"],
        error: nil
      )
    rescue StandardError => error
      EndpointResult.new(
        name: name,
        url: url,
        configured: true,
        network_checked: true,
        status: nil,
        content_type: nil,
        last_modified: nil,
        content_length: nil,
        error: error.class.name
      )
    end

    def head(url)
      uri = URI.parse(url)
      request = Net::HTTP::Head.new(uri)
      http_client.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
        http.request(request)
      end
    end

    def rows_disabled?(source_policy)
      keys = %i[
        data_rows_authorized
        metric_definitions_authorized
        metric_observations_authorized
        quality_reviews_authorized
        analysis_authorized
        exports_authorized
        prediction_links_authorized
      ]

      keys.all? { |key| source_policy.fetch(key, false) == false }
    end

    def source_blockers(sources)
      sources.flat_map do |source|
        source.checks.filter_map do |check_name, passed|
          "#{source.source_kind}.#{check_name}" unless passed
        end
      end
    end

    def warnings
      [].tap do |warnings|
        warnings << "network_check_disabled" unless network_enabled
        warnings << "dry_run_only_no_rows_written"
      end
    end
  end
end
