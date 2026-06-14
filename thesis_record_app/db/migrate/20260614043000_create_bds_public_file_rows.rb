class CreateBdsPublicFileRows < ActiveRecord::Migration[7.2]
  def change
    create_table :bds_public_file_rows do |t|
      t.references :data_source, null: false, foreign_key: true
      t.references :intake_manifest, null: false, foreign_key: true
      t.references :schema_version, null: false, foreign_key: true
      t.integer :source_row_number, null: false
      t.integer :year, null: false
      t.string :sector_code, null: false
      t.string :firm_age_code, null: false
      t.string :firm_size_code, null: false
      t.jsonb :raw_measure_values, default: {}, null: false
      t.jsonb :numeric_measure_values, default: {}, null: false
      t.jsonb :publication_flags, default: {}, null: false
      t.string :row_hash, null: false
      t.jsonb :metadata, default: {}, null: false
      t.timestamps
    end

    add_index :bds_public_file_rows,
              [ :data_source_id, :year, :sector_code, :firm_age_code, :firm_size_code ],
              unique: true,
              name: "index_bds_rows_on_source_year_sector_age_size"
    add_index :bds_public_file_rows, [ :year, :sector_code ], name: "index_bds_rows_on_year_sector"
    add_index :bds_public_file_rows, :row_hash
  end
end
