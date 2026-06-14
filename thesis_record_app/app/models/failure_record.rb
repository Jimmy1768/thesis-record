class FailureRecord < ApplicationRecord
  belongs_to :prediction_link, optional: true
  belongs_to :audit_event, optional: true

  validates :prediction_id, :horizon, :failure_type, :metric_status,
            :observed_direction, :expected_direction, :human_review_status,
            :publication_status, :revision_action, presence: true
end
