module Operations
  class LegacyEvidenceWriteFence
    class MutationDenied < StandardError; end

    def self.enforce!(operation:, environment: Rails.env)
      return true unless environment.to_s == "production"

      raise MutationDenied,
            "Legacy evidence mutation is disabled for #{operation}; use the periodic database collection path"
    end
  end
end
