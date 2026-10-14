require "net/http"

module Evidence
  class CollectQuarterly
    class CollectionError < StandardError; end

    PARSER_VERSIONS = {
      "census_susb_public_file" => "periodic_susb_v1",
      "census_bds_public_file" => "periodic_bds_v1",
      "census_bfs_api" => "periodic_bfs_v1"
    }.freeze

    def self.call!(quarter:, cutoff_at:, registry_ids:, fetcher: ->(uri) { Net::HTTP.get_response(uri) },
                   environment: ENV)
      raise CollectionError, "production quarterly collection is not authorized" if
        Rails.env.production? && ENV["THESIS_RECORD_ALLOW_QUARTERLY_COLLECTION"] != "true"
      expected_cutoff = QuarterlyCollection.cutoff_for(quarter)
      raise CollectionError, "quarter is invalid" unless expected_cutoff
      raise CollectionError, "cutoff does not match quarter" unless
        cutoff_at.respond_to?(:to_time) && cutoff_at.to_time&.utc == expected_cutoff
      raise CollectionError, "quarter has not closed" if Time.current.utc < expected_cutoff
      raise CollectionError, "all three source registries are required" unless
        registry_ids.keys.map(&:to_s).sort == PARSER_VERSIONS.keys.sort

      policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
      captures = PARSER_VERSIONS.map do |kind, parser_version|
        ids = registry_ids.fetch(kind) { registry_ids.fetch(kind.to_sym) }
        source = DataSource.find(ids.fetch("data_source_id") { ids.fetch(:data_source_id) })
        manifest = IntakeManifest.find(ids.fetch("intake_manifest_id") { ids.fetch(:intake_manifest_id) })
        schema = SchemaVersion.find(ids.fetch("schema_version_id") { ids.fetch(:schema_version_id) })
        raise CollectionError, "source kind mismatch" unless source.source_kind == kind
        raise CollectionError, "source registry mismatch" unless
          manifest.data_source_id == source.id && schema.data_source_id == source.id &&
          schema.intake_manifest_id == manifest.id

        begin
          release = PeriodicSourceReleases.latest!(source_kind: kind, cutoff_at: expected_cutoff,
                                                   fetcher: fetcher, environment: environment,
                                                   policy: policy)
        rescue PeriodicSourceReleases::ReleaseError => error
          PeriodicSourceCheck.create!(data_source: source,
                                      dataset_scope: PeriodicSourceReleases::SCOPES.fetch(kind),
                                      release_identity: "undetermined", status: "failed",
                                      error_class: error.class.name, checked_at: Time.current)
          raise
        end
        RecordPeriodicCapture.call!(data_source: source, intake_manifest: manifest,
                                    schema_version: schema, dataset_scope: release.dataset_scope,
                                    release_identity: release.release_identity, response: release.response,
                                    parser_version: parser_version, parser: release.parser,
                                    checked_at: release.checked_at)
      end

      CompleteQuarterlyCollection.call!(
        quarter: quarter, captures: captures, cutoff_at: expected_cutoff,
        method_manifest: PeriodicSourceNativeResults.method_manifest(policy: policy),
        definitions: PeriodicSourceNativeResults.definitions_manifest(policy: policy),
        compute: ->(inputs) { PeriodicSourceNativeResults.call(inputs, policy: policy) }
      )
    end
  end
end
