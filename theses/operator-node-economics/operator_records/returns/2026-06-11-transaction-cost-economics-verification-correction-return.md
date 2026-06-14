---
record_id: return-2026-06-11-transaction-cost-economics-verification-correction
record_type: return
workflow_id: 2026-06-11-transaction-cost-economics-research
status: complete
created_at: 2026-06-11T02:19:51+08:00
owner: Research
source_handoff: docs/operator/handoffs/2026-06-11-transaction-cost-economics-research-handoff.md
corrects_return: docs/operator/returns/2026-06-11-transaction-cost-economics-research-return.md
---

# Correction Return: Source Verification Status

## Correction Summary

The original return created source notes from the attached Deep Research return.
This correction pass added explicit verification status to each source note and
downgraded claims that depended on unverified current-source citations.

The source notes should now be read as follows:

- verified source existence and bibliographic metadata where available;
- direct full-text inspection only where the verification note says it occurred;
- Deep Research memo-derived substantive notes remain provisional until direct
  full-text reinspection.

## Sources Verified

- Ronald H. Coase, "The Nature of the Firm" - verified_primary_source via JSTOR
  bibliographic record.
- Oliver E. Williamson, "Comparative Economic Organization" -
  verified_primary_source via JSTOR bibliographic record.
- Oliver E. Williamson, "Transaction Cost Economics: The Natural Progression" -
  verified_primary_source via American Economic Association article page, DOI
  10.1257/aer.100.3.673.
- Jeffrey T. Macher and Barak D. Richman, "Transaction Cost Economics: An
  Assessment of Empirical Research in the Social Sciences" -
  verified_primary_source via Cambridge Core/DOI record,
  DOI 10.2202/1469-3569.1210.
- Walter W. Powell, "Neither Market Nor Hierarchy" - verified_primary_source
  via Stanford/author-hosted PDF.
- Erik Brynjolfsson, Danielle Li, and Lindsey R. Raymond, "Generative AI at
  Work" - verified_primary_source via Oxford Academic/QJE page, DOI
  10.1093/qje/qjae044.
- Fabrizio Dell'Acqua et al., "Navigating the Jagged Technological Frontier" -
  verified_primary_source via Harvard Business School working-paper page.
- IRS, "Independent Contractor Defined" - verified_primary_source via IRS.gov,
  page last reviewed or updated 01-Jun-2026.
- SBA, "Table of size standards" - verified_primary_source via SBA.gov, last
  updated December 26, 2024.
- BLS electronically mediated work source - corrected and verified via BLS
  Monthly Labor Review, "Electronically mediated work: new questions in the
  Contingent Worker Supplement," September 2018, DOI 10.21916/mlr.2018.24.

## Sources Verified As Secondary Or Partial

- Shakked Noy and Whitney Zhang - verified_secondary_source. MIT-hosted
  working-paper PDF was inspected and verifies the title, authors, design, and
  pre-publication results. The final *Science* DOI/publisher page still needs
  direct verification.
- Cornell Legal Information Institute/Wex "corporations" and "LLC" -
  verified_secondary_source because Wex is a legal encyclopedia, not a primary
  legal authority.

## Sources Unverified Or Needing Correction

- U.S. Census Bureau, "AI Use at U.S. Businesses," May 26, 2026 -
  unverified_from_deep_research_return. Targeted searches did not locate the
  exact Census.gov source.
- Federal Reserve FEDS Notes, "Monitoring AI Adoption in the US Economy,"
  April 3, 2026 - unverified_from_deep_research_return. Targeted searches did
  not locate the exact FederalReserve.gov source.
- OECD, "The Effects of Generative AI on Productivity, Innovation and
  Entrepreneurship," 2025 - unverified_from_deep_research_return. Targeted
  searches did not locate the exact OECD/OECD iLibrary source.
- Paul L. Joskow, "Vertical Integration," April 22, 2010 MIT-hosted draft -
  unverified_from_deep_research_return. Targeted searches did not locate the
  exact MIT-hosted draft or corrected publication record.
