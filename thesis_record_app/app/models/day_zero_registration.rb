class DayZeroRegistration < ApplicationRecord
  validates :baseline_key, :baseline_observed_on, :manifest_digest, :manifest, :verified_at, presence: true
  validates :baseline_key, uniqueness: true

  before_update { raise ActiveRecord::ReadOnlyRecord, "Day 0 registration is immutable" }
  before_destroy { raise ActiveRecord::ReadOnlyRecord, "Day 0 registration is immutable" }
end
