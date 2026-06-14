class ExportArtifact < ApplicationRecord
  belongs_to :evidence_snapshot, optional: true

  validates :artifact_kind, :export_status, :privacy_review_status, presence: true
  validate :review_required_for_public_repo_exports

  private

  def review_required_for_public_repo_exports
    return unless reviewed_for_public_repo? == false && export_status == "published_to_git"

    errors.add(:reviewed_for_public_repo, "must be true before publishing to Git")
  end
end
