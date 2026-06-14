require "test_helper"

class PublicSources::Susb::MetricDefinitionScaffoldTest < ActiveSupport::TestCase
  test "creates draft-disabled SUSB metric definitions without observations" do
    assert_difference -> { MetricDefinition.count }, 5 do
      assert_no_difference -> { MetricObservation.count } do
        PublicSources::Susb::MetricDefinitionScaffold.call!(actor: "test_operator")
      end
    end

    definition = MetricDefinition.find_by!(key: "susb_employment")
    assert_equal "draft_disabled", definition.formula_status
    assert_includes definition.limitations, "no MetricObservation rows"
    assert_includes definition.limitations, "claim linkage"
  end

  test "is idempotent and records audit events" do
    PublicSources::Susb::MetricDefinitionScaffold.call!(actor: "test_operator")

    assert_no_difference -> { MetricDefinition.count } do
      assert_difference -> { AuditEvent.where(event_type: "metric_definition_changed").count }, 5 do
        PublicSources::Susb::MetricDefinitionScaffold.call!(actor: "test_operator")
      end
    end
  end
end
