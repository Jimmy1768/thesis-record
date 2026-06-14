---
record_id: handoff-2026-06-11-ai-adoption-firm-boundary-evidence
record_type: handoff
workflow_id: 2026-06-11-ai-adoption-firm-boundary-evidence
status: ready
created_at: 2026-06-11T11:33:00+08:00
owner: Company Operator
target_thread: Research
---

# Handoff: AI Adoption And Firm-Boundary Evidence

## Role

You are the Research thread for the Operator Node Economics repository.

Work in:

```text
/Users/jimmy1768/Projects/operator-node-economics
```

This is an empirical evidence pass. The TCE theoretical anchor is now strong
enough for governance framing. The next question is whether empirical evidence
supports, weakens, or fails to reach the Operator Node hypothesis.

## Read First

- `docs/source_truth/research_contract.md`
- `docs/source_truth/core_hypothesis.md`
- `docs/source_truth/falsifiability_contract.md`
- `docs/source_truth/operator_node_definition.md`
- `paper/evidence_requirements.md`
- `paper/argument_map.md`
- `research/claims_index.md`
- `research/predictions.md`
- `research/criticisms.md`
- `research/open_questions.md`
- Existing source notes under `research/source_notes/`

## Task

Build a verified empirical evidence base for AI adoption, task productivity,
transaction costs, and firm-boundary change.

The key distinction:

- Task-productivity evidence can show AI improves work speed or quality.
- Transaction-cost evidence must show effects on search, contracting,
  monitoring, coordination, dispute, trust, procurement, enforcement,
  verification, liability, or rework costs.
- Firm-boundary evidence must show effects on firm size, nonemployer share,
  outsourcing, management layers, revenue per human, business formation,
  concentration, or transitions between one-person nodes and firms.

Do not treat task-productivity evidence as firm-boundary evidence unless the
study directly measures a firm-boundary or transaction-cost outcome.

## Priority Sources To Verify Or Replace

Directly verify, replace, or downgrade these current notes:

- Brynjolfsson, Li, and Raymond 2025 on generative AI at work.
- Dell'Acqua et al. 2023 on the jagged frontier.
- Noy and Zhang 2023; direct publisher or DOI verification is still needed.
- Census 2026 AI-use note; currently unverified.
- Federal Reserve 2026 AI-adoption note; currently unverified.
- OECD 2025 generative-AI/productivity/entrepreneurship note; currently
  unverified.

Also search for better accessible replacements if current citations are weak,
unavailable, or not directly relevant.

## Evidence Questions

Answer these with evidence status, not prose conclusions:

1. What does verified AI productivity evidence actually measure?
2. Do any sources measure transaction-cost effects rather than task outputs?
3. Do any sources measure firm-boundary effects: nonemployer growth, firm size,
   outsourcing, management layers, concentration, or small-vs-large adoption?
4. Is there evidence that corporations adopt or absorb AI faster than
   one-person or very small firms?
5. Is there evidence that AI lowers market/protocol coordination costs more
   than it lowers internal firm coordination costs?
6. What evidence exists for platform, escrow, arbitration, insurance,
   certification, audit-log, SLA, reputation, or payment systems reducing
   transaction costs?
7. What evidence would directly disconfirm the Operator Node hypothesis?

## Required Updates

Update only where evidence justifies it:

- `research/source_notes/`
- `research/claims_index.md`
- `research/predictions.md`
- `research/criticisms.md`
- `research/open_questions.md`
- `paper/evidence_requirements.md`
- `research/reading_queue.md`
- `paper/references.bib` if bibliographic entries are added or corrected

Write a return record under `docs/operator/returns/`.

## Claim Rules

- Keep task-productivity, transaction-cost, and firm-boundary evidence
  separate.
- Do not promote C001, C002, C003, TCE-CLAIM-003, TCE-CLAIM-006, or any
  prediction unless verified evidence supports that specific level of claim.
- If a source is inaccessible, unverifiable, or only indirectly relevant, mark
  it as such.
- Prefer official agency pages, DOI/publisher pages, working-paper PDFs from
  authors/institutions, reputable peer-reviewed journals, and transparent
  datasets.
- Preserve disconfirming evidence and large-firm advantage evidence.
- Do not cite media summaries as primary support when primary data or papers
  are available.

## Hard Boundaries

- Do not edit `paper/draft.md`.
- Do not write paper prose.
- Do not write conclusions for the paper.
- Do not write manifesto language.
- Do not use philosophical or religious foundations, or related
  philosophical traditions as foundations.
- Do not assume the Operator Node hypothesis is true.
- Do not commit or push.

## Verification Required

Run:

```bash
git diff -- paper/draft.md
git diff --check
rg -n "Status:" research/source_notes
rg -n "unverified|needs verification|needs refinement|weak support|supported" research/claims_index.md research/predictions.md research/criticisms.md paper/evidence_requirements.md
rg -n "task productivity|transaction-cost|transaction cost|firm-boundary|firm boundary|nonemployer|adoption|management layer|coordination cost" research paper
rg -n "philosophical|religious" docs research paper
rg -n "manifesto|conclusion|conclusions|obsolete|firm is dead|end of the firm" research paper docs/operator/returns
```

If web/source verification requires browser access, include source links in the
return.

## Return Required

Return with:

- sources directly verified;
- sources replaced or downgraded;
- files changed;
- claims strengthened, weakened, or left unchanged;
- predictions updated;
- evidence gaps remaining;
- whether task-productivity evidence was kept separate from transaction-cost
  and firm-boundary evidence;
- whether `paper/draft.md` remained untouched;
- exact verification performed;
- source links used.

## Expected Outcome

After this slice, the repo should know whether the empirical base is ready for
Writer architecture refinement or whether more research is needed before any
paper prose begins.
