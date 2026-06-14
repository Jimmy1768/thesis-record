class ApplicationController < ActionController::Base
  RESEARCH_OPERATOR_ROLES = %w[admin research_admin research_operator].freeze

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :require_login

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    return if current_user&.active?

    redirect_to new_session_path, alert: "Sign in required"
  end

  def require_research_operator
    return if current_user&.research_operator?

    redirect_to root_path, alert: "Research operator access required"
  end
end
