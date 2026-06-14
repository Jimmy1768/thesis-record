# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_06_14_043000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audit_events", force: :cascade do |t|
    t.datetime "occurred_at", null: false
    t.string "actor_type", null: false
    t.string "actor_id"
    t.string "event_type", null: false
    t.string "entity_type", null: false
    t.string "entity_id", null: false
    t.string "source_id"
    t.string "snapshot_id"
    t.string "request_id"
    t.string "job_id"
    t.string "previous_state_hash"
    t.string "new_state_hash"
    t.text "change_summary", null: false
    t.string "reason_code", null: false
    t.boolean "review_required", default: false, null: false
    t.string "review_id"
    t.string "storage_zone", null: false
    t.string "privacy_classification", null: false
    t.string "claim_status_effect", default: "unchanged", null: false
    t.boolean "export_allowed", default: false, null: false
    t.string "ip_or_host"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_type", "entity_id"], name: "index_audit_events_on_entity_type_and_entity_id"
    t.index ["event_type", "occurred_at"], name: "index_audit_events_on_event_type_and_occurred_at"
  end

  create_table "bds_public_file_rows", force: :cascade do |t|
    t.bigint "data_source_id", null: false
    t.bigint "intake_manifest_id", null: false
    t.bigint "schema_version_id", null: false
    t.integer "source_row_number", null: false
    t.integer "year", null: false
    t.string "sector_code", null: false
    t.string "firm_age_code", null: false
    t.string "firm_size_code", null: false
    t.jsonb "raw_measure_values", default: {}, null: false
    t.jsonb "numeric_measure_values", default: {}, null: false
    t.jsonb "publication_flags", default: {}, null: false
    t.string "row_hash", null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_source_id", "year", "sector_code", "firm_age_code", "firm_size_code"], name: "index_bds_rows_on_source_year_sector_age_size", unique: true
    t.index ["data_source_id"], name: "index_bds_public_file_rows_on_data_source_id"
    t.index ["intake_manifest_id"], name: "index_bds_public_file_rows_on_intake_manifest_id"
    t.index ["row_hash"], name: "index_bds_public_file_rows_on_row_hash"
    t.index ["schema_version_id"], name: "index_bds_public_file_rows_on_schema_version_id"
    t.index ["year", "sector_code"], name: "index_bds_rows_on_year_sector"
  end

  create_table "bfs_api_rows", force: :cascade do |t|
    t.bigint "data_source_id", null: false
    t.bigint "intake_manifest_id", null: false
    t.bigint "schema_version_id", null: false
    t.string "period_month", null: false
    t.integer "year", null: false
    t.integer "month", null: false
    t.string "data_type_code", null: false
    t.string "time_slot_id", null: false
    t.string "seasonally_adj", null: false
    t.string "category_code", null: false
    t.string "geography_level", null: false
    t.string "geography_code", null: false
    t.string "cell_value_raw", null: false
    t.decimal "cell_value_numeric", precision: 20, scale: 6
    t.string "error_data", null: false
    t.string "row_hash", null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_code"], name: "index_bfs_api_rows_on_category_code"
    t.index ["data_source_id", "period_month", "data_type_code", "category_code", "seasonally_adj", "geography_level", "geography_code"], name: "index_bfs_rows_on_source_month_series_category_geo", unique: true
    t.index ["data_source_id"], name: "index_bfs_api_rows_on_data_source_id"
    t.index ["data_type_code"], name: "index_bfs_api_rows_on_data_type_code"
    t.index ["intake_manifest_id"], name: "index_bfs_api_rows_on_intake_manifest_id"
    t.index ["period_month"], name: "index_bfs_api_rows_on_period_month"
    t.index ["row_hash"], name: "index_bfs_api_rows_on_row_hash"
    t.index ["schema_version_id"], name: "index_bfs_api_rows_on_schema_version_id"
    t.index ["seasonally_adj"], name: "index_bfs_api_rows_on_seasonally_adj"
  end

  create_table "claim_reviews", force: :cascade do |t|
    t.bigint "prediction_link_id"
    t.string "claim_id", null: false
    t.string "review_status", default: "review_pending", null: false
    t.string "prior_status", null: false
    t.string "proposed_status", null: false
    t.string "reason_code", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prediction_link_id"], name: "index_claim_reviews_on_prediction_link_id"
  end

  create_table "data_sources", force: :cascade do |t|
    t.string "name", null: false
    t.string "source_kind", null: false
    t.string "source_status", default: "source_registered", null: false
    t.string "storage_zone", null: false
    t.string "privacy_classification", null: false
    t.boolean "public_repo_allowed", default: false, null: false
    t.boolean "structured_private_allowed", default: true, null: false
    t.boolean "private_file_storage_allowed", default: false, null: false
    t.boolean "secret_material_present", default: false, null: false
    t.boolean "redaction_required", default: true, null: false
    t.boolean "minimum_cell_rule_required", default: true, null: false
    t.boolean "human_review_required", default: true, null: false
    t.string "retention_rule", null: false
    t.string "claim_status_allowed", default: "not_evidence", null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_data_sources_on_name"
    t.index ["privacy_classification"], name: "index_data_sources_on_privacy_classification"
    t.index ["source_status"], name: "index_data_sources_on_source_status"
    t.index ["storage_zone"], name: "index_data_sources_on_storage_zone"
  end

  create_table "evidence_snapshots", force: :cascade do |t|
    t.string "version_label", null: false
    t.string "snapshot_status", null: false
    t.datetime "frozen_at", null: false
    t.string "commit_sha"
    t.jsonb "manifest", default: {}, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["version_label"], name: "index_evidence_snapshots_on_version_label", unique: true
  end

  create_table "export_artifacts", force: :cascade do |t|
    t.bigint "evidence_snapshot_id"
    t.string "artifact_kind", null: false
    t.string "export_status", default: "draft", null: false
    t.string "privacy_review_status", default: "pending", null: false
    t.boolean "reviewed_for_public_repo", default: false, null: false
    t.string "artifact_path"
    t.string "content_hash"
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["evidence_snapshot_id"], name: "index_export_artifacts_on_evidence_snapshot_id"
  end

  create_table "failure_records", force: :cascade do |t|
    t.bigint "prediction_link_id"
    t.bigint "audit_event_id"
    t.string "prediction_id", null: false
    t.string "horizon", null: false
    t.string "failure_type", null: false
    t.string "evidence_object_id"
    t.string "source_status"
    t.string "metric_status", null: false
    t.string "observed_direction", null: false
    t.string "expected_direction", null: false
    t.boolean "failure_condition_triggered", default: false, null: false
    t.text "alternative_explanation"
    t.text "business_cycle_context"
    t.string "company_case_scope"
    t.string "human_review_status", default: "pending", null: false
    t.string "publication_status", default: "not_public", null: false
    t.string "revision_action", default: "none", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audit_event_id"], name: "index_failure_records_on_audit_event_id"
    t.index ["failure_type"], name: "index_failure_records_on_failure_type"
    t.index ["prediction_id"], name: "index_failure_records_on_prediction_id"
    t.index ["prediction_link_id"], name: "index_failure_records_on_prediction_link_id"
  end

  create_table "intake_manifests", force: :cascade do |t|
    t.bigint "data_source_id", null: false
    t.string "name", null: false
    t.string "manifest_status", default: "empty_manifest", null: false
    t.string "storage_zone", null: false
    t.string "privacy_classification", null: false
    t.boolean "public_repo_allowed", default: false, null: false
    t.boolean "structured_private_allowed", default: true, null: false
    t.boolean "private_file_storage_allowed", default: false, null: false
    t.boolean "secret_material_present", default: false, null: false
    t.boolean "redaction_required", default: true, null: false
    t.boolean "minimum_cell_rule_required", default: true, null: false
    t.boolean "human_review_required", default: true, null: false
    t.string "retention_rule", null: false
    t.jsonb "field_map", default: {}, null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_source_id"], name: "index_intake_manifests_on_data_source_id"
  end

  create_table "metric_definitions", force: :cascade do |t|
    t.string "key", null: false
    t.string "name", null: false
    t.string "formula_status", default: "draft", null: false
    t.text "formula"
    t.text "limitations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_metric_definitions_on_key", unique: true
  end

  create_table "metric_observations", force: :cascade do |t|
    t.bigint "metric_definition_id", null: false
    t.bigint "data_source_id"
    t.string "period", null: false
    t.string "metric_status", null: false
    t.decimal "numeric_value", precision: 20, scale: 6
    t.string "unit"
    t.jsonb "dimensions", default: {}, null: false
    t.jsonb "quality_metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_source_id"], name: "index_metric_observations_on_data_source_id"
    t.index ["metric_definition_id"], name: "index_metric_observations_on_metric_definition_id"
    t.index ["period"], name: "index_metric_observations_on_period"
  end

  create_table "metric_quality_reviews", force: :cascade do |t|
    t.bigint "metric_observation_id", null: false
    t.bigint "data_source_id"
    t.string "policy_version", null: false
    t.string "source_metric_status", null: false
    t.string "review_status", null: false
    t.string "review_reason_code", null: false
    t.string "reviewed_by", null: false
    t.datetime "reviewed_at", null: false
    t.jsonb "review_metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_source_id"], name: "index_metric_quality_reviews_on_data_source_id"
    t.index ["metric_observation_id"], name: "index_metric_quality_reviews_on_metric_observation_id"
    t.index ["metric_observation_id"], name: "index_metric_quality_reviews_on_observation", unique: true
    t.index ["policy_version"], name: "index_metric_quality_reviews_on_policy_version"
    t.index ["review_status"], name: "index_metric_quality_reviews_on_review_status"
    t.index ["reviewed_at"], name: "index_metric_quality_reviews_on_reviewed_at"
  end

  create_table "prediction_links", force: :cascade do |t|
    t.bigint "metric_observation_id"
    t.bigint "data_source_id"
    t.string "prediction_id", null: false
    t.string "evidence_classification", null: false
    t.string "review_status", default: "review_pending", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_source_id"], name: "index_prediction_links_on_data_source_id"
    t.index ["metric_observation_id"], name: "index_prediction_links_on_metric_observation_id"
    t.index ["prediction_id"], name: "index_prediction_links_on_prediction_id"
  end

  create_table "privacy_reviews", force: :cascade do |t|
    t.bigint "data_source_id"
    t.bigint "intake_manifest_id"
    t.string "review_status", null: false
    t.string "privacy_classification", null: false
    t.string "reviewed_by", null: false
    t.boolean "identity_fields_removed", default: false, null: false
    t.boolean "client_confidentiality_reviewed", default: false, null: false
    t.boolean "worker_or_evaluator_confidentiality_reviewed", default: false, null: false
    t.boolean "hidden_labor_reviewed", default: false, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_source_id"], name: "index_privacy_reviews_on_data_source_id"
    t.index ["intake_manifest_id"], name: "index_privacy_reviews_on_intake_manifest_id"
  end

  create_table "private_artifacts", force: :cascade do |t|
    t.bigint "data_source_id"
    t.string "artifact_kind", null: false
    t.string "storage_zone", null: false
    t.string "privacy_classification", null: false
    t.boolean "public_repo_allowed", default: false, null: false
    t.boolean "structured_private_allowed", default: false, null: false
    t.boolean "private_file_storage_allowed", default: true, null: false
    t.boolean "secret_material_present", default: false, null: false
    t.boolean "redaction_required", default: true, null: false
    t.boolean "minimum_cell_rule_required", default: true, null: false
    t.boolean "human_review_required", default: true, null: false
    t.string "storage_pointer", null: false
    t.string "content_hash", null: false
    t.string "retention_rule", null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_source_id"], name: "index_private_artifacts_on_data_source_id"
  end

  create_table "quality_flags", force: :cascade do |t|
    t.bigint "metric_observation_id"
    t.bigint "data_source_id"
    t.string "flag_type", null: false
    t.string "status", default: "open", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_source_id"], name: "index_quality_flags_on_data_source_id"
    t.index ["metric_observation_id"], name: "index_quality_flags_on_metric_observation_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "schema_versions", force: :cascade do |t|
    t.bigint "data_source_id"
    t.bigint "intake_manifest_id"
    t.string "version", null: false
    t.string "schema_status", default: "draft", null: false
    t.jsonb "schema", default: {}, null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_source_id"], name: "index_schema_versions_on_data_source_id"
    t.index ["intake_manifest_id"], name: "index_schema_versions_on_intake_manifest_id"
  end

  create_table "source_access_paths", force: :cascade do |t|
    t.bigint "data_source_id", null: false
    t.string "access_type", null: false
    t.text "uri_or_reference", null: false
    t.string "status", null: false
    t.datetime "last_checked_at"
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_source_id"], name: "index_source_access_paths_on_data_source_id"
  end

  create_table "susb_public_file_rows", force: :cascade do |t|
    t.bigint "data_source_id", null: false
    t.bigint "intake_manifest_id", null: false
    t.bigint "schema_version_id", null: false
    t.integer "year", null: false
    t.string "state_code", null: false
    t.string "naics_code", null: false
    t.string "enterprise_size_code", null: false
    t.bigint "firm_count", null: false
    t.bigint "establishment_count", null: false
    t.bigint "employment", null: false
    t.string "employment_noise_flag", null: false
    t.bigint "annual_payroll_thousand", null: false
    t.string "payroll_noise_flag", null: false
    t.bigint "receipts_thousand"
    t.string "receipts_noise_flag"
    t.string "state_name", null: false
    t.text "naics_description", null: false
    t.string "enterprise_size_description", null: false
    t.string "row_hash", null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_source_id", "year", "state_code", "naics_code", "enterprise_size_code"], name: "index_susb_rows_on_source_year_state_naics_size", unique: true
    t.index ["data_source_id"], name: "index_susb_public_file_rows_on_data_source_id"
    t.index ["intake_manifest_id"], name: "index_susb_public_file_rows_on_intake_manifest_id"
    t.index ["row_hash"], name: "index_susb_public_file_rows_on_row_hash"
    t.index ["schema_version_id"], name: "index_susb_public_file_rows_on_schema_version_id"
    t.index ["year", "state_code", "naics_code"], name: "index_susb_rows_on_year_state_naics"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "role_id"
    t.string "email", null: false
    t.string "password_digest"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((email)::text)", name: "index_users_on_lower_email", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "bds_public_file_rows", "data_sources"
  add_foreign_key "bds_public_file_rows", "intake_manifests"
  add_foreign_key "bds_public_file_rows", "schema_versions"
  add_foreign_key "bfs_api_rows", "data_sources"
  add_foreign_key "bfs_api_rows", "intake_manifests"
  add_foreign_key "bfs_api_rows", "schema_versions"
  add_foreign_key "claim_reviews", "prediction_links"
  add_foreign_key "export_artifacts", "evidence_snapshots"
  add_foreign_key "failure_records", "audit_events"
  add_foreign_key "failure_records", "prediction_links"
  add_foreign_key "intake_manifests", "data_sources"
  add_foreign_key "metric_observations", "data_sources"
  add_foreign_key "metric_observations", "metric_definitions"
  add_foreign_key "metric_quality_reviews", "data_sources"
  add_foreign_key "metric_quality_reviews", "metric_observations"
  add_foreign_key "prediction_links", "data_sources"
  add_foreign_key "prediction_links", "metric_observations"
  add_foreign_key "privacy_reviews", "data_sources"
  add_foreign_key "privacy_reviews", "intake_manifests"
  add_foreign_key "private_artifacts", "data_sources"
  add_foreign_key "quality_flags", "data_sources"
  add_foreign_key "quality_flags", "metric_observations"
  add_foreign_key "schema_versions", "data_sources"
  add_foreign_key "schema_versions", "intake_manifests"
  add_foreign_key "source_access_paths", "data_sources"
  add_foreign_key "susb_public_file_rows", "data_sources"
  add_foreign_key "susb_public_file_rows", "intake_manifests"
  add_foreign_key "susb_public_file_rows", "schema_versions"
  add_foreign_key "users", "roles"
end
