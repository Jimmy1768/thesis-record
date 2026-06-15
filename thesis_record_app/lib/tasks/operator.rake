namespace :operator do
  desc "Bootstrap the first ThesisRecord operator admin from environment variables"
  task bootstrap_admin: :environment do
    user = Operators::BootstrapAdmin.call!
    puts "Bootstrapped operator admin: #{user.email}"
  rescue Operators::BootstrapAdmin::Error => error
    abort "Operator admin bootstrap failed: #{error.message}"
  end

  desc "Verify production operations policy keeps ingestion and secret/private-row risks disabled"
  task verify_operations_policy: :environment do
    result = Operations::PolicyCheck.call

    if result.passed
      Audit::Recorder.record_system!(
        actor: "operator_policy_check",
        event_type: "operations_policy_checked",
        entity_type: "OperationsPolicy",
        entity_id: "thesis_record_policy_v1",
        change_summary: "Production operations policy guardrails passed",
        reason_code: "operations_policy_check"
      )
      puts "Operations policy guardrails passed"
    else
      abort "Operations policy guardrails failed:\n- #{result.failures.join("\n- ")}"
    end
  end

  desc "Verify production deployment env matches ThesisRecord droplet assumptions"
  task verify_deployment_config: :environment do
    result = Operations::DeploymentCheck.call

    if result.passed
      puts "Deployment config guardrails passed"
    else
      abort "Deployment config guardrails failed:\n- #{result.failures.join("\n- ")}"
    end
  end

  desc "Verify claim-review gate remains design-only and disables automatic claim promotion"
  task verify_claim_review_gate: :environment do
    result = Evidence::ClaimReviewGateDesignCheck.call

    if result.passed
      puts "Claim-review gate guardrails passed"
    else
      abort "Claim-review gate guardrails failed:\n- #{result.failures.join("\n- ")}"
    end
  end

  desc "Verify Operator Nodes v0 source-truth review scaffold without accepting it"
  task verify_v0_source_truth_review: :environment do
    result = Operations::V0SourceTruthReview.call

    if result.passed
      puts "Operator Nodes v0 source-truth review scaffold passed"
      result.checks.each do |name, passed|
        puts "check.#{name}=#{passed}"
      end
      puts "warnings=#{result.warnings.empty? ? "(none)" : result.warnings.join(",")}"
    else
      abort "Operator Nodes v0 source-truth review scaffold failed:\n- #{result.failures.join("\n- ")}"
    end
  end

  desc "Verify Operator Nodes v0 prohibited-foundations review scaffold without accepting it"
  task verify_v0_prohibited_foundations_review: :environment do
    result = Operations::V0ProhibitedFoundationsReview.call

    if result.passed
      puts "Operator Nodes v0 prohibited-foundations review scaffold passed"
      result.checks.each do |name, passed|
        puts "check.#{name}=#{passed}"
      end
      puts "warnings=#{result.warnings.empty? ? "(none)" : result.warnings.join(",")}"
    else
      abort "Operator Nodes v0 prohibited-foundations review scaffold failed:\n- #{result.failures.join("\n- ")}"
    end
  end

  desc "Verify Operator Nodes v0 frozen claim-set review scaffold without accepting it"
  task verify_v0_frozen_claim_set_review: :environment do
    result = Operations::V0FrozenClaimSetReview.call

    if result.passed
      puts "Operator Nodes v0 frozen claim-set review scaffold passed"
      result.checks.each do |name, passed|
        puts "check.#{name}=#{passed}"
      end
      puts "warnings=#{result.warnings.empty? ? "(none)" : result.warnings.join(",")}"
    else
      abort "Operator Nodes v0 frozen claim-set review scaffold failed:\n- #{result.failures.join("\n- ")}"
    end
  end

  desc "Verify Operator Nodes v0 frozen forecast-set review scaffold without accepting it"
  task verify_v0_frozen_forecast_set_review: :environment do
    result = Operations::V0FrozenForecastSetReview.call

    if result.passed
      puts "Operator Nodes v0 frozen forecast-set review scaffold passed"
      result.checks.each do |name, passed|
        puts "check.#{name}=#{passed}"
      end
      puts "warnings=#{result.warnings.empty? ? "(none)" : result.warnings.join(",")}"
    else
      abort "Operator Nodes v0 frozen forecast-set review scaffold failed:\n- #{result.failures.join("\n- ")}"
    end
  end

  desc "Verify Operator Nodes v0 prose review scaffold without accepting it"
  task verify_v0_prose_review: :environment do
    result = Operations::V0ProseReview.call

    if result.passed
      puts "Operator Nodes v0 prose review scaffold passed"
      result.checks.each do |name, passed|
        puts "check.#{name}=#{passed}"
      end
      puts "warnings=#{result.warnings.empty? ? "(none)" : result.warnings.join(",")}"
    else
      abort "Operator Nodes v0 prose review scaffold failed:\n- #{result.failures.join("\n- ")}"
    end
  end

  desc "Verify Operator Nodes v0 public-release review scaffold without accepting it"
  task verify_v0_public_release_review: :environment do
    result = Operations::V0PublicReleaseReview.call

    if result.passed
      puts "Operator Nodes v0 public-release review scaffold passed"
      result.checks.each do |name, passed|
        puts "check.#{name}=#{passed}"
      end
      puts "warnings=#{result.warnings.empty? ? "(none)" : result.warnings.join(",")}"
    else
      abort "Operator Nodes v0 public-release review scaffold failed:\n- #{result.failures.join("\n- ")}"
    end
  end

  desc "Print claim-review dry-run candidates without creating links, reviews, exports, or status changes"
  task claim_review_candidate_dry_run: :environment do
    result = Evidence::ClaimReviewCandidateDryRun.call

    puts "Claim-review candidate dry run"
    puts "policy_check_passed=#{result.policy_check_passed}"
    puts "policy_check_failures=#{result.policy_check_failures}"
    puts "total_reviewed_observations=#{result.total_reviewed_observations}"
    puts "total_unreviewed_observations=#{result.total_unreviewed_observations}"
    puts "prediction_link_count=#{result.prediction_link_count}"
    puts "claim_review_count=#{result.claim_review_count}"
    puts "export_created_audit_event_count=#{result.export_created_audit_event_count}"
    result.candidate_groups.each do |group|
      puts "#{group.id}.source_kind=#{group.source_kind}"
      puts "#{group.id}.reviewed_observation_count=#{group.reviewed_observation_count}"
      puts "#{group.id}.unreviewed_observation_count=#{group.unreviewed_observation_count}"
      puts "#{group.id}.related_prediction_ids=#{group.related_prediction_ids}"
      puts "#{group.id}.related_claim_ids=#{group.related_claim_ids}"
      puts "#{group.id}.candidate_status=#{group.candidate_status}"
      puts "#{group.id}.evidence_classification=#{group.evidence_classification}"
      puts "#{group.id}.proposed_claim_status=#{group.proposed_claim_status}"
    end
  end

  desc "Verify app boot, database, Redis, Sidekiq schedule, and operations policy"
  task health_check: :environment do
    result = Operations::HealthCheck.call

    if result.passed
      puts "Health checks passed"
    else
      abort "Health checks failed:\n- #{result.failures.join("\n- ")}"
    end
  end

  desc "Print a read-only ThesisRecord production health and evidence summary"
  task production_summary: :environment do
    summary = Operations::ProductionSummary.call

    puts "ThesisRecord production summary"
    puts "generated_at=#{summary.generated_at.iso8601}"
    puts "rails_env=#{summary.rails_env}"
    puts "relative_url_root=#{summary.relative_url_root || "(unset)"}"
    puts "canonical_data_promotion_disabled=#{summary.canonical_data_promotion_disabled}"
    puts "health_passed=#{summary.health_passed}"
    summary.health_checks.each do |name, passed|
      puts "health.#{name}=#{passed}"
    end
    summary.table_counts.each do |table_name, count|
      puts "count.#{table_name}=#{count}"
    end
    puts "latest_audit_event_at=#{summary.latest_audit_event_at&.iso8601 || "(none)"}"
    puts "warnings=#{summary.warnings.empty? ? "(none)" : summary.warnings.join(",")}"
  end

  desc "Print latest Operator Nodes scheduler/readiness audit status without writes"
  task status: :environment do
    summary = Operations::OperatorStatusSummary.call

    puts "Operator Nodes operating status"
    puts "generated_at=#{summary.generated_at.iso8601}"
    summary.latest_events.each do |name, event|
      if event
        puts "event.#{name}.id=#{event.event_id}"
        puts "event.#{name}.type=#{event.event_type}"
        puts "event.#{name}.occurred_at=#{event.occurred_at.iso8601}"
        puts "event.#{name}.reason_code=#{event.reason_code}"
        puts "event.#{name}.entity_id=#{event.entity_id}"
        puts "event.#{name}.summary=#{event.change_summary}"
      else
        puts "event.#{name}.id=(none)"
      end
    end
    summary.table_counts.each do |table_name, count|
      puts "count.#{table_name}=#{count}"
    end
    puts "warnings=#{summary.warnings.empty? ? "(none)" : summary.warnings.join(",")}"
  end

  desc "Print a read-only Operator Nodes v0 baseline summary"
  task v0_baseline_summary: :environment do
    summary = Operations::V0BaselineSummary.call

    puts "Operator Nodes v0 baseline summary"
    puts "generated_at=#{summary.generated_at.iso8601}"
    puts "thesis_slug=#{summary.thesis_slug}"
    puts "baseline_manifest_present=#{summary.baseline_manifest_present}"
    puts "baseline_status=#{summary.baseline_status || "(unknown)"}"
    puts "claim_set_present=#{summary.claim_set_present}"
    puts "claim_set_status=#{summary.claim_set_status || "(unknown)"}"
    puts "claim_set_approval_status=#{summary.claim_set_approval_status || "(unknown)"}"
    puts "claim_count=#{summary.claim_count}"
    puts "forecast_set_present=#{summary.forecast_set_present}"
    puts "forecast_set_status=#{summary.forecast_set_status || "(unknown)"}"
    puts "forecast_set_approval_status=#{summary.forecast_set_approval_status || "(unknown)"}"
    puts "forecast_count=#{summary.forecast_count}"
    puts "collection_plan_present=#{summary.collection_plan_present}"
    puts "timeline_present=#{summary.timeline_present}"
    summary.source_coverage.each do |source_kind, present|
      puts "source_coverage.#{source_kind}=#{present}"
    end
    summary.table_counts.each do |table_name, count|
      puts "count.#{table_name}=#{count}"
    end
    puts "production_health_passed=#{summary.production_health_passed}"
    puts "v0_readiness_passed=#{summary.v0_readiness_passed}"
    puts "v0_readiness_blockers=#{summary.v0_readiness_blockers.empty? ? "(none)" : summary.v0_readiness_blockers.join(",")}"
    puts "warnings=#{summary.warnings.empty? ? "(none)" : summary.warnings.join(",")}"
  end

  desc "Print a consolidated Operator Nodes v0 approval-gate summary"
  task v0_gate_summary: :environment do
    summary = Operations::V0GateSummary.call

    puts "Operator Nodes v0 gate summary"
    puts "generated_at=#{summary.generated_at.iso8601}"
    puts "thesis_slug=#{summary.thesis_slug}"
    puts "approval_status=#{summary.approval_status || "(unknown)"}"
    puts "public_release_status=#{summary.public_release_status || "(unknown)"}"
    puts "baseline_status=#{summary.baseline_status || "(unknown)"}"
    puts "scaffolds_passed=#{summary.scaffolds_passed}"
    puts "v0_readiness_passed=#{summary.v0_readiness_passed}"
    puts "v0_readiness_blockers=#{summary.v0_readiness_blockers.empty? ? "(none)" : summary.v0_readiness_blockers.join(",")}"
    summary.gates.each do |gate|
      puts "gate.#{gate.name}.approval_status=#{gate.approval_status || "(unknown)"}"
      puts "gate.#{gate.name}.validator_passed=#{gate.validator_passed}"
      puts "gate.#{gate.name}.required_artifacts=#{gate.required_artifacts.empty? ? "(none)" : gate.required_artifacts.join(",")}"
      puts "gate.#{gate.name}.failures=#{gate.failures.empty? ? "(none)" : gate.failures.join(",")}"
      puts "gate.#{gate.name}.warnings=#{gate.warnings.empty? ? "(none)" : gate.warnings.join(",")}"
    end
    puts "warnings=#{summary.warnings.empty? ? "(none)" : summary.warnings.join(",")}"
  end

  desc "Report whether Operator Nodes v0 collection remains safely blocked before source approval"
  task v0_collection_readiness: :environment do
    result = Operations::V0CollectionReadiness.call

    puts "Operator Nodes v0 collection readiness"
    puts "passed=#{result.passed}"
    result.checks.each do |name, passed|
      puts "check.#{name}=#{passed}"
    end
    puts "blockers=#{result.blockers.empty? ? "(none)" : result.blockers.join(",")}"
    puts "warnings=#{result.warnings.empty? ? "(none)" : result.warnings.join(",")}"
  end

  desc "Dry-run Operator Nodes v0 source freshness across SUSB, BFS, and BDS without row writes"
  task v0_source_freshness_dry_run: :environment do
    network_enabled = ActiveModel::Type::Boolean.new.cast(ENV["THESIS_RECORD_V0_SOURCE_FRESHNESS_NETWORK"])
    result = Operations::V0SourceFreshnessDryRun.call(network_enabled: network_enabled)

    puts "Operator Nodes v0 source freshness dry run"
    puts "passed=#{result.passed}"
    puts "network_enabled=#{result.network_enabled}"
    result.sources.each do |source|
      puts "#{source.source_kind}.policy_key=#{source.policy_key}"
      source.checks.each do |name, passed|
        puts "#{source.source_kind}.check.#{name}=#{passed}"
      end
      source.endpoints.each do |endpoint|
        puts "#{source.source_kind}.endpoint.#{endpoint.name}.configured=#{endpoint.configured}"
        puts "#{source.source_kind}.endpoint.#{endpoint.name}.network_checked=#{endpoint.network_checked}"
        puts "#{source.source_kind}.endpoint.#{endpoint.name}.status=#{endpoint.status || "(not_checked)"}"
        puts "#{source.source_kind}.endpoint.#{endpoint.name}.last_modified=#{endpoint.last_modified || "(unknown)"}"
        puts "#{source.source_kind}.endpoint.#{endpoint.name}.content_length=#{endpoint.content_length || "(unknown)"}"
        puts "#{source.source_kind}.endpoint.#{endpoint.name}.error=#{endpoint.error || "(none)"}"
      end
    end
    puts "blockers=#{result.blockers.empty? ? "(none)" : result.blockers.join(",")}"
    puts "warnings=#{result.warnings.empty? ? "(none)" : result.warnings.join(",")}"
  end

  desc "Preflight Operator Nodes v0 canonical row collection without ingesting rows"
  task v0_canonical_collection_preflight: :environment do
    result = Operations::V0CanonicalCollectionPreflight.call

    puts "Operator Nodes v0 canonical collection preflight"
    puts "passed=#{result.passed}"
    puts "manifest_path=#{result.manifest_path}"
    puts "source_kind=#{result.source_kind.presence || "(unknown)"}"
    result.checks.each do |name, passed|
      puts "check.#{name}=#{passed}"
    end
    puts "blockers=#{result.blockers.empty? ? "(none)" : result.blockers.join(",")}"
    puts "warnings=#{result.warnings.empty? ? "(none)" : result.warnings.join(",")}"

    abort "Operator Nodes v0 canonical collection preflight failed" unless result.passed
  end

  desc "Report blockers for publishing Operator Nodes v0"
  task v0_readiness: :environment do
    result = Operations::V0Readiness.call

    puts "Operator Nodes v0 readiness"
    puts "passed=#{result.passed}"
    result.checks.each do |name, passed|
      puts "check.#{name}=#{passed}"
    end
    puts "blockers=#{result.blockers.empty? ? "(none)" : result.blockers.join(",")}"
    puts "warnings=#{result.warnings.empty? ? "(none)" : result.warnings.join(",")}"
  end
end
