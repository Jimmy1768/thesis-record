class CreatePeriodicDatabaseCollections < ActiveRecord::Migration[7.2]
  def change
    create_table :day_zero_registrations do |t|
      t.string :baseline_key, null: false
      t.date :baseline_observed_on, null: false
      t.string :manifest_digest, null: false
      t.jsonb :manifest, null: false
      t.datetime :verified_at, null: false
      t.timestamps
    end
    add_index :day_zero_registrations, :baseline_key, unique: true

    create_table :periodic_captures do |t|
      t.references :data_source, null: false, foreign_key: true
      t.string :dataset_scope, null: false
      t.string :release_identity, null: false
      t.string :response_sha256, null: false
      t.string :parsed_rows_digest, null: false
      t.string :parser_version, null: false
      t.bigint :row_count, null: false
      t.string :status, null: false, default: "loading"
      t.datetime :retrieved_at, null: false
      t.datetime :completed_at
      t.timestamps
    end
    add_index :periodic_captures,
              %i[data_source_id dataset_scope release_identity response_sha256 parser_version],
              unique: true, name: "index_periodic_captures_on_identity"
    add_check_constraint :periodic_captures, "status IN ('loading', 'completed')",
                         name: "periodic_captures_status"
    add_check_constraint :periodic_captures, "row_count >= 0", name: "periodic_captures_nonnegative_count"
    add_check_constraint :periodic_captures,
                         "(status = 'loading' AND completed_at IS NULL) OR (status = 'completed' AND completed_at IS NOT NULL)",
                         name: "periodic_captures_completion"

    create_table :periodic_source_checks do |t|
      t.references :data_source, null: false, foreign_key: true
      t.references :periodic_capture, foreign_key: true
      t.string :dataset_scope, null: false
      t.string :release_identity, null: false
      t.string :status, null: false
      t.string :error_class
      t.datetime :checked_at, null: false
      t.timestamps
    end
    add_check_constraint :periodic_source_checks,
                         "status IN ('new', 'unchanged', 'failed')",
                         name: "periodic_source_checks_status"
    add_check_constraint :periodic_source_checks,
                         "(status = 'failed' AND periodic_capture_id IS NULL) OR (status <> 'failed' AND periodic_capture_id IS NOT NULL)",
                         name: "periodic_source_checks_capture_presence"

    create_table :quarterly_result_sets do |t|
      t.string :input_digest, null: false
      t.string :method_digest, null: false
      t.string :definition_digest, null: false
      t.string :identity_digest, null: false
      t.jsonb :method_manifest, null: false
      t.string :status, null: false, default: "building"
      t.bigint :observation_count
      t.bigint :review_count
      t.datetime :completed_at
      t.timestamps
    end
    add_index :quarterly_result_sets, :identity_digest, unique: true
    add_check_constraint :quarterly_result_sets, "status IN ('building', 'completed')",
                         name: "quarterly_result_sets_status"
    add_check_constraint :quarterly_result_sets,
                         "(status = 'building' AND completed_at IS NULL) OR (status = 'completed' AND completed_at IS NOT NULL AND observation_count = review_count)",
                         name: "quarterly_result_sets_completion"

    create_table :quarterly_collections do |t|
      t.string :quarter, null: false
      t.integer :revision, null: false
      t.string :identity_digest, null: false
      t.string :input_digest, null: false
      t.references :quarterly_result_set, foreign_key: true
      t.string :status, null: false, default: "building"
      t.datetime :cutoff_at, null: false
      t.datetime :completed_at
      t.timestamps
    end
    add_index :quarterly_collections, %i[quarter revision], unique: true
    add_index :quarterly_collections, %i[quarter identity_digest], unique: true,
              name: "index_quarterly_collections_on_identity"
    add_check_constraint :quarterly_collections, "quarter ~ '^[0-9]{4}-Q[1-4]$'",
                         name: "quarterly_collections_quarter_format"
    add_check_constraint :quarterly_collections, "revision > 0", name: "quarterly_collections_revision"
    add_check_constraint :quarterly_collections, "status IN ('building', 'completed')",
                         name: "quarterly_collections_status"
    add_check_constraint :quarterly_collections,
                         "(status = 'building' AND completed_at IS NULL) OR (status = 'completed' AND completed_at IS NOT NULL AND quarterly_result_set_id IS NOT NULL)",
                         name: "quarterly_collections_completion"

    create_table :quarterly_collection_captures do |t|
      t.references :quarterly_collection, null: false, foreign_key: true,
                   index: { name: "index_quarter_capture_on_collection" }
      t.references :periodic_capture, null: false, foreign_key: true,
                   index: { name: "index_quarter_capture_on_capture" }
      t.timestamps
    end
    add_index :quarterly_collection_captures,
              %i[quarterly_collection_id periodic_capture_id], unique: true,
              name: "index_quarter_capture_on_pair"

    add_reference :susb_public_file_rows, :periodic_capture, foreign_key: true
    add_reference :bds_public_file_rows, :periodic_capture, foreign_key: true
    add_reference :bfs_api_rows, :periodic_capture, foreign_key: true
    add_reference :metric_observations, :quarterly_result_set, foreign_key: true
    add_column :metric_observations, :result_row_key, :string
    add_index :metric_observations, %i[quarterly_result_set_id result_row_key],
              unique: true, where: "quarterly_result_set_id IS NOT NULL",
              name: "index_metric_observations_on_result_row"
    add_check_constraint :metric_observations,
                         "(quarterly_result_set_id IS NULL AND result_row_key IS NULL) OR (quarterly_result_set_id IS NOT NULL AND result_row_key IS NOT NULL)",
                         name: "metric_observations_result_key_presence"

    replace_source_unique_indexes
  end

  private

  def replace_source_unique_indexes
    indexes = {
      susb_public_file_rows: {
        name: "index_susb_rows_on_source_year_state_naics_size",
        columns: %i[data_source_id year state_code naics_code enterprise_size_code]
      },
      bds_public_file_rows: {
        name: "index_bds_rows_on_source_year_sector_age_size",
        columns: %i[data_source_id year sector_code firm_age_code firm_size_code]
      },
      bfs_api_rows: {
        name: "index_bfs_rows_on_source_month_series_category_geo",
        columns: %i[data_source_id period_month data_type_code category_code seasonally_adj geography_level geography_code]
      }
    }
    indexes.each do |table, definition|
      remove_index table, name: definition.fetch(:name)
      add_index table, definition.fetch(:columns), unique: true,
                where: "periodic_capture_id IS NULL", name: definition.fetch(:name)
      add_index table, [ :periodic_capture_id, *definition.fetch(:columns).drop(1) ], unique: true,
                where: "periodic_capture_id IS NOT NULL", name: "index_#{table}_on_capture_grain"
    end
  end
end
