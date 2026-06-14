require "bigdecimal"
require "csv"
require "set"

module PublicSources
  module Bds
    class ParserDryRun
      class DryRunError < StandardError; end

      Result = Data.define(
        :local_path,
        :rows_seen,
        :rows_parsed,
        :rows_persisted,
        :bad_width_rows,
        :blank_lines,
        :duplicate_key_count,
        :observed_year_range,
        :sector_count,
        :firm_age_count,
        :firm_size_count,
        :numeric_cell_count,
        :publication_flag_totals,
        :publication_flag_counts,
        :bds_public_file_row_count,
        :metric_observations_created,
        :quality_reviews_created,
        :prediction_links_created,
        :exports_created
      )

      def self.call!(local_path: nil, policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
        new(local_path: local_path, policy: policy).call!
      end

      def initialize(local_path:, policy:)
        @policy = policy.deep_symbolize_keys
        @bds_policy = @policy.fetch(:public_ingestion_v1).fetch(:bds_sector_age_size_public_file)
        @parser_design = @bds_policy.fetch(:parser_design_v1)
        @acquisition_design = @bds_policy.fetch(:acquisition_design_v1)
        @local_path = Pathname(local_path || Rails.root.parent.join(@acquisition_design.fetch(:local_raw_path)))
      end

      def call!
        ensure_policy_allows_dry_run!
        raise DryRunError, "BDS raw file missing at #{local_path}" unless local_path.exist?

        counts = dry_run_counts
        Result.new(
          local_path: local_path.to_s,
          rows_seen: counts.fetch(:rows_seen),
          rows_parsed: counts.fetch(:rows_parsed),
          rows_persisted: 0,
          bad_width_rows: counts.fetch(:bad_width_rows),
          blank_lines: counts.fetch(:blank_lines),
          duplicate_key_count: counts.fetch(:duplicate_key_count),
          observed_year_range: counts.fetch(:observed_year_range),
          sector_count: counts.fetch(:sector_count),
          firm_age_count: counts.fetch(:firm_age_count),
          firm_size_count: counts.fetch(:firm_size_count),
          numeric_cell_count: counts.fetch(:numeric_cell_count),
          publication_flag_totals: publication_flag_totals(counts.fetch(:publication_flag_counts)),
          publication_flag_counts: counts.fetch(:publication_flag_counts),
          bds_public_file_row_count: BdsPublicFileRow.count,
          metric_observations_created: 0,
          quality_reviews_created: 0,
          prediction_links_created: 0,
          exports_created: 0
        )
      end

      private

      attr_reader :policy, :bds_policy, :parser_design, :acquisition_design, :local_path

      def ensure_policy_allows_dry_run!
        parser_result = PublicSources::Bds::ParserDesignCheck.call(
          policy: policy,
          require_staging_table: true,
          require_empty_staging_table: false
        )
        row_load_result = PublicSources::Bds::RowLoadPolicyCheck.call(policy: policy)
        failures = parser_result.failures + row_load_result.failures
        raise DryRunError, "BDS dry-run policy failed: #{failures.join('; ')}" if failures.any?
      end

      def dry_run_counts
        header = nil
        rows_seen = 0
        rows_parsed = 0
        bad_width_rows = 0
        blank_lines = 0
        duplicate_key_count = 0
        numeric_cell_count = 0
        keys = Set.new
        years = Set.new
        sectors = Set.new
        firm_ages = Set.new
        firm_sizes = Set.new
        publication_flag_counts = measure_columns.index_with { {} }

        File.open(local_path, "r:UTF-8") do |file|
          CSV.new(file, headers: true, col_sep: delimiter).each.with_index(1) do |row, source_row_number|
            header ||= row.headers
            if row.fields.all?(&:blank?)
              blank_lines += 1
              next
            end

            rows_seen += 1
            bad_width_rows += 1 unless row.fields.length == expected_header.length
            key = row_grain.map { |field| row.fetch(field) }.join("\u0000")
            duplicate_key_count += 1 unless keys.add?(key)

            validate_dimensions!(row, source_row_number)
            years.add(Integer(row.fetch("year"), 10))
            sectors.add(row.fetch("sector"))
            firm_ages.add(row.fetch("fage"))
            firm_sizes.add(row.fetch("fsize"))
            numeric_cell_count += collect_measure_counts!(row, source_row_number, publication_flag_counts)
            rows_parsed += 1
          end
        end

        validate_header!(header)

        {
          rows_seen: rows_seen,
          rows_parsed: rows_parsed,
          bad_width_rows: bad_width_rows,
          blank_lines: blank_lines,
          duplicate_key_count: duplicate_key_count,
          observed_year_range: { start: years.min, end: years.max },
          sector_count: sectors.length,
          firm_age_count: firm_ages.length,
          firm_size_count: firm_sizes.length,
          numeric_cell_count: numeric_cell_count,
          publication_flag_counts: publication_flag_counts
        }
      end

      def validate_header!(header)
        raise DryRunError, "BDS dry-run header mismatch: #{header.inspect}" unless header == expected_header
      end

      def validate_dimensions!(row, source_row_number)
        failures = []
        failures << "sector=#{row.fetch('sector')}" unless bds_policy.fetch(:allowed_sector_values).include?(row.fetch("sector"))
        failures << "fage=#{row.fetch('fage')}" unless bds_policy.fetch(:allowed_fage_values).include?(row.fetch("fage"))
        failures << "fsize=#{row.fetch('fsize')}" unless bds_policy.fetch(:allowed_fsize_values).include?(row.fetch("fsize"))
        return if failures.empty?

        raise DryRunError, "unexpected BDS dimension values at row #{source_row_number}: #{failures.join(', ')}"
      end

      def collect_measure_counts!(row, source_row_number, publication_flag_counts)
        numeric_count = 0
        measure_columns.each do |field|
          value = row.fetch(field)
          if allowed_publication_flags.include?(value)
            publication_flag_counts.fetch(field)[value] = publication_flag_counts.fetch(field).fetch(value, 0) + 1
          elsif numeric_cell?(value)
            numeric_count += 1
          else
            raise DryRunError, "unexpected BDS measure cell #{field}=#{value.inspect} at row #{source_row_number}"
          end
        end
        numeric_count
      end

      def numeric_cell?(value)
        BigDecimal(value)
        true
      rescue ArgumentError
        false
      end

      def expected_header
        bds_policy.fetch(:required_columns)
      end

      def row_grain
        bds_policy.fetch(:row_grain)
      end

      def measure_columns
        expected_header - row_grain
      end

      def allowed_publication_flags
        parser_design.fetch(:flag_handling).fetch(:allowed_flags)
      end

      def publication_flag_totals(publication_flag_counts)
        allowed_publication_flags.index_with do |flag|
          publication_flag_counts.values.sum { |counts| counts.fetch(flag, 0) }
        end
      end

      def delimiter
        acquisition_design.fetch(:expected_delimiter)
      end
    end
  end
end
