class EvidenceSnapshot < ApplicationRecord
  validates :version_label, :snapshot_status, :frozen_at, presence: true
end
