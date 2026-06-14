class DataSource < ApplicationRecord
  include StorageClassifiable

  has_many :source_access_paths, dependent: :destroy
  has_many :intake_manifests, dependent: :restrict_with_exception
  has_many :schema_versions, dependent: :restrict_with_exception
  has_many :privacy_reviews, dependent: :restrict_with_exception
  has_many :private_artifacts, dependent: :restrict_with_exception
  has_many :metric_quality_reviews, dependent: :restrict_with_exception

  validates :name, :source_kind, :source_status, :retention_rule, presence: true

  def self.register!(attributes, actor:, reason_code: "new_source")
    transaction do
      source = create!(attributes)
      Audit::Recorder.record!(
        actor: actor,
        event_type: "source_registered",
        entity: source,
        change_summary: "Registered data source #{source.name}",
        reason_code: reason_code,
        storage_zone: source.storage_zone,
        privacy_classification: source.privacy_classification,
        claim_status_effect: "unchanged",
        export_allowed: source.public_repo_allowed?
      )
      source
    end
  end
end
