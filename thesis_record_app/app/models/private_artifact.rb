class PrivateArtifact < ApplicationRecord
  include StorageClassifiable

  belongs_to :data_source, optional: true

  validates :artifact_kind, :storage_pointer, :content_hash, :retention_rule, presence: true
end
