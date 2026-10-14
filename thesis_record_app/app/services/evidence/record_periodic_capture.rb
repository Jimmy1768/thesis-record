require "digest"

module Evidence
  class RecordPeriodicCapture
    BATCH_SIZE = 1_000

    SOURCE_MODELS = {
      "census_susb_public_file" => SusbPublicFileRow,
      "census_bds_public_file" => BdsPublicFileRow,
      "census_bfs_api" => BfsApiRow
    }.freeze

    class CaptureError < StandardError; end

    def self.call!(data_source:, intake_manifest:, schema_version:, dataset_scope:,
                   release_identity:, response:, parser_version:, parser:, checked_at: Time.current)
      raise CaptureError, "production periodic capture is not authorized" if
        Rails.env.production? && ENV["THESIS_RECORD_ALLOW_QUARTERLY_COLLECTION"] != "true"

      model = SOURCE_MODELS.fetch(data_source.source_kind)
      raise CaptureError, "source metadata mismatch" unless
        intake_manifest.data_source_id == data_source.id &&
        schema_version.data_source_id == data_source.id &&
        schema_version.intake_manifest_id == intake_manifest.id
      raise CaptureError, "response must be a String" unless response.is_a?(String)
      raise CaptureError, "parser is required" unless parser.respond_to?(:call)

      response_bytes = response.dup.b.freeze
      digest = Digest::SHA256.hexdigest(response_bytes)
      rows = parser.call(response_bytes)
      raise CaptureError, "parser must return an enumerable" unless rows.respond_to?(:each)

      identity = {
        data_source_id: data_source.id,
        dataset_scope: dataset_scope,
        release_identity: release_identity,
        response_sha256: digest,
        parser_version: parser_version
      }
      PeriodicCapture.transaction do
        connection = PeriodicCapture.connection
        lock_key = CanonicalDigest.call(identity)
        connection.execute("SELECT pg_advisory_xact_lock(20260920, hashtext(#{connection.quote(lock_key)}))")
        capture = PeriodicCapture.find_by(identity)
        if capture
          raise CaptureError, "existing capture is incomplete" unless capture.status == "completed"
          status = "unchanged"
        else
          capture = PeriodicCapture.create!(**identity, row_count: 0,
                                            parsed_rows_digest: Digest::SHA256.hexdigest(""),
                                            status: "loading", retrieved_at: checked_at)
          status = "new"
        end
        parsed_digest = Digest::SHA256.new
        count = 0
        batch = []
        rows.each do |row|
          raise CaptureError, "parser rows must be Hashes" unless row.is_a?(Hash)
          attributes = row.symbolize_keys.except(:id, :data_source_id, :intake_manifest_id,
                                                  :schema_version_id, :periodic_capture_id,
                                                  :created_at, :updated_at)
          parsed_digest << CanonicalDigest.dump(attributes) << "\n"
          count += 1
          if status == "new"
            record = model.new(**attributes, data_source: data_source,
                               intake_manifest: intake_manifest, schema_version: schema_version,
                               periodic_capture: capture, created_at: checked_at, updated_at: checked_at)
            raise ActiveRecord::RecordInvalid, record unless record.valid?

            batch << record.attributes.except("id")
            if batch.size >= BATCH_SIZE
              model.insert_all!(batch)
              batch.clear
            end
          end
        end
        raise CaptureError, "capture contains no source rows" if count.zero?
        if status == "new"
          model.insert_all!(batch) if batch.any?
          capture.update!(row_count: count, parsed_rows_digest: parsed_digest.hexdigest,
                          status: "completed", completed_at: Time.current)
        elsif capture.row_count != count || capture.parsed_rows_digest != parsed_digest.hexdigest
          raise CaptureError, "existing capture parsed rows differ"
        end
        PeriodicSourceCheck.create!(data_source: data_source, periodic_capture: capture,
                                    dataset_scope: dataset_scope, release_identity: release_identity,
                                    status: status, checked_at: checked_at)
        capture
      end
    rescue StandardError => error
      PeriodicSourceCheck.create!(data_source: data_source, dataset_scope: dataset_scope,
                                  release_identity: release_identity, status: "failed",
                                  error_class: error.class.name, checked_at: checked_at) if
        data_source&.persisted? && dataset_scope.present? && release_identity.present?
      raise
    end
  end
end
