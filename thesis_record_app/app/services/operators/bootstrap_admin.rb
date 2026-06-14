module Operators
  class BootstrapAdmin
    class Error < StandardError; end
    class AlreadyBootstrapped < Error; end
    class MissingConfiguration < Error; end
    class WeakPassword < Error; end

    ADMIN_ROLES = %w[admin research_admin].freeze

    def self.call!(env: ENV)
      new(env: env).call!
    end

    def initialize(env:)
      @env = env
      @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
      @operations_policy = @policy.fetch(:production_operations_v1)
      @bootstrap_env = @operations_policy.fetch(:admin_bootstrap_env)
    end

    def call!
      ensure_one_time_guard!
      ensure_password_strength!

      User.transaction do
        role = Role.find_or_create_by!(name: role_name) do |new_role|
          new_role.description = "Production research operator administrator"
        end
        user = User.find_or_initialize_by(email: email)
        user.assign_attributes(role: role, active: true, password: password)
        user.save!

        Audit::Recorder.record_system!(
          actor: "operator_bootstrap",
          event_type: "operator_admin_bootstrapped",
          entity_type: "User",
          entity_id: user.id.to_s,
          change_summary: "Bootstrapped ThesisRecord operator admin #{user.email}",
          reason_code: "operator_bootstrap"
        )

        user
      end
    end

    private

    attr_reader :env, :operations_policy, :bootstrap_env

    def ensure_one_time_guard!
      return if override?
      return unless User.joins(:role).where(roles: { name: ADMIN_ROLES }).exists?

      raise AlreadyBootstrapped, "operator admin already exists; set override env only for an intentional bootstrap rerun"
    end

    def ensure_password_strength!
      minimum = operations_policy.fetch(:admin_bootstrap_minimum_password_length)
      return if password.length >= minimum

      raise WeakPassword, "admin password must be at least #{minimum} characters"
    end

    def email
      required_env(:email)
    end

    def password
      required_env(:password)
    end

    def role_name
      env.fetch(bootstrap_env.fetch(:role), operations_policy.fetch(:admin_bootstrap_default_role))
    end

    def override?
      ActiveModel::Type::Boolean.new.cast(env[bootstrap_env.fetch(:override)])
    end

    def required_env(key)
      env_name = bootstrap_env.fetch(key)
      value = env[env_name].to_s.strip
      return value if value.present?

      raise MissingConfiguration, "#{env_name} is required"
    end
  end
end
