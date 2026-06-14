---
record_id: return-2026-06-11-empirical-strategy
record_type: return
workflow_id: 2026-06-11-empirical-strategy
status: completed
created_at: 2026-06-11T14:00:18+08:00
owner: Research
---

# Return: Empirical Strategy

## Scope

This Research pass translated the accepted nonemployer and firm-boundary
evidence base into testable empirical designs. It did not run quantitative
analysis and did not add paper prose.

`paper/draft.md` was not edited.

## Files Changed

- `research/empirical_strategy.md`
- `research/predictions.md`
- `paper/evidence_requirements.md`
- `docs/operator/returns/2026-06-11-empirical-strategy-return.md`

## Strategy Added

Added `research/empirical_strategy.md` with:

- data-source roles for BTOS, Bonney et al. 2026, NES, AIES-NES, SUSB, BDS,
  BFS, and Bick/Blandin/Deming 2024;
- AI-exposure hierarchy, preferring observed BTOS employer-business AI adoption
  over theoretical occupation-exposure measures;
- test designs for TCE-P001, TCE-P007, TCE-P009, and TCE-P010;
- blocked-data sections for TCE-P005 management-layer evidence and
  employer-to-vendor substitution;
- explicit weak-support, supported, and disconfirmation thresholds.

## Prediction Updates

`research/predictions.md` now records:

- TCE-P001 can be tested only as a sector-panel design until direct business
  AI-use linkage exists.
- TCE-P007 can use BFS employer formations and BDS employer startups only as
  indirect payroll-transition proxies.
- TCE-P009 can use NES counts, receipt-size classes, BFS applications, and BDS
  employer dynamics, but direct nonemployer survival linked to AI remains
  missing.
- TCE-P010 can compare NES/AIES-NES nonemployer revenue share against SUSB/BDS
  employer baselines in high-AI-exposure sectors.
- TCE-P005 remains blocked until direct management-layer data is verified.

## Evidence Requirements Updated

`paper/evidence_requirements.md` now points to the empirical strategy and adds
guardrails:

- do not treat nonemployer receipt growth as Operator Node evidence without AI
  exposure, hidden-labor, sector-comparability, and durability checks;
- do not treat BFS employer formation as proof that nodes became firms;
- do not treat worker-level GenAI adoption as firm-boundary change.

## Source Handling

No new source was promoted to source truth in this pass.

The strategy uses already accepted measurement sources from the prior slice:

- Census NES/AIES-NES;
- Census BFS;
- Census BDS;
- Census SUSB;
- Bick, Blandin, and Deming 2024 only as worker-level GenAI adoption context;
- BTOS and Bonney et al. 2026 only as employer-business AI adoption and
  diffusion context.

Candidate occupation-exposure papers remain outside accepted source truth until
separately verified and approved.

## Remaining Gaps

- No direct AI-use linkage to nonemployer receipts, survival, churn, or
  high-receipt one-human businesses.
- No direct nonemployer-to-employer conversion evidence.
- No direct employer-to-vendor or employer-to-contractor substitution evidence
  caused by AI.
- No direct management-layer evidence after AI adoption.
- No verified occupational GenAI exposure source has been accepted for
  NAICS-weighted sector exposure.

## Verification Commands

Run after editing:

```bash
git diff -- paper/draft.md
git diff --check
rg -n "TCE-P001|TCE-P005|TCE-P007|TCE-P009|TCE-P010|weak support|supported|contradicted" research/empirical_strategy.md research/predictions.md paper/evidence_requirements.md
rg -n "Operator Node evidence|BFS employer formation|worker-level GenAI adoption|management-layer" research/empirical_strategy.md paper/evidence_requirements.md
```

Expected results:

- `paper/draft.md` should show no diff.
- `git diff --check` should pass.
- Strategy terms should appear in research/evidence-gate files only.

## Commit Recommendation

Do not commit until the user or Company Operator accepts the strategy slice.
