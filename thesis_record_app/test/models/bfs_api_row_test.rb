require "test_helper"

class BfsApiRowTest < ActiveSupport::TestCase
  setup do
    @operator = create_operator_user
    @scaffold = PublicSources::Bfs::ApiScaffold.call!(actor: @operator)
  end

  test "validates source-native BFS row grain uniqueness" do
    create_bfs_row

    duplicate = build_bfs_row
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:data_type_code], "has already been taken"
  end

  test "requires valid seasonality value" do
    row = build_bfs_row(seasonally_adj: "maybe")

    assert_not row.valid?
    assert_includes row.errors[:seasonally_adj], "is not included in the list"
  end

  private

  def create_bfs_row(**overrides)
    build_bfs_row(**overrides).tap(&:save!)
  end

  def build_bfs_row(**overrides)
    BfsApiRow.new(
      {
        data_source: @scaffold.fetch(:data_source),
        intake_manifest: @scaffold.fetch(:intake_manifest),
        schema_version: @scaffold.fetch(:schema_version),
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
        row_hash: SecureRandom.hex(32),
        metadata: {
          metrics_authorized: false,
          analysis_authorized: false,
          exports_authorized: false,
          prediction_links_authorized: false
        }
      }.merge(overrides)
    )
  end
end
