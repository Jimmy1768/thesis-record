class MetricDefinition < ApplicationRecord
  validates :key, :name, :formula_status, presence: true
  validates :key, uniqueness: true
end
