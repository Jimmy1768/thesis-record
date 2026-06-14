module StorageClassifiable
  extend ActiveSupport::Concern

  STORAGE_ZONES = %w[
    git_repository
    production_postgresql
    private_file_storage
    secret_manager_env
    local_development_database
    encrypted_backup_storage
  ].freeze

  PRIVACY_CLASSIFICATIONS = %w[
    public
    aggregated_public
    redacted_public
    internal
    confidential
  ].freeze

  included do
    validates :storage_zone, presence: true, inclusion: { in: STORAGE_ZONES }
    validates :privacy_classification, presence: true, inclusion: { in: PRIVACY_CLASSIFICATIONS }
    validate :private_records_are_not_git_allowed
    validate :secrets_are_never_public_repo_allowed
  end

  private

  def private_records_are_not_git_allowed
    return unless public_repo_allowed?
    return if %w[public aggregated_public redacted_public].include?(privacy_classification)

    errors.add(:public_repo_allowed, "cannot be true for internal or confidential records")
  end

  def secrets_are_never_public_repo_allowed
    return unless secret_material_present? && public_repo_allowed?

    errors.add(:public_repo_allowed, "cannot be true when secret material is present")
  end
end
