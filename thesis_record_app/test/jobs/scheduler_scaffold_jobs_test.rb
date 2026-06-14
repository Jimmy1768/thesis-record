require "test_helper"
require "erb"
require "yaml"

class SchedulerScaffoldJobsTest < ActiveJob::TestCase
  test "source release check job records no-op audit event" do
    assert_difference -> { AuditEvent.where(event_type: "source_release_check_requested").count }, 1 do
      Evidence::SourceReleaseCheckJob.perform_now
    end
  end

  test "quarterly checkpoint job records no-op audit event" do
    assert_difference -> { AuditEvent.where(event_type: "quarterly_checkpoint_requested").count }, 1 do
      Evidence::QuarterlyIndicatorCheckpointJob.perform_now
    end
  end

  test "annual snapshot candidate job records no-op audit event" do
    assert_difference -> { AuditEvent.where(event_type: "annual_snapshot_candidate_requested").count }, 1 do
      Evidence::AnnualSnapshotCandidateJob.perform_now
    end
  end

  test "production summary check job records read-only audit event" do
    assert_difference -> { AuditEvent.where(event_type: "production_summary_checked").count }, 1 do
      Operations::ProductionSummaryCheckJob.perform_now
    end
  end

  test "v0 readiness check job records read-only audit event" do
    assert_difference -> { AuditEvent.where(event_type: "v0_readiness_checked").count }, 1 do
      Operations::V0ReadinessCheckJob.perform_now
    end
  end

  test "sidekiq schedule declares all policy-driven maintenance scaffolds" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys
    scheduled_jobs = policy.fetch(:scheduler).fetch(:jobs)
    raw_config = Rails.root.join("config/sidekiq.yml").read
    config = YAML.safe_load(ERB.new(raw_config).result, aliases: true, permitted_classes: [ Symbol ])
    schedule = config.fetch(:scheduler).fetch(:schedule)

    scheduled_jobs.each do |job_name, job|
      scheduled_job = schedule.fetch(job_name.to_s)
      assert_equal job.fetch(:cron), scheduled_job.fetch("cron")
      assert_equal job.fetch(:class_name), scheduled_job.fetch("class")
      assert_equal job.fetch(:queue), scheduled_job.fetch("queue")
      assert_equal job.fetch(:description), scheduled_job.fetch("description")
    end
  end

  test "ThesisRecord policy carries v1 threshold defaults" do
    policy = Rails.application.config_for(:thesis_record_policy).deep_symbolize_keys

    assert_equal "v1", policy.fetch(:policy_version)
    assert_equal "calendar_quarter", policy.dig(:forecast_clock, :measurement_atom)
    assert_equal 12, policy.dig(:forecast_clock, :checkpoint_quarters_after_v0, :v1)
    assert_equal 5, policy.dig(:privacy_thresholds_v1, :minimum_public_cell_size)
    assert_equal 1, policy.dig(:operator_node_classification_v1, :max_human_operators)
    assert_not policy.dig(:production_operations_v1, :private_ingestion_enabled_default)
  end
end
