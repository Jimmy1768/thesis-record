require "bigdecimal"
require "csv"
require "digest"
require "json"
require "stringio"

module Evidence
  class PeriodicSourceParsers
    class InvalidResponse < StandardError; end

    def self.susb(year:, policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
      settings = policy.fetch(:public_ingestion_v1).fetch(:susb_us_state_annual)
      expected = settings.fetch(:expected_header).map(&:to_s)
      flags = settings.fetch(:allowed_noise_flags).map(&:to_s)
      reference_year = Integer(year)
      lambda do |response|
        csv = open_csv(response, expected, encoding: "ISO-8859-1")
        Enumerator.new do |output|
          csv.each.with_index(1) do |cells, line|
            row = row_hash(cells, expected, line)
            %w[EMPLFL_N PAYRFL_N].each do |field|
              raise InvalidResponse, "SUSB invalid #{field} at row #{line}" unless flags.include?(row.fetch(field))
            end
            optional_flag = row.fetch("RCPTFL_N")
            if optional_flag.present? && !flags.include?(optional_flag)
              raise InvalidResponse, "SUSB invalid RCPTFL_N at row #{line}"
            end
            output << {
              year: reference_year, state_code: row.fetch("STATE"), naics_code: row.fetch("NAICS"),
              enterprise_size_code: row.fetch("ENTRSIZE"),
              firm_count: integer!(row.fetch("FIRM"), "FIRM", line),
              establishment_count: integer!(row.fetch("ESTB"), "ESTB", line),
              employment: integer!(row.fetch("EMPL"), "EMPL", line),
              employment_noise_flag: row.fetch("EMPLFL_N"),
              annual_payroll_thousand: integer!(row.fetch("PAYR"), "PAYR", line),
              payroll_noise_flag: row.fetch("PAYRFL_N"),
              receipts_thousand: row.fetch("RCPT").present? ? integer!(row.fetch("RCPT"), "RCPT", line) : nil,
              receipts_noise_flag: optional_flag.presence,
              state_name: row.fetch("STATEDSCR"), naics_description: row.fetch("NAICSDSCR"),
              enterprise_size_description: row.fetch("ENTRSIZEDSCR"),
              row_hash: Digest::SHA256.hexdigest(expected.map { |field| row.fetch(field) }.join("\0")),
              metadata: { "claim_status_effect" => "unchanged", "source_grain" => "year_state_naics_enterprise_size" }
            }
          end
        end
      end
    end

    def self.bds(release_year: nil, policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
      settings = policy.fetch(:public_ingestion_v1).fetch(:bds_sector_age_size_public_file)
      expected = settings.fetch(:required_columns).map(&:to_s)
      grain = settings.fetch(:row_grain).map(&:to_s)
      flags = settings.fetch(:parser_design_v1).fetch(:flag_handling).fetch(:allowed_flags).map(&:to_s)
      delimiter = settings.fetch(:acquisition_design_v1).fetch(:expected_delimiter)
      lambda do |response|
        csv = open_csv(response, expected, encoding: "UTF-8", delimiter: delimiter)
        Enumerator.new do |output|
          found_release_year = false
          csv.each.with_index(1) do |cells, line|
            row = row_hash(cells, expected, line)
            year = integer!(row.fetch("year"), "year", line)
            if release_year
              raise InvalidResponse, "BDS row #{line} exceeds release year" if year > release_year
              found_release_year ||= year == release_year
            end
            raw_values = {}
            numeric_values = {}
            publication_flags = {}
            (expected - grain).each do |field|
              value = row.fetch(field)
              raw_values[field] = value
              if flags.include?(value)
                numeric_values[field] = nil
                publication_flags[field] = value
              else
                numeric_values[field] = decimal!(value, field, line)
              end
            end
            output << {
              source_row_number: line, year: year,
              sector_code: row.fetch("sector"), firm_age_code: row.fetch("fage"),
              firm_size_code: row.fetch("fsize"), raw_measure_values: raw_values,
              numeric_measure_values: numeric_values, publication_flags: publication_flags,
              row_hash: Digest::SHA256.hexdigest(expected.map { |field| row.fetch(field) }.join("\0")),
              metadata: { "claim_status_effect" => "unchanged", "source_grain" => "year_sector_firm_age_firm_size" }
            }
          end
          raise InvalidResponse, "BDS response lacks release year" if release_year && !found_release_year
        end
      end
    end

    def self.bfs(year:, through_month: 12, policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
      settings = policy.fetch(:public_ingestion_v1).fetch(:bfs_monthly_api)
      design = settings.fetch(:ingestion_design_v1)
      expected = settings.fetch(:dry_run_v1).fetch(:expected_response_header).map(&:to_s)
      reference_year = Integer(year)
      last_month = Integer(through_month)
      raise InvalidResponse, "BFS cutoff month is invalid" unless (1..12).cover?(last_month)

      lambda do |response|
        raise InvalidResponse, "source response must be a String" unless response.is_a?(String)
        payload = JSON.parse(response)
        raise InvalidResponse, "BFS response is not a table" unless payload.is_a?(Array) && payload.first == expected

        Enumerator.new do |output|
          seen = {}
          payload.drop(1).each.with_index(1) do |cells, line|
            raise InvalidResponse, "BFS row #{line} has wrong width" unless cells.is_a?(Array) && cells.size == expected.size
            raise InvalidResponse, "BFS row #{line} contains non-string cells" unless cells.all? { |cell| cell.is_a?(String) }
            row = expected.zip(cells).to_h
            period = row.fetch("time")
            match = /\A(\d{4})-(0[1-9]|1[0-2])\z/.match(period)
            raise InvalidResponse, "BFS row #{line} has invalid period" unless match && match[1].to_i == reference_year
            raise InvalidResponse, "BFS row #{line} has invalid geography" unless row.fetch("us") == design.fetch(:geography_code).to_s

            next unless design.fetch(:first_pass_data_type_codes).include?(row.fetch("data_type_code")) &&
                        design.fetch(:first_pass_category_codes).include?(row.fetch("category_code")) &&
                        design.fetch(:seasonally_adj_allowed).include?(row.fetch("seasonally_adj"))
            raise InvalidResponse, "BFS row #{line} exceeds cutoff month" if match[2].to_i > last_month

            raise InvalidResponse, "BFS row #{line} has invalid slot" unless row.fetch("time_slot_id") == "0"
            raise InvalidResponse, "BFS row #{line} has invalid error flag" unless %w[no yes].include?(row.fetch("error_data"))
            grain = row.values_at("time", "data_type_code", "category_code", "seasonally_adj", "us")
            raise InvalidResponse, "BFS duplicate source grain" if seen[grain]
            seen[grain] = true
            value = row.fetch("cell_value")
            numeric = row.fetch("error_data") == "no" && value.present? ? numeric_or_nil(value) : nil
            output << {
              period_month: period, year: reference_year, month: match[2].to_i,
              data_type_code: row.fetch("data_type_code"), time_slot_id: row.fetch("time_slot_id"),
              seasonally_adj: row.fetch("seasonally_adj"), category_code: row.fetch("category_code"),
              geography_level: design.fetch(:geography_level), geography_code: row.fetch("us"),
              cell_value_raw: value, cell_value_numeric: numeric,
              error_data: row.fetch("error_data"),
              row_hash: Digest::SHA256.hexdigest(expected.map { |field| row.fetch(field) }.join("\0")),
              metadata: { "claim_status_effect" => "unchanged", "source_grain" => "month_data_type_category_adjustment_geography" }
            }
          end
        end
      rescue JSON::ParserError
        raise InvalidResponse, "BFS response is malformed JSON"
      end
    end

    def self.open_csv(response, expected, encoding:, delimiter: ",")
      raise InvalidResponse, "source response must be a String" unless response.is_a?(String)

      text = response.dup.force_encoding(encoding).encode("UTF-8")
      csv = CSV.new(StringIO.new(text), col_sep: delimiter, liberal_parsing: false)
      raise InvalidResponse, "source response header mismatch" unless csv.shift == expected

      csv
    rescue Encoding::InvalidByteSequenceError, Encoding::UndefinedConversionError, CSV::MalformedCSVError
      raise InvalidResponse, "source response is malformed"
    end

    def self.row_hash(cells, expected, line)
      raise InvalidResponse, "source response row #{line} has wrong width" unless cells&.size == expected.size
      raise InvalidResponse, "source response row #{line} contains null cells" if cells.any?(&:nil?)

      expected.zip(cells).to_h
    end

    def self.integer!(value, field, line)
      Integer(value, 10)
    rescue ArgumentError, TypeError
      raise InvalidResponse, "invalid integer #{field} at row #{line}"
    end

    def self.decimal!(value, field, line)
      decimal = BigDecimal(value)
      raise InvalidResponse, "invalid decimal #{field} at row #{line}" unless decimal.finite?
      decimal.to_s("F")
    rescue ArgumentError
      raise InvalidResponse, "invalid decimal #{field} at row #{line}"
    end

    def self.numeric_or_nil(value)
      decimal = BigDecimal(value)
      decimal.finite? ? decimal.to_s("F") : nil
    rescue ArgumentError
      nil
    end

    private_class_method :open_csv, :row_hash, :integer!, :decimal!, :numeric_or_nil
  end
end
