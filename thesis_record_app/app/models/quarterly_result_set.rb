class QuarterlyResultSet < ApplicationRecord
  has_many :metric_observations, dependent: :restrict_with_exception
  has_many :quarterly_collections, dependent: :restrict_with_exception

  validates :input_digest, :method_digest, :definition_digest, :identity_digest, :method_manifest, presence: true
  validates :status, inclusion: { in: %w[building completed] }

  before_update :reject_completed_change
  before_destroy :reject_completed_change

  private

  def reject_completed_change
    raise ActiveRecord::ReadOnlyRecord, "completed result set is immutable" if status_in_database == "completed"
  end
end
