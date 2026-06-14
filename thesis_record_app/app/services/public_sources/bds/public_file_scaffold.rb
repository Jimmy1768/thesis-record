module PublicSources
  module Bds
    class PublicFileScaffold
      def self.call!(actor:)
        new(actor: actor).call!
      end

      def initialize(actor:)
        @actor = actor
        @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
        @ingestion_policy = @policy.fetch(:public_ingestion_v1)
        @bds_policy = @ingestion_policy.fetch(:bds_sector_age_size_public_file)
      end

      def call!
        existing_source = DataSource.find_by(
          name: bds_policy.fetch(:source_name),
          source_kind: bds_policy.fetch(:source_kind)
        )
        return existing_scaffold(existing_source) if existing_source

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

      attr_reader :actor, :ingestion_policy, :bds_policy

      def existing_scaffold(source)
        access_path = source.source_access_paths.find_by!(access_type: "official_public_file_metadata")
        manifest = source.intake_manifests.find_by!(name: bds_policy.fetch(:manifest_name))
        schema_version = source.schema_versions.find_by!(version: bds_policy.fetch(:schema_version))

        source.update!(source_status: bds_policy.fetch(:source_status), metadata: source.metadata.merge(source_metadata.stringify_keys))
        access_path.update!(metadata: access_path.metadata.merge(access_path_metadata.stringify_keys))
        manifest.update!(
          manifest_status: ingestion_policy.fetch(:default_manifest_status),
          field_map: field_map,
          metadata: manifest.metadata.merge(manifest_metadata.stringify_keys)
        )
        schema_version.update!(schema_status: bds_policy.fetch(:schema_status), schema: schema_payload)

        {
          data_source: source,
          source_access_path: access_path,
          intake_manifest: manifest,
          schema_version: schema_version
        }
      end

      def register_source!
        DataSource.register!(
          {
            name: bds_policy.fetch(:source_name),
            source_kind: bds_policy.fetch(:source_kind),
            source_status: bds_policy.fetch(:source_status),
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
          reason_code: "bds_public_file_scaffold"
        )
      end

      def register_access_path!(source)
        access_path = source.source_access_paths.create!(
          access_type: "official_public_file_metadata",
          uri_or_reference: bds_policy.fetch(:source_url),
          status: "verified_metadata_only_not_fetched",
          last_checked_at: nil,
          metadata: access_path_metadata
        )

        Audit::Recorder.record!(
          actor: actor,
          event_type: "source_access_path_changed",
          entity: access_path,
          change_summary: "Registered BDS official public-file metadata access path without fetching raw data",
          reason_code: "bds_public_file_scaffold",
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
            name: bds_policy.fetch(:manifest_name),
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
          reason_code: "bds_public_file_scaffold"
        )
      end

      def create_schema_version!(source, manifest)
        schema_version = SchemaVersion.create!(
          data_source: source,
          intake_manifest: manifest,
          version: bds_policy.fetch(:schema_version),
          schema_status: bds_policy.fetch(:schema_status),
          schema: schema_payload,
          notes: "BDS public-file metadata scaffold only; no raw-file fetch, rows, metrics, analysis, or claim support."
        )

        Audit::Recorder.record!(
          actor: actor,
          event_type: "schema_version_created",
          entity: schema_version,
          change_summary: "Registered BDS public-file metadata scaffold",
          reason_code: "bds_public_file_scaffold",
          storage_zone: source.storage_zone,
          privacy_classification: source.privacy_classification,
          source_id: source.id
        )

        schema_version
      end

      def source_metadata
        {
          dataset_page_url: bds_policy.fetch(:dataset_page_url),
          methodology_url: bds_policy.fetch(:methodology_url),
          observed_year_range: bds_policy.fetch(:observed_year_range),
          year_count: bds_policy.fetch(:year_count),
          observed_row_count_excluding_header: bds_policy.fetch(:observed_row_count_excluding_header),
          naics_vintage: bds_policy.fetch(:naics_vintage),
          industry_grain: bds_policy.fetch(:industry_grain),
          geography_grain: bds_policy.fetch(:geography_grain),
          row_grain: bds_policy.fetch(:row_grain),
          evidence_class: bds_policy.fetch(:evidence_class),
          claim_status_effect: bds_policy.fetch(:claim_status_effect),
          guardrail: "BDS is employer-firm dynamics context only; not AI, nonemployer, Operator Node, management-layer, transaction-cost, or claim-support evidence."
        }
      end

      def access_path_metadata
        {
          dataset_page_url: bds_policy.fetch(:dataset_page_url),
          methodology_url: bds_policy.fetch(:methodology_url),
          raw_file_git_allowed: bds_policy.fetch(:raw_file_git_allowed),
          raw_file_fetched: bds_policy.fetch(:raw_file_fetched),
          fetch_enabled_default: ingestion_policy.fetch(:public_file_fetch_enabled_default),
          analysis_authorized: bds_policy.fetch(:analysis_authorized)
        }
      end

      def manifest_metadata
        {
          raw_file_storage_zone: ingestion_policy.fetch(:raw_public_file_storage_zone),
          raw_file_fetched: bds_policy.fetch(:raw_file_fetched),
          data_rows_authorized: bds_policy.fetch(:data_rows_authorized),
          metric_definitions_authorized: bds_policy.fetch(:metric_definitions_authorized),
          metric_observations_authorized: bds_policy.fetch(:metric_observations_authorized),
          quality_reviews_authorized: bds_policy.fetch(:quality_reviews_authorized),
          analysis_authorized: bds_policy.fetch(:analysis_authorized),
          exports_authorized: bds_policy.fetch(:exports_authorized),
          prediction_links_authorized: bds_policy.fetch(:prediction_links_authorized),
          claim_status_effect: bds_policy.fetch(:claim_status_effect)
        }
      end

      def field_map
        bds_policy.fetch(:required_columns).index_with do |field|
          { status: "verified_exact_public_file_metadata_field" }
        end
      end

      def schema_payload
        {
          source_url: bds_policy.fetch(:source_url),
          dataset_page_url: bds_policy.fetch(:dataset_page_url),
          methodology_url: bds_policy.fetch(:methodology_url),
          required_columns: bds_policy.fetch(:required_columns),
          row_grain: bds_policy.fetch(:row_grain),
          observed_year_range: bds_policy.fetch(:observed_year_range),
          observed_row_count_excluding_header: bds_policy.fetch(:observed_row_count_excluding_header),
          naics_vintage: bds_policy.fetch(:naics_vintage),
          industry_grain: bds_policy.fetch(:industry_grain),
          geography_grain: bds_policy.fetch(:geography_grain),
          publication_flags: bds_policy.fetch(:publication_flags),
          allowed_sector_values: bds_policy.fetch(:allowed_sector_values),
          allowed_fage_values: bds_policy.fetch(:allowed_fage_values),
          allowed_fsize_values: bds_policy.fetch(:allowed_fsize_values),
          compatibility_status: bds_policy.fetch(:compatibility_status),
          unresolved_paths: bds_policy.fetch(:unresolved_paths),
          prohibited_use: bds_policy.fetch(:prohibited_use)
        }
      end
    end
  end
end
