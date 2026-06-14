class PredictionLink < ApplicationRecord
  belongs_to :metric_observation, optional: true
  belongs_to :data_source, optional: true

  validates :prediction_id, :evidence_classification, :review_status, presence: true
end
