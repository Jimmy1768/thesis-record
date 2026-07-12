# Codex Task Roles

Status: current temporary Codex Work Mode guidance.

Canonical contract: OperatorKit commit `859bf872`.

ThesisRecord uses one repo-local Control task and one uniquely bound,
long-lived Handoff task. At most one bounded Handoff job may be active at a
time.

Each active Handoff belongs to exactly one Control. The
`owner_control_thread_id` and `handoff_thread_id` pair is a one-to-one identity
binding: a Handoff thread must never be shared across Controls, and a Control
must never target another Control's Handoff. `owner_control_thread_id` is
binding metadata, not a return destination.

## Control

ThesisRecord Control owns first-principles reasoning, readiness, branch and Git
state, complete Handoff packets, acceptance review, commits, approvals,
sequencing, heartbeat lifecycle, and Handoff archival.

The requested repository-Control profile is GPT-5.6-sol with high reasoning.
OperatorKit Control alone owns Sol/xhigh kernel architecture,
cross-repository contracts, and authority boundaries. ThesisRecord routes that
class of analysis Control-to-Control instead of increasing this Control to
xhigh. Requested model and reasoning remain configuration evidence rather than
runtime-telemetry proof.

Control independently verifies a terminal Handoff result before accepting and
committing it. Cross-repo requests route Control-to-Control.

## Handoff

ThesisRecord Handoff owns only the bounded implementation and focused checks in
its current packet. It has no permanent model or reasoning classification. A
Handoff does not switch branches, create worktrees, commit, merge, push,
request approval, deploy, restart services, or touch external state.

Control selects an execution profile for every bounded job and passes the same
requested model and reasoning in the packet and dispatch override. Baselines:

- mechanical documentation, tests, and fixtures: GPT-5.4-mini / medium;
- ordinary bounded implementation: GPT-5.4 / medium;
- architecture, persistence, authority, security, or cross-contract-sensitive
  implementation: GPT-5.4 / high.

Requested model and reasoning are configuration evidence, not proof of actual
runtime telemetry.

Every packet binds:

- `owner_control_thread_id`;
- `handoff_thread_id`;
- `expected_runtime_class`;
- `heartbeat_delay_minutes`;
- `requested_model`;
- `requested_reasoning`;
- `execution_profile`;
- `selection_reason`;
- `implementation_commit_owner`;
- `integration_commit_owner`.

The Handoff writes its final return in its own task and stops. That return is
not delivered to Control and does not wake Control. The packet must not use
`control_thread_id` as a worker-delivery field or claim direct delivery.

Cross-repository work routes Control-to-Control. The receiving Control uses its
own uniquely bound Handoff. Terminal jobs return the Handoff to idle for serial
reuse; a replacement is created only when the identity binding is explicitly
ended or the Handoff is no longer reachable.

## Terminal Wake And Heartbeat

The platform terminal wake is the primary Control-resumption mechanism after a
Handoff writes its terminal return and stops. The heartbeat is fallback
recovery only; it checks task status, never the active transcript.

While a Handoff is active, Control does not poll, read its transcript, narrate
progress, or steer status. When terminal wake or fallback heartbeat resumes
Control, Control deletes any outstanding heartbeat before reading the terminal
return once and reviewing the evidence. The long-lived Handoff then returns to
idle for the next serial job rather than being archived after each job.

## Research And Writing

Research and writing are bounded work scopes, not separate Codex task
identities. Research work must preserve source-verification and falsification
rules. Writing may begin only when accepted source truth and claim status
support it, and must not invent claims from raw returns or open questions.
