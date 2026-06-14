---
record_id: handoff-2026-06-11-tce-anchor-fulltext-reinspection
record_type: handoff
workflow_id: 2026-06-11-tce-anchor-fulltext-reinspection
status: ready
created_at: 2026-06-11T03:20:00+08:00
owner: Company Operator
target_thread: Research
---

# Handoff: TCE Anchor Full-Text Reinspection

## Role

You are the Research thread for the Operator Node Economics repository.

Work in:

```text
/Users/jimmy1768/Projects/operator-node-economics
```

This task is a source-quality hardening pass, not a new theory pass.

## Read First

- `docs/operator/acceptances/2026-06-11-transaction-cost-economics-research-acceptance.md`
- `docs/operator/acceptances/2026-06-11-writer-outline-architecture-acceptance.md`
- `paper/evidence_requirements.md`
- `paper/argument_map.md`
- `research/areas/03-transaction-cost-economics.md`
- `research/claims_index.md`
- `research/source_notes/coase_1937_nature_of_the_firm.md`
- `research/source_notes/williamson_1991_comparative_economic_organization.md`
- `research/source_notes/williamson_2009_nobel_transaction_cost_economics.md`
- `research/source_notes/macher_richman_2008_tce_empirical_assessment.md`
- `research/source_notes/powell_1990_network_forms.md`

## Task

Directly reinspect the full text or available authoritative text for the core
theoretical anchors:

1. Ronald H. Coase, "The Nature of the Firm" (1937).
2. Oliver E. Williamson, "Comparative Economic Organization" (1991).
3. Oliver E. Williamson, "Transaction Cost Economics: The Natural Progression"
   (2009/2010).
4. Jeffrey T. Macher and Barak D. Richman, "Transaction Cost Economics: An
   Assessment of Empirical Research in the Social Sciences" (2008).
5. Walter W. Powell, "Neither Market Nor Hierarchy" (1990).

## Required Updates

For each inspected source note:

- update verification status if needed;
- add `Direct Reinspection` section;
- record exact pages or sections inspected;
- add short compliant quotations only when useful;
- identify claims that are safe for prose versus claims still needing caution;
- identify interpretations that were weakened or corrected by direct reading.

Then update:

- `research/areas/03-transaction-cost-economics.md`
- `research/claims_index.md`
- `research/criticisms.md` if needed
- `paper/evidence_requirements.md`

## Hard Boundaries

- Do not edit `paper/draft.md`.
- Do not write paper prose.
- Do not write conclusions.
- Do not write manifesto language.
- Do not use philosophical or religious foundations, or related
  philosophical traditions as foundations.
- Do not promote a claim unless the inspected source actually supports it.
- Do not use source notes marked `unverified_from_deep_research_return` as
  support.
- No commit or push unless explicitly approved.

## Verification Required

Run:

```bash
git diff -- paper/draft.md
rg -n "philosophical|religious" docs research paper
rg -n "manifesto|conclusion|conclusions" research paper docs/operator/returns
rg -n "Direct Reinspection|Status:" research/source_notes/coase_1937_nature_of_the_firm.md research/source_notes/williamson_1991_comparative_economic_organization.md research/source_notes/williamson_2009_nobel_transaction_cost_economics.md research/source_notes/macher_richman_2008_tce_empirical_assessment.md research/source_notes/powell_1990_network_forms.md
git diff --check
```

## Return Required

Write a return record under `docs/operator/returns/` with:

- sources directly reinspected;
- files changed;
- claims strengthened;
- claims weakened or corrected;
- direct-text evidence added;
- remaining source gaps;
- whether `paper/draft.md` remained untouched;
- exact verification performed.

## Expected Outcome

After this slice, the Writer should know which TCE/network claims are safe for
future prose and which remain architecture-only.
