require "test_helper"

class BdsPublicFileRowTest < ActiveSupport::TestCase
  setup do
    @operator = create_operator_user
    @scaffold = PublicSources::Bds::PublicFileScaffold.call!(actor: @operator)
  end

  test "validates source-native BDS row grain uniqueness" do
    create_bds_row

    duplicate = build_bds_row
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:sector_code], "has already been taken"
  end

  test "requires source row number and row hash" do
    row = build_bds_row(source_row_number: nil, row_hash: nil)

    assert_not row.valid?
    assert_includes row.errors[:source_row_number], "can't be blank"
    assert_includes row.errors[:row_hash], "can't be blank"
  end

  private

  def create_bds_row(**overrides)
    build_bds_row(**overrides).tap(&:save!)
  end

  def build_bds_row(**overrides)
    BdsPublicFileRow.new(
      {
        data_source: @scaffold.fetch(:data_source),
        intake_manifest: @scaffold.fetch(:intake_manifest),
        schema_version: @scaffold.fetch(:schema_version),
        source_row_number: 1,
        year: 1978,
        sector_code: "11",
        firm_age_code: "a) 0",
        firm_size_code: "a) 1 to 4",
        raw_measure_values: { "firms" => "1" },
        numeric_measure_values: { "firms" => "1" },
        publication_flags: {},
        row_hash: SecureRandom.hex(32),
        metadata: {
          parser_authorized: false,
          row_load_authorized: false,
          analysis_authorized: false,
          exports_authorized: false,
          prediction_links_authorized: false
        }
      }.merge(overrides)
    )
  end
end
