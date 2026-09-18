class PeriodicSourceCheck < ApplicationRecord
  belongs_to :data_source
  belongs_to :periodic_capture, optional: true

  validates :dataset_scope, :release_identity, :status, :checked_at, presence: true
  validates :status, inclusion: { in: %w[new unchanged failed] }
end
