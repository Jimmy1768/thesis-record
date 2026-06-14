class MetricQualityReview < ApplicationRecord
  belongs_to :metric_observation
  belongs_to :data_source, optional: true

  validates :policy_version,
            :source_metric_status,
            :review_status,
            :review_reason_code,
            :reviewed_by,
            :reviewed_at,
            presence: true
end
