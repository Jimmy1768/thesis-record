require "test_helper"

class AuthenticationFlowTest < ActionDispatch::IntegrationTest
  test "data source registry requires authentication" do
    get data_sources_path

    assert_redirected_to new_session_path
  end

  test "active research operator can sign in" do
    create_operator_user(email: "Research@Example.test", password: "password")

    post session_path, params: { email: "research@example.test", password: "password" }

    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
  end
end
