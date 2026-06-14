---
record_id: return-2026-06-11-direct-empirical-gap-closure
record_type: return
workflow_id: 2026-06-11-direct-empirical-gap-closure
status: completed
created_at: 2026-06-11T11:54:28+08:00
owner: Research
---

# Return: Direct Empirical Gap Closure

## Scope

This pass proceeded directly without a new Company Operator handoff. It focused
on firm-boundary, transaction-cost, and platform-governance evidence gaps.
`paper/draft.md` was not edited.

## Sources Directly Verified

- Bonney, Breaux, Dinlersoz, Foster, Haltiwanger, and Pande 2026, "The
  Microstructure of AI Diffusion": Census CES working-paper page and PDF
  directly inspected. This is the strongest current source for employer-firm AI
  diffusion, large-firm concentration, functional/task-use breadth,
  augmentation/substitution, and employment-effect survey responses.
- Arledge 2025, "How AI and Other Technology Impacted Businesses and Workers":
  Census America Counts article directly inspected. This adds employer-business
  workforce-impact evidence from 2023 ABS/2022 data.
- Resnick, Zeckhauser, Swanson, and Lockwood 2006, "The Value of Reputation on
  eBay": Cambridge publisher metadata, abstract, citation, and DOI directly
  inspected. Full text remains pending.
- Pallais 2014, "Inefficient Hiring in Entry-Level Labor Markets": AEA article
  page, abstract, citation, DOI, and PDF link directly inspected.

## Claims Updated

- TCE-CLAIM-006 remains weak support, but now rests on both the Census 2026
  America Counts/BTOS source and Bonney et al. 2026 CES evidence for larger
  employer-firm AI adoption.
- TCE-CLAIM-009 remains weak support, now with direct platform reputation and
  evaluation evidence added for the narrower information-friction mechanism.
- TCE-CLAIM-011 added: current official Census evidence does not show broad
  AI-driven employer-firm headcount shrinkage; early AI diffusion appears
  mostly augmenting, concentrated in larger employer firms, and weakly
  connected to firm-boundary change.
- TCE-CLAIM-012 added as weak support: platform reputation and public
  evaluation systems can reduce some market information and trust frictions,
  but they do not solve contracting, enforcement, liability, or entry-barrier
  problems.

## Predictions Updated

- `research/predictions.md` now records that P001/P005-style hierarchy or
  headcount-shrinkage predictions face early disconfirming pressure from
  Census employer-firm evidence.
- TCE-P004 still lacks AI-specific transaction-cost evidence.
- TCE-P008 now has partial non-AI platform-governance support for reputation
  and public evaluation mechanisms, while escrow, arbitration, insurance,
  certification, audit-log, SLA, payment-delay, and dispute-resolution evidence
  remain open.
- TCE-P001, TCE-P002, TCE-P005, TCE-P007, TCE-P009, and TCE-P010 still lack
  direct nonemployer, outsourcing, management-layer, concentration, or
  node-to-firm transition evidence.

## Evidence Gaps Remaining

- Direct nonemployer AI evidence: receipts, survival, churn, revenue per human,
  and transition into employer firms.
- Direct transaction-cost evidence for AI-enabled one-person suppliers:
  search, contracting, monitoring, dispute, enforcement, procurement, payment,
  liability, and rework costs.
- Management-layer evidence: span of control, manager-to-worker ratios,
  support-staff ratios, and org-chart depth after AI adoption.
- AI-specific platform governance: escrow, arbitration, insurance,
  certification, audit logs, SLAs, payment systems, dispute outcomes, and
  repeat-client outcomes for AI-enabled suppliers.
- Causal adoption-to-outcome evidence: Bonney et al. 2026 is explicitly
  associational, not causal.

## Files Changed

- `research/source_notes/bonney_et_al_2026_microstructure_ai_diffusion.md`
- `research/source_notes/arledge_2025_technology_impact_businesses_workers.md`
- `research/source_notes/resnick_et_al_2006_value_reputation_ebay.md`
- `research/source_notes/pallais_2014_inefficient_hiring_entry_level_labor_markets.md`
- `research/claims_index.md`
- `research/predictions.md`
- `research/criticisms.md`
- `research/open_questions.md`
- `research/areas/03-transaction-cost-economics.md`
- `paper/evidence_requirements.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-11-direct-empirical-gap-closure-return.md`

## Paper Draft Status

`paper/draft.md` remained untouched.

## Exact Verification Performed

- Opened Census "AI Use at U.S. Businesses" and followed its working-paper link
  to the Census CES page for "The Microstructure of AI Diffusion."
- Opened and inspected the Census CES PDF for Bonney et al. 2026.
- Opened the Census related America Counts article "How AI and Other
  Technology Impacted Businesses and Workers."
- Opened Cambridge DOI/publisher page for Resnick et al. 2006.
- Opened AEA article page for Pallais 2014.
- Ran repository verification commands after editing.

## Source Links Used

- https://www.census.gov/library/working-papers/2026/adrm/CES-WP-26-25.html
- https://www2.census.gov/library/working-papers/2026/adrm/ces/CES-WP-26-25.pdf
- https://www.census.gov/library/stories/2025/09/technology-impact.html
- https://doi.org/10.1007/s10683-006-4309-2
- https://www.aeaweb.org/articles?id=10.1257/aer.104.11.3565

## Checkpoint Recommendation

This pass is ready for a later Company Operator checkpoint if the next phase is
claim acceptance or Writer architecture/prose. It is not necessary for Company
Operator to review before another narrow evidence pass.
