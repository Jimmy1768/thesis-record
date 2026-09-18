class PeriodicCapture < ApplicationRecord
  belongs_to :data_source
  has_many :periodic_source_checks, dependent: :restrict_with_exception

  validates :dataset_scope, :release_identity, :response_sha256, :parsed_rows_digest,
            :parser_version, :retrieved_at, presence: true
  validates :response_sha256, :parsed_rows_digest, length: { is: 64 }
  validates :row_count, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: %w[loading completed] }

  before_update :reject_completed_change
  before_destroy :reject_completed_change

  private

  def reject_completed_change
    raise ActiveRecord::ReadOnlyRecord, "completed capture is immutable" if status_in_database == "completed"
  end
end
