require "sidekiq"
require "yaml"
require "erb"

module Operations
  class HealthCheck
    Result = Data.define(:passed, :checks, :failures)

    def self.call(redis_client: nil)
      new(redis_client: redis_client).call
    end

    def initialize(redis_client:)
      @redis_client = redis_client
    end

    def call
      checks = {}
      checks[:rails_booted] = check { Rails.application.present? }
      checks[:database_connected] = check { database_connected? }
      checks[:redis_connected] = check { redis_ping == "PONG" }
      checks[:sidekiq_config_loaded] = check { sidekiq_schedule_present? }
      checks[:operations_policy_passed] = Operations::PolicyCheck.call.passed

      failures = checks.filter_map { |name, passed| name.to_s unless passed }
      Result.new(passed: failures.empty?, checks: checks, failures: failures)
    end

    private

    attr_reader :redis_client

    def check
      !!yield
    rescue StandardError
      false
    end

    def redis_ping
      return redis_client.call("PING") if redis_client

      Sidekiq.redis { |connection| connection.call("PING") }
    end

    def database_connected?
      ActiveRecord::Base.connection_pool.with_connection do |connection|
        connection.execute("SELECT 1")
      end
      true
    end

    def sidekiq_schedule_present?
      raw_config = Rails.root.join("config/sidekiq.yml").read
      config = YAML.safe_load(ERB.new(raw_config).result, aliases: true, permitted_classes: [ Symbol ])
      config.fetch(:scheduler).fetch(:schedule).keys.sort == %w[
        annual_snapshot_candidate
        quarterly_indicator_checkpoint
        source_release_check
      ]
    end
  end
end
