# ThesisRecord Codex Work Mode

Status: current repository builder-governance reference.

Codex Work Mode is the builder workflow for planning, implementing, reviewing,
and locally integrating ThesisRecord changes. It is not a ThesisRecord product
or runtime control surface, and its task mechanics do not define evidence,
research, publication, provider, deployment, secret, or lifecycle semantics.

## Authority And Roles

Strategy is the one workspace-wide Codex Work Mode task. It owns
cross-repository architecture and sequencing, model policy, durable task
creation, and Thread Refresh. It routes repository work through the relevant
Planning task and does not implement repository changes.

ThesisRecord Planning is this repository's one unnumbered Planning task. It
owns first-principles reasoning, readiness, accepted plan documentation, and
frozen acceptance criteria on `main`. A cross-repository or new-contract issue
returns to Strategy.

ThesisRecord may have `Control A` and `Control B`. Each independently consumes
a frozen plan, chooses the implementation branch, freezes an implementation
packet, dispatches one implementation agent, verifies frozen-plan conformance,
reruns the required checks, and may stage, commit, and locally integrate an
accepted result. A Control does not implement its packet or reopen Planning.

## Implementation Agents

The default execution mode is one ephemeral Implementer per frozen packet. The
Implementer receives the packet, not the full Control conversation; it cannot
spawn an agent, edits only its owned paths, runs the stated checks, and returns
directly to Control. A Control remains active while that Implementer runs,
observing activity and progress before receiving the direct result. It does not
use that supervision to edit the work, repeatedly inspect partial diffs, widen
the packet, or interrupt merely for status.

A persistent Handoff is a one-packet exception for multiple implementation
rounds, extended waiting, approval-sensitive pauses, or a separately
inspectable high-blast-radius history. Control requests the exception, Strategy
creates it, and the requesting Control alone reviews the terminal result.
Difficulty alone is insufficient. The Handoff is archived after acceptance,
rejection, or abandonment.

Neither agent stages, commits, merges, pushes, deploys, publishes, resolves
approvals, broadens scope, accesses secrets/providers, or mutates external
systems.

## Model Policy

- Strategy: `gpt-5.6-sol`, high reasoning.
- Planning and Control by default: `gpt-5.6-terra`, high reasoning.
- Certified mechanical Implementer: `gpt-5.6-luna`, medium reasoning.
- Normal Implementer or Handoff: `gpt-5.6-terra`, medium reasoning.
- Deeper bounded Implementer or Handoff: `gpt-5.6-terra`, high reasoning.

Strategy may authorize Sol for a demanding contract or high-risk Control review.
Luna is unavailable for unresolved design, lifecycle judgment, or
cross-component semantic work. Every packet records its model, reasoning, and
selection reason.

## Packets And Terminal Return

Every packet identifies its objective, accepted plan/design, repository,
implementation branch, Control slot, execution mode, selected model and
reasoning, owned paths, required behavior, checks, blocked surfaces, and result
evidence. Use [the packet template](templates/codex_control_implementation.md).

After `accept`, `reject`, or `blocked`, Control sends exactly one terminal
packet to Planning. It includes implementation-agent identity and model,
repository/worktree/branch/base and final HEAD, decision, changed paths,
checks, accepted commit when applicable, final status and staging, first
blocker, and authority-boundary confirmation.

## Thread Refresh And Snapshot

Strategy alone performs Thread Refresh. It applies to Strategy, Planning,
Control, and exceptional persistent Handoff tasks, never to an Implementer.
It does not use or define builder-thread reincarnation.

Before refresh, Strategy records exact volatile coordination in
[the current snapshot](codex_work_mode_current.md), including task identity,
repository state, plans, packet, callbacks, authorization, blockers, and next
action. Accepted decisions and open design questions belong in plans and
references before that snapshot. Strategy attempts a successor once and
retains predecessor authority until the successor has read source truth and the
snapshot, verified actual state, and reported its real task ID, model, role,
and readiness. Only then may the predecessor be archived.

Planning and Strategy are unnumbered. A refreshed Control keeps slot A or B and
must be idle: no active Implementer/Handoff, pending result review or
integration, unresolved approval/callback, or unsent Planning packet. Its exact
repository state must already be recorded. Strategy self-refresh requires
Director authorization; the Director may restore unavailable Strategy from the
snapshot.

## ThesisRecord Boundaries

The current global Director phase comes only from the repository architecture
roadmap. Thesis-local phases and historical records do not replace it. Frozen
plans and accepted phases remain intact; only the Director changes phase scope
or lifecycle. Research keeps its source-verification and falsification rules.
Writing requires accepted source truth and claim status and cannot promote raw
returns or open questions into claims.

This reference, [the protocol](codex_work_mode.yml),
[the snapshot template](templates/codex_thread_snapshot.md), and
[the accepted migration plan](plans/CODEX_WORK_MODE_STRATEGY_IMPLEMENTER_THREAD_REFRESH_PLAN.md)
are the active repository Codex Work Mode source truth. Historical operational
handoffs preserve their original terminology as evidence and are not current
governance.
