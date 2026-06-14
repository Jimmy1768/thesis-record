module Operations
  class PolicyCheck
    Result = Data.define(:passed, :failures)

    REQUIRED_OPERATIONS_VALUES = {
      database_system_of_record: "production_postgresql",
      secrets_store: "server_environment_or_managed_secret_store",
      admin_bootstrap: "one_time_environment_backed_task",
      backup_required_before_private_ingestion: true,
      restore_test_required_before_private_ingestion: true,
      public_ingestion_enabled_default: false,
      private_ingestion_enabled_default: false,
      production_data_on_laptop_allowed: false,
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
  end
end
