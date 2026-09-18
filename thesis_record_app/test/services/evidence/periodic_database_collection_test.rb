require "test_helper"
require "minitest/mock"

class PeriodicDatabaseCollectionTest < ActiveSupport::TestCase
  setup do
    travel_to Time.utc(2027, 1, 2)
    @source = DataSource.create!(name: "periodic BDS test", source_kind: "census_bds_public_file",
                                 storage_zone: "production_postgresql", privacy_classification: "public",
                                 retention_rule: "test")
    @manifest = IntakeManifest.create!(data_source: @source, name: "periodic BDS test",
                                       storage_zone: "production_postgresql", privacy_classification: "public",
                                       retention_rule: "test")
    @schema = SchemaVersion.create!(data_source: @source, intake_manifest: @manifest,
                                    version: "test-v1", schema_status: "validated")
    @definition = MetricDefinition.create!(key: "periodic-test", name: "Periodic test",
                                           formula_status: "draft", formula: "count")
  end

  teardown { travel_back }

  test "quarter cutoffs are derived and persisted values must match" do
    assert_equal Time.utc(2026, 4, 1), QuarterlyCollection.cutoff_for("2026-Q1")
    assert_equal Time.utc(2026, 7, 1), QuarterlyCollection.cutoff_for("2026-Q2")
    assert_equal Time.utc(2026, 10, 1), QuarterlyCollection.cutoff_for("2026-Q3")
    assert_equal Time.utc(2027, 1, 1), QuarterlyCollection.cutoff_for("2026-Q4")

    collection = QuarterlyCollection.new(quarter: "2026-Q3", cutoff_at: Time.utc(2026, 9, 30),
                                         revision: 1, identity_digest: "identity", input_digest: "input",
                                         status: "building")
    assert_not collection.valid?
    assert_includes collection.errors[:cutoff_at], "must match the quarter end"
  end

  test "Day 0 registration verifies existing members and protects them without rewriting" do
    baseline = BdsPublicFileRow.create!(**row_attributes, data_source: @source,
                                        intake_manifest: @manifest, schema_version: @schema)
    original = baseline.attributes
    config = {
      baseline_key: "test-day-zero",
      baseline_observed_on: "2026-06-14",
      authority_manifest_paths: [],
      historical_provenance: { original_application_commit: "unknown" },
      expected_counts: Evidence::DayZeroManifestBuilder::TABLE_MODELS.transform_values(&:count)
    }
    registration = Evidence::RegisterDayZero.call!(config: config)

    assert_equal registration.id, Evidence::RegisterDayZero.call!(config: config).id
    assert_equal original, baseline.reload.attributes
    assert_equal "unknown", registration.manifest.fetch("historical_provenance").fetch("original_application_commit")
    assert_raises(ActiveRecord::StatementInvalid) do
      BdsPublicFileRow.transaction(requires_new: true) { baseline.update!(sector_code: "21") }
    end
    assert_raises(ActiveRecord::StatementInvalid) do
      BdsPublicFileRow.transaction(requires_new: true) { baseline.delete }
    end
    assert_raises(ActiveRecord::StatementInvalid) do
      BdsPublicFileRow.transaction(requires_new: true) do
        BdsPublicFileRow.create!(**row_attributes.merge(sector_code: "22"), data_source: @source,
                                 intake_manifest: @manifest, schema_version: @schema)
      end
    end

    capture = capture_for("response-one", row_attributes)
    assert_equal 1, capture.row_count
    assert Evidence::RegisterDayZero.verify!(registration)
  end

  test "capture and quarter retries reuse database rows; revisions and unchanged quarters remain distinct" do
    capture = capture_for("response-one", row_attributes)
    assert_equal "new", PeriodicSourceCheck.last.status
    assert_equal capture.id, capture_for("response-one", row_attributes).id
    assert_equal "unchanged", PeriodicSourceCheck.last.status
    assert_equal 1, BdsPublicFileRow.where(periodic_capture: capture).count
    assert_raises(Evidence::RecordPeriodicCapture::CaptureError) do
      capture_for("response-one", row_attributes.merge(row_hash: "different parser output"))
    end
    assert_equal 1, BdsPublicFileRow.where(periodic_capture: capture).count

    first = complete("2026-Q3", capture)
    assert_equal first.id, complete("2026-Q3", capture).id
    assert_equal 1, first.revision
    assert_equal 1, MetricObservation.where(quarterly_result_set: first.quarterly_result_set).count
    assert_equal 1, MetricQualityReview.joins(:metric_observation)
                                      .where(metric_observations: { quarterly_result_set_id: first.quarterly_result_set_id }).count

    next_quarter = complete("2026-Q4", capture)
    assert_not_equal first.id, next_quarter.id
    assert_equal first.quarterly_result_set_id, next_quarter.quarterly_result_set_id

    revised_capture = capture_for("response-two", row_attributes.merge(source_row_number: 2, row_hash: "changed"))
    assert_not_equal capture.id, revised_capture.id
    assert_equal 2, BdsPublicFileRow.where(data_source: @source).count
    revised = complete("2026-Q3", revised_capture)
    assert_equal 2, revised.revision
    assert_not_equal first.quarterly_result_set_id, revised.quarterly_result_set_id

    assert_raises(ActiveRecord::StatementInvalid) do
      BdsPublicFileRow.transaction(requires_new: true) do
        BdsPublicFileRow.find_by!(periodic_capture: capture).update!(row_hash: "overwrite")
      end
    end
    assert_raises(ActiveRecord::StatementInvalid) do
      QuarterlyCollection.transaction(requires_new: true) { first.update_column(:revision, 9) }
    end
  end

  test "failed parse and computation leave no completed rows" do
    assert_raises(ArgumentError) do
      Evidence::RecordPeriodicCapture.call!(**capture_options("invalid"), parser: ->(_response) { raise ArgumentError, "invalid" })
    end
    assert_equal "failed", PeriodicSourceCheck.last.status
    assert_equal 0, PeriodicCapture.count

    assert_raises(FrozenError) do
      Evidence::RecordPeriodicCapture.call!(**capture_options("immutable-response"),
                                             parser: ->(bytes) { bytes.replace("changed") })
    end
    assert_equal 0, PeriodicCapture.count

    parser = lambda do |_response|
      Enumerator.new do |rows|
        rows << row_attributes
        raise ArgumentError, "stream interrupted"
      end
    end
    assert_raises(ArgumentError) do
      Evidence::RecordPeriodicCapture.call!(**capture_options("interrupted"), parser: parser)
    end
    assert_equal 0, PeriodicCapture.count
    assert_equal 0, BdsPublicFileRow.count

    capture = capture_for("response-one", row_attributes)
    assert_raises(ArgumentError) do
      Evidence::CompleteQuarterlyCollection.call!(**quarter_options("2026-Q3", capture),
                                                   compute: ->(_captures) { raise ArgumentError, "failure" })
    end
    assert_equal 0, QuarterlyCollection.count
    assert_equal 0, QuarterlyResultSet.count
    assert_equal 0, MetricObservation.count
  end

  test "production entry points remain disabled until the later phase" do
    Rails.stub(:env, ActiveSupport::StringInquirer.new("production")) do
      assert_raises(Evidence::RegisterDayZero::RegistrationMismatch) do
        Evidence::RegisterDayZero.call!(config: {})
      end
      assert_raises(Evidence::RecordPeriodicCapture::CaptureError) do
        Evidence::RecordPeriodicCapture.call!(**capture_options("response"), parser: ->(_bytes) { [] })
      end
      assert_raises(Evidence::CompleteQuarterlyCollection::CollectionError) do
        Evidence::CompleteQuarterlyCollection.call!(**quarter_options("2026-Q3", nil), compute: ->(_) { [] })
      end
    end
  end

  test "direct quarter completion rejects an unrelated or unclosed cutoff" do
    capture = capture_for("response-one", row_attributes)
    compute = ->(_captures) { [] }
    error = assert_raises(Evidence::CompleteQuarterlyCollection::CollectionError) do
      Evidence::CompleteQuarterlyCollection.call!(
        **quarter_options("2026-Q3", capture).merge(cutoff_at: Time.utc(2026, 9, 30)),
        compute: compute)
    end
    assert_match(/cutoff/, error.message)

    travel_to Time.utc(2026, 9, 30, 23, 59, 59) do
      error = assert_raises(Evidence::CompleteQuarterlyCollection::CollectionError) do
        Evidence::CompleteQuarterlyCollection.call!(**quarter_options("2026-Q3", capture), compute: compute)
      end
      assert_match(/not closed/, error.message)
    end
    assert_equal 0, QuarterlyCollection.count
    assert_equal 0, QuarterlyResultSet.count
  end

  test "building record identities cannot drift before completion" do
    capture = PeriodicCapture.create!(data_source: @source, dataset_scope: "test",
                                      release_identity: "2023", response_sha256: "a" * 64,
                                      parsed_rows_digest: "b" * 64, parser_version: "v1",
                                      row_count: 0, retrieved_at: Time.current)
    assert_raises(ActiveRecord::StatementInvalid) do
      PeriodicCapture.transaction(requires_new: true) do
        capture.update_column(:release_identity, "2024")
      end
    end
  end

  test "batch insertion rolls back earlier batches when a later row fails" do
    parser = lambda do |_response|
      Enumerator.new do |output|
        1_001.times do |index|
          output << row_attributes.merge(year: 1900 + index, source_row_number: index + 1,
                                         row_hash: "row-#{index}")
        end
        raise ArgumentError, "later parse failure"
      end
    end
    assert_raises(ArgumentError) do
      Evidence::RecordPeriodicCapture.call!(**capture_options("large-response"), parser: parser)
    end
    assert_equal 0, PeriodicCapture.count
    assert_equal 0, BdsPublicFileRow.count

    parser = ->(_response) { (0...1_001).lazy.map { |index|
      row_attributes.merge(year: 1900 + index, source_row_number: index + 1,
                           row_hash: "row-#{index}")
    } }
    capture = Evidence::RecordPeriodicCapture.call!(**capture_options("large-response"), parser: parser)
    assert_equal 1_001, capture.row_count
    assert_equal 1_001, BdsPublicFileRow.where(periodic_capture: capture).count
  end

  private

  def row_attributes
    { source_row_number: 1, year: 2023, sector_code: "11", firm_age_code: "a) 0",
      firm_size_code: "a) 1 to 4", raw_measure_values: {}, numeric_measure_values: {},
      publication_flags: {}, row_hash: "test-row", metadata: {} }
  end

  def capture_options(response)
    { data_source: @source, intake_manifest: @manifest, schema_version: @schema,
      dataset_scope: "bds-test", release_identity: "2023", response: response,
      parser_version: "test-v1", checked_at: Time.utc(2026, 9, 18) }
  end

  def capture_for(response, attributes)
    Evidence::RecordPeriodicCapture.call!(**capture_options(response),
                                          parser: ->(_response) { [ attributes ].each })
  end

  def quarter_options(quarter, capture)
    { quarter: quarter, captures: [ capture ], cutoff_at: QuarterlyCollection.cutoff_for(quarter),
      method_manifest: { "version" => "test-v1" }, definitions: { "periodic-test" => "count" } }
  end

  def complete(quarter, capture)
    Evidence::CompleteQuarterlyCollection.call!(**quarter_options(quarter, capture), compute: lambda { |_captures|
      [ [
        { metric_definition_id: @definition.id, data_source_id: @source.id, period: "2023",
          metric_status: "draft", numeric_value: 1, unit: "count", dimensions: { "sector" => "11" } },
        { data_source_id: @source.id, policy_version: "test-v1", source_metric_status: "draft",
          review_status: "pending", review_reason_code: "test", reviewed_by: "test",
          reviewed_at: Time.utc(2026, 9, 18) }
      ] ]
    })
  end
end
