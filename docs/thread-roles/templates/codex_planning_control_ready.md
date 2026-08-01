# Codex Planning Control-Ready Request Template

Planning sends this one request to Strategy only after it has frozen the
accepted plan and acceptance criteria on `main`. It provides readiness context,
not an implementation packet: Control alone selects the implementation branch,
execution mode, implementation model/reasoning, exact owned paths, and final
required checks before dispatch.

```yaml
planning_control_ready_request:
  accepted_plan:
  frozen_acceptance_criteria: []
  canonical_main_base_head:
  canonical_main_final_head:
  recommended_control_slot:
  recommended_control_model:
  likely_implementation_scope: []
  likely_checks: []
  blocked_surfaces: []
  follow_on:
  final_status_and_staging:
  first_blocker:
```

Strategy creates `Control A` only from this request. `Control B` is available
only for work genuinely independent of active Control A work. The request does
not select implementation details or authorize implementation, integration,
external actions, provider/secret access, or any product/runtime change.
