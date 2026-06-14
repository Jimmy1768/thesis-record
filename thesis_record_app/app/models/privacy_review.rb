class PrivacyReview < ApplicationRecord
  belongs_to :data_source, optional: true
  belongs_to :intake_manifest, optional: true

  validates :review_status, :privacy_classification, :reviewed_by, presence: true
end
