require "bigdecimal"
require "csv"
require "digest"

module PublicSources
  module Bds
    class ParserSkeleton
      class ParserError < StandardError; end

      ParsedRow = Data.define(
        :source_row_number,
        :year,
        :sector_code,
        :firm_age_code,
        :firm_size_code,
        :raw_measure_values,
        :numeric_measure_values,
        :publication_flags,
        :row_hash,
        :metadata
      )
      Result = Data.define(:parsed_rows, :rows_seen, :rows_persisted)

      def self.call!(csv_text:, fixture_only: true,
                     policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
        new(csv_text: csv_text, fixture_only: fixture_only, policy: policy).call!
      end

      def initialize(csv_text:, fixture_only:, policy:)
        @csv_text = csv_text
        @fixture_only = fixture_only
        @policy = policy.deep_symbolize_keys
        @bds_policy = @policy.fetch(:public_ingestion_v1).fetch(:bds_sector_age_size_public_file)
        @parser_design = @bds_policy.fetch(:parser_design_v1)
      end

      def call!
        ensure_fixture_only!
        ensure_policy_allows_fixture_parse!

        parsed_rows = parse_fixture_rows
        Result.new(parsed_rows: parsed_rows, rows_seen: parsed_rows.length, rows_persisted: 0)
      end

      private

      attr_reader :csv_text, :fixture_only, :policy, :bds_policy, :parser_design

      def ensure_fixture_only!
        raise ParserError, "BDS parser skeleton is fixture-only" unless fixture_only
      end

      def ensure_policy_allows_fixture_parse!
        parser_result = PublicSources::Bds::ParserDesignCheck.call(
          policy: policy,
          require_staging_table: true,
          require_empty_staging_table: false
        )
        row_load_result = PublicSources::Bds::RowLoadPolicyCheck.call(policy: policy)
        failures = parser_result.failures + row_load_result.failures
        raise ParserError, "BDS parser policy failed: #{failures.join('; ')}" if failures.any?
      end

      def parse_fixture_rows
        rows = []
        CSV.parse(csv_text, headers: true, col_sep: delimiter).each.with_index(1) do |row, source_row_number|
          validate_header!(row.headers) if source_row_number == 1
          rows << parsed_row(row, source_row_number)
        end
        rows
      end

      def validate_header!(header)
        raise ParserError, "BDS fixture header mismatch: #{header.inspect}" unless header == expected_header
      end

      def parsed_row(row, source_row_number)
        validate_dimensions!(row, source_row_number)

        raw_values = {}
        numeric_values = {}
        publication_flags = {}
        measure_columns.each do |field|
          raw_value = row.fetch(field)
          raw_values[field] = raw_value
          if allowed_publication_flags.include?(raw_value)
            numeric_values[field] = nil
            publication_flags[field] = raw_value
          else
            numeric_values[field] = decimal_string(raw_value, field, source_row_number)
          end
        end

        ParsedRow.new(
          source_row_number: source_row_number,
          year: Integer(row.fetch("year"), 10),
          sector_code: row.fetch("sector"),
          firm_age_code: row.fetch("fage"),
          firm_size_code: row.fetch("fsize"),
          raw_measure_values: raw_values,
          numeric_measure_values: numeric_values,
          publication_flags: publication_flags,
          row_hash: row_hash(row),
          metadata: row_metadata
        )
      end

      def validate_dimensions!(row, source_row_number)
        failures = []
        failures << "sector=#{row.fetch('sector')}" unless bds_policy.fetch(:allowed_sector_values).include?(row.fetch("sector"))
        failures << "fage=#{row.fetch('fage')}" unless bds_policy.fetch(:allowed_fage_values).include?(row.fetch("fage"))
        failures << "fsize=#{row.fetch('fsize')}" unless bds_policy.fetch(:allowed_fsize_values).include?(row.fetch("fsize"))
        return if failures.empty?

        raise ParserError, "unexpected BDS dimension values at fixture row #{source_row_number}: #{failures.join(', ')}"
      end

      def decimal_string(value, field, source_row_number)
        BigDecimal(value).to_s("F")
      rescue ArgumentError
        raise ParserError, "unexpected BDS measure cell #{field}=#{value.inspect} at fixture row #{source_row_number}"
      end

      def row_hash(row)
        Digest::SHA256.hexdigest(expected_header.map { |field| row[field].to_s }.join("\u0000"))
      end

      def row_metadata
        {
          fixture_only: true,
          parser_authorized: parser_design.fetch(:parser_authorized),
          full_file_parser_authorized: parser_design.fetch(:full_file_parser_authorized),
          row_load_authorized: parser_design.fetch(:row_load_authorized),
          analysis_authorized: parser_design.fetch(:analysis_authorized),
          exports_authorized: parser_design.fetch(:exports_authorized),
          prediction_links_authorized: parser_design.fetch(:prediction_links_authorized),
          claim_status_effect: parser_design.fetch(:claim_status_effect)
        }
      end

      def expected_header
        bds_policy.fetch(:required_columns)
      end

      def measure_columns
        expected_header - bds_policy.fetch(:row_grain)
      end

      def allowed_publication_flags
        parser_design.fetch(:flag_handling).fetch(:allowed_flags)
      end

      def delimiter
        bds_policy.fetch(:acquisition_design_v1).fetch(:expected_delimiter)
      end
    end
  end
end
