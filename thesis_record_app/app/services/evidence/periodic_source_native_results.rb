module Evidence
  class PeriodicSourceNativeResults
    METHOD_VERSION = "periodic_source_native_v1"
    SOURCE_KINDS = PeriodicSourceReleases::SCOPES.keys.freeze

    def self.method_manifest(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
      ingestion = policy.fetch(:public_ingestion_v1)
      {
        "version" => METHOD_VERSION,
        "parser_versions" => CollectQuarterly::PARSER_VERSIONS,
        "susb" => {
          "design" => ingestion.fetch(:susb_us_state_annual).fetch(:metric_computation_design_v1),
          "mapping" => PublicSources::Susb::ComputeContextObservations::METRIC_FIELD_MAP
        },
        "bds" => {
          "design" => ingestion.fetch(:bds_sector_age_size_public_file).fetch(:parser_design_v1)
                               .fetch(:metric_computation_design_v1),
          "mapping" => PublicSources::Bds::ComputeSourceNativeObservations::METRIC_FIELD_MAP
        },
        "bfs" => {
          "design" => ingestion.fetch(:bfs_monthly_api).fetch(:metric_computation_design_v1),
          "mapping" => PublicSources::Bfs::ComputeSourceNativeObservations::DATA_TYPE_METRIC_KEYS
        }
      }
    end

    def self.metric_keys(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
      ingestion = policy.fetch(:public_ingestion_v1)
      ingestion.fetch(:susb_us_state_annual).fetch(:metric_computation_design_v1).fetch(:first_pass_metric_keys) +
        ingestion.fetch(:bds_sector_age_size_public_file).fetch(:parser_design_v1)
                 .fetch(:metric_computation_design_v1).fetch(:eligible_metric_keys) +
        ingestion.fetch(:bfs_monthly_api).fetch(:metric_computation_design_v1).fetch(:first_pass_metric_keys)
    end

    def self.definitions_manifest(policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
      metric_keys(policy: policy).index_with do |key|
        MetricDefinition.find_by!(key: key).attributes.except("created_at", "updated_at")
      end
    end

    def self.call(captures, policy: Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys)
      kinds = captures.map { |capture| capture.data_source.source_kind }
      raise ArgumentError, "exactly one completed capture per configured source is required" unless
        kinds.sort == SOURCE_KINDS.sort && captures.all? { |capture| capture.status == "completed" }

      definitions = metric_keys(policy: policy).index_with { |key| MetricDefinition.find_by!(key: key) }
      Enumerator.new do |output|
        captures.each do |capture|
          case capture.data_source.source_kind
          when "census_susb_public_file" then susb_pairs(capture, policy, definitions, output)
          when "census_bds_public_file" then bds_pairs(capture, policy, definitions, output)
          when "census_bfs_api" then bfs_pairs(capture, policy, definitions, output)
          end
        end
      end
    end

    def self.susb_pairs(capture, policy, definitions, output)
      design = policy.fetch(:public_ingestion_v1).fetch(:susb_us_state_annual).fetch(:metric_computation_design_v1)
      mapping = PublicSources::Susb::ComputeContextObservations::METRIC_FIELD_MAP
      SusbPublicFileRow.where(periodic_capture: capture,
                             enterprise_size_code: design.fetch(:eligible_enterprise_size_codes)).find_each do |row|
        mapping.each do |key, metric|
          value = row.public_send(metric.fetch(:row_value))
          next if value.nil?
          flag = metric.fetch(:noise_flag)&.then { |field| row.public_send(field) }
          status = flag ? design.fetch(:noise_flag_rules).fetch(flag.to_sym) : "staged_context"
          next if status == "blocked_noise_or_suppression"

          dimensions = { year: row.year, state_code: row.state_code, naics_code: row.naics_code,
                         enterprise_size_code: row.enterprise_size_code,
                         evidence_class: design.fetch(:evidence_class), grain: design.fetch(:grain) }
          output << pair(capture, row, definitions.fetch(key.to_s), key.to_s, row.year.to_s,
                         value, metric.fetch(:unit), status, dimensions, source_noise_flag: flag)
        end
      end
    end

    def self.bds_pairs(capture, policy, definitions, output)
      design = policy.fetch(:public_ingestion_v1).fetch(:bds_sector_age_size_public_file)
                     .fetch(:parser_design_v1).fetch(:metric_computation_design_v1)
      mapping = PublicSources::Bds::ComputeSourceNativeObservations::METRIC_FIELD_MAP
      BdsPublicFileRow.where(periodic_capture: capture).find_each do |row|
        mapping.each do |key, metric|
          field = metric.fetch(:source_field)
          value = row.numeric_measure_values[field]
          next if value.nil? || row.publication_flags[field].present?

          dimensions = { year: row.year, sector_code: row.sector_code,
                         firm_age_code: row.firm_age_code, firm_size_code: row.firm_size_code,
                         evidence_class: design.fetch(:evidence_class), grain: design.fetch(:grain) }
          output << pair(capture, row, definitions.fetch(key.to_s), key.to_s, row.year.to_s,
                         value, metric.fetch(:unit), "staged_context", dimensions,
                         source_field: field)
        end
      end
    end

    def self.bfs_pairs(capture, policy, definitions, output)
      design = policy.fetch(:public_ingestion_v1).fetch(:bfs_monthly_api).fetch(:metric_computation_design_v1)
      mapping = PublicSources::Bfs::ComputeSourceNativeObservations::DATA_TYPE_METRIC_KEYS
      BfsApiRow.where(periodic_capture: capture, error_data: "no",
                     data_type_code: design.fetch(:eligible_data_type_codes),
                     category_code: design.fetch(:eligible_category_codes),
                     seasonally_adj: design.fetch(:eligible_seasonally_adj),
                     geography_level: design.fetch(:eligible_geography_level)).find_each do |row|
        next if row.cell_value_numeric.nil?

        key = mapping.fetch(row.data_type_code)
        dimensions = { year: row.year, month: row.month, period_month: row.period_month,
                       data_type_code: row.data_type_code, category_code: row.category_code,
                       seasonally_adj: row.seasonally_adj, geography_level: row.geography_level,
                       geography_code: row.geography_code,
                       evidence_class: design.fetch(:evidence_class), grain: design.fetch(:grain) }
        output << pair(capture, row, definitions.fetch(key), key, row.period_month,
                       row.cell_value_numeric, "count", "staged_context", dimensions)
      end
    end

    def self.pair(capture, row, definition, key, period, value, unit, status, dimensions, extra = {})
      metadata = { source_table: row.class.table_name, source_row_id: row.id,
                   source_row_hash: row.row_hash, periodic_capture_id: capture.id,
                   metric_key: key, claim_status_effect: "unchanged",
                   claim_support_authorized: false, aggregation_computed: false,
                   ratios_computed: false, trends_computed: false }.merge(extra)
      observation = { metric_definition_id: definition.id, data_source_id: capture.data_source_id,
                      period: period, metric_status: status, numeric_value: value,
                      unit: unit, dimensions: dimensions, quality_metadata: metadata }
      review = { data_source_id: capture.data_source_id, policy_version: METHOD_VERSION,
                 source_metric_status: status, review_status: "pending",
                 review_reason_code: "automated_source_native_pending_review",
                 reviewed_by: "system:periodic_collection", reviewed_at: Time.current,
                 review_metadata: { "claim_status_effect" => "unchanged",
                                    "accepted_evidence" => false } }
      [ observation, review ]
    end

    private_class_method :susb_pairs, :bds_pairs, :bfs_pairs, :pair
  end
end
