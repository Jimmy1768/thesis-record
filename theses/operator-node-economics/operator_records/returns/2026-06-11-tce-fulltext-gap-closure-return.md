---
record_id: return-2026-06-11-tce-fulltext-gap-closure
record_type: return
workflow_id: 2026-06-11-tce-fulltext-gap-closure
status: complete_with_gaps_preserved
created_at: 2026-06-11T02:56:59+08:00
owner: Research
source_handoff: docs/operator/handoffs/2026-06-11-tce-fulltext-gap-closure-handoff.md
---

# TCE Full-Text Gap Closure Return

## Williamson 1991 Access Paths Tried

Target: Oliver E. Williamson, "Comparative Economic Organization: The Analysis
of Discrete Structural Alternatives," *Administrative Science Quarterly* 36(2),
1991.

Access paths:

- JSTOR stable page: `https://www.jstor.org/stable/2393356`; accessible only
  as metadata/image shell in this environment.
- JSTOR direct PDF endpoint:
  `https://www.jstor.org/stable/pdf/2393356.pdf`; returned `403 text/html`.
- CADIA university-hosted PDF pointer cited by German Wikipedia:
  `https://cadia.ru.is/wiki/_media/public:economic-organization-williamson.pdf`;
  normal `curl` failed with code 35; escalated and TLS-relaxed attempts also
  failed with code 35.
- Crossref API for DOI `10.2307/2393356`; verified metadata/JSTOR primary URL,
  but no full text or PDF.
- OpenAlex API for DOI `10.2307/2393356`; verified metadata/abstract, but
  reported no full text, no PDF URL, no OA URL, and no repository full text.
- Semantic Scholar API for DOI `10.2307/2393356`; reported `openAccessPdf`
  status `CLOSED`.
- Web searches for exact title, PDF variants, the CADIA filename, and
  distinctive title phrases found no usable public full text.

Full text obtained: no.

## Macher/Richman 2008 Access Paths Tried

Target: Jeffrey T. Macher and Barak D. Richman, "Transaction Cost Economics:
An Assessment of Empirical Research in the Social Sciences," *Business and
Politics* 10(1), 2008.

Access paths:

- DOI/Cambridge page: `https://doi.org/10.2202/1469-3569.1210`; redirected to
  Cambridge abstract/access page with metadata, abstract, references, and
  `Get access`.
- Cambridge article URL without `/abs/`; redirected back to the abstract/access
  page.
- Cambridge direct PDF-style endpoint using article hash
  `F8A15284520F07A0421F5752EBB6C773`; returned `200 text/html`, not a PDF.
- Crossref metadata for DOI `10.2202/1469-3569.1210`; verified metadata,
  abstract, references, footnotes, and Cambridge content identifier
  `S1369525800003508`, but no full-text article body.
- Cambridge content-view URL from Crossref,
  `https://www.cambridge.org/core/services/aop-cambridge-core/content/view/S1369525800003508`;
  returned `200 text/html`, not article full text/PDF.
- OpenAlex API for DOI `10.2202/1469-3569.1210`; reported closed access, no
  PDF URL, no OA URL, and `any_repository_has_fulltext: false`.
- Semantic Scholar API for DOI `10.2202/1469-3569.1210`; reported
  `openAccessPdf` status `CLOSED`.
- Web searches for exact title, DOI, author/title combinations, and distinctive
  abstract phrases found no usable public full text.

Full text obtained: no.

## Files Changed

- `research/source_notes/williamson_1991_comparative_economic_organization.md`
- `research/source_notes/macher_richman_2008_tce_empirical_assessment.md`
- `research/areas/03-transaction-cost-economics.md`
- `paper/evidence_requirements.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-11-tce-fulltext-gap-closure-return.md`

## Claims Strengthened, Weakened, Or Left Unchanged

- No claims were strengthened.
- No claims were promoted from `weak support` or `needs refinement`.
- TCE-CLAIM-002 remains `weak support`; Williamson 1991-specific support is
  still full-text-pending.
- TCE-CLAIM-004 remains `supported` only through directly inspected Williamson
  2009/2010 plus Macher/Richman abstract-level support; detailed empirical
  claims from Macher/Richman remain excluded.
- TCE-CLAIM-005 remains `needs refinement`; Powell 1990's network-form
  distinction remains preserved.
- TCE-CLAIM-009 remains `weak support`; no Williamson 1991 reputation claim was
  promoted.
- TCE-CLAIM-010 remains `weak support`; no Williamson 1991 hybrid-disturbance
  claim was promoted.

## Remaining Source Gaps

- Williamson 1991 full text remains inaccessible. Do not use this source for
  market/hybrid/hierarchy tables, reputation effects, or hybrid disturbance-
  adaptation claims until full text is obtained.
- Macher/Richman 2008 full text remains inaccessible. Do not use this source
  for page-level claims about empirical counts, methods, construct validity,
  opportunism measurement, or endogeneity until full text is obtained.

## Paper Draft Status

`paper/draft.md` remained untouched.

## Exact Verification Performed

Required commands:

- `git diff -- paper/draft.md`
- `git diff --check`
- `rg -n "Status:|Full text|Direct Reinspection|Access" research/source_notes/williamson_1991_comparative_economic_organization.md research/source_notes/macher_richman_2008_tce_empirical_assessment.md`
- `rg -n "Williamson 1991|Macher|Richman|TCE-CLAIM-00[2459]|TCE-CLAIM-010" research/claims_index.md research/areas/03-transaction-cost-economics.md paper/evidence_requirements.md research/reading_queue.md`
- `rg -n "philosophical|religious" docs research paper`
- `rg -n "manifesto|conclusion|conclusions|obsolete|firm is dead|end of the firm" research paper docs/operator/returns`

Additional checks:

- `git status --short`
- Local workspace searches for existing PDFs or local source copies.
- Crossref, OpenAlex, Semantic Scholar, JSTOR, Cambridge, and CADIA access
  attempts listed above.

Verification results:

- `git diff -- paper/draft.md`: no output; draft file remained untouched.
- `git diff --check`: no output.
- Source-note scan confirmed both target notes retain full-text-pending
  statuses and now include access-path/full-text outcome records.
- Claim/evidence scan confirmed current claims remain weakened or pending where
  Williamson 1991 or Macher/Richman full text is still missing.
- Prohibited-foundation scan returned existing handoff/source-truth/checklist
  text and verification-command listings only.
- Manifesto/conclusion/obsolete scan returned existing outline/argument-map
  guardrails, source-note README guidance, a pre-existing Macher/Richman note
  boundary sentence, and verification-command listings only.

No commit or push was performed.
