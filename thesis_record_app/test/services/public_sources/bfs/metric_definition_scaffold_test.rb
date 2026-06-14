require "test_helper"

class PublicSources::Bfs::MetricDefinitionScaffoldTest < ActiveSupport::TestCase
  test "creates draft-disabled BFS metric definitions without observations" do
    assert_difference -> { MetricDefinition.where("key LIKE ?", "bfs_%").count }, 6 do
      assert_no_difference -> { MetricObservation.count } do
        @result = PublicSources::Bfs::MetricDefinitionScaffold.call!(actor: "test_operator")
      end
    end

    assert_equal 6, @result.metric_definitions_created
    assert_equal 0, @result.metric_observations_created
    assert_equal 0, @result.prediction_links_created
    assert_equal 0, @result.exports_created
    definition = MetricDefinition.find_by!(key: "bfs_business_applications")
    assert_equal "draft_disabled", definition.formula_status
    assert_includes definition.limitations, "no MetricObservation rows"
    assert_includes definition.limitations, "claim support"
  end

  test "is idempotent and records audit events" do
    PublicSources::Bfs::MetricDefinitionScaffold.call!(actor: "test_operator")

    assert_no_difference -> { MetricDefinition.where("key LIKE ?", "bfs_%").count } do
      assert_difference -> { AuditEvent.where(event_type: "metric_definition_changed", reason_code: "bfs_metric_definition_scaffold").count }, 6 do
        result = PublicSources::Bfs::MetricDefinitionScaffold.call!(actor: "test_operator")
        assert_equal 0, result.metric_definitions_created
      end
    end
  end
end
