module Evidence
  class QuarterlyCollectionDispatchJob < ApplicationJob
    class DispatchError < StandardError; end

    SOURCE_KINDS = %w[
      census_susb_public_file
      census_bds_public_file
      census_bfs_api
    ].freeze

    queue_as :maintenance

    def perform
      quarter, cutoff_at = most_recently_closed_quarter(Time.current.utc)

      QuarterlyDatabaseCollectionJob.perform_later(
        quarter: quarter,
        cutoff_at: cutoff_at.iso8601,
        registry_ids: registry_ids
      )
    end

    private

    def most_recently_closed_quarter(now)
      current_quarter_start = Time.utc(now.year, ((now.month - 1) / 3) * 3 + 1, 1)
      closed_at = current_quarter_start - 1.second
      quarter = "#{closed_at.year}-Q#{((closed_at.month - 1) / 3) + 1}"
      cutoff_at = QuarterlyCollection.cutoff_for(quarter)

      raise DispatchError, "could not derive a quarterly cutoff" unless cutoff_at == current_quarter_start

      [ quarter, cutoff_at ]
    end

    def registry_ids
      SOURCE_KINDS.index_with { |source_kind| registry_for!(source_kind) }
    end

    def registry_for!(source_kind)
      sources = DataSource.where(source_kind: source_kind).to_a
      unless sources.one?
        raise DispatchError, "expected exactly one data source for #{source_kind}"
      end

      source = sources.first
      chains = SchemaVersion.joins(:intake_manifest)
                            .where(data_source_id: source.id,
                                   intake_manifests: { data_source_id: source.id })
                            .pluck(:id, :intake_manifest_id)
      unless chains.one?
        raise DispatchError, "expected exactly one manifest/schema chain for #{source_kind}"
      end

      schema_version_id, intake_manifest_id = chains.first
      {
        "data_source_id" => source.id,
        "intake_manifest_id" => intake_manifest_id,
        "schema_version_id" => schema_version_id
      }
    end
  end
end
