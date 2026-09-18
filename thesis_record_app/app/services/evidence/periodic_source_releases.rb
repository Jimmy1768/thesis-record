require "net/http"
require "uri"

module Evidence
  class PeriodicSourceReleases
    class ReleaseError < StandardError; end

    Release = Data.define(:source_kind, :dataset_scope, :release_identity, :response,
                          :parser, :public_url, :checked_at)

    SCOPES = {
      "census_susb_public_file" => "susb_us_state_annual",
      "census_bds_public_file" => "bds_sector_age_size_public_file",
      "census_bfs_api" => "bfs_us_unadjusted_first_pass"
    }.freeze

    def self.latest!(source_kind:, cutoff_at:, fetcher: ->(uri) { Net::HTTP.get_response(uri) },
                     environment: ENV, policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
      raise ReleaseError, "production source retrieval is a later phase" if Rails.env.production?
      raise ReleaseError, "unknown periodic source" unless SCOPES.key?(source_kind)

      ingestion = policy.fetch(:public_ingestion_v1)
      first_year = case source_kind
                   when "census_susb_public_file" then Integer(ingestion.fetch(:susb_us_state_annual).fetch(:default_year))
                   when "census_bds_public_file"
                     Integer(ingestion.fetch(:bds_sector_age_size_public_file).fetch(:source_url)[/bds(\d{4})_/, 1])
                   else 2012
                   end
      cutoff = cutoff_at.to_time.utc
      cutoff.year.downto(first_year) do |year|
        public_url = public_url(source_kind, year, ingestion)
        request_url = authenticated_url(public_url, source_kind, environment)
        response = begin
          fetcher.call(URI(request_url))
        rescue StandardError => error
          raise ReleaseError, "source request failed (#{error.class.name})"
        end
        code = Integer(response.code)
        next if code == 404 || code == 204
        raise ReleaseError, "source returned HTTP #{code} for #{public_url}" unless code == 200
        raise ReleaseError, "source response is not text for #{public_url}" unless response.body.is_a?(String)

        parser = case source_kind
                 when "census_susb_public_file" then PeriodicSourceParsers.susb(year: year, policy: policy)
                 when "census_bds_public_file" then PeriodicSourceParsers.bds(release_year: year, policy: policy)
                 else PeriodicSourceParsers.bfs(year: year,
                                                through_month: year == cutoff.year ? cutoff.month : 12,
                                                policy: policy)
                 end
        return Release.new(source_kind: source_kind, dataset_scope: SCOPES.fetch(source_kind),
                           release_identity: year.to_s, response: response.body,
                           parser: parser, public_url: public_url, checked_at: Time.current)
      end
      raise ReleaseError, "no available release for #{source_kind} by cutoff"
    end

    def self.public_url(source_kind, year, ingestion)
      case source_kind
      when "census_susb_public_file"
        configured = ingestion.fetch(:susb_us_state_annual).fetch(:source_url)
        baseline = ingestion.fetch(:susb_us_state_annual).fetch(:default_year).to_s
        configured.sub(%r{/tables/#{baseline}/}, "/tables/#{year}/")
                  .sub(/_#{baseline}\.txt\z/, "_#{year}.txt")
      when "census_bds_public_file"
        configured = ingestion.fetch(:bds_sector_age_size_public_file).fetch(:source_url)
        baseline = configured[/bds(\d{4})_/, 1]
        configured.sub(%r{/#{baseline}/}, "/#{year}/").sub(/bds#{baseline}_/, "bds#{year}_")
      when "census_bfs_api"
        settings = ingestion.fetch(:bfs_monthly_api)
        fields = settings.fetch(:dry_run_v1).fetch(:query_get_fields).join(",")
        "#{settings.fetch(:endpoint_url)}?#{URI.encode_www_form(get: fields, time: year, for: 'us:*')}"
      end
    end

    def self.authenticated_url(public_url, source_kind, environment)
      return public_url unless source_kind == "census_bfs_api"

      key = environment["CENSUS_API_KEY"]
      raise ReleaseError, "CENSUS_API_KEY is required for BFS retrieval" if key.blank?
      "#{public_url}&#{URI.encode_www_form(key: key)}"
    end

    private_class_method :public_url, :authenticated_url
  end
end
