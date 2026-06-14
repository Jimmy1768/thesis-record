---
record_id: return-2026-06-11-writer-outline-architecture
record_type: return
workflow_id: 2026-06-11-writer-outline-architecture
status: completed
created_at: 2026-06-11T03:00:00+08:00
source_record: docs/operator/handoffs/2026-06-11-writer-outline-architecture-handoff.md
owner: Writer
---

# Return: Writer Outline Architecture

## Files Changed

- `paper/outline.md`
- `paper/argument_map.md`
- `paper/evidence_requirements.md`
- `docs/operator/returns/2026-06-11-writer-outline-architecture-return.md`

## Outline Decisions

- Replaced the placeholder outline with a section-level scholarly architecture.
- Framed the paper around a research question, not a conclusion:
  under what conditions, if any, AI-enabled Operator Nodes could reduce
  market/protocol coordination costs relative to internal firm organization.
- Made transaction-cost economics the first theoretical anchor, before
  Operator Node hypothesis development.
- Separated theory, organizational definitions, current AI evidence, proposed
  hypothesis, mechanisms, protocol networks, boundary conditions, criticisms,
  predictions, and evidence gaps.
- Dedicated a full section to criticisms and failure modes.
- Dedicated a full section to falsifiable predictions and empirical strategy.
- Marked sections with readiness statuses: `architecture only`,
  `partial evidence`, and `not ready for prose`.
- Added evidence gates throughout the outline to prevent unsupported prose.
- Omitted any drafted conclusion. The terminal section is an evidence-gap and
  research-agenda register, explicitly not a conclusion.

## Claims Intentionally Not Drafted

- AI is causing the corporation to decline.
- Operator Nodes are already a dominant or superior organizational form.
- Protocol-based coordination generally replaces hierarchy.
- Large firms are losing AI adoption or productivity advantages.
- Current AI productivity studies prove firm-boundary change.
- Legal corporate form is becoming irrelevant.
- Historical coordination forms imply a necessary future sequence.
- Any normative claim that one organizational form should prevail.

## Evidence Gaps Surfaced

- Coase 1937, Williamson 1991, Williamson 2009/2010, Macher/Richman 2008,
  and Powell 1990 need direct full-text reinspection before prose.
- Noy and Zhang 2023 still needs direct publisher or DOI verification.
- Census 2026, Federal Reserve 2026, OECD 2025, and Joskow 2010 notes remain
  unavailable for strong claims until replaced or verified.
- AI productivity studies must be checked for whether they measure task
  productivity, transaction costs, firm-boundary change, or only proxies.
- Operator Node definition thresholds remain unresolved for employees,
  payroll, managerial layers, dedicated assets, hidden labor, subcontractors,
  institutional memory, protocols, auditability, and output.
- Prediction data sources remain unfilled for many required fields, including
  sector, timeframe, comparison group, confounders, and failure condition.
- Large-firm AI adoption and productivity-capture evidence remains an
  important criticism hypothesis, not a supported claim.
- Protocol-network claims need data on dispute resolution, rework, escrow,
  insurance, arbitration, audit logs, and accountability.

## `paper/draft.md` Status

`paper/draft.md` remained untouched.

## Exact Verification Performed

Read context:

```bash
sed -n '1,240p' docs/operator/handoffs/2026-06-11-writer-outline-architecture-handoff.md
rg --files
sed -n '1,260p' README.md
sed -n '1,260p' docs/source_truth/research_contract.md
sed -n '1,260p' docs/source_truth/core_hypothesis.md
sed -n '1,260p' docs/source_truth/operator_node_definition.md
sed -n '1,260p' docs/source_truth/terminology.md
sed -n '1,260p' docs/source_truth/falsifiability_contract.md
sed -n '1,260p' docs/source_truth/prohibited_foundations.md
sed -n '1,320p' research/areas/03-transaction-cost-economics.md
sed -n '1,360p' research/claims_index.md
sed -n '1,320p' research/criticisms.md
sed -n '1,360p' research/predictions.md
sed -n '1,260p' docs/operator/acceptances/2026-06-11-transaction-cost-economics-research-acceptance.md
sed -n '1,260p' paper/outline.md
sed -n '1,260p' paper/draft.md
rg -n "^Status:|verification|unverified|verified|needs" research/source_notes/*.md
sed -n '1,220p' research/literature_review.md
sed -n '1,220p' research/open_questions.md
sed -n '1,220p' peer_review/reviewer_objections.md
sed -n '1,220p' peer_review/submission_checklist.md
```

Post-edit checks:

```bash
sed -n '1,260p' paper/outline.md
sed -n '1,260p' paper/argument_map.md
sed -n '1,300p' paper/evidence_requirements.md
git diff -- paper/draft.md
rg -n "<prohibited-foundation-terms>" paper/outline.md paper/argument_map.md paper/evidence_requirements.md docs/operator/returns/2026-06-11-writer-outline-architecture-return.md
rg -n "manifesto|conclusion|conclusions" paper/outline.md paper/argument_map.md paper/evidence_requirements.md docs/operator/returns/2026-06-11-writer-outline-architecture-return.md
git diff --check
git status --short
```

Verification results:

- `git diff -- paper/draft.md` returned no output.
- No prohibited-foundation terms appeared in the new paper files.
- `manifesto`, `conclusion`, and `conclusions` appeared only in boundary,
  prohibition, or deferral language.
- `git diff --check` returned no output.
- No commit or push was performed.
