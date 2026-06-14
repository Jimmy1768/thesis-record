require "test_helper"

class Operations::DeploymentCheckTest < ActiveSupport::TestCase
  def valid_env
    {
      "RAILS_ENV" => "production",
      "RAILS_FORCE_SSL" => "false",
      "RAILS_RELATIVE_URL_ROOT" => "/thesis",
      "PORT" => "3400",
      "THESIS_RECORD_BIND" => "127.0.0.1",
      "DATABASE_URL" => "present",
      "REDIS_URL" => "present",
      "SECRET_KEY_BASE" => "present"
    }
  end

  test "passes when production deployment env matches policy" do
    result = Operations::DeploymentCheck.call(env: valid_env)

    assert result.passed
    assert_empty result.failures
  end

  test "fails when relative URL root is missing" do
    env = valid_env.except("RAILS_RELATIVE_URL_ROOT")

    result = Operations::DeploymentCheck.call(env: env)

    assert_not result.passed
    assert_includes result.failures, "relative_url_root"
  end

  test "fails when canonical data promotion is enabled by default" do
    env = valid_env.merge("THESIS_RECORD_ALLOW_CANONICAL_DATA_PROMOTION" => "true")

    result = Operations::DeploymentCheck.call(env: env)

    assert_not result.passed
    assert_includes result.failures, "canonical_promotion_disabled_by_default"
  end

  test "fails when initial deployment enables SSL before nginx" do
    env = valid_env.merge("RAILS_FORCE_SSL" => "true")

    result = Operations::DeploymentCheck.call(env: env)

    assert_not result.passed
    assert_includes result.failures, "force_ssl_initially"
  end
end
