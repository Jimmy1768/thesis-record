module PublicSources
  module Susb
    class PublicFileScaffold
      def self.call!(actor:, year: nil)
        new(actor: actor, year: year).call!
      end

      def initialize(actor:, year:)
        @actor = actor
        @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
        @ingestion_policy = @policy.fetch(:public_ingestion_v1)
        @susb_policy = @ingestion_policy.fetch(:susb_us_state_annual)
        @year = year || @susb_policy.fetch(:default_year)
      end

      def call!
        DataSource.transaction do
          source = register_source!
          access_path = register_access_path!(source)
          manifest = create_manifest!(source)
          schema_version = create_schema_version!(source, manifest)

          {
            data_source: source,
            source_access_path: access_path,
            intake_manifest: manifest,
            schema_version: schema_version
          }
        end
      end

      private

      attr_reader :actor, :ingestion_policy, :susb_policy, :year

      def register_source!
        DataSource.register!(
          {
            name: "#{susb_policy.fetch(:source_name)} #{year}",
            source_kind: susb_policy.fetch(:source_kind),
            source_status: ingestion_policy.fetch(:default_source_status),
            storage_zone: ingestion_policy.fetch(:metadata_storage_zone),
            privacy_classification: "public",
            public_repo_allowed: true,
            structured_private_allowed: false,
            private_file_storage_allowed: false,
            secret_material_present: false,
            redaction_required: false,
            minimum_cell_rule_required: true,
            human_review_required: true,
            retention_rule: "public_source_metadata_retained",
            claim_status_allowed: "context_only",
            metadata: source_metadata
          },
          actor: actor,
          reason_code: "susb_public_file_scaffold"
        )
      end

      def register_access_path!(source)
        access_path = source.source_access_paths.create!(
          access_type: "official_public_file",
          uri_or_reference: source_url,
          status: "verified_metadata_only_not_fetched",
          last_checked_at: nil,
          metadata: {
            record_layout_url: susb_policy.fetch(:record_layout_url),
            local_raw_path_template: susb_policy.fetch(:local_raw_path_template),
            raw_file_git_allowed: ingestion_policy.fetch(:raw_public_file_git_allowed),
            fetch_enabled_default: ingestion_policy.fetch(:public_file_fetch_enabled_default)
          }
        )

        Audit::Recorder.record!(
          actor: actor,
          event_type: "source_access_path_changed",
          entity: access_path,
          change_summary: "Registered SUSB official public-file access path without fetching raw data",
          reason_code: "susb_public_file_scaffold",
          storage_zone: source.storage_zone,
          privacy_classification: source.privacy_classification,
          source_id: source.id
        )

        access_path
      end

      def create_manifest!(source)
        IntakeManifests::Create.call!(
          data_source: source,
          attributes: {
            name: format(susb_policy.fetch(:manifest_name_template), year: year),
            manifest_status: ingestion_policy.fetch(:default_manifest_status),
            storage_zone: ingestion_policy.fetch(:metadata_storage_zone),
            privacy_classification: "public",
            public_repo_allowed: true,
            structured_private_allowed: false,
            private_file_storage_allowed: false,
            secret_material_present: false,
            redaction_required: false,
            minimum_cell_rule_required: true,
            human_review_required: true,
            retention_rule: "public_source_metadata_retained",
            field_map: field_map,
            metadata: manifest_metadata
          },
          actor: actor,
          reason_code: "susb_public_file_scaffold"
        )
      end

      def create_schema_version!(source, manifest)
        schema_version = SchemaVersion.create!(
          data_source: source,
          intake_manifest: manifest,
          version: susb_policy.fetch(:schema_version),
          schema_status: "verified_record_layout_scaffold",
          schema: schema_payload,
          notes: "SUSB U.S./state annual public-file schema scaffold only; raw file was not fetched."
        )

        Audit::Recorder.record!(
          actor: actor,
          event_type: "schema_version_created",
          entity: schema_version,
          change_summary: "Registered SUSB verified record-layout scaffold for #{year}",
          reason_code: "susb_public_file_scaffold",
          storage_zone: source.storage_zone,
          privacy_classification: source.privacy_classification,
          source_id: source.id
        )

        schema_version
      end

      def source_metadata
        {
          year: year,
          naics_vintage: susb_policy.fetch(:naics_vintage),
          geography_grain: susb_policy.fetch(:geography_grain),
          row_grain: susb_policy.fetch(:row_grain),
          metric_computation_enabled_default: ingestion_policy.fetch(:metric_computation_enabled_default),
          claim_status_effect_default: ingestion_policy.fetch(:claim_status_effect_default),
          guardrail: "Employer-side public source only; no AI, nonemployer, management-layer, transaction-cost, or one-person-firm evidence."
        }
      end

      def manifest_metadata
        {
          raw_file_storage_zone: ingestion_policy.fetch(:raw_public_file_storage_zone),
          local_raw_path: format(susb_policy.fetch(:local_raw_path_template), year: year),
          raw_file_fetched: false,
          checksum_recorded: false,
          analysis_authorized: false,
          metrics_authorized: false
        }
      end

      def field_map
        susb_policy.fetch(:required_columns).index_with { |field| { status: "required_verified_exact" } }.merge(
          susb_policy.fetch(:optional_economic_census_columns).index_with { |field| { status: "optional_economic_census_year" } }
        )
      end

      def schema_payload
        {
          source_url: source_url,
          record_layout_url: susb_policy.fetch(:record_layout_url),
          year_carried_from_file_vintage: year,
          required_columns: susb_policy.fetch(:required_columns),
          optional_economic_census_columns: susb_policy.fetch(:optional_economic_census_columns),
          row_grain: susb_policy.fetch(:row_grain),
          qa_rules: [
            "Verify exact header and column count before processing.",
            "Verify STATE, NAICS, and ENTRSIZE uniqueness at intended grain.",
            "Preserve EMPLFL_N, PAYRFL_N, and RCPTFL_N before numeric coercion.",
            "Treat D and S noise flags as withheld cells, not true zeroes.",
            "Do not compute ratios or metrics in scaffold phase."
          ]
        }
      end

      def source_url
        susb_policy.fetch(:source_url).sub("/2022/", "/#{year}/").sub("_2022.", "_#{year}.")
      end
    end
  end
end
