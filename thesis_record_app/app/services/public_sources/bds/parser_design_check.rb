module PublicSources
  module Bds
    class ParserDesignCheck
      Result = Data.define(:passed, :failures)

      REQUIRED_STATUS = "source_row_load_authorized"
      REQUIRED_FALSE_FLAGS = %i[
        metric_computation_authorized
        quality_reviews_authorized
        analysis_authorized
        exports_authorized
        prediction_links_authorized
      ].freeze
      REQUIRED_TRUE_FLAGS = %i[
        full_file_parser_authorized
        row_load_authorized
        parser_authorized
      ].freeze
      REQUIRED_PRIMARY_KEY = %w[data_source_id year sector_code firm_age_code firm_size_code].freeze
      REQUIRED_ALLOWED_FLAGS = %w[D S X N].freeze
      REQUIRED_PROHIBITIONS = %w[
        ratios
        trends
        aggregation
        naics_crosswalk
        productivity_measures
        ai_or_node_interpretation
        nonemployer_conversion
        management_layer_inference
        claim_support
        exports
      ].freeze

      def self.call(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys,
                    require_no_staging_table: false,
                    require_staging_table: false,
                    require_empty_staging_table: false)
        new(
          policy: policy,
          require_no_staging_table: require_no_staging_table,
          require_staging_table: require_staging_table,
          require_empty_staging_table: require_empty_staging_table
        ).call
      end

      def initialize(policy:, require_no_staging_table:, require_staging_table:, require_empty_staging_table:)
        @policy = policy.deep_symbolize_keys
        @require_no_staging_table = require_no_staging_table
        @require_staging_table = require_staging_table
        @require_empty_staging_table = require_empty_staging_table
      end

      def call
        failures = []
        failures << "status expected #{REQUIRED_STATUS.inspect}, got #{design[:status].inspect}" unless design[:status] == REQUIRED_STATUS
        failures << "staging_table expected \"bds_public_file_rows\"" unless design[:staging_table] == "bds_public_file_rows"
        failures << "staging_table_creation_authorized expected true" unless design[:staging_table_creation_authorized] == true
        failures << "fixture_parser_authorized expected true" unless design[:fixture_parser_authorized] == true
        failures << "full_file_dry_run_authorized expected true" unless design[:full_file_dry_run_authorized] == true
        failures << "claim_status_effect expected \"unchanged\"" unless design[:claim_status_effect] == "unchanged"
        failures << "source_grain expected \"year_sector_firm_age_firm_size\"" unless design[:source_grain] == "year_sector_firm_age_firm_size"
        failures << "primary_key_candidate expected #{REQUIRED_PRIMARY_KEY.inspect}, got #{design[:primary_key_candidate].inspect}" unless design[:primary_key_candidate] == REQUIRED_PRIMARY_KEY

        REQUIRED_FALSE_FLAGS.each do |flag|
          failures << "#{flag} expected false, got #{design[flag].inspect}" unless design[flag] == false
        end

        REQUIRED_TRUE_FLAGS.each do |flag|
          failures << "#{flag} expected true, got #{design[flag].inspect}" unless design[flag] == true
        end

        failures << "dimension_fields missing year" unless design.fetch(:dimension_fields).fetch(:year) == "integer"
        failures << "flag_handling.preserve_raw_cell_value expected true" unless flag_handling[:preserve_raw_cell_value] == true
        failures << "flag_handling.extract_publication_flags_before_numeric_coercion expected true" unless flag_handling[:extract_publication_flags_before_numeric_coercion] == true
        failures << "flag_handling.flagged_numeric_value_policy expected \"null_numeric_value\"" unless flag_handling[:flagged_numeric_value_policy] == "null_numeric_value"

        missing_flags = REQUIRED_ALLOWED_FLAGS - Array(flag_handling[:allowed_flags])
        failures << "missing allowed flags: #{missing_flags.join(', ')}" if missing_flags.any?

        missing_count_fields = required_count_fields - Array(design[:count_measure_fields])
        failures << "missing count measure fields: #{missing_count_fields.join(', ')}" if missing_count_fields.any?

        missing_rate_fields = required_rate_fields - Array(design[:rate_measure_fields])
        failures << "missing rate measure fields: #{missing_rate_fields.join(', ')}" if missing_rate_fields.any?

        missing_prohibitions = REQUIRED_PROHIBITIONS - Array(design[:prohibited_parser_outputs])
        failures << "missing prohibited parser outputs: #{missing_prohibitions.join(', ')}" if missing_prohibitions.any?

        table_exists = ActiveRecord::Base.connection.data_source_exists?(design.fetch(:staging_table))
        if require_no_staging_table && table_exists
          failures << "#{design.fetch(:staging_table)} table already exists"
        end
        failures << "#{design.fetch(:staging_table)} table is missing" if require_staging_table && !table_exists
        failures << "#{design.fetch(:staging_table)} rows already exist" if require_empty_staging_table && table_exists && BdsPublicFileRow.exists?

        Result.new(passed: failures.empty?, failures: failures)
      end

      private

      attr_reader :policy, :require_no_staging_table, :require_staging_table,
                  :require_empty_staging_table

      def bds_policy
        @bds_policy ||= policy.fetch(:public_ingestion_v1).fetch(:bds_sector_age_size_public_file)
      end

      def design
        @design ||= bds_policy.fetch(:parser_design_v1)
      end

      def flag_handling
        design.fetch(:flag_handling)
      end

      def required_count_fields
        bds_policy.fetch(:required_columns) - bds_policy.fetch(:row_grain) - required_rate_fields
      end

      def required_rate_fields
        bds_policy.fetch(:required_columns).select { |field| field.include?("_rate") }
      end
    end
  end
end
