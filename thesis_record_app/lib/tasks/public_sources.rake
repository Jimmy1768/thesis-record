namespace :public_sources do
  desc "Print read-only combined source health without exports, writes, or claim support"
  task source_health_summary: :environment do
    result = PublicSources::SourceHealthSummary.call

    puts "Source health summary"
    puts "total_source_rows=#{result.total_source_rows}"
    puts "total_metric_definitions=#{result.total_metric_definitions}"
    puts "total_metric_observations=#{result.total_metric_observations}"
    puts "total_quality_reviews=#{result.total_quality_reviews}"
    puts "total_prediction_links=#{result.total_prediction_links}"
    puts "total_export_created_audit_events=#{result.total_export_created_audit_events}"
    puts "all_policy_checks_passed=#{result.all_policy_checks_passed}"
    puts "overall_evidence_status=#{result.overall_evidence_status}"
    result.sources.each do |source|
      puts "#{source.key}.source_status=#{source.source_status}"
      puts "#{source.key}.source_row_count=#{source.source_row_count}"
      puts "#{source.key}.metric_definition_count=#{source.metric_definition_count}"
      puts "#{source.key}.metric_observation_count=#{source.metric_observation_count}"
      puts "#{source.key}.quality_review_count=#{source.quality_review_count}"
      puts "#{source.key}.unreviewed_observation_count=#{source.unreviewed_observation_count}"
      puts "#{source.key}.prediction_link_count=#{source.prediction_link_count}"
      puts "#{source.key}.evidence_status=#{source.evidence_status}"
      puts "#{source.key}.guardrail_flag_counts=#{source.guardrail_flag_counts}"
    end
  end

  namespace :bds do
    desc "Register BDS public-file metadata scaffold without fetching raw data or creating metrics"
    task scaffold: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_bds_public_file_scaffold")
      result = PublicSources::Bds::PublicFileScaffold.call!(actor: actor)

      puts "Registered BDS public-file scaffold"
      puts "data_source_id=#{result.fetch(:data_source).id}"
      puts "source_status=#{result.fetch(:data_source).source_status}"
      puts "schema_status=#{result.fetch(:schema_version).schema_status}"
      puts "raw_file_fetched=#{result.fetch(:intake_manifest).metadata.fetch('raw_file_fetched')}"
      puts "analysis_authorized=#{result.fetch(:intake_manifest).metadata.fetch('analysis_authorized')}"
      puts "prediction_links_authorized=#{result.fetch(:intake_manifest).metadata.fetch('prediction_links_authorized')}"
    end

    desc "Verify BDS public-file scaffold remains metadata-only and claim-neutral"
    task verify_scaffold_policy: :environment do
      result = PublicSources::Bds::ScaffoldPolicyCheck.call(require_no_bds_rows: true)

      if result.passed
        puts "BDS scaffold policy guardrails passed"
      else
        abort "BDS scaffold policy guardrails failed:\n- #{result.failures.join("\n- ")}"
      end
    end

    desc "Verify BDS acquisition design remains checksum-gated and fetch-disabled"
    task verify_acquisition_design: :environment do
      result = PublicSources::Bds::AcquisitionDesignCheck.call

      if result.passed
        puts "BDS acquisition design guardrails passed"
      else
        abort "BDS acquisition design guardrails failed:\n- #{result.failures.join("\n- ")}"
      end
    end

    desc "Fetch if needed and validate BDS public file without parser rows, metrics, exports, or claim support"
    task fetch_and_validate: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_bds_fetch_and_validate")
      force_fetch = ActiveModel::Type::Boolean.new.cast(ENV["BDS_FORCE_FETCH"])
      result = PublicSources::Bds::FetchAndValidatePublicFile.call!(
        actor: actor,
        force_fetch: force_fetch
      )

      puts "Validated BDS public file"
      puts "data_source_id=#{result.data_source.id}"
      puts "local_path=#{result.local_path}"
      puts "fetched_this_run=#{result.fetched_this_run}"
      puts "sha256=#{result.sha256}"
      puts "byte_size=#{result.byte_size}"
      puts "row_count_excluding_header=#{result.row_count_excluding_header}"
      puts "duplicate_key_count=#{result.duplicate_key_count}"
      puts "observed_year_range=#{result.observed_year_range}"
      puts "sector_count=#{result.sector_count}"
      puts "firm_age_count=#{result.firm_age_count}"
      puts "firm_size_count=#{result.firm_size_count}"
      puts "manifest_reconciled=#{result.manifest_reconciled}"
      puts "metric_definitions_created=#{result.metric_definitions_created}"
      puts "metric_observations_created=#{result.metric_observations_created}"
      puts "quality_reviews_created=#{result.quality_reviews_created}"
      puts "prediction_links_created=#{result.prediction_links_created}"
      puts "exports_created=#{result.exports_created}"
    end

    desc "Verify BDS parser design remains source-row-only and claim-neutral"
    task verify_parser_design: :environment do
      result = PublicSources::Bds::ParserDesignCheck.call(
        require_staging_table: true
      )

      if result.passed
        puts "BDS parser design guardrails passed"
      else
        abort "BDS parser design guardrails failed:\n- #{result.failures.join("\n- ")}"
      end
    end

    desc "Verify BDS row-load gate remains source-row-only and claim-neutral"
    task verify_row_load_policy: :environment do
      result = PublicSources::Bds::RowLoadPolicyCheck.call

      if result.passed
        puts "BDS row-load policy guardrails passed"
      else
        abort "BDS row-load policy guardrails failed:\n- #{result.failures.join("\n- ")}"
      end
    end

    desc "Parse a tiny BDS fixture in memory without inserting rows"
    task parse_fixture: :environment do
      policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
      bds_policy = policy.fetch(:public_ingestion_v1).fetch(:bds_sector_age_size_public_file)
      header = bds_policy.fetch(:required_columns)
      row = header.index_with { "1" }
      row["year"] = "1978"
      row["sector"] = "11"
      row["fage"] = "a) 0"
      row["fsize"] = "a) 1 to 4"
      row["estabs_exit"] = "D"
      row["firmdeath_firms"] = "X"
      row["net_job_creation_rate"] = "N"
      delimiter = bds_policy.fetch(:acquisition_design_v1).fetch(:expected_delimiter)
      csv_text = [
        header.join(delimiter),
        header.map { |field| row.fetch(field) }.join(delimiter)
      ].join("\n") + "\n"

      result = PublicSources::Bds::ParserSkeleton.call!(csv_text: csv_text)

      puts "Parsed BDS fixture"
      puts "rows_seen=#{result.rows_seen}"
      puts "rows_persisted=#{result.rows_persisted}"
      puts "bds_public_file_row_count=#{BdsPublicFileRow.count}"
    end

    desc "Dry-run parse the full local BDS public file without inserting rows"
    task dry_run_parser: :environment do
      result = PublicSources::Bds::ParserDryRun.call!

      puts "BDS parser dry run"
      puts "local_path=#{result.local_path}"
      puts "rows_seen=#{result.rows_seen}"
      puts "rows_parsed=#{result.rows_parsed}"
      puts "rows_persisted=#{result.rows_persisted}"
      puts "bad_width_rows=#{result.bad_width_rows}"
      puts "blank_lines=#{result.blank_lines}"
      puts "duplicate_key_count=#{result.duplicate_key_count}"
      puts "observed_year_range=#{result.observed_year_range}"
      puts "sector_count=#{result.sector_count}"
      puts "firm_age_count=#{result.firm_age_count}"
      puts "firm_size_count=#{result.firm_size_count}"
      puts "numeric_cell_count=#{result.numeric_cell_count}"
      puts "publication_flag_totals=#{result.publication_flag_totals}"
      puts "bds_public_file_row_count=#{result.bds_public_file_row_count}"
      puts "metric_observations_created=#{result.metric_observations_created}"
      puts "quality_reviews_created=#{result.quality_reviews_created}"
      puts "prediction_links_created=#{result.prediction_links_created}"
      puts "exports_created=#{result.exports_created}"
    end

    desc "Load validated BDS source-native rows into staging without metrics or analysis"
    task load_staging: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_bds_source_row_load")
      result = PublicSources::Bds::LoadStagingRows.call!(actor: actor)

      puts "Loaded BDS staging rows"
      puts "data_source_id=#{result.data_source.id}"
      puts "local_path=#{result.local_path}"
      puts "load_id=#{result.load_id}"
      puts "rows_read=#{result.rows_read}"
      puts "rows_inserted=#{result.rows_inserted}"
      puts "rows_deleted_before_load=#{result.rows_deleted_before_load}"
      puts "metric_definitions_created=#{result.metric_definitions_created}"
      puts "metric_observations_created=#{result.metric_observations_created}"
      puts "quality_reviews_created=#{result.quality_reviews_created}"
      puts "prediction_links_created=#{result.prediction_links_created}"
      puts "exports_created=#{result.exports_created}"
    end

    desc "Create draft-disabled BDS metric definitions without observations or analysis"
    task scaffold_metric_definitions: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_bds_metric_definition_scaffold")
      result = PublicSources::Bds::MetricDefinitionScaffold.call!(actor: actor)

      puts "Scaffolded BDS metric definitions"
      result.definitions.each do |definition|
        puts "#{definition.key}=#{definition.formula_status}"
      end
      puts "metric_definitions_created=#{result.metric_definitions_created}"
      puts "metric_observations_created=#{result.metric_observations_created}"
      puts "quality_reviews_created=#{result.quality_reviews_created}"
      puts "prediction_links_created=#{result.prediction_links_created}"
      puts "exports_created=#{result.exports_created}"
    end

    desc "Verify BDS metric-computation design remains source-native and claim-neutral"
    task verify_metric_design: :environment do
      result = PublicSources::Bds::MetricComputationDesignCheck.call

      if result.passed
        puts "BDS metric computation design guardrails passed"
      else
        abort "BDS metric computation design guardrails failed:\n- #{result.failures.join("\n- ")}"
      end
    end

    desc "Compute BDS source-native context observations without reviews, links, exports, or analysis"
    task compute_source_native_observations: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_bds_source_native_observation_computation")
      result = PublicSources::Bds::ComputeSourceNativeObservations.call!(actor: actor)

      puts "Computed BDS source-native observations"
      puts "data_source_id=#{result.data_source.id}"
      puts "eligible_rows=#{result.eligible_rows}"
      puts "observations_deleted=#{result.observations_deleted}"
      puts "observations_created=#{result.observations_created}"
      puts "status_counts=#{result.status_counts.to_h.sort.to_h}"
      puts "metric_counts=#{result.metric_counts.to_h.sort.to_h}"
      puts "blocked_cells=#{result.blocked_cells.to_h.sort.to_h}"
      puts "quality_reviews_created=#{result.quality_reviews_created}"
      puts "prediction_links_created=#{result.prediction_links_created}"
      puts "exports_created=#{result.exports_created}"
    end

    desc "Verify BDS quality-review policy before review-state storage or exports"
    task verify_quality_review_policy: :environment do
      result = PublicSources::Bds::QualityReviewPolicyCheck.call

      if result.passed
        puts "BDS quality-review policy guardrails passed"
      else
        abort "BDS quality-review policy guardrails failed:\n- #{result.failures.join("\n- ")}"
      end
    end

    desc "Create BDS quality reviews as reviewed context only"
    task create_quality_reviews: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_bds_quality_review")
      result = PublicSources::Bds::CreateQualityReviews.call!(actor: actor)

      puts "Created BDS metric quality reviews"
      puts "observations_reviewed=#{result.observations_reviewed}"
      puts "reviews_upserted=#{result.reviews_upserted}"
      puts "status_counts=#{result.status_counts.to_h.sort.to_h}"
      puts "prediction_links_created=#{result.prediction_links_created}"
      puts "exports_created=#{result.exports_created}"
    end

    desc "Print read-only BDS quality-review summary without exports, writes, or claim support"
    task quality_review_summary: :environment do
      result = PublicSources::Bds::QualityReviewSummary.call

      puts "BDS quality review summary"
      puts "review_count=#{result.review_count}"
      puts "reviewable_observation_count=#{result.reviewable_observation_count}"
      puts "unreviewed_observation_count=#{result.unreviewed_observation_count}"
      puts "review_status_counts=#{result.review_status_counts}"
      puts "source_metric_status_counts=#{result.source_metric_status_counts}"
      puts "metric_key_counts=#{result.metric_key_counts}"
      puts "policy_version_counts=#{result.policy_version_counts}"
      puts "guardrail_flag_counts=#{result.guardrail_flag_counts}"
      puts "prediction_link_count=#{result.prediction_link_count}"
      puts "export_created_audit_event_count=#{result.export_created_audit_event_count}"
      puts "policy_check_passed=#{result.policy_check_passed}"
      puts "policy_check_failures=#{result.policy_check_failures}"
    end
  end

  namespace :susb do
    desc "Register SUSB public-file source, access path, manifest, and schema scaffold without fetching raw data"
    task scaffold: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_public_source_scaffold")
      year = ENV["SUSB_YEAR"]&.to_i
      result = PublicSources::Susb::PublicFileScaffold.call!(actor: actor, year: year)

      puts "Registered SUSB scaffold data_source_id=#{result.fetch(:data_source).id}"
    end

    desc "Fetch if needed and validate SUSB public file without metrics or claim-status changes"
    task fetch_and_validate: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_susb_fetch_and_validate")
      year = ENV["SUSB_YEAR"]&.to_i
      force_fetch = ActiveModel::Type::Boolean.new.cast(ENV["SUSB_FORCE_FETCH"])
      result = PublicSources::Susb::FetchAndValidatePublicFile.call!(
        actor: actor,
        year: year,
        force_fetch: force_fetch
      )

      puts "Validated SUSB public file"
      puts "data_source_id=#{result.data_source.id}"
      puts "local_path=#{result.local_path}"
      puts "fetched_this_run=#{result.fetched_this_run}"
      puts "sha256=#{result.sha256}"
      puts "byte_size=#{result.byte_size}"
      puts "row_count_excluding_header=#{result.row_count_excluding_header}"
      puts "duplicate_key_count=#{result.duplicate_key_count}"
      puts "manifest_reconciled=#{result.manifest_reconciled}"
    end

    desc "Create draft-disabled SUSB metric definitions without observations or analysis"
    task scaffold_metric_definitions: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_susb_metric_definition_scaffold")
      definitions = PublicSources::Susb::MetricDefinitionScaffold.call!(actor: actor)

      puts "Scaffolded SUSB metric definitions"
      definitions.each do |definition|
        puts "#{definition.key}=#{definition.formula_status}"
      end
    end

    desc "Load validated SUSB source-native rows into staging without metrics or analysis"
    task load_staging: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_susb_staging_load")
      year = ENV["SUSB_YEAR"]&.to_i
      result = PublicSources::Susb::LoadStagingRows.call!(actor: actor, year: year)

      puts "Loaded SUSB staging rows"
      puts "data_source_id=#{result.data_source.id}"
      puts "local_path=#{result.local_path}"
      puts "rows_read=#{result.rows_read}"
      puts "rows_upserted=#{result.rows_upserted}"
      puts "metric_observations_created=#{result.metric_observations_created}"
      puts "quality_flags_created=#{result.quality_flags_created}"
    end

    desc "Verify SUSB metric-computation design remains conservative and disabled"
    task verify_metric_design: :environment do
      result = PublicSources::Susb::MetricComputationDesignCheck.call

      if result.passed
        puts "SUSB metric computation design guardrails passed"
      else
        abort "SUSB metric computation design guardrails failed:\n- #{result.failures.join("\n- ")}"
      end
    end

    desc "Compute first-pass SUSB context observations under V1 guardrails"
    task compute_context_observations: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_susb_context_observation_computation")
      year = ENV["SUSB_YEAR"]&.to_i
      result = PublicSources::Susb::ComputeContextObservations.call!(actor: actor, year: year)

      puts "Computed SUSB context observations"
      puts "data_source_id=#{result.data_source.id}"
      puts "eligible_rows=#{result.eligible_rows}"
      puts "observations_deleted=#{result.observations_deleted}"
      puts "observations_created=#{result.observations_created}"
      puts "status_counts=#{result.status_counts.to_h.sort.to_h}"
      puts "metric_counts=#{result.metric_counts.to_h.sort.to_h}"
      puts "blocked_cells=#{result.blocked_cells.to_h.sort.to_h}"
    end

    desc "Verify SUSB quality-review policy before any review-state storage or exports"
    task verify_quality_policy: :environment do
      result = PublicSources::Susb::QualityReviewPolicyCheck.call

      if result.passed
        puts "SUSB quality review policy guardrails passed"
      else
        abort "SUSB quality review policy guardrails failed:\n- #{result.failures.join("\n- ")}"
      end
    end

    desc "Create idempotent SUSB metric quality reviews without exports or claim support"
    task create_quality_reviews: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_susb_quality_review_creation")
      result = PublicSources::Susb::CreateQualityReviews.call!(actor: actor)

      puts "Created SUSB quality reviews"
      puts "observations_reviewed=#{result.observations_reviewed}"
      puts "reviews_upserted=#{result.reviews_upserted}"
      puts "status_counts=#{result.status_counts.to_h.sort.to_h}"
    end

    desc "Print read-only SUSB quality-review summary without exports, writes, or claim support"
    task quality_review_summary: :environment do
      result = PublicSources::Susb::QualityReviewSummary.call

      puts "SUSB quality review summary"
      puts "review_count=#{result.review_count}"
      puts "review_status_counts=#{result.review_status_counts}"
      puts "source_metric_status_counts=#{result.source_metric_status_counts}"
      puts "metric_key_counts=#{result.metric_key_counts}"
      puts "policy_version_counts=#{result.policy_version_counts}"
      puts "reviewable_observation_count=#{result.reviewable_observation_count}"
      puts "unreviewed_observation_count=#{result.unreviewed_observation_count}"
      puts "guardrail_flag_counts=#{result.guardrail_flag_counts}"
      puts "prediction_link_count=#{result.prediction_link_count}"
      puts "export_created_audit_event_count=#{result.export_created_audit_event_count}"
      puts "policy_check_passed=#{result.policy_check_passed}"
      puts "policy_check_failures=#{result.policy_check_failures}"
    end
  end

  namespace :bfs do
    desc "Register BFS API metadata scaffold without querying data or creating metrics"
    task scaffold: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_bfs_api_scaffold")
      result = PublicSources::Bfs::ApiScaffold.call!(actor: actor)

      puts "Registered BFS API scaffold"
      puts "data_source_id=#{result.fetch(:data_source).id}"
      puts "source_status=#{result.fetch(:data_source).source_status}"
      puts "schema_status=#{result.fetch(:schema_version).schema_status}"
      puts "api_data_queried=#{result.fetch(:intake_manifest).metadata.fetch('api_data_queried')}"
      puts "analysis_authorized=#{result.fetch(:intake_manifest).metadata.fetch('analysis_authorized')}"
    end

    desc "Verify BFS ingestion design remains staging-schema-only with no API pull"
    task verify_ingestion_design: :environment do
      result = PublicSources::Bfs::IngestionDesignCheck.call

      if result.passed
        puts "BFS ingestion design guardrails passed"
      else
        abort "BFS ingestion design guardrails failed:\n- #{result.failures.join("\n- ")}"
      end
    end

    desc "Dry-run BFS API query shape without storing rows or creating metrics"
    task dry_run_query: :environment do
      result = PublicSources::Bfs::DryRunQueryValidator.call!

      puts "BFS dry-run query validation passed"
      puts "redacted_query_url=#{result.redacted_query_url}"
      puts "total_rows=#{result.total_rows}"
      puts "eligible_rows=#{result.eligible_rows}"
      puts "eligible_data_type_codes=#{result.eligible_data_type_codes}"
      puts "eligible_category_codes=#{result.eligible_category_codes}"
      puts "eligible_seasonally_adj_values=#{result.eligible_seasonally_adj_values}"
      puts "eligible_time_slot_ids=#{result.eligible_time_slot_ids}"
      puts "eligible_error_data_values=#{result.eligible_error_data_values}"
      puts "database_counts_unchanged=#{result.database_counts_unchanged}"
    end

    desc "Load guarded BFS sample rows without metrics, observations, exports, or claim support"
    task load_sample_rows: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_bfs_sample_row_load")
      result = PublicSources::Bfs::LoadSampleRows.call!(actor: actor)

      puts "Loaded BFS sample rows"
      puts "data_source_id=#{result.data_source.id}"
      puts "total_rows=#{result.total_rows}"
      puts "eligible_rows=#{result.eligible_rows}"
      puts "rows_upserted=#{result.rows_upserted}"
      puts "metric_definitions_created=#{result.metric_definitions_created}"
      puts "metric_observations_created=#{result.metric_observations_created}"
      puts "prediction_links_created=#{result.prediction_links_created}"
      puts "exports_created=#{result.exports_created}"
    end

    desc "Verify BFS metric computation design remains disabled and context-only"
    task verify_metric_computation_design: :environment do
      result = PublicSources::Bfs::MetricComputationDesignCheck.call

      if result.passed
        puts "BFS metric computation design guardrails passed"
      else
        abort "BFS metric computation design guardrails failed:\n- #{result.failures.join("\n- ")}"
      end
    end

    desc "Scaffold draft-disabled BFS metric definitions without observations or claim support"
    task scaffold_metric_definitions: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_bfs_metric_definition_scaffold")
      result = PublicSources::Bfs::MetricDefinitionScaffold.call!(actor: actor)

      puts "Scaffolded BFS metric definitions"
      puts "definition_keys=#{result.definitions.map(&:key)}"
      puts "metric_definitions_created=#{result.metric_definitions_created}"
      puts "metric_observations_created=#{result.metric_observations_created}"
      puts "prediction_links_created=#{result.prediction_links_created}"
      puts "exports_created=#{result.exports_created}"
    end

    desc "Compute BFS source-native context observations without links, exports, or claim support"
    task compute_source_native_observations: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_bfs_source_native_observation_computation")
      result = PublicSources::Bfs::ComputeSourceNativeObservations.call!(actor: actor)

      puts "Computed BFS source-native observations"
      puts "data_source_id=#{result.data_source.id}"
      puts "eligible_rows=#{result.eligible_rows}"
      puts "observations_deleted=#{result.observations_deleted}"
      puts "observations_created=#{result.observations_created}"
      puts "status_counts=#{result.status_counts}"
      puts "metric_counts=#{result.metric_counts}"
      puts "blocked_cells=#{result.blocked_cells}"
      puts "prediction_links_created=#{result.prediction_links_created}"
      puts "exports_created=#{result.exports_created}"
    end

    desc "Verify BFS quality review policy remains context-only and claim-neutral"
    task verify_quality_review_policy: :environment do
      result = PublicSources::Bfs::QualityReviewPolicyCheck.call

      if result.passed
        puts "BFS quality review policy guardrails passed"
      else
        abort "BFS quality review policy guardrails failed:\n- #{result.failures.join("\n- ")}"
      end
    end

    desc "Create BFS metric quality reviews without links, exports, or claim support"
    task create_quality_reviews: :environment do
      actor = ENV.fetch("THESIS_RECORD_ACTOR", "operator_bfs_quality_review_creation")
      result = PublicSources::Bfs::CreateQualityReviews.call!(actor: actor)

      puts "Created BFS metric quality reviews"
      puts "observations_reviewed=#{result.observations_reviewed}"
      puts "reviews_upserted=#{result.reviews_upserted}"
      puts "status_counts=#{result.status_counts}"
      puts "prediction_links_created=#{result.prediction_links_created}"
      puts "exports_created=#{result.exports_created}"
    end

    desc "Print read-only BFS quality-review summary without exports, writes, or claim support"
    task quality_review_summary: :environment do
      result = PublicSources::Bfs::QualityReviewSummary.call

      puts "BFS quality review summary"
      puts "review_count=#{result.review_count}"
      puts "review_status_counts=#{result.review_status_counts}"
      puts "source_metric_status_counts=#{result.source_metric_status_counts}"
      puts "metric_key_counts=#{result.metric_key_counts}"
      puts "policy_version_counts=#{result.policy_version_counts}"
      puts "reviewable_observation_count=#{result.reviewable_observation_count}"
      puts "unreviewed_observation_count=#{result.unreviewed_observation_count}"
      puts "guardrail_flag_counts=#{result.guardrail_flag_counts}"
      puts "prediction_link_count=#{result.prediction_link_count}"
      puts "export_created_audit_event_count=#{result.export_created_audit_event_count}"
      puts "policy_check_passed=#{result.policy_check_passed}"
      puts "policy_check_failures=#{result.policy_check_failures}"
    end
  end
end
