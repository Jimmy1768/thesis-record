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

  desc "Verify claim-review gate remains design-only and disables automatic claim promotion"
  task verify_claim_review_gate: :environment do
    result = Evidence::ClaimReviewGateDesignCheck.call

    if result.passed
      puts "Claim-review gate guardrails passed"
    else
      abort "Claim-review gate guardrails failed:\n- #{result.failures.join("\n- ")}"
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
end
