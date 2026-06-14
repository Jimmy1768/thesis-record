class SchemaVersion < ApplicationRecord
  belongs_to :data_source, optional: true
  belongs_to :intake_manifest, optional: true

  validates :version, :schema_status, presence: true
end
