module Evidence
  class RegisterDayZero
    class RegistrationMismatch < StandardError; end

    def self.call!(config: Rails.application.config_for(:day_zero_baseline).deep_symbolize_keys)
      raise RegistrationMismatch, "production Day 0 registration is a later phase" if Rails.env.production?

      key = config.fetch(:baseline_key)
      existing = DayZeroRegistration.find_by(baseline_key: key)
      return verify!(existing) if existing

      result = DayZeroManifestBuilder.call(config: config)
      DayZeroRegistration.create!(
        baseline_key: key,
        baseline_observed_on: config.fetch(:baseline_observed_on),
        manifest: result.manifest,
        manifest_digest: result.manifest_digest,
        verified_at: Time.current
      )
    rescue ActiveRecord::RecordNotUnique
      verify!(DayZeroRegistration.find_by!(baseline_key: key))
    end

    def self.verify!(registration)
      manifest = registration.manifest
      raise RegistrationMismatch, "Day 0 manifest digest changed" unless
        CanonicalDigest.call(manifest) == registration.manifest_digest

      DayZeroManifestBuilder::TABLE_MODELS.each do |name, model|
        SealedRelationManifest.verify!(model: model, manifest: manifest.fetch("tables").fetch(name.to_s))
      end
      registration
    end
  end
end
