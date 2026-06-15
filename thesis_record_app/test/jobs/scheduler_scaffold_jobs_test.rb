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

  test "quarterly checkpoint job records audit-only checkpoint candidate" do
    as_of = Time.utc(2026, 7, 1, 6, 0, 0)

    assert_no_difference -> { DataSource.count } do
      assert_no_difference -> { SusbPublicFileRow.count } do
        assert_no_difference -> { BfsApiRow.count } do
          assert_no_difference -> { BdsPublicFileRow.count } do
            assert_no_difference -> { MetricDefinition.count } do
              assert_no_difference -> { MetricObservation.count } do
                assert_no_difference -> { MetricQualityReview.count } do
                  assert_no_difference -> { PredictionLink.count } do
                    assert_no_difference -> { ClaimReview.count } do
                      assert_no_difference -> { ExportArtifact.count } do
                        assert_no_difference -> { EvidenceSnapshot.count } do
                          assert_no_difference -> { FailureRecord.count } do
                            assert_difference -> { AuditEvent.where(event_type: "quarterly_checkpoint_requested").count }, 1 do
                              Evidence::QuarterlyIndicatorCheckpointJob.perform_now(as_of: as_of)
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
        end
      end
    end

    event = AuditEvent.where(event_type: "quarterly_checkpoint_requested").last
    assert_equal "scheduled_quarterly_checkpoint_candidate", event.reason_code
    assert_equal "unchanged", event.claim_status_effect
    assert_not event.export_allowed
    assert_equal "SchedulerCheckpoint", event.entity_type
    assert_equal "quarterly_indicator_checkpoint:2026-Q3", event.entity_id
    assert_includes event.change_summary, "period=2026-Q3"
    assert_includes event.change_summary, "first_measurement_period=2026-Q3"
    assert_includes event.change_summary, "measurement_index=1"
    assert_includes event.change_summary, "status=quarterly_checkpoint_candidate"
    assert_includes event.change_summary, "checkpoint_ref=(none)"
    assert_includes event.change_summary, "forecast_count=12"
    assert_includes event.change_summary, "effects=no_row_writes"
    assert_includes event.change_summary, "no_thesis_verdict"
  end

  test "quarterly checkpoint candidate identifies scheduled checkpoint periods" do
    result = Evidence::QuarterlyIndicatorCheckpointCandidate.call(as_of: Time.utc(2029, 4, 1, 6, 0, 0))

    assert_equal "2029-Q2", result.current_period
    assert_equal "2026-Q3", result.first_measurement_period
    assert_equal 12, result.measurement_index
    assert_equal "v1", result.checkpoint_ref
    assert_equal "quarterly_checkpoint_candidate", result.candidate_status
  end

  test "quarterly checkpoint candidate remains pre-measurement before first period" do
    result = Evidence::QuarterlyIndicatorCheckpointCandidate.call(as_of: Time.utc(2026, 6, 15, 6, 0, 0))

    assert_equal "2026-Q2", result.current_period
    assert_nil result.measurement_index
    assert_nil result.checkpoint_ref
    assert_equal "pre_first_measurement_period", result.candidate_status
    assert_includes result.warnings, "forecast_items_unapproved"
  end

  test "quarterly checkpoint candidate reports v2 and v3 target periods" do
    v2 = Evidence::QuarterlyIndicatorCheckpointCandidate.call(as_of: Time.utc(2031, 4, 1, 6, 0, 0))
    v3 = Evidence::QuarterlyIndicatorCheckpointCandidate.call(as_of: Time.utc(2036, 4, 1, 6, 0, 0))

    assert_equal 20, v2.measurement_index
    assert_equal "v2", v2.checkpoint_ref
    assert_equal 40, v3.measurement_index
    assert_equal "v3", v3.checkpoint_ref
  end

  test "quarterly checkpoint candidate does not create records by itself" do
    assert_no_difference -> { AuditEvent.count } do
      assert_no_difference -> { MetricObservation.count } do
        Evidence::QuarterlyIndicatorCheckpointCandidate.call(as_of: Time.utc(2026, 7, 1, 6, 0, 0))
      end
    end
  end

  test "annual snapshot candidate job records audit-only snapshot candidate" do
    as_of = Time.utc(2027, 7, 15, 6, 0, 0)

    assert_no_difference -> { DataSource.count } do
      assert_no_difference -> { SusbPublicFileRow.count } do
        assert_no_difference -> { BfsApiRow.count } do
          assert_no_difference -> { BdsPublicFileRow.count } do
            assert_no_difference -> { MetricDefinition.count } do
              assert_no_difference -> { MetricObservation.count } do
                assert_no_difference -> { MetricQualityReview.count } do
                  assert_no_difference -> { PredictionLink.count } do
                    assert_no_difference -> { ClaimReview.count } do
                      assert_no_difference -> { ExportArtifact.count } do
                        assert_no_difference -> { EvidenceSnapshot.count } do
                          assert_no_difference -> { FailureRecord.count } do
                            assert_difference -> { AuditEvent.where(event_type: "annual_snapshot_candidate_requested").count }, 1 do
                              Evidence::AnnualSnapshotCandidateJob.perform_now(as_of: as_of)
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
        end
      end
    end

    event = AuditEvent.where(event_type: "annual_snapshot_candidate_requested").last
    assert_equal "scheduled_annual_snapshot_candidate", event.reason_code
    assert_equal "unchanged", event.claim_status_effect
    assert_not event.export_allowed
    assert_equal "SchedulerCheckpoint", event.entity_type
    assert_equal "annual_snapshot_candidate:2027-Q2", event.entity_id
    assert_includes event.change_summary, "current_period=2027-Q3"
    assert_includes event.change_summary, "snapshot_period=2027-Q2"
    assert_includes event.change_summary, "first_snapshot_period=2027-Q2"
    assert_includes event.change_summary, "snapshot_index=1"
    assert_includes event.change_summary, "status=annual_snapshot_candidate"
    assert_includes event.change_summary, "forecast_count=12"
    assert_includes event.change_summary, "effects=no_row_writes"
    assert_includes event.change_summary, "no_publication"
    assert_includes event.change_summary, "no_thesis_verdict"
  end

  test "annual snapshot candidate resolves annual periods from completed quarter" do
    first = Evidence::AnnualSnapshotCandidate.call(as_of: Time.utc(2027, 7, 15, 6, 0, 0))
    second = Evidence::AnnualSnapshotCandidate.call(as_of: Time.utc(2028, 7, 15, 6, 0, 0))

    assert_equal "2027-Q2", first.snapshot_period
    assert_equal 1, first.snapshot_index
    assert_equal "annual_snapshot_candidate", first.candidate_status
    assert_equal "2028-Q2", second.snapshot_period
    assert_equal 2, second.snapshot_index
    assert_equal "annual_snapshot_candidate", second.candidate_status
  end

  test "annual snapshot candidate identifies off-cycle periods" do
    result = Evidence::AnnualSnapshotCandidate.call(as_of: Time.utc(2027, 1, 15, 6, 0, 0))

    assert_equal "2027-Q1", result.current_period
    assert_equal "2026-Q4", result.snapshot_period
    assert_nil result.snapshot_index
    assert_equal "not_annual_snapshot_period", result.candidate_status
    assert_includes result.warnings, "not_annual_snapshot_period"
  end

  test "annual snapshot candidate does not create records by itself" do
    assert_no_difference -> { AuditEvent.count } do
      assert_no_difference -> { EvidenceSnapshot.count } do
        Evidence::AnnualSnapshotCandidate.call(as_of: Time.utc(2027, 7, 15, 6, 0, 0))
      end
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
