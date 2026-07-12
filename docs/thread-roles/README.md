# Codex Task Roles

Status: current temporary Codex Work Mode guidance.

Canonical contract: OperatorKit commit `4c29cf51`.

ThesisRecord uses one repo-local Control task and at most one active disposable
Handoff task.

## Control

ThesisRecord Control owns first-principles reasoning, readiness, branch and Git
state, complete Handoff packets, acceptance review, commits, approvals,
sequencing, heartbeat lifecycle, and Handoff archival.

Control independently verifies a terminal Handoff result before accepting and
committing it. Cross-repo requests route Control-to-Control.

## Handoff

ThesisRecord Handoff owns only the bounded implementation and focused checks in
its packet. The current execution profile is GPT-5.4-mini with medium
reasoning. A Handoff does not switch branches, create worktrees, commit, merge,
push, request approval, deploy, restart services, or touch external state.

Every packet binds:

- `handoff_thread_id`;
- `expected_runtime_class`;
- `heartbeat_delay_minutes`;
- `implementation_commit_owner`;
- `integration_commit_owner`.

The Handoff writes its final return in its own task and stops. That return is
not delivered to Control and does not wake Control. The packet must not use
`control_thread_id` as a worker-delivery field or claim direct delivery.

## Heartbeat

The heartbeat is the sole Control wakeup and recovery mechanism. It checks task
status only. While a Handoff is active, Control does not poll, read its active
transcript, narrate progress, or steer status. When the task is terminal or
unreachable, Control deletes the heartbeat before reading the terminal return
once, reviewing evidence, and archiving the disposable Handoff.

## Research And Writing

Research and writing are bounded work scopes, not separate Codex task
identities. Research work must preserve source-verification and falsification
rules. Writing may begin only when accepted source truth and claim status
support it, and must not invent claims from raw returns or open questions.
