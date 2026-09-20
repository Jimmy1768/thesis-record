require "test_helper"

class Evidence::QuarterlyCollectionDispatchJobTest < ActiveJob::TestCase
  SOURCE_KINDS = %w[
    census_susb_public_file
    census_bds_public_file
    census_bfs_api
  ].freeze

  setup do
    @previous_queue_adapter = ActiveJob::Base.queue_adapter
    ActiveJob::Base.queue_adapter = :test
  end

  teardown do
    ActiveJob::Base.queue_adapter = @previous_queue_adapter
  end

  test "at the Q3 boundary enqueues one collection with the complete registry" do
    registry_ids = create_complete_registry

    travel_to Time.utc(2026, 10, 1) do
      assert_enqueued_with(job: Evidence::QuarterlyDatabaseCollectionJob,
                           queue: "maintenance",
                           args: [ {
                             quarter: "2026-Q3",
                             cutoff_at: "2026-10-01T00:00:00Z",
                             registry_ids: registry_ids
                           } ]) do
        Evidence::QuarterlyCollectionDispatchJob.perform_now
      end
    end

    assert_equal 1, enqueued_jobs.size
  end

  test "at the Q4 boundary enqueues the preceding year Q4" do
    registry_ids = create_complete_registry

    travel_to Time.utc(2027, 1, 1, 0, 0, 1) do
      assert_enqueued_with(job: Evidence::QuarterlyDatabaseCollectionJob,
                           queue: "maintenance",
                           args: [ {
                             quarter: "2026-Q4",
                             cutoff_at: "2027-01-01T00:00:00Z",
                             registry_ids: registry_ids
                           } ]) do
        Evidence::QuarterlyCollectionDispatchJob.perform_now
      end
    end
  end

  test "missing source registry fails before enqueue" do
    create_complete_registry(except: "census_bfs_api")

    assert_no_enqueued_jobs do
      assert_raises(Evidence::QuarterlyCollectionDispatchJob::DispatchError) do
        Evidence::QuarterlyCollectionDispatchJob.perform_now
      end
    end
  end

  test "ambiguous source registry fails before enqueue" do
    create_complete_registry
    create_source("census_bfs_api")

    assert_no_enqueued_jobs do
      assert_raises(Evidence::QuarterlyCollectionDispatchJob::DispatchError) do
        Evidence::QuarterlyCollectionDispatchJob.perform_now
      end
    end
  end

  test "mismatched manifest and schema registry fails before enqueue" do
    create_complete_registry(except: "census_bfs_api")
    source = create_source("census_bfs_api")
    manifest = create_manifest(source)
    other_source = create_source("unrelated_source")
    SchemaVersion.create!(data_source: other_source, intake_manifest: manifest,
                          version: "periodic-test-v1", schema_status: "validated")

    assert_no_enqueued_jobs do
      assert_raises(Evidence::QuarterlyCollectionDispatchJob::DispatchError) do
        Evidence::QuarterlyCollectionDispatchJob.perform_now
      end
    end
  end

  private

  def create_complete_registry(except: nil)
    SOURCE_KINDS.each_with_object({}) do |source_kind, registries|
      next if source_kind == except

      source = create_source(source_kind)
      manifest = create_manifest(source)
      schema = SchemaVersion.create!(data_source: source, intake_manifest: manifest,
                                     version: "periodic-test-v1", schema_status: "validated")
      registries[source_kind] = {
        "data_source_id" => source.id,
        "intake_manifest_id" => manifest.id,
        "schema_version_id" => schema.id
      }
    end
  end

  def create_source(source_kind)
    DataSource.create!(name: "periodic #{source_kind}", source_kind: source_kind,
                       source_status: "staged_context", storage_zone: "production_postgresql",
                       privacy_classification: "public", retention_rule: "test")
  end

  def create_manifest(source)
    IntakeManifest.create!(data_source: source, name: "periodic #{source.source_kind}",
                           manifest_status: "staged_context", storage_zone: "production_postgresql",
                           privacy_classification: "public", retention_rule: "test")
  end
end
