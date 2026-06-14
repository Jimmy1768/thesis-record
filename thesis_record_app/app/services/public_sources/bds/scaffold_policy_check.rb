module PublicSources
  module Bds
    class ScaffoldPolicyCheck
      Result = Data.define(:passed, :failures)

      REQUIRED_FALSE_FLAGS = %i[
        raw_file_fetched
        data_rows_authorized
        metric_definitions_authorized
        metric_observations_authorized
        quality_reviews_authorized
        analysis_authorized
        exports_authorized
        prediction_links_authorized
      ].freeze

      REQUIRED_ROW_GRAIN = %w[year sector fage fsize].freeze
      REQUIRED_PUBLICATION_FLAGS = %w[D S X N].freeze
      REQUIRED_UNRESOLVED_PATHS = %w[
        six_digit_naics_firm_age_size
        subnational_firm_age_size_multiyear
        api_bdsfagefsize_multiyear
        direct_employer_firm_startup_field
      ].freeze
      REQUIRED_PROHIBITIONS = %w[
        nonemployer_to_employer_conversion_evidence
        nonemployer_evidence
        ai_or_node_interpretation
        management_layer_evidence
        vendor_substitution_evidence
        transaction_cost_evidence
        firm_boundary_conclusion
        claim_support
        exports
        quantitative_analysis
      ].freeze

      def self.call(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys,
                    require_no_bds_rows: false)
        new(policy: policy, require_no_bds_rows: require_no_bds_rows).call
      end

      def initialize(policy:, require_no_bds_rows:)
        @policy = policy.deep_symbolize_keys
        @require_no_bds_rows = require_no_bds_rows
      end

      def call
        failures = []
        failures << "source_kind expected census_bds_public_file" unless bds_policy[:source_kind] == "census_bds_public_file"
        failures << "schema_status expected verified_public_file_metadata_scaffold" unless bds_policy[:schema_status] == "verified_public_file_metadata_scaffold"
        failures << "evidence_class expected employer_dynamics_context_only" unless bds_policy[:evidence_class] == "employer_dynamics_context_only"
        failures << "claim_status_effect expected unchanged" unless bds_policy[:claim_status_effect] == "unchanged"
        failures << "industry_grain expected sector" unless bds_policy[:industry_grain] == "sector"
        failures << "geography_grain expected national" unless bds_policy[:geography_grain] == "national"
        failures << "row_grain expected #{REQUIRED_ROW_GRAIN.inspect}, got #{bds_policy[:row_grain].inspect}" unless bds_policy[:row_grain] == REQUIRED_ROW_GRAIN

        REQUIRED_FALSE_FLAGS.each do |flag|
          failures << "#{flag} expected false, got #{bds_policy[flag].inspect}" unless bds_policy[flag] == false
        end

        missing_flags = REQUIRED_PUBLICATION_FLAGS - bds_policy.fetch(:publication_flags).keys.map(&:to_s)
        failures << "missing publication flags: #{missing_flags.join(', ')}" if missing_flags.any?

        missing_unresolved_paths = REQUIRED_UNRESOLVED_PATHS - bds_policy.fetch(:unresolved_paths)
        failures << "missing unresolved paths: #{missing_unresolved_paths.join(', ')}" if missing_unresolved_paths.any?

        missing_prohibitions = REQUIRED_PROHIBITIONS - bds_policy.fetch(:prohibited_use)
        failures << "missing prohibited uses: #{missing_prohibitions.join(', ')}" if missing_prohibitions.any?

        compatibility = bds_policy.fetch(:compatibility_status)
        failures << "geography_naics_year should remain blocked" unless compatibility[:geography_naics_year].to_s.start_with?("blocked")
        failures << "employer_nonemployer_comparison_cells should remain blocked" unless compatibility[:employer_nonemployer_comparison_cells].to_s.start_with?("blocked")
        failures << "exposure_cells should remain blocked" unless compatibility[:exposure_cells].to_s.start_with?("blocked")
        failures << "tce_p005 should remain blocked" unless compatibility[:tce_p005].to_s.start_with?("blocked")

        failures << "BDS data source already has metric observations" if require_no_bds_rows && bds_metric_observations_exist?
        failures << "BDS data source already has quality reviews" if require_no_bds_rows && bds_quality_reviews_exist?

        Result.new(passed: failures.empty?, failures: failures)
      end

      private

      attr_reader :policy, :require_no_bds_rows

      def bds_policy
        @bds_policy ||= policy.fetch(:public_ingestion_v1).fetch(:bds_sector_age_size_public_file)
      end

      def bds_sources
        DataSource.where(source_kind: bds_policy.fetch(:source_kind))
      end

      def bds_metric_observations_exist?
        MetricObservation.where(data_source: bds_sources).exists?
      end

      def bds_quality_reviews_exist?
        MetricQualityReview.where(data_source: bds_sources).exists?
      end
    end
  end
end
