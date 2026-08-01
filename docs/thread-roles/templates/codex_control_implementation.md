# Codex Control Implementation Packet Template

Use this template only after Planning has supplied an accepted plan and frozen
acceptance criteria. The default mode is an ephemeral Implementer; a persistent
Handoff requires a qualifying continuity need recorded in the packet.

```yaml
implementation_packet:
  objective:
  accepted_plan_or_design: []
  repository:
  implementation_branch:
  control_slot:
  execution_mode: ephemeral_implementer
  implementation_model:
  implementation_reasoning:
  model_selection_reason:
  owned_paths: []
  required_behavior: []
  checks: []
  blocked_surfaces: []
  result_evidence:
    changed_paths: []
    checks: []
    blockers: []
    notes:
```

Control freezes the repository, branch, paths, behavior, checks, execution
mode, model, reasoning, and selection reason. An Implementer receives this
packet instead of Control's conversation and returns directly to Control.
Control stays active while it waits for that result but does not edit, widen,
repeatedly inspect, or status-interrupt the implementation.

`persistent_handoff` is available only for multiple implementation rounds,
extended waiting, an approval-sensitive pause, or a separately inspectable
high-blast-radius history. Strategy creates that task; difficulty alone does
not qualify. The Implementer or Handoff edits only owned paths, runs required
checks, and cannot stage, commit, merge, push, deploy, publish, resolve
approvals, access secrets/providers, mutate external systems, broaden the job,
or create another implementation agent.

Control performs frozen-plan conformance review and required-check reruns. It
may locally integrate an accepted result. It then sends Planning exactly one
terminal packet containing agent/model identity, exact repository state,
decision, paths, checks, accepted commit when applicable, cleanliness, first
blocker, and authority-boundary confirmation.
