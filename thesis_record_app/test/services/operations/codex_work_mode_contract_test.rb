require "test_helper"
require "yaml"

class Operations::CodexWorkModeContractTest < ActiveSupport::TestCase
  REPOSITORY_ROOT = Rails.root.parent
  THREAD_ROLES = REPOSITORY_ROOT.join("docs/thread-roles")

  test "current governance sources implement the accepted topology" do
    contract = YAML.safe_load_file(THREAD_ROLES.join("codex_work_mode.yml"))
      .fetch("codex_work_mode_contract")

    assert_equal 1, contract.dig("roles", "strategy", "count")
    assert_equal 1, contract.dig("roles", "planning", "count_per_repository")
    assert_equal false, contract.dig("roles", "planning", "numbered")
    assert_equal ["A", "B"], contract.dig("roles", "control", "stable_slot_names")
    assert_equal "ephemeral_implementer", contract.dig("topology", "default_execution_mode")
    assert_equal true, contract.dig("roles", "handoff", "exceptional")
    assert_equal false, contract.dig("topology", "persistent_control_handoff_pairs")
    assert_equal true, contract.dig("roles", "planning", "sends_one_control_ready_request_after_plan_and_criteria_frozen")
    assert_equal true, contract.dig("roles", "planning", "control_ready_request_excludes_implementation_detail_selection")
    assert_equal true, contract.dig("topology", "control_a_created_only_from_planning_control_ready_request")
    assert_equal true, contract.dig("topology", "control_b_requires_independent_parallel_work")
    assert_equal true, contract.dig("implementation_packet", "default_dispatches_one_ephemeral_implementer")
    assert_equal "strategy", contract.dig("thread_refresh", "owner")
    assert_equal false, contract.dig("thread_refresh", "numbered_builder_reincarnation_used")
    assert_equal true, contract.dig("thread_refresh", "control_archive_requires_complete_snapshot_recorded_idle_gate")
    assert_equal %w[repository worktree branch head status staging],
      contract.dig("thread_refresh", "control_archive_snapshot_state_fields")
  end

  test "control-ready request preserves Planning and Control responsibilities" do
    contract = YAML.safe_load_file(THREAD_ROLES.join("codex_work_mode.yml"))
      .fetch("codex_work_mode_contract")
    request = THREAD_ROLES.join("templates/codex_planning_control_ready.md").read

    contract.dig("planning_control_ready_request", "fields").each do |field|
      assert_includes request, "#{field}:"
    end

    contract.dig("planning_control_ready_request", "excludes_control_selected_implementation_details").each do |field|
      assert_not_includes request, "#{field}:"
    end

    assert_includes request, "Strategy creates `Control A` only from this request"
    assert_includes request, "independent of active Control A work"
  end

  test "packet and snapshot sources provide the required governance fields" do
    contract = YAML.safe_load_file(THREAD_ROLES.join("codex_work_mode.yml"))
      .fetch("codex_work_mode_contract")
    packet = THREAD_ROLES.join("templates/codex_control_implementation.md").read
    snapshot = THREAD_ROLES.join("codex_work_mode_current.md").read

    contract.dig("implementation_packet", "required_fields").each do |field|
      assert_includes packet, "#{field}:"
    end

    contract.dig("thread_snapshot", "required_fields").each do |field|
      assert_includes snapshot, "#{field}:"
    end
  end

  test "obsolete pair command is absent from active governance" do
    active_sources = [
      REPOSITORY_ROOT.join("AGENTS.md").read,
      THREAD_ROLES.join("README.md").read,
      THREAD_ROLES.join("codex_work_mode.yml").read
    ].join("\n")

    assert_not_includes active_sources, "Reincarnate this Codex pair"
    assert_not_includes active_sources, "owner_control_thread_id"
    assert_not_includes active_sources, "handoff_thread_id"
  end
end
