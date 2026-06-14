module PublicSources
  module Bfs
    class ApiScaffold
      def self.call!(actor:)
        new(actor: actor).call!
      end

      def initialize(actor:)
        @actor = actor
        @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
        @ingestion_policy = @policy.fetch(:public_ingestion_v1)
        @bfs_policy = @ingestion_policy.fetch(:bfs_monthly_api)
      end

      def call!
        existing_source = DataSource.find_by(name: bfs_policy.fetch(:source_name), source_kind: bfs_policy.fetch(:source_kind))
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

      attr_reader :actor, :ingestion_policy, :bfs_policy

      def existing_scaffold(source)
        access_path = source.source_access_paths.find_by!(access_type: "official_census_api_metadata")
        manifest = source.intake_manifests.find_by!(name: bfs_policy.fetch(:manifest_name))
        schema_version = source.schema_versions.find_by!(version: bfs_policy.fetch(:schema_version))

        source.update!(metadata: source.metadata.merge(source_metadata.stringify_keys))
        access_path.update!(metadata: access_path.metadata.merge(access_path_metadata.stringify_keys))
        manifest.update!(
          field_map: field_map,
          metadata: manifest.metadata.merge(manifest_metadata.stringify_keys)
        )
        schema_version.update!(schema: schema_payload)

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
            name: bfs_policy.fetch(:source_name),
            source_kind: bfs_policy.fetch(:source_kind),
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
          reason_code: "bfs_api_scaffold"
        )
      end

      def register_access_path!(source)
        access_path = source.source_access_paths.create!(
          access_type: "official_census_api_metadata",
          uri_or_reference: bfs_policy.fetch(:endpoint_url),
          status: "verified_metadata_only_not_queried",
          last_checked_at: nil,
          metadata: access_path_metadata
        )

        Audit::Recorder.record!(
          actor: actor,
          event_type: "source_access_path_changed",
          entity: access_path,
          change_summary: "Registered BFS official API metadata access path without querying data",
          reason_code: "bfs_api_scaffold",
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
            name: bfs_policy.fetch(:manifest_name),
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
          reason_code: "bfs_api_scaffold"
        )
      end

      def create_schema_version!(source, manifest)
        schema_version = SchemaVersion.create!(
          data_source: source,
          intake_manifest: manifest,
          version: bfs_policy.fetch(:schema_version),
          schema_status: bfs_policy.fetch(:schema_status),
          schema: schema_payload,
          notes: "BFS API metadata scaffold only; no API data query, metrics, analysis, or claim support."
        )

        Audit::Recorder.record!(
          actor: actor,
          event_type: "schema_version_created",
          entity: schema_version,
          change_summary: "Registered BFS verified API metadata scaffold",
          reason_code: "bfs_api_scaffold",
          storage_zone: source.storage_zone,
          privacy_classification: source.privacy_classification,
          source_id: source.id
        )

        schema_version
      end

      def source_metadata
        {
          endpoint_url: bfs_policy.fetch(:endpoint_url),
          monthly_data_dictionary_url: bfs_policy.fetch(:monthly_data_dictionary_url),
          geography_grain_status: bfs_policy.fetch(:geography_grain_status),
          category_code_mapping_status: bfs_policy.fetch(:category_code_mapping_status),
          data_type_code_mapping_status: bfs_policy.fetch(:data_type_code_mapping_status),
          evidence_class: bfs_policy.fetch(:evidence_class),
          claim_status_effect: bfs_policy.fetch(:claim_status_effect),
          guardrail: "BFS employer formations are an indirect payroll-transition proxy only; not nonemployer conversion, AI, Operator Node, or claim-support evidence."
        }
      end

      def manifest_metadata
        {
          api_data_queried: false,
          data_rows_stored: false,
          metrics_authorized: false,
          analysis_authorized: false,
          exports_authorized: false,
          claim_status_effect: bfs_policy.fetch(:claim_status_effect)
        }
      end

      def access_path_metadata
        {
          variables_url: bfs_policy.fetch(:variables_url),
          geography_url: bfs_policy.fetch(:geography_url),
          monthly_data_dictionary_url: bfs_policy.fetch(:monthly_data_dictionary_url),
          examples_url: bfs_policy.fetch(:examples_url),
          api_pull_authorized: false,
          analysis_authorized: false
        }
      end

      def field_map
        bfs_policy.fetch(:exact_fields).index_with { |_field| { status: "verified_exact_api_metadata_field" } }
      end

      def schema_payload
        {
          endpoint_url: bfs_policy.fetch(:endpoint_url),
          variables_url: bfs_policy.fetch(:variables_url),
          geography_url: bfs_policy.fetch(:geography_url),
          monthly_data_dictionary_url: bfs_policy.fetch(:monthly_data_dictionary_url),
          examples_url: bfs_policy.fetch(:examples_url),
          exact_fields: bfs_policy.fetch(:exact_fields),
          candidate_measure_abbreviations_not_api_verified: bfs_policy.fetch(:candidate_measure_abbreviations_not_api_verified),
          verified_data_type_codes: bfs_policy.fetch(:verified_data_type_codes),
          target_data_type_codes: bfs_policy.fetch(:target_data_type_codes),
          verified_category_codes: bfs_policy.fetch(:verified_category_codes),
          api_example_query_shape: bfs_policy.fetch(:api_example_query_shape),
          compatibility_blocks: {
            category_code_mapping_status: bfs_policy.fetch(:category_code_mapping_status),
            data_type_code_mapping_status: bfs_policy.fetch(:data_type_code_mapping_status),
            geography_grain_status: bfs_policy.fetch(:geography_grain_status)
          },
          prohibited_use: bfs_policy.fetch(:prohibited_use)
        }
      end
    end
  end
end
