module Operations
  class DeploymentCheck
    Result = Data.define(:passed, :checks, :failures)

    REQUIRED_ENV_KEYS = %w[
      DATABASE_URL
      REDIS_URL
      SECRET_KEY_BASE
    ].freeze

    def self.call(env: ENV, policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
      new(env: env, policy: policy).call
    end

    def initialize(env:, policy:)
      @env = env
      @policy = policy.deep_symbolize_keys
    end

    def call
      operations_policy = policy.fetch(:production_operations_v1)
      checks = {}
      checks[:operations_policy_passed] = Operations::PolicyCheck.call(policy: policy).passed
      checks[:rails_env_production] = env.fetch("RAILS_ENV", nil) == "production"
      checks[:relative_url_root] = env.fetch("RAILS_RELATIVE_URL_ROOT", nil) == operations_policy.fetch(:rails_relative_url_root)
      checks[:puma_port] = env.fetch("PORT", nil).to_i == operations_policy.fetch(:puma_port)
      checks[:puma_bind] = env.fetch("THESIS_RECORD_BIND", nil) == operations_policy.fetch(:puma_bind)
      checks[:force_ssl_initially] = boolean_env("RAILS_FORCE_SSL") == operations_policy.fetch(:force_ssl_initially)
      checks[:required_secrets_present] = REQUIRED_ENV_KEYS.all? { |key| env.fetch(key, "").present? }
      checks[:canonical_promotion_disabled_by_default] = env.fetch("THESIS_RECORD_ALLOW_CANONICAL_DATA_PROMOTION", "false") != "true"

      failures = checks.filter_map { |name, passed| name.to_s unless passed }
      Result.new(passed: failures.empty?, checks: checks, failures: failures)
    end

    private

    attr_reader :env, :policy

    def boolean_env(key)
      ActiveModel::Type::Boolean.new.cast(env.fetch(key, "false"))
    end
  end
end
