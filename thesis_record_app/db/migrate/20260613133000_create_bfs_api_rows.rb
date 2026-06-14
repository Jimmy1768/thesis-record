class CreateBfsApiRows < ActiveRecord::Migration[7.2]
  def change
    create_table :bfs_api_rows do |t|
      t.references :data_source, null: false, foreign_key: true
      t.references :intake_manifest, null: false, foreign_key: true
      t.references :schema_version, null: false, foreign_key: true
      t.string :period_month, null: false
      t.integer :year, null: false
      t.integer :month, null: false
      t.string :data_type_code, null: false
      t.string :time_slot_id, null: false
      t.string :seasonally_adj, null: false
      t.string :category_code, null: false
      t.string :geography_level, null: false
      t.string :geography_code, null: false
      t.string :cell_value_raw, null: false
      t.decimal :cell_value_numeric, precision: 20, scale: 6
      t.string :error_data, null: false
      t.string :row_hash, null: false
      t.jsonb :metadata, default: {}, null: false

      t.timestamps
    end

    add_index :bfs_api_rows,
              [
                :data_source_id,
                :period_month,
                :data_type_code,
                :category_code,
                :seasonally_adj,
                :geography_level,
                :geography_code
              ],
              unique: true,
              name: "index_bfs_rows_on_source_month_series_category_geo"
    add_index :bfs_api_rows, :period_month
    add_index :bfs_api_rows, :data_type_code
    add_index :bfs_api_rows, :category_code
    add_index :bfs_api_rows, :seasonally_adj
    add_index :bfs_api_rows, :row_hash
  end
end
