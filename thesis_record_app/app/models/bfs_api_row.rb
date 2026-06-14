class BfsApiRow < ApplicationRecord
  belongs_to :data_source
  belongs_to :intake_manifest
  belongs_to :schema_version

  validates :period_month, :year, :month, :data_type_code, :time_slot_id,
            :seasonally_adj, :category_code, :geography_level,
            :geography_code, :cell_value_raw, :error_data, :row_hash,
            presence: true
  validates :seasonally_adj, inclusion: { in: %w[no yes] }
  validates :month, inclusion: { in: 1..12 }
  validates :data_type_code,
            uniqueness: {
              scope: [
                :data_source_id,
                :period_month,
                :category_code,
                :seasonally_adj,
                :geography_level,
                :geography_code
              ]
            }
end
