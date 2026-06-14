---
record_id: handoff-2026-06-11-tce-fulltext-gap-closure
record_type: handoff
workflow_id: 2026-06-11-tce-fulltext-gap-closure
status: ready
created_at: 2026-06-11T02:50:00+08:00
owner: Company Operator
target_thread: Research
---

# Handoff: TCE Full-Text Gap Closure

## Role

You are the Research thread for the Operator Node Economics repository.

Work in:

```text
/Users/jimmy1768/Projects/operator-node-economics
```

This task is a narrow source-access and claim-hardening pass. It is not a new
theory pass and not a paper-writing pass.

## Read First

- `docs/operator/acceptances/2026-06-11-tce-anchor-fulltext-reinspection-acceptance.md`
- `docs/operator/returns/2026-06-11-tce-anchor-fulltext-reinspection-return.md`
- `paper/evidence_requirements.md`
- `research/claims_index.md`
- `research/areas/03-transaction-cost-economics.md`
- `research/source_notes/williamson_1991_comparative_economic_organization.md`
- `research/source_notes/macher_richman_2008_tce_empirical_assessment.md`

## Task

Close, or explicitly preserve, the two accepted TCE source gaps:

1. Oliver E. Williamson, "Comparative Economic Organization: The Analysis of
   Discrete Structural Alternatives" (1991).
2. Jeffrey T. Macher and Barak D. Richman, "Transaction Cost Economics: An
   Assessment of Empirical Research in the Social Sciences" (2008).

For each source:

- Attempt direct full-text access through legitimate scholarly sources,
  publisher pages, DOI pages, university-hosted PDFs, author pages, public
  repositories, or other reputable sources.
- If full text is obtained, inspect the relevant sections directly and update
  the source note with exact pages or sections.
- If full text remains inaccessible, do not invent support from metadata or
  abstracts. Keep the note full-text-pending and record the access path tried.
- Use short quotations only when they are useful and copyright-compliant.

## Required Updates

Update only where the source evidence justifies it:

- `research/source_notes/williamson_1991_comparative_economic_organization.md`
- `research/source_notes/macher_richman_2008_tce_empirical_assessment.md`
- `research/claims_index.md`
- `research/areas/03-transaction-cost-economics.md`
- `research/criticisms.md` if a verified source changes a criticism
- `paper/evidence_requirements.md`
- `research/reading_queue.md` if a source remains blocked

## Claim Rules

- Do not promote a claim from `weak support` or `needs refinement` unless the
  directly inspected full text supports the promotion.
- If Williamson 1991 remains inaccessible, keep 1991-specific claims marked as
  not directly verified.
- If Macher/Richman 2008 remains inaccessible beyond abstract/metadata, keep
  detailed empirical-method claims out of support columns.
- Preserve the current Coasean relative-cost framing.
- Preserve Powell 1990's distinction between network forms and a simple
  market-hierarchy continuum unless new evidence specifically changes it.

## Hard Boundaries

- Do not edit `paper/draft.md`.
- Do not write paper prose.
- Do not write conclusions.
- Do not write manifesto language.
- Do not use philosophical or religious foundations, or related
  philosophical traditions as foundations.
- Do not use unverified source notes as support for strong claims.
- Do not commit or push.

## Verification Required

Run:

```bash
git diff -- paper/draft.md
git diff --check
rg -n "Status:|Full text|Direct Reinspection|Access" research/source_notes/williamson_1991_comparative_economic_organization.md research/source_notes/macher_richman_2008_tce_empirical_assessment.md
rg -n "Williamson 1991|Macher|Richman|TCE-CLAIM-00[2459]|TCE-CLAIM-010" research/claims_index.md research/areas/03-transaction-cost-economics.md paper/evidence_requirements.md research/reading_queue.md
rg -n "philosophical|religious" docs research paper
rg -n "manifesto|conclusion|conclusions|obsolete|firm is dead|end of the firm" research paper docs/operator/returns
```

## Return Required

Write a return record under `docs/operator/returns/` with:

- access paths tried for Williamson 1991;
- access paths tried for Macher/Richman 2008;
- whether full text was obtained for each;
- files changed;
- claims strengthened, weakened, or left unchanged;
- remaining source gaps;
- whether `paper/draft.md` remained untouched;
- exact verification performed.

## Expected Outcome

After this slice, the repo should either have direct full-text support for the
two remaining TCE sources or an explicit record that those source gaps remain
open. Either outcome is acceptable if the claim index stays honest.
