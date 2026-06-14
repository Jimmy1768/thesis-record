---
record_id: return-2026-06-11-ai-adoption-firm-boundary-evidence
record_type: return
workflow_id: 2026-06-11-ai-adoption-firm-boundary-evidence
status: completed
created_at: 2026-06-11T11:46:33+08:00
owner: Research
---

# Return: AI Adoption And Firm-Boundary Evidence

## Sources Directly Verified

- Brynjolfsson, Li, and Raymond 2025, "Generative AI at Work":
  verified_primary_source. Directly inspected QJE/OUP full-text page and DOI
  metadata. Usable for task-productivity, training/learning, customer
  escalation, and single-firm limitation claims; not usable for firm-boundary
  claims.
- Dell'Acqua et al. 2026, "Navigating the Jagged Technological Frontier":
  verified_primary_source. Directly inspected Organization Science/INFORMS
  full-text page and DOI 10.1287/orsc.2025.21838. Updated the source note from
  HBS working paper to final journal article. Usable for task-productivity and
  verification/correctness-risk claims; not usable for firm-boundary claims.
- Noy and Zhang 2023, "Experimental Evidence on the Productivity Effects of
  Generative Artificial Intelligence": verified_primary_source for final DOI
  metadata. Crossref and OpenAlex verify the Science article, DOI
  10.1126/science.adh2586, volume/issue/pages, authors, and abstract. The
  Science page was not accessible from this environment, so the MIT working
  paper remains the inspected full-text basis for design/detail.
- U.S. Census Bureau, "AI Use at U.S. Businesses," May 26, 2026:
  verified_primary_source. Directly inspected Census.gov America Counts
  article, BTOS program page, and AI-supplement questionnaire PDF. Usable only
  for employer-business AI adoption by firm size/sector and question wording.

## Sources Replaced Or Downgraded

- Federal Reserve FEDS Notes, "Monitoring AI Adoption in the US Economy":
  marked citation_needs_correction. Exact title, author, FEDS Notes,
  FederalReserve.gov domain, and broad web searches did not verify the source.
  It remains excluded from claim support.
- OECD, "The Effects of Generative AI on Productivity, Innovation and
  Entrepreneurship": marked citation_needs_correction. Exact title, author,
  OECD.org, and OECD iLibrary searches did not verify the source. It remains
  excluded from claim support.
- Census 2026 was corrected from unverified to verified_primary_source, but
  its evidentiary use was narrowed to adoption-by-size. It does not support
  productivity capture or firm-boundary claims.

## Files Changed

- `research/source_notes/brynjolfsson_li_raymond_2025_generative_ai_at_work.md`
- `research/source_notes/dellacqua_et_al_2023_jagged_frontier.md`
- `research/source_notes/noy_zhang_2023_productivity_effects_gen_ai.md`
- `research/source_notes/census_2026_ai_use_us_businesses.md`
- `research/source_notes/fed_2026_monitoring_ai_adoption.md`
- `research/source_notes/oecd_2025_gen_ai_productivity_innovation_entrepreneurship.md`
- `research/claims_index.md`
- `research/predictions.md`
- `research/criticisms.md`
- `research/open_questions.md`
- `research/areas/03-transaction-cost-economics.md`
- `paper/evidence_requirements.md`
- `research/reading_queue.md`
- `docs/operator/returns/2026-06-11-ai-adoption-firm-boundary-evidence-return.md`

`paper/references.bib` was not changed because it had no existing entries to
correct and no paper prose was being prepared.

## Claims Strengthened, Weakened, Or Left Unchanged

- TCE-CLAIM-003 left supported, but explicitly narrowed: the verified evidence
  supports task-productivity and the lack of direct boundary evidence, not an
  Operator Node performance result.
- TCE-CLAIM-006 changed from a broad corporate-absorption criticism to weak
  support for a narrower adoption-by-size criticism. Census BTOS supports
  larger employer firms reporting higher AI use than the smallest employer
  firms; it does not support productivity capture or boundary change.
- TCE-CLAIM-007 left supported with stronger source basis: Dell'Acqua et al.
  now uses final Organization Science evidence for outside-frontier correctness
  decline, and Brynjolfsson uses directly inspected QJE full text.
- C001, C002, and C003 left as hypotheses. No verified empirical source in this
  pass directly supports them.

## Predictions Updated

- `research/predictions.md` now lists BTOS as a data source candidate.
- Added current evidence status separating task-productivity evidence,
  transaction-cost evidence, firm-boundary evidence, and TCE-P006
  adoption-by-size support.
- No prediction was promoted to accepted.

## Evidence Gaps Remaining

- Direct firm-boundary evidence: nonemployer receipts, revenue per human,
  outsourcing share, management-layer change, market concentration, and
  node-to-firm transitions.
- Direct transaction-cost evidence: search, contracting, monitoring, dispute,
  enforcement, procurement, payment, liability, and rework costs.
- Adoption-to-outcome linkage: verified AI adoption measures need linkage to
  revenue, employment, productivity, survival, and concentration outcomes by
  firm size.
- Platform-governance evidence: escrow, arbitration, reputation, insurance,
  certification, audit-log, SLA, and payment-system effects on dispute and
  enforcement costs.

## Evidence Separation

Task-productivity evidence was kept separate from transaction-cost evidence
and firm-boundary evidence.

- Task productivity: Brynjolfsson/QJE, Dell'Acqua/Organization Science, and
  Noy-Zhang/Science DOI plus MIT working paper.
- Transaction costs: no direct market-transaction evidence verified in this
  pass; only limited internal escalation or verification-risk proxies.
- Firm boundaries: no direct verified boundary-change evidence; Census is
  adoption-by-size evidence for employer businesses only.

## Paper Draft Status

`paper/draft.md` remained untouched.

## Exact Verification Performed

- Read the handoff and required source-truth files from the workspace.
- Opened QJE/OUP DOI page for Brynjolfsson, Li, and Raymond 2025 and inspected
  abstract, introduction, setting, findings, and limitation language.
- Opened HBS working-paper page and Organization Science/INFORMS DOI page for
  Dell'Acqua et al.; verified final article metadata, abstract, publication
  date, DOI, volume/issue/pages, and study findings.
- Queried Crossref and OpenAlex for DOI 10.1126/science.adh2586; verified the
  final Science bibliographic record and abstract.
- Opened Census.gov America Counts page for "AI Use at U.S. Businesses," BTOS
  program page, and the AI-supplement questionnaire PDF; inspected firm-size
  adoption findings, survey coverage, and AI question wording.
- Searched exact title, author, domain-restricted, and broad web queries for
  the Federal Reserve and OECD citations; no primary or corrected source was
  found.
- Ran handoff verification commands after editing.

## Source Links Used

- https://doi.org/10.1093/qje/qjae044
- https://doi.org/10.1287/orsc.2025.21838
- https://www.hbs.edu/faculty/Pages/item.aspx?num=64700
- https://api.crossref.org/works/10.1126/science.adh2586
- https://api.openalex.org/works/https://doi.org/10.1126/science.adh2586
- https://www.census.gov/library/stories/2026/05/ai-use-businesses.html
- https://www.census.gov/programs-surveys/btos.html
- https://www2.census.gov/data/experimental-data-products/business-trends-and-outlook-survey/questionnaire-ai-supplement.pdf
