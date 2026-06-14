module PublicSources
  module Susb
    class ComputeContextObservations
      class ComputationError < StandardError; end

      Result = Data.define(
        :data_source,
        :eligible_rows,
        :observations_created,
        :observations_deleted,
        :status_counts,
        :metric_counts,
        :blocked_cells
      )

      BATCH_SIZE = 5_000

      METRIC_FIELD_MAP = {
        susb_employer_firm_count: {
          row_value: :firm_count,
          unit: "count",
          noise_flag: nil
        },
        susb_employer_establishment_count: {
          row_value: :establishment_count,
          unit: "count",
          noise_flag: nil
        },
        susb_employment: {
          row_value: :employment,
          unit: "employees",
          noise_flag: :employment_noise_flag
        },
        susb_annual_payroll_thousand: {
          row_value: :annual_payroll_thousand,
          unit: "thousand_usd_nominal",
          noise_flag: :payroll_noise_flag
        },
        susb_receipts_thousand_economic_census_year: {
          row_value: :receipts_thousand,
          unit: "thousand_usd_nominal",
          noise_flag: :receipts_noise_flag
        }
      }.freeze

      def self.call!(actor:, year: nil)
        new(actor: actor, year: year).call!
      end

      def initialize(actor:, year:)
        @actor = actor
        @policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
        @susb_policy = @policy.fetch(:public_ingestion_v1).fetch(:susb_us_state_annual)
        @design = @susb_policy.fetch(:metric_computation_design_v1)
        @year = year || @susb_policy.fetch(:default_year)
      end

      def call!
        ensure_design_allowed!
        source = find_source!
        metric_definitions = find_metric_definitions!
        scope = eligible_rows_scope(source)
        eligible_rows = scope.count
        raise ComputationError, "No eligible SUSB staging rows found for #{year}" if eligible_rows.zero?

        observations_deleted = delete_existing_observations!(source, metric_definitions)
        counters = compute_observations!(scope, source, metric_definitions)
        record_audit!(source, eligible_rows, counters)

        Result.new(
          data_source: source,
          eligible_rows: eligible_rows,
          observations_created: counters.fetch(:observations_created),
          observations_deleted: observations_deleted,
          status_counts: counters.fetch(:status_counts),
          metric_counts: counters.fetch(:metric_counts),
          blocked_cells: counters.fetch(:blocked_cells)
        )
      end

      private

      attr_reader :actor, :susb_policy, :design, :year

      def ensure_design_allowed!
        result = PublicSources::Susb::MetricComputationDesignCheck.call
        raise ComputationError, result.failures.join("; ") unless result.passed
      end

      def find_source!
        DataSource.find_by!(
          name: "#{susb_policy.fetch(:source_name)} #{year}",
          source_kind: susb_policy.fetch(:source_kind)
        )
      end

      def find_metric_definitions!
        design.fetch(:first_pass_metric_keys).index_with do |key|
          MetricDefinition.find_by!(key: key)
        end
      end

      def eligible_rows_scope(source)
        SusbPublicFileRow.where(
          data_source: source,
          year: year,
          enterprise_size_code: design.fetch(:eligible_enterprise_size_codes)
        )
      end

      def delete_existing_observations!(source, metric_definitions)
        MetricObservation.where(
          data_source: source,
          metric_definition: metric_definitions.values,
          period: year.to_s
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
          metric_definitions.each do |key, definition|
            metric = METRIC_FIELD_MAP.fetch(key.to_sym)
            observation = observation_attributes(row, source, definition, key, metric, now)
            if observation
              batch << observation
              counters.fetch(:observations_created)
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
        value = row.public_send(metric.fetch(:row_value))
        return nil if value.nil?

        flag = metric.fetch(:noise_flag)&.then { |field| row.public_send(field) }
        status = status_for(flag)
        return nil if status == "blocked_noise_or_suppression"

        {
          metric_definition_id: definition.id,
          data_source_id: source.id,
          period: year.to_s,
          metric_status: status,
          numeric_value: value,
          unit: metric.fetch(:unit),
          dimensions: dimensions_for(row),
          quality_metadata: quality_metadata_for(row, key, flag, status),
          created_at: timestamp,
          updated_at: timestamp
        }
      end

      def status_for(flag)
        return "staged_context" if flag.nil?

        design.fetch(:noise_flag_rules).fetch(flag.to_sym)
      end

      def dimensions_for(row)
        {
          year: row.year,
          state_code: row.state_code,
          naics_code: row.naics_code,
          enterprise_size_code: row.enterprise_size_code,
          evidence_class: design.fetch(:evidence_class),
          grain: design.fetch(:grain)
        }
      end

      def quality_metadata_for(row, key, flag, status)
        {
          source_table: "susb_public_file_rows",
          source_row_id: row.id,
          source_row_hash: row.row_hash,
          metric_key: key.to_s,
          source_noise_flag: flag,
          metric_status_reason: status,
          claim_status_effect: design.fetch(:claim_status_effect),
          ratios_computed: false,
          trends_computed: false,
          aggregation_computed: false,
          exports_created: false,
          claim_support_authorized: false,
          guardrail: "SUSB employer-side context only; no AI, node, transaction-cost, management-layer, or thesis interpretation."
        }
      end

      def record_audit!(source, eligible_rows, counters)
        Audit::Recorder.record!(
          actor: actor,
          event_type: "metric_observation_created",
          entity: source,
          change_summary: "Created #{counters.fetch(:observations_created)} SUSB #{year} context observations from #{eligible_rows} ENTRSIZE=01 rows",
          reason_code: "susb_context_observation_computation",
          storage_zone: source.storage_zone,
          privacy_classification: source.privacy_classification,
          claim_status_effect: design.fetch(:claim_status_effect),
          source_id: source.id
        )
      end
    end
  end
end
