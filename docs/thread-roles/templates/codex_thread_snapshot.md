# Codex Work Mode Thread Snapshot Template

The current snapshot transfers volatile builder coordination during a
Strategy-owned Thread Refresh. It points to accepted plans and references; it
does not define new repository architecture or product behavior.

```yaml
codex_work_mode_snapshot:
  recorded_at:
  logical_role:
  actual_task_id:
  repository:
  worktree:
  branch:
  head:
  status:
  active_plan_links: []
  active_packet:
  callbacks: []
  authorization: []
  blockers: []
  next_action:
```

Before a snapshot is recorded, put accepted decisions and unresolved design
questions into plans or references. Record observed repository state rather
than inferred state. A successor must read the active governance sources,
linked plans, and repository state, then report its real task ID, role, model,
and readiness before Strategy transfers authority.
