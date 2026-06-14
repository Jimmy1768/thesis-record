require "test_helper"

class PublicSources::Bfs::LoadSampleRowsTest < ActiveSupport::TestCase
  Response = Data.define(:code, :body)

  test "loads eligible BFS sample rows without metrics or claim artifacts" do
    assert_difference -> { BfsApiRow.count }, 2 do
      assert_no_difference -> { MetricDefinition.where("key LIKE ?", "bfs_%").count } do
        assert_no_difference -> { MetricObservation.count } do
          @result = PublicSources::Bfs::LoadSampleRows.call!(
            actor: create_operator_user,
            api_key: "test-key",
            expected_eligible_rows: 2,
            fetcher: ->(_uri) { Response.new(code: "200", body: sample_response.to_json) }
          )
        end
      end
    end

    assert_equal 2, @result.total_rows
    assert_equal 2, @result.eligible_rows
    assert_equal 2, @result.rows_upserted
    assert_equal 0, @result.metric_definitions_created
    assert_equal 0, @result.metric_observations_created
    row = BfsApiRow.find_by!(data_type_code: "BA_BA")
    assert_equal "2012-01", row.period_month
    assert_equal "NAICS11", row.category_code
    assert_equal "no", row.seasonally_adj
    assert_equal false, row.metadata.fetch("metrics_authorized")
    assert_equal false, row.metadata.fetch("analysis_authorized")
    assert_equal false, row.metadata.fetch("exports_authorized")
    assert_equal false, row.metadata.fetch("prediction_links_authorized")
    suppressed_row = BfsApiRow.find_by!(category_code: "NAICS21")
    assert_equal "D", suppressed_row.cell_value_raw
    assert_nil suppressed_row.cell_value_numeric
    assert_equal true, suppressed_row.metadata.fetch("raw_cell_value_non_numeric")
  end

  test "is idempotent by source-native row grain" do
    operator = create_operator_user
    PublicSources::Bfs::LoadSampleRows.call!(
      actor: operator,
      api_key: "test-key",
      expected_eligible_rows: 2,
      fetcher: ->(_uri) { Response.new(code: "200", body: sample_response.to_json) }
    )

    assert_no_difference -> { BfsApiRow.count } do
      PublicSources::Bfs::LoadSampleRows.call!(
        actor: operator,
        api_key: "test-key",
        expected_eligible_rows: 2,
        fetcher: ->(_uri) { Response.new(code: "200", body: sample_response.to_json) }
      )
    end
  end

  private

  def sample_response
    [
      sample_header,
      [ "BA_BA", "0", "no", "NAICS11", "3290", "no", "2012-01", "1" ],
      [ "BA_BA", "0", "no", "NAICS21", "D", "no", "2012-01", "1" ]
    ]
  end

  def sample_header
    %w[data_type_code time_slot_id seasonally_adj category_code cell_value error_data time us]
  end
end
