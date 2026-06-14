class ClaimReview < ApplicationRecord
  belongs_to :prediction_link, optional: true

  validates :claim_id, :review_status, :prior_status, :proposed_status,
            :reason_code, presence: true
end
