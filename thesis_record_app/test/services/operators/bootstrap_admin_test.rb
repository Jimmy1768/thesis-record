require "test_helper"

class Operators::BootstrapAdminTest < ActiveSupport::TestCase
  test "bootstraps first operator admin from environment values" do
    env = bootstrap_env

    assert_difference -> { User.count }, 1 do
      assert_difference -> { AuditEvent.where(event_type: "operator_admin_bootstrapped").count }, 1 do
        user = Operators::BootstrapAdmin.call!(env: env)

        assert_equal "operator@example.test", user.email
        assert_equal "research_admin", user.role.name
        assert user.authenticate(env.fetch("THESIS_RECORD_ADMIN_PASSWORD"))
      end
    end
  end

  test "refuses bootstrap when operator admin already exists" do
    create_operator_user

    assert_no_difference -> { User.count } do
      assert_raises(Operators::BootstrapAdmin::AlreadyBootstrapped) do
        Operators::BootstrapAdmin.call!(env: bootstrap_env)
      end
    end
  end

  test "allows intentional override bootstrap when override env is set" do
    create_operator_user
    env = bootstrap_env.merge("THESIS_RECORD_BOOTSTRAP_OVERRIDE" => "true")

    assert_difference -> { User.count }, 1 do
      Operators::BootstrapAdmin.call!(env: env)
    end
  end

  test "requires configured email and password env values" do
    assert_raises(Operators::BootstrapAdmin::MissingConfiguration) do
      Operators::BootstrapAdmin.call!(env: {})
    end
  end

  test "requires a minimum bootstrap password length" do
    env = bootstrap_env.merge("THESIS_RECORD_ADMIN_PASSWORD" => "too-short")

    assert_raises(Operators::BootstrapAdmin::WeakPassword) do
      Operators::BootstrapAdmin.call!(env: env)
    end
  end

  private

  def bootstrap_env
    {
      "THESIS_RECORD_ADMIN_EMAIL" => "operator@example.test",
      "THESIS_RECORD_ADMIN_PASSWORD" => "long-enough-password",
      "THESIS_RECORD_ADMIN_ROLE" => "research_admin"
    }
  end
end
