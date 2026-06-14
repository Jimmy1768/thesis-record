require "test_helper"

class Operations::HealthCheckTest < ActiveSupport::TestCase
  FakeRedis = Data.define(:response) do
    def call(command)
      return response if command == "PING"

      nil
    end
  end

  test "passes with app, database, redis, sidekiq schedule, and policy available" do
    result = Operations::HealthCheck.call(redis_client: FakeRedis.new("PONG"))

    assert result.passed
    assert_empty result.failures
  end

  test "fails when redis ping fails" do
    result = Operations::HealthCheck.call(redis_client: FakeRedis.new("NOPE"))

    assert_not result.passed
    assert_includes result.failures, "redis_connected"
  end
end
