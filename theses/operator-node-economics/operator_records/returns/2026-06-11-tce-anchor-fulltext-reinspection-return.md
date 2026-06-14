---
record_id: return-2026-06-11-tce-anchor-fulltext-reinspection
record_type: return
workflow_id: 2026-06-11-tce-anchor-fulltext-reinspection
status: complete
created_at: 2026-06-11T02:45:14+08:00
owner: Research
source_handoff: docs/operator/handoffs/2026-06-11-tce-anchor-fulltext-reinspection-handoff.md
---

# TCE Anchor Full-Text Reinspection Return

## Sources Directly Reinspected

- Coase 1937, "The Nature of the Firm": bibliographic record verified through
  JSTOR; full text visually reinspected from an archived JSTOR PDF copy after
  the publisher DOI PDF was blocked. Pages inspected: article pp.388,
  390-391, 393-394, and 397-398.
- Williamson 2009/2010, "Transaction Cost Economics: The Natural Progression":
  official Nobel Prize PDF directly inspected. Pages inspected: pp.455-471,
  including governance framing, lens of contract, transaction as unit,
  incomplete contracts, bounded rationality, opportunism, adaptation, asset
  specificity, bilateral dependency, hierarchy as internal dispute forum, and
  the Boeing 787 outsourcing caveat.
- Powell 1990, "Neither Market Nor Hierarchy: Network Forms of Organization":
  Stanford-hosted scanned PDF directly visually inspected. Pages inspected:
  pp.295-336.
- Macher and Richman 2008, "Transaction Cost Economics: An Assessment of
  Empirical Research in the Social Sciences": Cambridge/DOI metadata,
  abstract, and reference list directly inspected. Full text was not obtained.
- Williamson 1991, "Comparative Economic Organization": bibliographic reality
  verified through JSTOR metadata, but full text was not reinspected. Public
  PDF retrieval attempts failed.

## Files Changed

- `research/source_notes/coase_1937_nature_of_the_firm.md`
- `research/source_notes/williamson_1991_comparative_economic_organization.md`
- `research/source_notes/williamson_2009_nobel_transaction_cost_economics.md`
- `research/source_notes/macher_richman_2008_tce_empirical_assessment.md`
- `research/source_notes/powell_1990_network_forms.md`
- `research/areas/03-transaction-cost-economics.md`
- `research/claims_index.md`
- `research/criticisms.md`
- `paper/evidence_requirements.md`
- `docs/operator/returns/2026-06-11-tce-anchor-fulltext-reinspection-return.md`

## Claims Strengthened

- TCE-CLAIM-001 was strengthened as a directly inspected Coasean relative-cost
  guardrail: firm-boundary claims must compare market/protocol costs against
  internal organization costs.
- TCE-CLAIM-004 remains supported for core TCE hazards through directly
  inspected Williamson 2009/2010 passages on incomplete contracts, bounded
  rationality, opportunism, adaptation, asset specificity, and bilateral
  dependency.
- Powell 1990 now directly supports network-form classification and cautions:
  networks depend on reciprocity, trust, reputation, and repeated interaction,
  while also carrying dependency, particularism, entry-barrier, and
  performance/control risks.
- Macher and Richman 2008 now supports only broad empirical-review framing from
  the inspected abstract: considerable support for many central TCE tenets and
  unresolved theoretical and empirical issues.

## Claims Weakened Or Corrected

- "Transaction costs collapse" language was corrected to a relative-cost
  formulation. Coase does not imply technology necessarily shrinks firms;
  inspected passages show technology may also increase firm size by lowering
  internal organization costs.
- TCE-CLAIM-002 was downgraded from `supported` to `weak support` because the
  low-asset-specificity boundary is directly supported by Williamson 2009/2010,
  but the digital/modular Operator Node extension still needs sector evidence
  and Williamson 1991 page-level support was not verified.
- TCE-CLAIM-005 was changed from a supported "Operator Node networks are best
  interpreted as hybrid governance" claim to `needs refinement`. Powell 1990
  directly argues network forms are neither markets nor hierarchies, so a
  simple hybrid label is too strong.
- TCE-CLAIM-009 remains `weak support`, but now rests on directly inspected
  Powell network-form evidence rather than uninspected Williamson 1991
  reputation language. Audit-trail and protocol mechanisms remain hypotheses.
