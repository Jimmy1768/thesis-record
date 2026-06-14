class SusbPublicFileRow < ApplicationRecord
  belongs_to :data_source
  belongs_to :intake_manifest
  belongs_to :schema_version

  validates :year, :state_code, :naics_code, :enterprise_size_code,
            :firm_count, :establishment_count, :employment,
            :employment_noise_flag, :annual_payroll_thousand,
            :payroll_noise_flag, :state_name, :naics_description,
            :enterprise_size_description, :row_hash, presence: true
  validates :employment_noise_flag, :payroll_noise_flag, inclusion: { in: %w[G H J D S] }
  validates :receipts_noise_flag, inclusion: { in: %w[G H J D S] }, allow_nil: true
  validates :enterprise_size_code, uniqueness: { scope: [ :data_source_id, :year, :state_code, :naics_code ] }
end
