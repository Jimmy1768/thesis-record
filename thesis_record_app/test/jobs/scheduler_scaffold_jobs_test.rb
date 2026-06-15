require "test_helper"
require "erb"
require "yaml"

class SchedulerScaffoldJobsTest < ActiveJob::TestCase
  FakeResponse = Data.define(:code, :headers) do
    def [](key)
      headers[key.downcase]
    end
  end

  class FakeHttpClient
    def self.start(_host, _port, use_ssl:)
      raise "expected ssl" unless use_ssl

      yield new
    end

    def request(_request)
      FakeResponse.new(
        "200",
        {
          "content-type" => "text/plain",
          "last-modified" => "Mon, 15 Jun 2026 00:00:00 GMT",
          "content-length" => "123"
        }
      )
    end
  end

  test "source release check job records read-only source freshness audit event" do
    assert_no_difference -> { DataSource.count } do
      assert_no_difference -> { SusbPublicFileRow.count } do
        assert_no_difference -> { BfsApiRow.count } do
          assert_no_difference -> { BdsPublicFileRow.count } do
            assert_no_difference -> { MetricObservation.count } do
              assert_no_difference -> { MetricQualityReview.count } do
                assert_no_difference -> { PredictionLink.count } do
                  assert_no_difference -> { ClaimReview.count } do
                    assert_no_difference -> { ExportArtifact.count } do
                      assert_difference -> { AuditEvent.where(event_type: "source_release_check_completed").count }, 1 do
                        Evidence::SourceReleaseCheckJob.perform_now(http_client: FakeHttpClient)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    event = AuditEvent.where(event_type: "source_release_check_completed").last
    assert_equal "scheduled_source_release_check", event.reason_code
    assert_equal "unchanged", event.claim_status_effect
    assert_not event.export_allowed
    assert_includes event.change_summary, "passed=true"
    assert_includes event.change_summary, "network_enabled=true"
    assert_includes event.change_summary, "effects=no_row_writes"
    assert_includes event.change_summary, "census_bfs_api"
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
