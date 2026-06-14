class SourceAccessPath < ApplicationRecord
  belongs_to :data_source

  validates :access_type, :uri_or_reference, :status, presence: true
end
