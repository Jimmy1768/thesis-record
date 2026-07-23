# ThesisRecord Agent Instructions

These instructions apply to the entire repository.

This file governs Codex builder workflow only. It does not define or alter
ThesisRecord product behavior, evidence authority, research methodology,
publication state, deployment topology, runtime services, data ownership, or
application lifecycle semantics.

## Control And Handoff

Control owns reasoning, planning, readiness, acceptance review, Git state, and
approval-sensitive actions.

Handoff implements the bounded work selected by Control, edits only owned
paths, runs required checks, and returns evidence. Handoff does not stage,
commit, merge, push, deploy, resolve approvals, broaden the job, or select its
own execution configuration.

Control independently reviews Handoff work and integrates only accepted
changes.

## Model Allocation And Escalation

Every Control and Handoff task creation explicitly selects its model and
reasoning. Model and reasoning settings are never inherited from the creating
task. Every Handoff dispatch states the selected model, reasoning, and the
selection reason for that bounded work.

Control uses:

1. `gpt-5.6-sol` with `high` reasoning as the primary configuration.
2. `gpt-5.6-terra` with `high` reasoning only when `gpt-5.6-sol` is unavailable
   or capacity-limited. Control records the fallback reason.

Control selects the lowest sufficient Handoff configuration for each bounded
job:

1. `gpt-5.4` with `medium` reasoning for deterministic, mechanical work.
2. `gpt-5.4` with `high` reasoning when deeper reasoning is needed.
3. `gpt-5.5` with `medium` reasoning only after GPT-5.4 work is unsatisfactory
   or rejected.
4. `gpt-5.5` with `high` reasoning only as the last resort.

An idle Handoff starts on `gpt-5.4` with `medium` reasoning. `gpt-5.4-mini` is
not used.

Handoff cannot self-select or self-escalate its model or reasoning. A model or
reasoning mismatch is not ready for work. If the selected configuration is
unavailable, the task blocks and reports the mismatch instead of silently
substituting another configuration.

## Pair Retirement And Replacement

The exact Director command is `Reincarnate this Codex pair`.

When the Director gives that command, the current Control performs this
builder-only cutover:

1. Stop dispatching work and preserve the repository, checkout, branch, HEAD,
   status, worktrees, active plan, decisions, blockers, and current pair IDs.
2. Create one successor Control/Handoff pair using the next pair number and the
   required role configurations.
3. Attempt each task creation once. Never automatically retry a timeout or a
   missing task ID.
4. Keep the old pair authoritative until both successor tasks acknowledge real
   task IDs, exclusive binding, configured model and reasoning, and readiness
   after reading this `AGENTS.md`.
5. Archive the retiring Handoff first and the retiring Control second. Record
   the old and new pair IDs in the handoff record.

The predecessor and successor pairs may overlap only for an inactive cutover.
That overlap does not authorize a third working pair.

Pair retirement and replacement are Codex builder mechanics only. They do not
define ThesisRecord product or runtime lifecycle semantics.

## Safety

Preserve repository-specific authority, evidence, research, deployment, and
runtime boundaries. Without explicit authorization, do not push, deploy,
publish, access secrets, mutate external systems, or change production data or
services.
