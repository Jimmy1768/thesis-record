class QualityFlag < ApplicationRecord
  belongs_to :metric_observation, optional: true
  belongs_to :data_source, optional: true

  validates :flag_type, :status, presence: true
end
