require "test_helper"

class Operations::ProductionSummaryTest < ActiveSupport::TestCase
  FakeRedis = Data.define(:response) do
    def call(command)
      return response if command == "PING"

      nil
    end
  end

  test "reports health, environment, table counts, and default warnings" do
    summary = Operations::ProductionSummary.call(
      env: {
        "RAILS_RELATIVE_URL_ROOT" => "/thesis"
      },
      redis_client: FakeRedis.new("PONG")
    )

    assert summary.health_passed
    assert_equal "test", summary.rails_env
    assert_equal "/thesis", summary.relative_url_root
    assert summary.canonical_data_promotion_disabled
    assert_equal 0, summary.table_counts.fetch(:users)
    assert_equal 0, summary.table_counts.fetch(:roles)
    assert_includes summary.warnings, "no_production_users"
    assert_includes summary.warnings, "no_production_roles"
  end

  test "warns when canonical data promotion is enabled" do
    summary = Operations::ProductionSummary.call(
      env: {
        "THESIS_RECORD_ALLOW_CANONICAL_DATA_PROMOTION" => "true"
      },
      redis_client: FakeRedis.new("PONG")
    )

    assert_not summary.canonical_data_promotion_disabled
    assert_includes summary.warnings, "canonical_data_promotion_enabled"
  end

  test "warns when health checks fail" do
    summary = Operations::ProductionSummary.call(
      env: {},
      redis_client: FakeRedis.new("NOPE")
    )

    assert_not summary.health_passed
    assert_includes summary.warnings, "health_checks_failed"
  end
end
