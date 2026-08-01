# ThesisRecord Agent Instructions

These instructions apply to the entire repository.

## Builder And Repository Boundary

Codex Work Mode is ThesisRecord's builder workflow. It governs task roles,
planning, implementation review, and local integration. It does not define or
alter ThesisRecord product behavior, evidence authority, research methodology,
publication state, deployment topology, runtime services, data ownership, or
application lifecycle semantics.

Builder-governance records and thesis/product evidence remain separate. A
Codex task, thread, model, packet, or Thread Refresh is not product or runtime
evidence. Preserve the authority of the source-verification, research,
publication, provider, deployment, and runtime documents that govern the work
being considered.

## Roles And Topology

Strategy is the one cross-repository Codex Work Mode task. It owns
cross-repository architecture and sequencing, model policy, durable task
creation, and Thread Refresh. Strategy does not implement repository changes
or replace repository Planning.

ThesisRecord has one unnumbered Planning task. Planning owns repository
reasoning, readiness, plan documentation, and frozen acceptance criteria. It
writes accepted plans on `main`, then sends Strategy one Control-ready request
for the frozen plan. That request identifies the plan, criteria, canonical
`main` base/final HEAD, recommended Control slot/model, likely scope/checks,
blocked surfaces, follow-on, status/staging, and first blocker; it does not
select implementation details. Planning returns cross-repository or
new-contract questions to Strategy.

Strategy creates `Control A` only from Planning's Control-ready request.
`Control B` is allowed only for work genuinely independent of active Control A
work. A Control consumes a frozen plan, freezes one implementation packet, selects its
implementation branch, reviews only for frozen-plan conformance, reruns the
required checks, and may stage, commit, and locally integrate accepted work.
Control selects its execution mode, implementation model/reasoning, exact
owned paths, and required checks before it dispatches one ephemeral
Implementer. Control does not implement the packet or reopen Planning.

An ephemeral Implementer is the default one-packet implementation agent. Each
Control has at most one active implementation agent. An Implementer receives a
frozen packet rather than the Control conversation, edits only packet-owned
paths, runs the required checks, and returns its result directly to Control.

A persistent Handoff is exceptional. Control may request one packet only for
multiple implementation rounds, extended waiting, an approval-sensitive pause,
or a separately inspectable high-blast-radius history. Strategy creates it;
the requesting Control alone reviews it; it is archived after its terminal
disposition. Difficulty alone is not a qualifying reason.

Implementers and Handoffs do not stage, commit, merge, push, deploy, publish,
resolve approvals, broaden work, access secrets, or mutate external systems.
They cannot spawn another implementation agent.

## Model Allocation

Strategy uses `gpt-5.6-sol` with high reasoning. Planning and Control use
`gpt-5.6-terra` with high reasoning by default; Strategy may authorize
`gpt-5.6-sol` for a demanding contract or high-risk Control review.

For every implementation packet, Control records the selected model,
reasoning, and selection reason:

1. certified mechanical Implementer: `gpt-5.6-luna`, medium reasoning;
2. normal Implementer or Handoff: `gpt-5.6-terra`, medium reasoning;
3. deeper bounded Implementer or Handoff: `gpt-5.6-terra`, high reasoning.

Do not use Luna for an unresolved design choice, lifecycle judgment, or
cross-component semantic decision. A rejected implementation does not itself
justify model escalation; a correction requires a newly explicit packet.

## Supervision, Packets, And Thread Refresh

Control remains active while its ephemeral Implementer is active, observes its
activity and progress, and waits for the direct result. This does not authorize
Control to edit implementation, repeatedly inspect partial diffs, widen the
packet, or interrupt merely to request status. After `accept`, `reject`, or
`blocked`, Control sends exactly one terminal packet to Planning containing the
implementation agent/model, repository/worktree/branch/base and final HEAD,
decision, changed paths, checks, accepted commit when applicable, final status
and staging, first blocker, and authority-boundary confirmation.

Strategy alone performs Thread Refresh for Strategy, Planning, Control, and
exceptional persistent Handoff tasks. Codex Work Mode does not use numbered
builder-thread reincarnation. Before a refresh, Strategy stops predecessor
dispatch, ensures accepted decisions and unresolved design questions are in
repository source truth, records exact volatile state in the current snapshot,
attempts successor creation once, and keeps the predecessor authoritative
until the successor verifies source truth, actual state, real task ID, model,
role, and readiness. Strategy archives the predecessor only after that
verification.

Strategy and Planning remain unnumbered. A refreshed Control retains its A or
B slot and Strategy archives it only after the complete idle gate is satisfied
and recorded in the current snapshot: no active Implementer or Handoff, pending
result review or integration, unresolved approval or callback, or unsent
terminal packet to Planning, plus exact repository/worktree/branch/HEAD/status
and staging state. Implementers are never refreshed. Strategy self-refresh
requires explicit Director authorization; the Director may restore Strategy
from the current snapshot if it is unavailable.

## Phase Integrity

Resolve the current global Director phase from the canonical repository roadmap
before planning, dispatch, implementation, review, or repair. Classify
similarly named phases as global-current, historical, or plan-local; do not
substitute a local thesis phase for the global phase.

Do not reopen, retest, rename, or add acceptance demands to a Director-accepted
or closed phase. Do not change frozen requirements during implementation or
review, add unrelated tests or blockers, or use readiness work to change a
phase's objective or gates. A bug in an approved phase remains in that phase;
Control may dispatch a bounded repair under the frozen plan. If the plan must
change, Control stops and Planning may revise it only after an explicit
Director reopening. Only the Director may create, split, rename, defer,
replace, or close a phase.

## Research, Writing, And Safety

Research and writing are bounded work scopes, not separate Codex task
identities. Research preserves source-verification and falsification rules.
Writing begins only when accepted source truth and claim status support it and
does not invent claims from raw returns or open questions.

Without explicit authorization, do not push, deploy, publish, access secrets
or providers, mutate external systems or production data/services, or resolve
approval-sensitive actions. Preserve repository-specific authority, evidence,
research, deployment, secret, provider, product, and runtime boundaries.
