class QuarterlyCollection < ApplicationRecord
  belongs_to :quarterly_result_set, optional: true
  has_many :quarterly_collection_captures, dependent: :restrict_with_exception
  has_many :periodic_captures, through: :quarterly_collection_captures

  validates :quarter, format: { with: /\A\d{4}-Q[1-4]\z/ }
  validates :revision, numericality: { greater_than: 0 }
  validates :identity_digest, :input_digest, :cutoff_at, presence: true
  validates :status, inclusion: { in: %w[building completed] }

  before_update :reject_completed_change
  before_destroy :reject_completed_change

  private

  def reject_completed_change
    raise ActiveRecord::ReadOnlyRecord, "completed quarter is immutable" if status_in_database == "completed"
  end
end
