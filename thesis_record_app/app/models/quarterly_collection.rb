class QuarterlyCollection < ApplicationRecord
  belongs_to :quarterly_result_set, optional: true
  has_many :quarterly_collection_captures, dependent: :restrict_with_exception
  has_many :periodic_captures, through: :quarterly_collection_captures

  validates :quarter, format: { with: /\A\d{4}-Q[1-4]\z/ }
  validates :revision, numericality: { greater_than: 0 }
  validates :identity_digest, :input_digest, :cutoff_at, presence: true
  validates :status, inclusion: { in: %w[building completed] }
  validate :cutoff_matches_quarter

  before_update :reject_completed_change
  before_destroy :reject_completed_change

  def self.cutoff_for(quarter)
    match = /\A(\d{4})-Q([1-4])\z/.match(quarter.to_s)
    return unless match

    year = match[1].to_i
    number = match[2].to_i
    number == 4 ? Time.utc(year + 1, 1, 1) : Time.utc(year, number * 3 + 1, 1)
  end

  private

  def cutoff_matches_quarter
    expected = self.class.cutoff_for(quarter)
    errors.add(:cutoff_at, "must match the quarter end") if expected && cutoff_at && cutoff_at.utc != expected
  end

  def reject_completed_change
    raise ActiveRecord::ReadOnlyRecord, "completed quarter is immutable" if status_in_database == "completed"
  end
end
