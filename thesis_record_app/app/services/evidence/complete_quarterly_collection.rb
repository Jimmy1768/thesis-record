module Evidence
  class CompleteQuarterlyCollection
    class CollectionError < StandardError; end

    def self.call!(quarter:, captures:, cutoff_at:, method_manifest:, definitions:, compute:)
      raise CollectionError, "production quarterly collection is a later phase" if Rails.env.production?

      raise CollectionError, "quarter is invalid" unless quarter.match?(/\A\d{4}-Q[1-4]\z/)
      raise CollectionError, "captures must be nonempty" unless captures.any?
      raise CollectionError, "captures must be distinct" unless captures.map(&:id).uniq.size == captures.size
      raise CollectionError, "captures must be completed" unless captures.all? { |capture| capture.status == "completed" }
      raise CollectionError, "one capture per source is required" unless captures.map(&:data_source_id).uniq.size == captures.size
      raise CollectionError, "compute block is required" unless compute.respond_to?(:call)

      capture_ids = captures.map(&:id).sort
      input_digest = CanonicalDigest.call(capture_ids)
      method_digest = CanonicalDigest.call(method_manifest)
      definition_digest = CanonicalDigest.call(definitions)
      result_identity = CanonicalDigest.call([ input_digest, method_digest, definition_digest ])
      quarter_identity = CanonicalDigest.call([ quarter, result_identity ])

      QuarterlyCollection.transaction do
        connection = QuarterlyCollection.connection
        connection.execute("SELECT pg_advisory_xact_lock(20260919, hashtext(#{connection.quote(result_identity)}))")
        connection.execute("SELECT pg_advisory_xact_lock(20260918, hashtext(#{connection.quote(quarter)}))")
        existing = QuarterlyCollection.find_by(quarter: quarter, identity_digest: quarter_identity)
        if existing
          raise CollectionError, "matching quarter is incomplete" unless existing.status == "completed"
          next existing
        end

        result_set = QuarterlyResultSet.find_by(identity_digest: result_identity)
        if result_set
          raise CollectionError, "matching result set is incomplete" unless result_set.status == "completed"
        else
          result_set = QuarterlyResultSet.create!(
            input_digest: input_digest, method_digest: method_digest,
            definition_digest: definition_digest, identity_digest: result_identity,
            method_manifest: { "method" => method_manifest, "definitions" => definitions },
            status: "building"
          )
          items = compute.call(captures)
          raise CollectionError, "compute must return an enumerable" unless items.respond_to?(:each)
          items.each do |observation_attributes, review_attributes|
            raise CollectionError, "compute must return observation/review pairs" unless
              observation_attributes.is_a?(Hash) && review_attributes.is_a?(Hash)
            observation = MetricObservation.create!(
              **observation_attributes.symbolize_keys,
              quarterly_result_set: result_set,
              result_row_key: row_key(observation_attributes)
            )
            MetricQualityReview.create!(**review_attributes.symbolize_keys,
                                        metric_observation: observation)
          end
          count = result_set.metric_observations.count
          raise CollectionError, "result set contains no observations" if count.zero?
          raise CollectionError, "review coverage is incomplete" unless
            MetricQualityReview.where(metric_observation_id: result_set.metric_observations.select(:id)).count == count
          result_set.update!(status: "completed", observation_count: count,
                             review_count: count, completed_at: Time.current)
        end

        revision = QuarterlyCollection.where(quarter: quarter).maximum(:revision).to_i + 1
        collection = QuarterlyCollection.create!(
          quarter: quarter, revision: revision, identity_digest: quarter_identity,
          input_digest: input_digest, quarterly_result_set: result_set,
          status: "building", cutoff_at: cutoff_at
        )
        capture_ids.each do |id|
          QuarterlyCollectionCapture.create!(quarterly_collection: collection, periodic_capture_id: id)
        end
        collection.update!(status: "completed", completed_at: Time.current)
        collection
      end
    end

    def self.row_key(attributes)
      values = attributes.stringify_keys
      CanonicalDigest.call(values.slice("metric_definition_id", "data_source_id", "period", "dimensions"))
    end
    private_class_method :row_key
  end
end
