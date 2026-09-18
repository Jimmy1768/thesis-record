class BdsPublicFileRow < ApplicationRecord
  belongs_to :data_source
  belongs_to :intake_manifest
  belongs_to :schema_version
  belongs_to :periodic_capture, optional: true

  validates :source_row_number, :year, :sector_code, :firm_age_code,
            :firm_size_code, :row_hash, presence: true
  validates :sector_code,
            uniqueness: {
              scope: [
                :data_source_id,
                :year,
                :firm_age_code,
                :firm_size_code,
                :periodic_capture_id
              ]
            },
            if: -> { periodic_capture_id.nil? }
end
