require "digest"

module Evidence
  class SealedRelationManifest
    Result = Data.define(:manifest, :manifest_digest)

    class VerificationError < StandardError; end

    def self.build(relation, batch_size: 5_000)
      new(relation, batch_size: batch_size).build
    end

    def self.verify!(model:, manifest:, batch_size: 5_000)
      expected = manifest.deep_stringify_keys
      relation = relation_for_ranges(model, expected.fetch("primary_key"), expected.fetch("member_id_ranges"))
      actual = build(relation, batch_size: batch_size).manifest.deep_stringify_keys
      return true if actual == expected

      raise VerificationError, "sealed relation manifest does not match #{model.table_name}"
    end

    def self.relation_for_ranges(model, primary_key, ranges)
      ranges.reduce(model.none) do |scope, bounds|
        first, last = bounds
        scope.or(model.where(primary_key => first..last))
      end
    end
    private_class_method :relation_for_ranges

    def initialize(relation, batch_size:)
      @relation = relation
      @batch_size = batch_size
    end

    def build
      columns = relation.klass.column_names.sort
      primary_key = relation.klass.primary_key
      content_digest = Digest::SHA256.new
      member_id_digest = Digest::SHA256.new
      ranges = []
      range_start = nil
      previous_id = nil
      row_count = 0

      relation.reorder(primary_key => :asc).find_each(batch_size: batch_size) do |record|
        id = record.public_send(primary_key)
        if previous_id.nil? || id != previous_id + 1
          ranges << [ range_start, previous_id ] if previous_id
          range_start = id
        end
        previous_id = id
        row_count += 1

        member_id_digest << id.to_s << "\n"
        values = columns.to_h { |column| [ column, record.public_send(column) ] }
        content_digest << Evidence::CanonicalDigest.dump(values) << "\n"
      end
      ranges << [ range_start, previous_id ] if previous_id

      manifest = {
        "table" => relation.klass.table_name,
        "primary_key" => primary_key,
        "columns" => columns,
        "row_count" => row_count,
        "member_id_ranges" => ranges,
        "member_id_sha256" => member_id_digest.hexdigest,
        "content_sha256" => content_digest.hexdigest,
        "canonicalization_version" => Evidence::CanonicalDigest::VERSION
      }
      Result.new(manifest: manifest, manifest_digest: Evidence::CanonicalDigest.call(manifest))
    end

    private

    attr_reader :relation, :batch_size
  end
end
