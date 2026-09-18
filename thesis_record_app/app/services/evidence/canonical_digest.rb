require "digest"
require "json"

module Evidence
  class CanonicalDigest
    VERSION = "canonical-json-v1"

    def self.call(value)
      Digest::SHA256.hexdigest(dump(value))
    end

    def self.dump(value)
      JSON.generate(canonicalize(value))
    end

    def self.canonicalize(value)
      case value
      when Hash
        value.to_h.transform_keys(&:to_s).sort.to_h.transform_values { |item| canonicalize(item) }
      when Array
        value.map { |item| canonicalize(item) }
      when Time, DateTime, ActiveSupport::TimeWithZone
        value.utc.iso8601(6)
      when Date
        value.iso8601
      when BigDecimal
        value.to_s("F")
      else
        value
      end
    end
    private_class_method :canonicalize
  end
end
