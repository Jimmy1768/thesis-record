module Evidence
  class DayZeroManifestBuilder
    TABLE_MODELS = {
      data_sources: DataSource,
      source_access_paths: SourceAccessPath,
      intake_manifests: IntakeManifest,
      schema_versions: SchemaVersion,
      metric_definitions: MetricDefinition,
      metric_observations: MetricObservation,
      metric_quality_reviews: MetricQualityReview,
      susb_public_file_rows: SusbPublicFileRow,
      bfs_api_rows: BfsApiRow,
      bds_public_file_rows: BdsPublicFileRow
    }.freeze

    Result = Data.define(:manifest, :manifest_digest)

    class CountMismatch < StandardError; end

    def self.call(config: Rails.application.config_for(:day_zero_baseline).deep_symbolize_keys)
      new(config).call
    end

    def initialize(config)
      @config = config
    end

    def call
      table_manifests = TABLE_MODELS.to_h do |name, model|
        expected = expected_counts.fetch(name)
        actual = model.count
        raise CountMismatch, "#{name} expected #{expected}, found #{actual}" unless actual == expected

        result = Evidence::SealedRelationManifest.build(model.all)
        [ name.to_s, result.manifest ]
      end

      manifest = {
        "schema_version" => "day-zero-seal-v1",
        "baseline_key" => config.fetch(:baseline_key),
        "baseline_observed_on" => config.fetch(:baseline_observed_on).to_s,
        "authority_manifest_paths" => config.fetch(:authority_manifest_paths).map(&:to_s).sort,
        "historical_provenance" => config.fetch(:historical_provenance).deep_stringify_keys,
        "tables" => table_manifests
      }
      Result.new(manifest: manifest, manifest_digest: Evidence::CanonicalDigest.call(manifest))
    end

    private

    attr_reader :config

    def expected_counts
      @expected_counts ||= config.fetch(:expected_counts).transform_values { |value| Integer(value) }
    end
  end
end
