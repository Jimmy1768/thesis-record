require "time"
require "yaml"

module Operations
  class V0CanonicalCollectionPreflight
    class PreflightError < StandardError; end

    Result = Data.define(:passed, :checks, :blockers, :warnings, :manifest_path, :source_kind)

    THESIS_SLUG = "operator-node-economics"
    THESIS_ROOT = Rails.root.join("..", "theses", THESIS_SLUG).expand_path
    MANIFEST_ROOT = THESIS_ROOT.join("evidence", "manifests").expand_path
    COLLECTION_PLAN_PATH = THESIS_ROOT.join("publication", "v0_collection_plan.yml")
    MANIFEST_ENV_KEY = "THESIS_RECORD_V0_COLLECTION_MANIFEST"
    COLLECTION_ENV_GATE = "THESIS_RECORD_ALLOW_V0_CANONICAL_COLLECTION"

    SUPPORTED_VERSION = "v0_canonical_collection_manifest_v1"
    REQUIRED_RUN_MODE = "canonical_ingestion_candidate"
    REQUIRED_APPROVAL_STATUS = "approved"

    SOURCE_CONFIG = {
      "census_bfs_api" => {
        table_name: "bfs_api_rows",
        unique_key: %w[
          data_source_id
          period_month
          data_type_code
          category_code
          seasonally_adj
          geography_level
          geography_code
        ],
        idempotency_strategy: "upsert_all_unique_index"
      },
      "census_susb_public_file" => {
        table_name: "susb_public_file_rows",
        unique_key: %w[
          data_source_id
          year
          state_code
          naics_code
          enterprise_size_code
        ],
        idempotency_strategy: "upsert_all_unique_index"
      },
      "census_bds_public_file" => {
        table_name: "bds_public_file_rows",
        unique_key: %w[
          data_source_id
          year
          sector_code
          firm_age_code
          firm_size_code
        ],
        idempotency_strategy: "transactional_replace_source_rows"
      }
    }.freeze

    PROTECTED_ROW_DELTA_KEYS = %i[
      metric_definitions
      metric_observations
      metric_quality_reviews
      prediction_links
      claim_reviews
      export_artifacts
    ].freeze

    POST_COLLECTION_CHECKS = %i[
      production_summary
      v0_baseline_summary
      v0_readiness
    ].freeze

    PROHIBITED_EFFECTS = %i[
      claim_status_change
      prediction_link_creation
      claim_review_creation
      export_creation
      paper_prose_change
      thesis_verdict
      publication
    ].freeze

    def self.call(env: ENV,
                  rails_env: Rails.env.to_s,
                  manifest_path: nil,
                  manifest_root: MANIFEST_ROOT,
                  collection_plan_path: COLLECTION_PLAN_PATH,
                  policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
      new(
        env: env,
        rails_env: rails_env,
        manifest_path: manifest_path,
        manifest_root: manifest_root,
        collection_plan_path: collection_plan_path,
        policy: policy
      ).call
    end

    def self.enforce_source_write_allowed!(source_kind:, env: ENV, manifest_path: nil, rails_env: Rails.env.to_s)
      return true unless rails_env == "production"

      result = call(env: env, manifest_path: manifest_path, rails_env: rails_env)
      return true if result.passed && result.source_kind == source_kind

      blockers = result.blockers.dup
      blockers << "manifest_source_kind_mismatch" unless result.source_kind == source_kind
      raise PreflightError, "Operator Nodes v0 canonical collection preflight failed: #{blockers.uniq.join(', ')}"
    end

    def initialize(env:, rails_env:, manifest_path:, manifest_root:, collection_plan_path:, policy:)
      @env = env
      @rails_env = rails_env.to_s
      @manifest_path = Pathname(manifest_path.presence || env[MANIFEST_ENV_KEY].to_s)
      @manifest_root = Pathname(manifest_root).expand_path
      @collection_plan_path = Pathname(collection_plan_path)
      @policy = policy.deep_symbolize_keys
    end

    def call
      manifest = load_manifest
      collection_plan = load_collection_plan
      source_kind = manifest.fetch(:source_kind, nil).to_s

      checks = {
        env_gate_enabled: env.fetch(COLLECTION_ENV_GATE, "false") == "true",
        rails_env_production: rails_env == "production",
        production_postgresql_target: production_postgresql_target?,
        collection_plan_present: collection_plan.present?,
        collection_plan_default_blocks_writes: collection_plan_default_blocks_writes?(collection_plan),
        collection_plan_canonical_candidate_defined: collection_plan_canonical_candidate_defined?(collection_plan),
        manifest_path_present: manifest_path.to_s.present?,
        manifest_path_under_thesis_manifests: manifest_path_under_thesis_manifests?,
        manifest_present: manifest_path.exist?,
        manifest_status_ready: manifest.fetch(:status, nil) == "ready_for_canonical_ingestion",
        manifest_version_supported: manifest.fetch(:version, nil) == SUPPORTED_VERSION,
        thesis_slug_correct: manifest.fetch(:thesis_slug, nil) == THESIS_SLUG,
        run_mode_canonical_ingestion_candidate: manifest.fetch(:run_mode, nil) == REQUIRED_RUN_MODE,
        approval_status_approved: manifest.dig(:operator_approval, :approval_status) == REQUIRED_APPROVAL_STATUS,
        approval_timestamp_present: parseable_time?(manifest.dig(:operator_approval, :approved_at_utc)),
        required_env_present: required_env_present?(manifest),
        source_kind_allowed: SOURCE_CONFIG.key?(source_kind),
        source_table_matches: source_table_matches?(manifest, source_kind),
        source_unique_index_present: source_unique_index_present?(source_kind),
        natural_key_matches_source: natural_key_matches_source?(manifest, source_kind),
        backup_completed: manifest.dig(:pre_collection_backup, :completed) == true,
        backup_path_outside_repo: backup_path_outside_repo?(manifest),
        backup_sha256_present: sha256?(manifest.dig(:pre_collection_backup, :sha256)),
        backup_timestamp_present: parseable_time?(manifest.dig(:pre_collection_backup, :completed_at_utc)),
        restore_or_integrity_check_completed: manifest.dig(:restore_or_integrity_check, :completed) == true,
        restore_or_integrity_check_timestamp_present: parseable_time?(manifest.dig(:restore_or_integrity_check, :completed_at_utc)),
        expected_counts_present: expected_counts_present?(manifest),
        expected_count_delta_reconciles: expected_count_delta_reconciles?(manifest),
        duplicate_natural_key_count_zero: manifest.dig(:expected_counts, :duplicate_natural_key_count_after) == 0,
        protected_row_deltas_zero: protected_row_deltas_zero?(manifest),
        idempotency_strategy_matches_source: idempotency_strategy_matches_source?(manifest, source_kind),
        post_collection_checks_required: post_collection_checks_required?(manifest),
        prohibited_effects_present: prohibited_effects_present?(manifest),
        no_claim_or_publication_effects: no_claim_or_publication_effects?(manifest),
        production_policy_ingestion_disabled_by_default: production_policy_ingestion_disabled?
      }

      blockers = checks.filter_map { |name, passed| name.to_s unless passed }

      Result.new(
        passed: blockers.empty?,
        checks: checks,
        blockers: blockers,
        warnings: warnings(manifest),
        manifest_path: manifest_path,
        source_kind: source_kind
      )
    end

    private

    attr_reader :env, :rails_env, :manifest_path, :manifest_root, :collection_plan_path, :policy

    def load_manifest
      return {} unless manifest_path.exist?

      YAML.safe_load_file(manifest_path).deep_symbolize_keys
    end

    def load_collection_plan
      return {} unless collection_plan_path.exist?

      YAML.safe_load_file(collection_plan_path).deep_symbolize_keys
    end

    def production_postgresql_target?
      ActiveRecord::Base.connection.adapter_name.downcase.include?("postgresql")
    end

    def collection_plan_default_blocks_writes?(plan)
      plan.fetch(:canonical_ingestion_authorized, true) == false &&
        plan.fetch(:row_ingestion_authorized, true) == false &&
        plan.fetch(:metric_computation_authorized, true) == false &&
        plan.fetch(:claim_review_authorized, true) == false &&
        plan.fetch(:prediction_link_authorized, true) == false &&
        plan.fetch(:publication_authorized, true) == false
    end

    def collection_plan_canonical_candidate_defined?(plan)
      mode = plan.fetch(:run_modes, {}).fetch(:canonical_ingestion_candidate, {})

      mode.fetch(:database_writes_allowed, false) == true &&
        mode.fetch(:network_fetch_allowed, false) == true &&
        mode.fetch(:row_count_changes_allowed, false) == true &&
        mode.fetch(:requires_human_approval, false) == true &&
        mode.fetch(:requires_env_gate, nil) == COLLECTION_ENV_GATE
    end

    def manifest_path_under_thesis_manifests?
      return false unless manifest_path.to_s.present?

      expanded_path = manifest_path.expand_path
      expanded_path.to_s.start_with?(manifest_root.to_s + File::SEPARATOR)
    end

    def source_table_matches?(manifest, source_kind)
      source_config = SOURCE_CONFIG[source_kind]
      source_config.present? && manifest.fetch(:source_table, nil) == source_config.fetch(:table_name)
    end

    def required_env_present?(manifest)
      required_keys = manifest.fetch(:required_env, [])
      return false unless required_keys.is_a?(Array)

      required_keys.all? { |key| env[key.to_s].present? }
    end

    def source_unique_index_present?(source_kind)
      source_config = SOURCE_CONFIG[source_kind]
      return false unless source_config

      ActiveRecord::Base.connection.indexes(source_config.fetch(:table_name)).any? do |index|
        index.unique && index.columns == source_config.fetch(:unique_key)
      end
    end

    def natural_key_matches_source?(manifest, source_kind)
      source_config = SOURCE_CONFIG[source_kind]
      source_config.present? && manifest.fetch(:natural_key, []) == source_config.fetch(:unique_key)
    end

    def backup_path_outside_repo?(manifest)
      backup_path = manifest.dig(:pre_collection_backup, :path).to_s
      return false if pending?(backup_path) || backup_path.blank?

      expanded_path = Pathname(backup_path).expand_path
      !expanded_path.to_s.start_with?(Rails.root.parent.expand_path.to_s + File::SEPARATOR)
    end

    def expected_counts_present?(manifest)
      expected_counts = manifest.fetch(:expected_counts, {})

      %i[source_rows_before source_rows_after source_row_count_delta duplicate_natural_key_count_after].all? do |key|
        expected_counts.fetch(key, nil).is_a?(Integer)
      end
    end

    def expected_count_delta_reconciles?(manifest)
      expected_counts = manifest.fetch(:expected_counts, {})
      return false unless expected_counts_present?(manifest)

      expected_counts.fetch(:source_rows_after) ==
        expected_counts.fetch(:source_rows_before) + expected_counts.fetch(:source_row_count_delta)
    end

    def protected_row_deltas_zero?(manifest)
      protected_deltas = manifest.dig(:expected_counts, :protected_row_deltas) || {}

      PROTECTED_ROW_DELTA_KEYS.all? { |key| protected_deltas.fetch(key, nil) == 0 }
    end

    def idempotency_strategy_matches_source?(manifest, source_kind)
      source_config = SOURCE_CONFIG[source_kind]
      source_config.present? && manifest.fetch(:idempotency_strategy, nil) == source_config.fetch(:idempotency_strategy)
    end

    def post_collection_checks_required?(manifest)
      configured = manifest.fetch(:post_collection_required_checks, []).map(&:to_sym)

      (POST_COLLECTION_CHECKS - configured).empty?
    end

    def prohibited_effects_present?(manifest)
      configured = manifest.fetch(:prohibited_effects, []).map(&:to_sym)

      (PROHIBITED_EFFECTS - configured).empty?
    end

    def no_claim_or_publication_effects?(manifest)
      effects = manifest.fetch(:authorized_effects, {})

      effects.fetch(:source_row_writes, nil) == true &&
        effects.fetch(:metric_computation, nil) == false &&
        effects.fetch(:quality_review_creation, nil) == false &&
        effects.fetch(:prediction_link_creation, nil) == false &&
        effects.fetch(:claim_review_creation, nil) == false &&
        effects.fetch(:export_creation, nil) == false &&
        effects.fetch(:paper_prose_change, nil) == false &&
        effects.fetch(:publication, nil) == false &&
        effects.fetch(:thesis_verdict, nil) == false
    end

    def production_policy_ingestion_disabled?
      operations_policy = policy.fetch(:production_operations_v1)
      public_policy = policy.fetch(:public_ingestion_v1)

      operations_policy.fetch(:public_ingestion_enabled_default, true) == false &&
        operations_policy.fetch(:canonical_data_promotion_default, nil) == "disabled" &&
        public_policy.fetch(:public_file_fetch_enabled_default, true) == false &&
        public_policy.fetch(:metric_computation_enabled_default, true) == false
    end

    def warnings(manifest)
      [].tap do |warnings|
        warnings << "canonical_collection_gate_enabled" if env.fetch(COLLECTION_ENV_GATE, "false") == "true"
        warnings << "manifest_missing" unless manifest_path.exist?
        warnings << "manifest_status_not_ready" unless manifest.fetch(:status, nil) == "ready_for_canonical_ingestion"
      end
    end

    def parseable_time?(value)
      return false if pending?(value)

      Time.iso8601(value.to_s)
      true
    rescue ArgumentError
      false
    end

    def sha256?(value)
      value.to_s.match?(/\A[0-9a-f]{64}\z/)
    end

    def pending?(value)
      value.to_s.blank? || value.to_s.start_with?("pending")
    end
  end
end
