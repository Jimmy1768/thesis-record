class CreateSusbPublicFileRows < ActiveRecord::Migration[7.2]
  def change
    create_table :susb_public_file_rows do |t|
      t.references :data_source, null: false, foreign_key: true
      t.references :intake_manifest, null: false, foreign_key: true
      t.references :schema_version, null: false, foreign_key: true
      t.integer :year, null: false
      t.string :state_code, null: false
      t.string :naics_code, null: false
      t.string :enterprise_size_code, null: false
      t.bigint :firm_count, null: false
      t.bigint :establishment_count, null: false
      t.bigint :employment, null: false
      t.string :employment_noise_flag, null: false
      t.bigint :annual_payroll_thousand, null: false
      t.string :payroll_noise_flag, null: false
      t.bigint :receipts_thousand
      t.string :receipts_noise_flag
      t.string :state_name, null: false
      t.text :naics_description, null: false
      t.string :enterprise_size_description, null: false
      t.string :row_hash, null: false
      t.jsonb :metadata, default: {}, null: false
      t.timestamps
    end

    add_index :susb_public_file_rows,
              [ :data_source_id, :year, :state_code, :naics_code, :enterprise_size_code ],
              unique: true,
              name: "index_susb_rows_on_source_year_state_naics_size"
    add_index :susb_public_file_rows, [ :year, :state_code, :naics_code ], name: "index_susb_rows_on_year_state_naics"
    add_index :susb_public_file_rows, :row_hash
  end
end
