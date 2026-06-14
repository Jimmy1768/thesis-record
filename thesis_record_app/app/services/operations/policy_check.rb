module Operations
  class PolicyCheck
    Result = Data.define(:passed, :failures)

    REQUIRED_OPERATIONS_VALUES = {
      database_system_of_record: "production_postgresql",
      secrets_store: "server_environment_or_managed_secret_store",
      public_path_target: "sourcegridlabs.com/thesis",
      rails_relative_url_root: "/thesis",
      puma_port: 3400,
      puma_bind: "127.0.0.1",
      nginx_required_initially: false,
      initial_operator_access: "ssh_tunnel_only",
      force_ssl_initially: false,
      admin_bootstrap: "one_time_environment_backed_task",
      sidekiq_process_name: "thesis-record-sidekiq",
      redis_namespace: "thesis-record-production",
      backup_required_before_private_ingestion: true,
      restore_test_required_before_private_ingestion: true,
      public_ingestion_enabled_default: false,
      private_ingestion_enabled_default: false,
      production_data_on_laptop_allowed: false,
      local_database_role: "dev_only_rehearsal_not_system_of_record",
      canonical_data_promotion_default: "disabled",
      deploy_or_push_authority_default: "none"
    }.freeze

    REQUIRED_PRIVACY_VALUES = {
      secrets_allowed_in_git: false,
      private_raw_rows_allowed_in_git: false,
      unreviewed_private_outputs_allowed_in_git: false,
      public_export_requires_human_review: true
    }.freeze

    def self.call(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
      new(policy: policy).call
    end

    def initialize(policy:)
      @policy = policy.deep_symbolize_keys
    end

    def call
      failures = []
      failures.concat(check_section(:production_operations_v1, REQUIRED_OPERATIONS_VALUES))
      failures.concat(check_canonical_promotion_requirements)
      failures.concat(check_section(:privacy_thresholds_v1, REQUIRED_PRIVACY_VALUES))

      Result.new(passed: failures.empty?, failures: failures)
    end

    private

    attr_reader :policy

    def check_section(section_name, required_values)
      section = policy.fetch(section_name)

      required_values.filter_map do |key, expected|
        actual = section.fetch(key)
        next if actual == expected

        "#{section_name}.#{key} expected #{expected.inspect}, got #{actual.inspect}"
      end
    end

    def check_canonical_promotion_requirements
      required_steps = %w[
        production_postgresql_target
        pre_promotion_backup
        migration_manifest
        row_count_reconciliation
        post_promotion_health_check
      ]
      configured_steps = policy.fetch(:production_operations_v1)
                               .fetch(:canonical_data_promotion_requires)
                               .map(&:to_s)
      missing_steps = required_steps - configured_steps
      return [] if missing_steps.empty?

      ["production_operations_v1.canonical_data_promotion_requires missing #{missing_steps.inspect}"]
    end
  end
end
