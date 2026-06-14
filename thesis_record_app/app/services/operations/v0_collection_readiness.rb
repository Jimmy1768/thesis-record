require "yaml"

module Operations
  class V0CollectionReadiness
    Result = Data.define(:passed, :checks, :blockers, :warnings)

    THESIS_SLUG = "operator-node-economics"
    THESIS_ROOT = Rails.root.join("..", "theses", THESIS_SLUG).expand_path
    COLLECTION_PLAN_PATH = THESIS_ROOT.join("publication", "v0_collection_plan.yml")

    ALLOWED_SOURCE_KINDS = %w[
      census_susb_public_file
      census_bfs_api
      census_bds_public_file
    ].freeze

    REQUIRED_CANONICAL_INGESTION_STEPS = %i[
      explicit_source_selection
      production_postgresql_target
      pre_collection_backup
      restore_test_or_backup_integrity_check
      collection_manifest_path
      expected_row_count_delta
      dry_run_output_review
      row_count_reconciliation
      post_collection_production_summary
      post_collection_v0_baseline_summary
      post_collection_v0_readiness
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

    OPTIONAL_METADATA_REFRESH_ACTION = "metadata_refresh_candidate"

    def self.call(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys,
                  env: ENV,
                  collection_plan_path: COLLECTION_PLAN_PATH)
      new(policy: policy, env: env, collection_plan_path: collection_plan_path).call
    end

    def initialize(policy:, env:, collection_plan_path:)
      @policy = policy.deep_symbolize_keys
      @env = env
      @collection_plan_path = Pathname(collection_plan_path)
    end

    def call
      plan = load_plan
      checks = {
        plan_present: plan.present?,
        plan_status_dry_run_only: plan.fetch(:status, nil) == "dry_run_only",
        approval_status_unapproved: plan.fetch(:approval_status, nil) == "unapproved",
        default_mode_read_only: default_mode_read_only?(plan),
        metadata_refresh_candidate_read_only: metadata_refresh_candidate_read_only?(plan),
        no_collection_env_gate_enabled: env.fetch("THESIS_RECORD_ALLOW_V0_CANONICAL_COLLECTION", "false") != "true",
        canonical_ingestion_not_authorized: plan.fetch(:canonical_ingestion_authorized, true) == false,
        metadata_refresh_has_no_row_effects: metadata_refresh_has_no_row_effects?(plan),
        row_ingestion_not_authorized: plan.fetch(:row_ingestion_authorized, true) == false,
        metric_computation_not_authorized: plan.fetch(:metric_computation_authorized, true) == false,
        no_claim_or_publication_effects: no_claim_or_publication_effects?(plan),
        allowed_sources_scoped: allowed_sources_scoped?(plan),
        source_freshness_authorized_for_all_sources: source_freshness_authorized_for_all_sources?(plan),
        source_rows_not_authorized: source_rows_not_authorized?(plan),
        first_live_collection_source_selected: !pending_decision?(plan.dig(:decision_gap, :first_live_collection_source)),
        first_live_collection_mode_metadata_refresh: plan.dig(:decision_gap, :first_live_collection_mode) == OPTIONAL_METADATA_REFRESH_ACTION,
        metadata_refresh_expected_zero_row_delta: plan.dig(:decision_gap, :expected_row_count_delta) == 0,
        metadata_refresh_manifest_present: metadata_refresh_manifest_present?(plan),
        canonical_ingestion_requirements_present: canonical_ingestion_requirements_present?(plan),
        prohibited_effects_present: prohibited_effects_present?(plan),
        production_policy_ingestion_disabled: production_policy_ingestion_disabled?,
        claim_review_gate_disabled: claim_review_gate_disabled?
      }

      blockers = checks.filter_map { |name, passed| name.to_s unless passed }
      Result.new(
        passed: blockers.empty?,
        checks: checks,
        blockers: blockers,
        warnings: warnings(plan)
      )
    end

    private

    attr_reader :policy, :env, :collection_plan_path

    def load_plan
      return {} unless collection_plan_path.exist?

      YAML.safe_load_file(collection_plan_path).deep_symbolize_keys
    end

    def default_mode_read_only?(plan)
      default_mode = plan.fetch(:default_run_mode, nil)
      mode = plan.fetch(:run_modes, {}).fetch(default_mode&.to_sym, {})

      default_mode == "dry_run_read_only" &&
        mode.fetch(:default, false) == true &&
        mode.fetch(:database_writes_allowed, true) == false &&
        mode.fetch(:network_fetch_allowed, true) == false &&
        mode.fetch(:row_count_changes_allowed, true) == false
    end

    def no_claim_or_publication_effects?(plan)
      %i[
        claim_review_authorized
        prediction_link_authorized
        paper_prose_change_authorized
        publication_authorized
      ].all? { |key| plan.fetch(key, true) == false }
    end

    def metadata_refresh_candidate_read_only?(plan)
      mode = plan.fetch(:run_modes, {}).fetch(OPTIONAL_METADATA_REFRESH_ACTION.to_sym, {})

      mode.fetch(:database_writes_allowed, true) == false &&
        mode.fetch(:network_fetch_allowed, false) == true &&
        mode.fetch(:row_count_changes_allowed, true) == false &&
        mode.fetch(:requires_human_approval, false) == true
    end

    def metadata_refresh_has_no_row_effects?(plan)
      return true unless plan.fetch(:metadata_refresh_authorized, false)

      metadata_refresh_candidate_read_only?(plan)
    end

    def allowed_sources_scoped?(plan)
      source_kinds = plan.fetch(:allowed_sources, []).map { |source| source.fetch(:source_kind).to_s }

      source_kinds.sort == ALLOWED_SOURCE_KINDS.sort
    end

    def source_rows_not_authorized?(plan)
      plan.fetch(:allowed_sources, []).all? do |source|
        source.fetch(:row_ingestion_authorized, true) == false
      end
    end

    def source_freshness_authorized_for_all_sources?(plan)
      plan.fetch(:allowed_sources, []).all? do |source|
        source.fetch(:source_freshness_dry_run_authorized, false) == true
      end
    end

    def canonical_ingestion_requirements_present?(plan)
      configured = plan.fetch(:required_before_canonical_ingestion, []).map(&:to_sym)

      (REQUIRED_CANONICAL_INGESTION_STEPS - configured).empty?
    end

    def metadata_refresh_manifest_present?(plan)
      manifest_path = plan.dig(:decision_gap, :collection_manifest_path).to_s
      manifest_path.present? && !pending_decision?(manifest_path) && Rails.root.join("..", manifest_path).exist?
    end

    def prohibited_effects_present?(plan)
      configured = plan.fetch(:prohibited_effects, []).map(&:to_sym)

      (PROHIBITED_EFFECTS - configured).empty?
    end

    def production_policy_ingestion_disabled?
      operations_policy = policy.fetch(:production_operations_v1)
      public_policy = policy.fetch(:public_ingestion_v1)

      operations_policy.fetch(:public_ingestion_enabled_default, true) == false &&
        operations_policy.fetch(:private_ingestion_enabled_default, true) == false &&
        operations_policy.fetch(:canonical_data_promotion_default, nil) == "disabled" &&
        public_policy.fetch(:public_file_fetch_enabled_default, true) == false &&
        public_policy.fetch(:metric_computation_enabled_default, true) == false
    end

    def claim_review_gate_disabled?
      gate = policy.fetch(:claim_review_gate_v1)

      gate.fetch(:claim_reviews_authorized, true) == false &&
        gate.fetch(:prediction_links_authorized, true) == false &&
        gate.fetch(:automatic_claim_promotion_authorized, true) == false
    end

    def warnings(plan)
      [].tap do |warnings|
        warnings << "collection_plan_missing" unless plan.present?
        warnings << "metadata_refresh_candidate_only" if plan.fetch(:metadata_refresh_authorized, false)
        warnings << "first_live_collection_source_pending" if pending_decision?(plan.dig(:decision_gap, :first_live_collection_source))
        warnings << "first_live_collection_mode_pending" if pending_decision?(plan.dig(:decision_gap, :first_live_collection_mode))
        warnings << "canonical_collection_env_gate_enabled" if env.fetch("THESIS_RECORD_ALLOW_V0_CANONICAL_COLLECTION", "false") == "true"
      end
    end

    def pending_decision?(value)
      value.to_s.start_with?("pending")
    end
  end
end
