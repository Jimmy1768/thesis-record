require "test_helper"
require "csv"
require "json"

class PeriodicSourceParsersTest < ActiveSupport::TestCase
  setup do
    @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
  end

  test "BDS parser preserves numeric and publication cells as database attributes" do
    header = bds_settings.fetch(:required_columns).map(&:to_s)
    row = header.index_with { "1" }
    row.merge!("year" => "2023", "sector" => "11", "fage" => "a) 0", "fsize" => "a) 1 to 4",
               "estabs_exit" => "D")
    parsed = Evidence::PeriodicSourceParsers.bds(policy: @policy).call(csv_response(header, row)).to_a

    assert_equal 1, parsed.size
    assert_equal 2023, parsed.first.fetch(:year)
    assert_equal "D", parsed.first.fetch(:raw_measure_values).fetch("estabs_exit")
    assert_nil parsed.first.fetch(:numeric_measure_values).fetch("estabs_exit")
    assert_equal "D", parsed.first.fetch(:publication_flags).fetch("estabs_exit")
    assert_equal "1.0", parsed.first.fetch(:numeric_measure_values).fetch("firms")
  end

  test "SUSB parser enforces the exact header and flags" do
    header = susb_settings.fetch(:expected_header).map(&:to_s)
    row = header.index_with { "1" }
    row.merge!("STATE" => "00", "NAICS" => "11", "ENTRSIZE" => "001",
               "EMPLFL_N" => "G", "PAYRFL_N" => "H", "RCPTFL_N" => "D",
               "STATEDSCR" => "United States", "NAICSDSCR" => "Agriculture",
               "ENTRSIZEDSCR" => "All")
    parsed = Evidence::PeriodicSourceParsers.susb(year: 2024, policy: @policy).call(csv_response(header, row)).to_a
    assert_equal 2024, parsed.first.fetch(:year)
    assert_equal "G", parsed.first.fetch(:employment_noise_flag)
    assert_equal 1, parsed.first.fetch(:receipts_thousand)

    assert_raises(Evidence::PeriodicSourceParsers::InvalidResponse) do
      Evidence::PeriodicSourceParsers.susb(year: 2024, policy: @policy)
                                     .call(csv_response(header.drop(1), row)).to_a
    end
    row["PAYRFL_N"] = "invalid"
    assert_raises(Evidence::PeriodicSourceParsers::InvalidResponse) do
      Evidence::PeriodicSourceParsers.susb(year: 2024, policy: @policy)
                                     .call(csv_response(header, row)).to_a
    end
  end

  test "malformed BDS row cannot become a parsed database row" do
    header = bds_settings.fetch(:required_columns).map(&:to_s)
    row = header.index_with { "1" }.merge("year" => "2023", "sector" => "11",
                                            "fage" => "a) 0", "fsize" => "a) 1 to 4")
    row["firms"] = "not-a-number"
    assert_raises(Evidence::PeriodicSourceParsers::InvalidResponse) do
      Evidence::PeriodicSourceParsers.bds(policy: @policy).call(csv_response(header, row)).to_a
    end
  end

  test "BDS release year is checked and non-finite values are rejected" do
    header = bds_settings.fetch(:required_columns).map(&:to_s)
    row = header.index_with { "1" }.merge("year" => "2025", "sector" => "11",
                                           "fage" => "a) 0", "fsize" => "a) 1 to 4")
    parser = Evidence::PeriodicSourceParsers.bds(release_year: 2026, policy: @policy)
    assert_raises(Evidence::PeriodicSourceParsers::InvalidResponse) do
      parser.call(csv_response(header, row)).to_a
    end
    row["year"] = "2027"
    assert_raises(Evidence::PeriodicSourceParsers::InvalidResponse) do
      parser.call(csv_response(header, row)).to_a
    end
    row["year"] = "2026"
    row["firms"] = "NaN"
    assert_raises(Evidence::PeriodicSourceParsers::InvalidResponse) do
      parser.call(csv_response(header, row)).to_a
    end
  end

  test "BFS parser uses configured scope without a sample-year limit" do
    header = bfs_settings.fetch(:dry_run_v1).fetch(:expected_response_header)
    eligible = [ "BA_BA", "0", "no", "NAICS11", "42", "no", "2026-09", "1" ]
    excluded = eligible.dup.tap { |row| row[3] = "TOTAL" }
    error = eligible.dup.tap { |row| row[0] = "BA_HBA"; row[4] = "D"; row[5] = "yes" }
    parsed = Evidence::PeriodicSourceParsers.bfs(year: 2026, through_month: 9, policy: @policy)
                                            .call(JSON.generate([ header, eligible, excluded, error ])).to_a

    assert_equal 2, parsed.size
    assert_equal "2026-09", parsed.first.fetch(:period_month)
    assert_equal "42.0", parsed.first.fetch(:cell_value_numeric)
    assert_nil parsed.last.fetch(:cell_value_numeric)
    assert_equal "D", parsed.last.fetch(:cell_value_raw)
  end

  test "BFS rejects a response beyond the cutoff rather than silently changing capture membership" do
    header = bfs_settings.fetch(:dry_run_v1).fetch(:expected_response_header)
    row = [ "BA_BA", "0", "no", "NAICS11", "42", "no", "2026-10", "1" ]
    parser = Evidence::PeriodicSourceParsers.bfs(year: 2026, through_month: 9, policy: @policy)
    [ row, row.dup.tap { |cells| cells[3] = "TOTAL" } ].each do |later_row|
      assert_raises(Evidence::PeriodicSourceParsers::InvalidResponse) do
        parser.call(JSON.generate([ header, later_row ])).to_a
      end
    end
  end

  test "BFS accepts a lagged latest month without inventing quarter-end coverage" do
    header = bfs_settings.fetch(:dry_run_v1).fetch(:expected_response_header)
    row = [ "BA_BA", "0", "no", "NAICS11", "42", "no", "2026-08", "1" ]
    parser = Evidence::PeriodicSourceParsers.bfs(year: 2026, through_month: 9, policy: @policy)
    assert_equal [ "2026-08" ], parser.call(JSON.generate([ header, row ])).map { |item| item.fetch(:period_month) }
  end

  test "BFS parser rejects malformed rows, geography, and duplicate grain" do
    header = bfs_settings.fetch(:dry_run_v1).fetch(:expected_response_header)
    row = [ "BA_BA", "0", "no", "NAICS11", "42", "no", "2026-09", "1" ]
    parser = Evidence::PeriodicSourceParsers.bfs(year: 2026, policy: @policy)
    [ [ header.drop(1), row ], [ header, row.drop(1) ],
      [ header, row.dup.tap { |cells| cells[-1] = "2" } ],
      [ header, row, row ] ].each do |payload|
      assert_raises(Evidence::PeriodicSourceParsers::InvalidResponse) do
        parser.call(JSON.generate(payload)).to_a
      end
    end
  end

  private

  def bds_settings
    @policy.fetch(:public_ingestion_v1).fetch(:bds_sector_age_size_public_file)
  end

  def susb_settings
    @policy.fetch(:public_ingestion_v1).fetch(:susb_us_state_annual)
  end

  def bfs_settings
    @policy.fetch(:public_ingestion_v1).fetch(:bfs_monthly_api)
  end

  def csv_response(header, row)
    CSV.generate_line(header) + CSV.generate_line(header.map { |field| row.fetch(field) })
  end
end
