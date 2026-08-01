# ThesisRecord Codex Work Mode Strategy, Implementer, And Thread Refresh Plan

Status: Director-authorized governance migration accepted

Owner: ThesisRecord Planning

Date: 2026-08-01

## Purpose

Replace the obsolete permanent Control/Handoff pair and numbered
builder-thread reincarnation rules with the accepted Codex Work Mode topology.
This is builder-governance work only. It does not change ThesisRecord product,
research, evidence, publication, provider, deployment, secret, or runtime
authority.

## Phase Identity

The global-current Director phase is **Phase 1: publish and operate Thesis 1,
Operator Nodes, before public productization**, as stated by `README.md` and
`docs/architecture/phase_1_operator_nodes_v0.md`.

The Mobility Conversion sequence is thesis-local: its Phase 5A is
plan-local/active-next for bounded boundary-record work. Its phases 1–4 and
closed 5B/5C substages are historical or closed local records. Historical
operational handoffs retain evidence of their original work but are not current
Codex Work Mode authority. No phase is renamed, reopened, or otherwise changed
by this migration.

## Accepted Design

1. Strategy is the single cross-repository owner of architecture, durable task
   creation, model policy, and Thread Refresh.
2. ThesisRecord Planning is one unnumbered repository task that owns reasoning,
   readiness, frozen plans, and acceptance criteria on `main`.
3. The repository may use independent `Control A` and `Control B` tasks. A
   Control freezes and reviews packets; it does not implement or reopen a plan.
4. A Control normally uses one ephemeral Implementer for one frozen packet and
   remains visibly active until the direct result returns.
5. A persistent Handoff is an exceptional one-packet task requested by Control,
   created by Strategy, and justified only by durable continuity needs.
6. Implementers and Handoffs have no integration, approval, external-system,
   provider, or secret-access authority.
7. Strategy-owned Thread Refresh replaces numbered builder-thread
   reincarnation. Strategy and Planning remain unnumbered; Control retains A or
   B and refreshes only while idle.
8. The current Markdown snapshot contains volatile coordination only. Plans and
   references retain accepted decisions and unresolved design questions.

## Model Policy

- Strategy: `gpt-5.6-sol`, high reasoning.
- Planning and default Control: `gpt-5.6-terra`, high reasoning.
- Certified mechanical Implementer: `gpt-5.6-luna`, medium reasoning.
- Normal Implementer/Handoff: `gpt-5.6-terra`, medium reasoning.
- Deeper bounded Implementer/Handoff: `gpt-5.6-terra`, high reasoning.

Every packet records the chosen model, reasoning, and selection reason. Luna
is excluded for unresolved design, lifecycle, or cross-component semantic work.

## Owned Source Truth

- `AGENTS.md`
- `docs/thread-roles/README.md`
- `docs/thread-roles/codex_work_mode.yml`
- `docs/thread-roles/templates/codex_control_implementation.md`
- `docs/thread-roles/templates/codex_thread_snapshot.md`
- `docs/thread-roles/codex_work_mode_current.md`
- this plan
- `docs/architecture/repository_structure.md`
- `thesis_record_app/test/services/operations/codex_work_mode_contract_test.rb`

## Acceptance Criteria

1. The active repository sources agree on Strategy, unnumbered Planning,
   Control A/B, ephemeral Implementer, exceptional persistent Handoff, and
   Strategy-owned Thread Refresh.
2. Permanent Control/Handoff pairing and numbered builder-thread reincarnation
   are no longer active governance.
3. The implementation packet and snapshot template provide every required
   contract field.
4. The current snapshot records exact observed volatile coordination without
   defining product or runtime behavior.
5. The migration preserves research, evidence, phase-integrity, provider,
   deployment, secret, product, and runtime boundaries.
6. The focused contract test, YAML parse, current-governance residue scan, and
   diff check pass.

## Explicit Non-Goals

Do not create Strategy, Planning, Control, Implementer, or Handoff tasks as
part of this document migration. Do not change a phase, access secrets or
providers, mutate external systems, push, deploy, publish, or resolve
approvals.
