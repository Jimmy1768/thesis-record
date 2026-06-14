require "test_helper"

class PublicSources::Bfs::DryRunQueryValidatorTest < ActiveSupport::TestCase
  Response = Data.define(:code, :body)

  test "validates dry-run query shape without database writes" do
    result = PublicSources::Bfs::DryRunQueryValidator.call!(
      api_key: "test-key",
      fetcher: ->(_uri) { Response.new(code: "200", body: sample_response.to_json) }
    )

    assert_equal 7, result.total_rows
    assert_equal 6, result.eligible_rows
    assert_equal %w[BA_BA BA_HBA BF_BF4Q BF_BF8Q BF_PBF4Q BF_PBF8Q], result.eligible_data_type_codes
    assert_equal %w[NAICS11], result.eligible_category_codes
    assert_equal %w[no], result.eligible_seasonally_adj_values
    assert_equal %w[0], result.eligible_time_slot_ids
    assert_equal %w[no], result.eligible_error_data_values
    assert result.database_counts_unchanged
    assert_includes result.redacted_query_url, "key=<redacted>"
  end

  test "fails when target response has no eligible rows" do
    error = assert_raises PublicSources::Bfs::DryRunQueryValidator::ValidationError do
      PublicSources::Bfs::DryRunQueryValidator.call!(
        api_key: "test-key",
        fetcher: ->(_uri) { Response.new(code: "200", body: [ sample_header ].to_json) }
      )
    end

    assert_equal "BFS dry run found no eligible rows", error.message
  end

  test "allows existing rows without mutating database counts" do
    operator = create_operator_user
    scaffold = PublicSources::Bfs::ApiScaffold.call!(actor: operator)
    BfsApiRow.create!(
      data_source: scaffold.fetch(:data_source),
      intake_manifest: scaffold.fetch(:intake_manifest),
      schema_version: scaffold.fetch(:schema_version),
      period_month: "2012-01",
      year: 2012,
      month: 1,
      data_type_code: "BA_BA",
      time_slot_id: "0",
      seasonally_adj: "no",
      category_code: "NAICS11",
      geography_level: "us",
      geography_code: "1",
      cell_value_raw: "3290",
      cell_value_numeric: 3290,
      error_data: "no",
      row_hash: SecureRandom.hex(32)
    )

    assert_no_difference -> { BfsApiRow.count } do
      result = PublicSources::Bfs::DryRunQueryValidator.call!(
        api_key: "test-key",
        fetcher: ->(_uri) { Response.new(code: "200", body: sample_response.to_json) }
      )
      assert result.database_counts_unchanged
    end
  end

  private

  def sample_response
    [
      sample_header,
      [ "BA_BA", "0", "no", "NAICS11", "3290", "no", "2012-01", "1" ],
      [ "BA_HBA", "0", "no", "NAICS11", "2128", "no", "2012-01", "1" ],
      [ "BF_BF4Q", "0", "no", "NAICS11", "2044", "no", "2012-01", "1" ],
      [ "BF_BF8Q", "0", "no", "NAICS11", "2138", "no", "2012-01", "1" ],
      [ "BF_PBF4Q", "0", "no", "NAICS11", "2044", "no", "2012-01", "1" ],
      [ "BF_PBF8Q", "0", "no", "NAICS11", "2138", "no", "2012-01", "1" ],
      [ "BA_CBA", "0", "no", "NAICS11", "444", "no", "2012-01", "1" ]
    ]
  end

  def sample_header
    %w[data_type_code time_slot_id seasonally_adj category_code cell_value error_data time us]
  end
end
