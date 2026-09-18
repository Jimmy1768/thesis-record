module Evidence
  class QuarterlyDatabaseCollectionJob < ApplicationJob
    queue_as :maintenance

    def perform(quarter:, cutoff_at:, registry_ids:)
      CollectQuarterly.call!(quarter: quarter, cutoff_at: Time.iso8601(cutoff_at),
                             registry_ids: registry_ids)
    end
  end
end
