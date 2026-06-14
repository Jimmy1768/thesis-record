require "test_helper"

class DataSourceTest < ActiveSupport::TestCase
  setup do
    @role = Role.create!(name: "research_admin")
    @user = User.create!(email: "research@example.test", role: @role)
  end

  test "register! creates a data source and audit event in one transaction" do
    assert_difference -> { DataSource.count }, 1 do
      assert_difference -> { AuditEvent.count }, 1 do
        DataSource.register!(source_attributes, actor: @user)
      end
    end

    event = AuditEvent.last
    assert_equal "source_registered", event.event_type
    assert_equal "DataSource", event.entity_type
    assert_equal "production_postgresql", event.storage_zone
    assert_equal "internal", event.privacy_classification
    assert_equal "unchanged", event.claim_status_effect
    assert_not event.export_allowed
  end

  test "register! fails closed when audit recording fails" do
    original_recorder = Audit::Recorder.method(:record!)
    Audit::Recorder.define_singleton_method(:record!) do |**|
      raise ActiveRecord::RecordInvalid, AuditEvent.new
    end

    assert_no_difference -> { DataSource.count } do
      assert_no_difference -> { AuditEvent.count } do
        assert_raises(ActiveRecord::RecordInvalid) do
          DataSource.register!(source_attributes, actor: @user)
        end
      end
    end
  ensure
    Audit::Recorder.define_singleton_method(:record!, original_recorder)
  end

  test "internal data source cannot be public repo allowed" do
    source = DataSource.new(source_attributes.merge(public_repo_allowed: true))

    assert_not source.valid?
    assert_includes source.errors[:public_repo_allowed],
                    "cannot be true for internal or confidential records"
  end

  private

  def source_attributes
    {
      name: "Company Operator Network Pilot",
      source_kind: "company_operator_network",
      source_status: "source_registered",
      storage_zone: "production_postgresql",
      privacy_classification: "internal",
      public_repo_allowed: false,
      structured_private_allowed: true,
      private_file_storage_allowed: false,
      secret_material_present: false,
      redaction_required: true,
      minimum_cell_rule_required: true,
      human_review_required: true,
      retention_rule: "retain_until_reviewed"
    }
  end
end
