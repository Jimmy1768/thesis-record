module PublicSources
  module Bds
    class ComputeSourceNativeObservations
      class ComputationError < StandardError; end

      Result = Data.define(
        :data_source,
        :eligible_rows,
        :observations_created,
        :observations_deleted,
        :status_counts,
        :metric_counts,
        :blocked_cells,
        :quality_reviews_created,
        :prediction_links_created,
        :exports_created
      )

      BATCH_SIZE = 5_000

      METRIC_FIELD_MAP = {
        bds_firms: { source_field: "firms", unit: "count" },
        bds_establishments: { source_field: "estabs", unit: "count" },
        bds_employment: { source_field: "emp", unit: "employees" },
        bds_establishment_entries: { source_field: "estabs_entry", unit: "count" },
        bds_establishment_exits: { source_field: "estabs_exit", unit: "count" },
        bds_firm_deaths: { source_field: "firmdeath_firms", unit: "count" },
        bds_job_creation: { source_field: "job_creation", unit: "jobs" },
        bds_job_destruction: { source_field: "job_destruction", unit: "jobs" },
        bds_net_job_creation: { source_field: "net_job_creation", unit: "jobs" },
        bds_reallocation_rate: { source_field: "reallocation_rate", unit: "rate" }
      }.freeze

      def self.call!(actor:)
        new(actor: actor).call!
      end

      def initialize(actor:)
        @actor = actor
        @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
        @bds_policy = @policy.fetch(:public_ingestion_v1).fetch(:bds_sector_age_size_public_file)
        @design = @bds_policy.fetch(:parser_design_v1).fetch(:metric_computation_design_v1)
      end

      def call!
        ensure_design_allowed!
        source = find_source!
        metric_definitions = find_metric_definitions!
        scope = BdsPublicFileRow.where(data_source: source)
        eligible_rows = scope.count
        raise ComputationError, "No BDS source rows found" if eligible_rows.zero?

        before_counts = guardrail_counts
        observations_deleted = delete_existing_observations!(source, metric_definitions)
        counters = compute_observations!(scope, source, metric_definitions)
        record_audit!(source, eligible_rows, counters)
        after_counts = guardrail_counts
        validate_guardrails!(before_counts, after_counts)

        Result.new(
          data_source: source,
          eligible_rows: eligible_rows,
          observations_created: counters.fetch(:observations_created),
          observations_deleted: observations_deleted,
          status_counts: counters.fetch(:status_counts),
          metric_counts: counters.fetch(:metric_counts),
          blocked_cells: counters.fetch(:blocked_cells),
          quality_reviews_created: after_counts.fetch(:quality_reviews) - before_counts.fetch(:quality_reviews),
          prediction_links_created: after_counts.fetch(:prediction_links) - before_counts.fetch(:prediction_links),
          exports_created: after_counts.fetch(:exports) - before_counts.fetch(:exports)
        )
      end

      private

      attr_reader :actor, :bds_policy, :design

      def ensure_design_allowed!
        result = PublicSources::Bds::MetricComputationDesignCheck.call(require_no_bds_observations: false)
        raise ComputationError, result.failures.join("; ") unless result.passed
      end

      def find_source!
        DataSource.find_by!(
          name: bds_policy.fetch(:source_name),
          source_kind: bds_policy.fetch(:source_kind)
        )
      end

      def find_metric_definitions!
        design.fetch(:eligible_metric_keys).index_with do |key|
          MetricDefinition.find_by!(key: key)
        end
      end

      def delete_existing_observations!(source, metric_definitions)
        MetricObservation.where(
          data_source: source,
          metric_definition: metric_definitions.values
        ).delete_all
      end

      def compute_observations!(scope, source, metric_definitions)
        now = Time.current
        batch = []
        counters = {
          observations_created: 0,
          status_counts: Hash.new(0),
          metric_counts: Hash.new(0),
          blocked_cells: Hash.new(0)
        }

        scope.find_each(batch_size: BATCH_SIZE) do |row|
          METRIC_FIELD_MAP.each do |key, metric|
            definition = metric_definitions.fetch(key.to_s)
            observation = observation_attributes(row, source, definition, key.to_s, metric, now)
            if observation
              batch << observation
              counters[:observations_created] += 1
              counters.fetch(:status_counts)[observation.fetch(:metric_status)] += 1
              counters.fetch(:metric_counts)[key.to_s] += 1
            else
              counters.fetch(:blocked_cells)[key.to_s] += 1
            end

            if batch.size >= BATCH_SIZE
              MetricObservation.insert_all!(batch)
              batch.clear
            end
          end
        end

        MetricObservation.insert_all!(batch) if batch.any?
        counters
      end

      def observation_attributes(row, source, definition, key, metric, timestamp)
        source_field = metric.fetch(:source_field)
        raw_value = row.raw_measure_values.fetch(source_field)
        publication_flag = row.publication_flags[source_field]
        numeric_value = row.numeric_measure_values[source_field]
        status = status_for(raw_value, publication_flag, numeric_value)
        return nil unless status == "staged_context"

        {
          metric_definition_id: definition.id,
          data_source_id: source.id,
          period: row.year.to_s,
          metric_status: status,
          numeric_value: numeric_value,
          unit: metric.fetch(:unit),
          dimensions: dimensions_for(row),
          quality_metadata: quality_metadata_for(row, key, source_field, raw_value, publication_flag, status),
          created_at: timestamp,
          updated_at: timestamp
        }
      end

      def status_for(raw_value, publication_flag, numeric_value)
        return design.fetch(:source_value_rules).fetch(:"publication_flag_#{publication_flag}") if publication_flag.present?
        return design.fetch(:source_value_rules).fetch(:null_numeric_value) if numeric_value.nil?
        return design.fetch(:source_value_rules).fetch(:missing_source_row) if raw_value.nil?

        design.fetch(:source_value_rules).fetch(:numeric_cell_value)
      end

      def dimensions_for(row)
        {
          year: row.year,
          sector_code: row.sector_code,
          firm_age_code: row.firm_age_code,
          firm_size_code: row.firm_size_code,
          evidence_class: design.fetch(:evidence_class),
          grain: design.fetch(:grain)
        }
      end

      def quality_metadata_for(row, key, source_field, raw_value, publication_flag, status)
        {
          source_table: "bds_public_file_rows",
          source_row_id: row.id,
          source_row_hash: row.row_hash,
          metric_key: key,
          source_grain: design.fetch(:grain),
          source_year: row.year,
          source_sector_code: row.sector_code,
          source_firm_age_code: row.firm_age_code,
          source_firm_size_code: row.firm_size_code,
          source_field: source_field,
          source_cell_value_raw: raw_value,
          source_publication_flag: publication_flag,
          metric_status_reason: status,
          claim_status_effect: design.fetch(:claim_status_effect),
          ratios_computed: false,
          trends_computed: false,
          aggregation_computed: false,
          exports_created: false,
          prediction_links_created: false,
          claim_support_authorized: false,
          guardrail: "BDS source-native context only; no AI, Operator Node, nonemployer conversion, management-layer, transaction-cost, firm-boundary, or thesis interpretation."
        }
      end

      def record_audit!(source, eligible_rows, counters)
        Audit::Recorder.record!(
          actor: actor,
          event_type: "metric_observation_created",
          entity: source,
          change_summary: "Created #{counters.fetch(:observations_created)} BDS source-native context observations from #{eligible_rows} source rows",
          reason_code: "bds_source_native_observation_computation",
          storage_zone: source.storage_zone,
          privacy_classification: source.privacy_classification,
          claim_status_effect: design.fetch(:claim_status_effect),
          source_id: source.id
        )
      end

      def validate_guardrails!(before_counts, after_counts)
        %i[quality_reviews prediction_links exports].each do |key|
          next if before_counts.fetch(key) == after_counts.fetch(key)

          raise ComputationError, "BDS source-native observation computation changed #{key}"
        end
      end

      def guardrail_counts
        {
          quality_reviews: MetricQualityReview.joins(:data_source).where(data_sources: { source_kind: bds_policy.fetch(:source_kind) }).count,
          prediction_links: PredictionLink.joins(metric_observation: :data_source).where(data_sources: { source_kind: bds_policy.fetch(:source_kind) }).count,
          exports: AuditEvent.where(event_type: "export_created").count
        }
      end
    end
  end
end
