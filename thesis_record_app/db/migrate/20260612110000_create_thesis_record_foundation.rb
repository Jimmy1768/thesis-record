class CreateThesisRecordFoundation < ActiveRecord::Migration[7.2]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.text :description
      t.timestamps
    end
    add_index :roles, :name, unique: true

    create_table :users do |t|
      t.references :role, foreign_key: true
      t.string :email, null: false
      t.string :password_digest
      t.boolean :active, null: false, default: true
      t.timestamps
    end
    add_index :users, "lower(email)", unique: true, name: "index_users_on_lower_email"

    create_table :audit_events do |t|
      t.datetime :occurred_at, null: false
      t.string :actor_type, null: false
      t.string :actor_id
      t.string :event_type, null: false
      t.string :entity_type, null: false
      t.string :entity_id, null: false
      t.string :source_id
      t.string :snapshot_id
      t.string :request_id
      t.string :job_id
      t.string :previous_state_hash
      t.string :new_state_hash
      t.text :change_summary, null: false
      t.string :reason_code, null: false
      t.boolean :review_required, null: false, default: false
      t.string :review_id
      t.string :storage_zone, null: false
      t.string :privacy_classification, null: false
      t.string :claim_status_effect, null: false, default: "unchanged"
      t.boolean :export_allowed, null: false, default: false
      t.string :ip_or_host
      t.timestamps
    end
    add_index :audit_events, %i[event_type occurred_at]
    add_index :audit_events, %i[entity_type entity_id]

    create_table :data_sources do |t|
      t.string :name, null: false
      t.string :source_kind, null: false
      t.string :source_status, null: false, default: "source_registered"
      t.string :storage_zone, null: false
      t.string :privacy_classification, null: false
      t.boolean :public_repo_allowed, null: false, default: false
      t.boolean :structured_private_allowed, null: false, default: true
      t.boolean :private_file_storage_allowed, null: false, default: false
      t.boolean :secret_material_present, null: false, default: false
      t.boolean :redaction_required, null: false, default: true
      t.boolean :minimum_cell_rule_required, null: false, default: true
      t.boolean :human_review_required, null: false, default: true
      t.string :retention_rule, null: false
      t.string :claim_status_allowed, null: false, default: "not_evidence"
      t.jsonb :metadata, null: false, default: {}
      t.timestamps
    end
    add_index :data_sources, :name
    add_index :data_sources, :source_status
    add_index :data_sources, :storage_zone
    add_index :data_sources, :privacy_classification

    create_table :source_access_paths do |t|
      t.references :data_source, null: false, foreign_key: true
      t.string :access_type, null: false
      t.text :uri_or_reference, null: false
      t.string :status, null: false
      t.datetime :last_checked_at
      t.jsonb :metadata, null: false, default: {}
      t.timestamps
    end

    create_table :intake_manifests do |t|
      t.references :data_source, null: false, foreign_key: true
      t.string :name, null: false
      t.string :manifest_status, null: false, default: "empty_manifest"
      t.string :storage_zone, null: false
      t.string :privacy_classification, null: false
      t.boolean :public_repo_allowed, null: false, default: false
      t.boolean :structured_private_allowed, null: false, default: true
      t.boolean :private_file_storage_allowed, null: false, default: false
      t.boolean :secret_material_present, null: false, default: false
      t.boolean :redaction_required, null: false, default: true
      t.boolean :minimum_cell_rule_required, null: false, default: true
      t.boolean :human_review_required, null: false, default: true
      t.string :retention_rule, null: false
      t.jsonb :field_map, null: false, default: {}
      t.jsonb :metadata, null: false, default: {}
      t.timestamps
    end

    create_table :schema_versions do |t|
      t.references :data_source, foreign_key: true
      t.references :intake_manifest, foreign_key: true
      t.string :version, null: false
      t.string :schema_status, null: false, default: "draft"
      t.jsonb :schema, null: false, default: {}
      t.text :notes
      t.timestamps
    end

    create_table :privacy_reviews do |t|
      t.references :data_source, foreign_key: true
      t.references :intake_manifest, foreign_key: true
      t.string :review_status, null: false
      t.string :privacy_classification, null: false
      t.string :reviewed_by, null: false
      t.boolean :identity_fields_removed, null: false, default: false
      t.boolean :client_confidentiality_reviewed, null: false, default: false
      t.boolean :worker_or_evaluator_confidentiality_reviewed, null: false, default: false
      t.boolean :hidden_labor_reviewed, null: false, default: false
      t.text :notes
      t.timestamps
    end

    create_table :private_artifacts do |t|
      t.references :data_source, foreign_key: true
      t.string :artifact_kind, null: false
      t.string :storage_zone, null: false
      t.string :privacy_classification, null: false
      t.boolean :public_repo_allowed, null: false, default: false
      t.boolean :structured_private_allowed, null: false, default: false
      t.boolean :private_file_storage_allowed, null: false, default: true
      t.boolean :secret_material_present, null: false, default: false
      t.boolean :redaction_required, null: false, default: true
      t.boolean :minimum_cell_rule_required, null: false, default: true
      t.boolean :human_review_required, null: false, default: true
      t.string :storage_pointer, null: false
      t.string :content_hash, null: false
      t.string :retention_rule, null: false
      t.jsonb :metadata, null: false, default: {}
      t.timestamps
    end

    create_table :metric_definitions do |t|
      t.string :key, null: false
      t.string :name, null: false
      t.string :formula_status, null: false, default: "draft"
      t.text :formula
      t.text :limitations
      t.timestamps
    end
    add_index :metric_definitions, :key, unique: true

    create_table :metric_observations do |t|
      t.references :metric_definition, null: false, foreign_key: true
      t.references :data_source, foreign_key: true
      t.string :period, null: false
      t.string :metric_status, null: false
      t.decimal :numeric_value, precision: 20, scale: 6
      t.string :unit
      t.jsonb :dimensions, null: false, default: {}
      t.jsonb :quality_metadata, null: false, default: {}
      t.timestamps
    end
    add_index :metric_observations, :period

    create_table :quality_flags do |t|
      t.references :metric_observation, foreign_key: true
      t.references :data_source, foreign_key: true
      t.string :flag_type, null: false
      t.string :status, null: false, default: "open"
      t.text :notes
      t.timestamps
    end

    create_table :prediction_links do |t|
      t.references :metric_observation, foreign_key: true
      t.references :data_source, foreign_key: true
      t.string :prediction_id, null: false
      t.string :evidence_classification, null: false
      t.string :review_status, null: false, default: "review_pending"
      t.text :notes
      t.timestamps
    end
    add_index :prediction_links, :prediction_id

    create_table :claim_reviews do |t|
      t.references :prediction_link, foreign_key: true
      t.string :claim_id, null: false
      t.string :review_status, null: false, default: "review_pending"
      t.string :prior_status, null: false
      t.string :proposed_status, null: false
      t.string :reason_code, null: false
      t.text :notes
      t.timestamps
    end

    create_table :failure_records do |t|
      t.references :prediction_link, foreign_key: true
      t.references :audit_event, foreign_key: true
      t.string :prediction_id, null: false
      t.string :horizon, null: false
      t.string :failure_type, null: false
      t.string :evidence_object_id
      t.string :source_status
      t.string :metric_status, null: false
      t.string :observed_direction, null: false
      t.string :expected_direction, null: false
      t.boolean :failure_condition_triggered, null: false, default: false
      t.text :alternative_explanation
      t.text :business_cycle_context
      t.string :company_case_scope
      t.string :human_review_status, null: false, default: "pending"
      t.string :publication_status, null: false, default: "not_public"
      t.string :revision_action, null: false, default: "none"
      t.timestamps
    end
    add_index :failure_records, :prediction_id
    add_index :failure_records, :failure_type

    create_table :evidence_snapshots do |t|
      t.string :version_label, null: false
      t.string :snapshot_status, null: false
      t.datetime :frozen_at, null: false
      t.string :commit_sha
      t.jsonb :manifest, null: false, default: {}
      t.text :notes
      t.timestamps
    end
    add_index :evidence_snapshots, :version_label, unique: true

    create_table :export_artifacts do |t|
      t.references :evidence_snapshot, foreign_key: true
      t.string :artifact_kind, null: false
      t.string :export_status, null: false, default: "draft"
      t.string :privacy_review_status, null: false, default: "pending"
      t.boolean :reviewed_for_public_repo, null: false, default: false
      t.string :artifact_path
      t.string :content_hash
      t.jsonb :metadata, null: false, default: {}
      t.timestamps
    end
  end
end
