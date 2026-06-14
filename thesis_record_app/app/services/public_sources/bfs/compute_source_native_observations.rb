module PublicSources
  module Bfs
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
        :prediction_links_created,
        :exports_created
      )

      BATCH_SIZE = 5_000

      DATA_TYPE_METRIC_KEYS = {
        "BA_BA" => "bfs_business_applications",
        "BA_HBA" => "bfs_high_propensity_business_applications",
        "BF_BF4Q" => "bfs_business_formations_4q",
        "BF_BF8Q" => "bfs_business_formations_8q",
        "BF_PBF4Q" => "bfs_projected_business_formations_4q",
        "BF_PBF8Q" => "bfs_projected_business_formations_8q"
      }.freeze

      def self.call!(actor:)
        new(actor: actor).call!
      end

      def initialize(actor:)
        @actor = actor
        @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
        @bfs_policy = @policy.fetch(:public_ingestion_v1).fetch(:bfs_monthly_api)
        @design = @bfs_policy.fetch(:metric_computation_design_v1)
      end

      def call!
        ensure_design_allowed!
        source = find_source!
        metric_definitions = find_metric_definitions!
        scope = eligible_rows_scope(source)
        eligible_rows = scope.count
        raise ComputationError, "No eligible BFS staging rows found" if eligible_rows.zero?

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
          prediction_links_created: after_counts.fetch(:prediction_links) - before_counts.fetch(:prediction_links),
          exports_created: after_counts.fetch(:exports) - before_counts.fetch(:exports)
        )
      end

      private

      attr_reader :actor, :bfs_policy, :design

      def ensure_design_allowed!
        result = PublicSources::Bfs::MetricComputationDesignCheck.call(require_no_bfs_observations: false)
        raise ComputationError, result.failures.join("; ") unless result.passed
      end

      def find_source!
        DataSource.find_by!(
          name: bfs_policy.fetch(:source_name),
          source_kind: bfs_policy.fetch(:source_kind)
        )
      end

      def find_metric_definitions!
        design.fetch(:first_pass_metric_keys).index_with do |key|
          MetricDefinition.find_by!(key: key)
        end
      end

      def eligible_rows_scope(source)
        BfsApiRow.where(
          data_source: source,
          geography_level: design.fetch(:eligible_geography_level),
          seasonally_adj: design.fetch(:eligible_seasonally_adj),
          data_type_code: design.fetch(:eligible_data_type_codes),
          category_code: design.fetch(:eligible_category_codes)
        )
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
          key = metric_key_for(row)
          observation = observation_attributes(row, source, metric_definitions.fetch(key), key, now)
          if observation
            batch << observation
            counters[:observations_created] += 1
            counters.fetch(:status_counts)[observation.fetch(:metric_status)] += 1
            counters.fetch(:metric_counts)[key] += 1
          else
            counters.fetch(:blocked_cells)[key] += 1
          end

          if batch.size >= BATCH_SIZE
            MetricObservation.insert_all!(batch)
            batch.clear
          end
        end

        MetricObservation.insert_all!(batch) if batch.any?
        counters
      end

      def observation_attributes(row, source, definition, key, timestamp)
        status = status_for(row)
        return nil unless status == "staged_context"

        {
          metric_definition_id: definition.id,
          data_source_id: source.id,
          period: row.period_month,
          metric_status: status,
          numeric_value: row.cell_value_numeric,
          unit: "count",
          dimensions: dimensions_for(row),
          quality_metadata: quality_metadata_for(row, key, status),
          created_at: timestamp,
          updated_at: timestamp
        }
      end

      def status_for(row)
        return design.fetch(:source_value_rules).fetch(:error_data_yes) unless row.error_data == "no"
        return design.fetch(:source_value_rules).fetch(:missing_cell_value) if row.cell_value_raw.blank?
        return design.fetch(:source_value_rules).fetch(:non_numeric_cell_value) if row.cell_value_numeric.nil?

        design.fetch(:source_value_rules).fetch(:numeric_cell_value)
      end

      def metric_key_for(row)
        DATA_TYPE_METRIC_KEYS.fetch(row.data_type_code)
      end

      def dimensions_for(row)
        {
          year: row.year,
          month: row.month,
          period_month: row.period_month,
          data_type_code: row.data_type_code,
          category_code: row.category_code,
          seasonally_adj: row.seasonally_adj,
          geography_level: row.geography_level,
          geography_code: row.geography_code,
          evidence_class: design.fetch(:evidence_class),
          grain: design.fetch(:grain)
        }
      end

      def quality_metadata_for(row, key, status)
        {
          source_table: "bfs_api_rows",
          source_row_id: row.id,
          source_row_hash: row.row_hash,
          metric_key: key,
          source_cell_value_raw: row.cell_value_raw,
          source_error_data: row.error_data,
          metric_status_reason: status,
          claim_status_effect: design.fetch(:claim_status_effect),
          ratios_computed: false,
          trends_computed: false,
          aggregation_computed: false,
          exports_created: false,
          prediction_links_created: false,
          claim_support_authorized: false,
          guardrail: "BFS source-native context only; no AI, Operator Node, nonemployer conversion, productivity, transaction-cost, firm-boundary, or thesis interpretation."
        }
      end

      def record_audit!(source, eligible_rows, counters)
        Audit::Recorder.record!(
          actor: actor,
          event_type: "metric_observation_created",
          entity: source,
          change_summary: "Created #{counters.fetch(:observations_created)} BFS source-native context observations from #{eligible_rows} staged rows",
          reason_code: "bfs_source_native_observation_computation",
          storage_zone: source.storage_zone,
          privacy_classification: source.privacy_classification,
          claim_status_effect: design.fetch(:claim_status_effect),
          source_id: source.id
        )
      end

      def validate_guardrails!(before_counts, after_counts)
        %i[prediction_links exports].each do |key|
          next if before_counts.fetch(key) == after_counts.fetch(key)

          raise ComputationError, "BFS source-native observation computation changed #{key}"
        end
      end

      def guardrail_counts
        {
          prediction_links: PredictionLink.joins(metric_observation: :data_source).where(data_sources: { source_kind: bfs_policy.fetch(:source_kind) }).count,
          exports: AuditEvent.where(event_type: "export_created").count
        }
      end
    end
  end
end