- BLS, "Tracking the Changing Nature of Work: The Process Continues," 2019 -
  citation corrected. The exact title was not verified; the source note now
  uses the verified 2018 BLS Monthly Labor Review article for the
  electronically mediated work and gig-definition claims.

## Claims Downgraded Or Refined

- TCE-CLAIM-006 was downgraded from `supported` to `needs refinement` because
  its support depended on the unverified Census 2026 and Federal Reserve 2026
  citations.
- TCE-CLAIM-003 remains `supported`, but OECD 2025 was removed from supporting
  evidence and marked as unverified in the notes.
- TCE-CLAIM-005 remains `supported`, but Joskow 2010 was removed from
  supporting evidence and marked as pending verification in the notes.
- TCE-CLAIM-007 remains `supported`, but OECD 2025 was removed from supporting
  evidence and marked as unverified in the notes.

## Files Changed

- research/source_notes/bls_2019_changing_nature_of_work.md
- research/source_notes/brynjolfsson_li_raymond_2025_generative_ai_at_work.md
- research/source_notes/census_2026_ai_use_us_businesses.md
- research/source_notes/coase_1937_nature_of_the_firm.md
- research/source_notes/cornell_wex_corporations_llc.md
- research/source_notes/dellacqua_et_al_2023_jagged_frontier.md
- research/source_notes/fed_2026_monitoring_ai_adoption.md
- research/source_notes/irs_2026_independent_contractor_defined.md
- research/source_notes/joskow_2010_vertical_integration.md
- research/source_notes/macher_richman_2008_tce_empirical_assessment.md
- research/source_notes/noy_zhang_2023_productivity_effects_gen_ai.md
- research/source_notes/oecd_2025_gen_ai_productivity_innovation_entrepreneurship.md
- research/source_notes/powell_1990_network_forms.md
- research/source_notes/sba_2024_size_standards.md
- research/source_notes/williamson_1991_comparative_economic_organization.md
- research/source_notes/williamson_2009_nobel_transaction_cost_economics.md
- research/claims_index.md
- research/areas/03-transaction-cost-economics.md
- research/criticisms.md
- docs/operator/returns/2026-06-11-transaction-cost-economics-verification-correction-return.md

## Exact Verification Performed

Local checks:

- `git status --short`
- `find research/source_notes -maxdepth 1 -type f -print`
- `rg -n "^Status: (verified_primary_source|verified_secondary_source|unverified_from_deep_research_return|citation_needs_correction)$" research/source_notes/*.md`
- `rg -n "Census 2026|Federal Reserve 2026|OECD 2025|Joskow 2010|unverified" research docs/source_truth docs/operator/returns`
- `rg -n "\\| TCE-CLAIM-00[0-9].*\\| supported \\|.*(Census 2026|Federal Reserve 2026|OECD 2025|Joskow 2010)" research/claims_index.md`
- `git diff -- paper/draft.md`

Web verification:

- Opened JSTOR stable records for Coase 1937 and Williamson 1991.
- Opened AEA article page for Williamson 2010.
- Opened Cambridge Core/DOI record for Macher and Richman 2008.
- Opened Oxford Academic/QJE DOI page for Brynjolfsson, Li, and Raymond 2025.
- Opened HBS working-paper page for Dell'Acqua et al. 2023.
- Opened MIT-hosted working-paper PDF for Noy and Zhang.
- Opened Stanford/author-hosted Powell PDF.
- Opened IRS.gov independent contractor page.
- Opened SBA.gov size standards page.
- Opened BLS Monthly Labor Review article for electronically mediated work.
- Opened Cornell Wex corporations and LLC pages.
- Searched exact and domain-restricted queries for the Census, Federal Reserve,
  OECD, and Joskow citations listed above; no verified exact source was found.

## Skipped Checks

- Did not perform institutional-library full-text downloads for paywalled
  journal articles.
- Did not run tests; this is a documentation/research correction.
- Did not commit or push.

## Draft Status

`paper/draft.md` remained untouched.
