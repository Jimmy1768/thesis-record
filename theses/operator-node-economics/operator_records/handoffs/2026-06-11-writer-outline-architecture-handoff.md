---
record_id: handoff-2026-06-11-writer-outline-architecture
record_type: handoff
workflow_id: 2026-06-11-writer-outline-architecture
status: ready
created_at: 2026-06-11T02:45:00+08:00
owner: Company Operator
target_thread: Writer
---

# Handoff: Writer Outline Architecture

## Role

You are the Writer thread for the Operator Node Economics repository.

Work in:

```text
/Users/jimmy1768/Projects/operator-node-economics
```

You own paper structure, argument architecture, section sequencing, evidence
requirements, and later prose drafting only after explicit approval.

For this slice, do not write paper prose.

## Read First

Source truth:

- `README.md`
- `docs/source_truth/research_contract.md`
- `docs/source_truth/core_hypothesis.md`
- `docs/source_truth/operator_node_definition.md`
- `docs/source_truth/terminology.md`
- `docs/source_truth/falsifiability_contract.md`
- `docs/source_truth/prohibited_foundations.md`

Research base:

- `research/areas/03-transaction-cost-economics.md`
- `research/claims_index.md`
- `research/criticisms.md`
- `research/predictions.md`
- `docs/operator/acceptances/2026-06-11-transaction-cost-economics-research-acceptance.md`

Paper files:

- `paper/outline.md`
- `paper/draft.md`

## Hard Constraints

- Do not edit `paper/draft.md`.
- Do not write conclusions.
- Do not write manifesto language.
- Do not assume the theory is true.
- Do not use philosophical or religious foundations, or related
  philosophical traditions as foundations.
- Treat unverified source notes as unavailable for strong claims.
- Preserve uncertainty and criticism.
- No commit or push unless explicitly approved.

## Task

Build paper architecture only.

Required outputs:

1. Expand `paper/outline.md` into a scholarly section-level outline.
2. Add `paper/argument_map.md`.
3. Add `paper/evidence_requirements.md`.

## Outline Requirements

The outline should:

- state the research problem without concluding the hypothesis is true;
- separate literature/theory from proposed hypothesis;
- make transaction-cost economics the first theoretical anchor;
- reserve a dedicated criticisms/failure-modes section;
- include a falsifiable predictions section;
- clearly mark sections that are not ready for prose.

## Argument Map Requirements

`paper/argument_map.md` should map:

- proposed section;
- claim or question;
- current evidence status;
- required evidence;
- strongest objection;
- source files to consult.

## Evidence Requirements

`paper/evidence_requirements.md` should list what must be verified before each
major section can become prose, including:

- direct full-text reinspection needs;
- unverified citations to replace or verify;
- data requirements for predictions;
- definition thresholds for Operator Node versus freelancer, firm, and
  corporation.

## Return Required

Write a return record under `docs/operator/returns/` with:

- files changed;
- outline decisions;
- claims intentionally not drafted;
- evidence gaps surfaced;
- whether `paper/draft.md` remained untouched;
- exact verification performed.

## Boundaries

- No prose draft.
- No paper conclusion.
- No manifesto framing.
- No source-note edits unless needed only to correct a pointer typo.
- No research claim promotion.
- No commit or push.