- TCE-CLAIM-010 was downgraded from `supported` to `weak support`. Directly
  inspected Williamson 2009/2010 supports coordinated-adaptation and hierarchy
  cautions, but the high-frequency/hybrid-specific formulation from
  Williamson 1991 remains unverified.
- Detailed Macher/Richman empirical-method claims remain withheld until full
  text is obtained.

## Direct-Text Evidence Added

- Coase source note: recorded inspected passages on market-use costs,
  employment/authority, marginal firm boundaries, and ambiguous technology
  effects; added a short quote from p.394.
- Williamson 2009/2010 source note: recorded inspected pages for governance,
  contracts, incomplete contracts, adaptation, asset specificity, bilateral
  dependency, hierarchy, and Boeing; added short quotes from pp.455, 456, 461,
  463, and 470.
- Powell source note: recorded visual inspection across pp.295-336 and added
  short quotes from pp.295, 301, 304, and 323.
- Macher/Richman source note: added short abstract quotes and explicitly
  limited use to abstract-level claims.

## Remaining Source Gaps

- Williamson 1991 full text still needs direct inspection before supporting
  market/hybrid/hierarchy table claims, reputation claims, or disturbance-
  adaptation claims specific to hybrids.
- Macher and Richman 2008 full text is still needed before using detailed
  empirical counts, methods, endogeneity, measurement, or page-level criticism
  claims.
- Coase 1937 was inspected from a scanned archived JSTOR PDF copy, not the
  publisher DOI PDF; the inspected passages are sufficient for the recorded
  claims but the access path should be noted.
- Powell 1990 was visually inspected from a scanned PDF; text extraction was
  unavailable, so page references should be manually checked before final
  quotation in a draft.
- No directly inspected source in this pass proves the Operator Node hypothesis
  or any AI-specific firm-boundary shift.

## Paper Draft Status

`paper/draft.md` remained untouched.

## Exact Verification Performed

Source access and inspection:

- Opened JSTOR metadata for Coase 1937 and Williamson 1991.
- Attempted publisher DOI/PDF access for Coase; Wiley PDF was blocked.
- Downloaded and visually inspected archived JSTOR PDF copy of Coase 1937.
- Opened AEA and Nobel records for Williamson 2009/2010; downloaded and
  inspected the official Nobel PDF.
- Attempted public PDF retrieval for Williamson 1991; retrieval failed.
- Opened Cambridge/DOI page for Macher and Richman 2008; inspected metadata,
  abstract, DOI, and reference list only.
- Downloaded and visually inspected Stanford-hosted scanned PDF for Powell
  1990.

Required local verification commands:

- `git diff -- paper/draft.md`
- `rg -n "philosophical|religious" docs research paper`
- `rg -n "manifesto|conclusion|conclusions" research paper docs/operator/returns`
- `rg -n "Direct Reinspection|Status:" research/source_notes/coase_1937_nature_of_the_firm.md research/source_notes/williamson_1991_comparative_economic_organization.md research/source_notes/williamson_2009_nobel_transaction_cost_economics.md research/source_notes/macher_richman_2008_tce_empirical_assessment.md research/source_notes/powell_1990_network_forms.md`
- `git diff --check`

Additional local checks:

- `git status --short`
- `rg -n "Williamson 1991|Macher and Richman|Powell 1990|transaction costs collapse|hybrid governance" research/claims_index.md research/areas/03-transaction-cost-economics.md research/criticisms.md paper/evidence_requirements.md`

Verification results:

- `git diff -- paper/draft.md`: no output; draft file remained untouched.
- Prohibited-foundation scan returned existing boundary/checklist matches in
  handoffs, source-truth files, execution/acceptance records, and return
  command listings; no new research argument prose introduced those
  foundations.
- Manifesto/end-section scan returned existing outline/argument-map boundary
  language, source-note README guidance, and return command listings; no paper
  prose was added.
- Source-note status scan confirmed all five target notes contain both
  `Status:` and `Direct Reinspection` entries.
- `git diff --check`: no output.
- Additional claim scan found no `supported` claim relying on Williamson 1991
  page-level evidence. The supported Macher/Richman row is limited to the
  directly inspected abstract and flags full-text empirical detail as a gap.

No commit or push was performed.
