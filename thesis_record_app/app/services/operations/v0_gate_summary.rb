require "yaml"

module Operations
  class V0GateSummary
    Gate = Data.define(:name, :approval_status, :validator_passed, :required_artifacts, :failures, :warnings)
    Result = Data.define(
      :generated_at,
      :thesis_slug,
      :approval_status,
      :public_release_status,
      :baseline_status,
      :scaffolds_passed,
      :v0_readiness_passed,
      :v0_readiness_blockers,
      :gates,
      :warnings
    )

    THESIS_SLUG = "operator-node-economics"
    REPO_ROOT = Rails.root.join("..").expand_path
    THESIS_ROOT = REPO_ROOT.join("theses", THESIS_SLUG)
    V0_APPROVAL_PACKET_PATH = THESIS_ROOT.join("publication", "v0_approval_packet.yml")

    VALIDATOR_BY_GATE = {
      source_truth_review: Operations::V0SourceTruthReview,
      prohibited_foundations_review: Operations::V0ProhibitedFoundationsReview,
      frozen_claim_set_review: Operations::V0FrozenClaimSetReview,
      frozen_forecast_set_review: Operations::V0FrozenForecastSetReview,
      prose_review: Operations::V0ProseReview,
      public_release_review: Operations::V0PublicReleaseReview
    }.freeze

    def self.call(approval_packet: nil, validators: nil, v0_readiness: nil, generated_at: Time.current)
      new(
        approval_packet: approval_packet,
        validators: validators,
        v0_readiness: v0_readiness,
        generated_at: generated_at
      ).call
    end

    def initialize(approval_packet:, validators:, v0_readiness:, generated_at:)
      @approval_packet = approval_packet
      @validators = validators
      @v0_readiness = v0_readiness
      @generated_at = generated_at
    end

    def call
      loaded_approval_packet = approval_packet || load_yaml(V0_APPROVAL_PACKET_PATH)
      readiness = v0_readiness || Operations::V0Readiness.call
      gate_results = gates(loaded_approval_packet)

      Result.new(
        generated_at: generated_at,
        thesis_slug: loaded_approval_packet.fetch(:thesis_slug, THESIS_SLUG),
        approval_status: loaded_approval_packet.fetch(:approval_status, nil),
        public_release_status: loaded_approval_packet.fetch(:public_release_status, nil),
        baseline_status: loaded_approval_packet.fetch(:baseline_status, nil),
        scaffolds_passed: gate_results.all?(&:validator_passed),
        v0_readiness_passed: readiness.passed,
        v0_readiness_blockers: readiness.blockers,
        gates: gate_results,
        warnings: warnings(loaded_approval_packet, readiness, gate_results)
      )
    end

    private

    attr_reader :approval_packet, :validators, :v0_readiness, :generated_at

    def load_yaml(path)
      return {} unless path.exist?

      YAML.safe_load_file(path).deep_symbolize_keys
    end

    def gates(loaded_approval_packet)
      configured_gates = loaded_approval_packet.fetch(:approval_gates, {})

      configured_gates.map do |gate_name, gate_config|
        validator_result = validator_result_for(gate_name)
        Gate.new(
          name: gate_name,
          approval_status: gate_config.fetch(:status, nil),
          validator_passed: validator_passed?(gate_name, gate_config, validator_result),
          required_artifacts: gate_config.fetch(:required_artifacts, []),
          failures: validator_result&.failures.to_a,
          warnings: validator_result&.warnings.to_a
        )
      end
    end

    def validator_result_for(gate_name)
      return validators.fetch(gate_name) if validators&.key?(gate_name)

      validator = VALIDATOR_BY_GATE.fetch(gate_name, nil)
      validator&.call
    end

    def validator_passed?(gate_name, gate_config, validator_result)
      return validator_result.passed unless validator_result.nil?

      return baseline_artifacts_present?(gate_config) if gate_name == :baseline_evidence_review

      false
    end

    def baseline_artifacts_present?(gate_config)
      gate_config.fetch(:status, nil) == "accepted" &&
        gate_config.fetch(:required_artifacts, []).all? { |artifact_path| REPO_ROOT.join(artifact_path).exist? }
    end

    def warnings(loaded_approval_packet, readiness, gate_results)
      [].tap do |warnings|
        warnings << "approval_packet_unapproved" if loaded_approval_packet.fetch(:approval_status, nil) == "unapproved"
        warnings << "public_release_not_public" if loaded_approval_packet.fetch(:public_release_status, nil) == "not_public"
        warnings << "v0_readiness_blocked" unless readiness.passed
        gate_results.each do |gate|
          warnings << "#{gate.name}_#{gate.approval_status}" unless gate.approval_status == "accepted"
        end
      end
    end
  end
end
