class User < ApplicationRecord
  belongs_to :role, optional: true

  has_secure_password validations: false

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  before_validation :normalize_email

  def research_operator?
    ApplicationController::RESEARCH_OPERATOR_ROLES.include?(role&.name)
  end

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end
