class MetricObservation < ApplicationRecord
  belongs_to :metric_definition
  belongs_to :data_source, optional: true
  has_one :metric_quality_review, dependent: :restrict_with_exception

  validates :period, :metric_status, presence: true
end
