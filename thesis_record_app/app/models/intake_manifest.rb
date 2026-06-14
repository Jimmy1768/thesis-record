class IntakeManifest < ApplicationRecord
  include StorageClassifiable

  belongs_to :data_source
  has_many :schema_versions, dependent: :restrict_with_exception

  validates :name, :manifest_status, :retention_rule, presence: true
end
