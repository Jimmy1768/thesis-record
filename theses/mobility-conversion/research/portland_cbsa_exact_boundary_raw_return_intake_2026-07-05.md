# Portland-Vancouver-Hillsboro CBSA Exact Boundary Raw Return Intake

Date: 2026-07-05

Raw return:

- `theses/mobility-conversion/operator_records/external_query_tests/2026-07-05-portland-cbsa-exact-boundary-source-bundle-raw-return.md`
- SHA-256:
  `76a1d438d3cd3bb0538e21a75acb58ace80383a6299aee3f24d9186fef04a1e3`

Status: intake only. No MTR is admitted. No evidence is accepted. No boundary
record, evidence manifest, candidate-universe ledger, outcome metric record,
score, ranking, accepted county membership, or accepted denominator value is
authorized.

## Scope Compliance

The return keeps Portland-Vancouver-Hillsboro CBSA as an
`official_statistical_metro` source-led lead. It does not use TriMet, C-TRAN,
FTA/NTD, BTS National Transit Map, routes, stops, service areas, or fare zones
as an MTR denominator.

No raw CBSA list, TIGER/Line file, ACS response, NTD file, or GTFS feed is
archived by this return.

## Intake Classification

### Source Leads

- OMB / U.S. Census CBSA list and definition paths for CBSA `38900`.
- U.S. Census TIGER/Line and cartographic boundary file paths for CBSA
  geometry.
- ACS direct CBSA population path and county aggregation fallback paths.
- County membership, central/outlying county status, and county-coarseness
  review leads.
- FTA/NTD GTFS Weblinks and BTS National Transit Map as service-source
  discovery paths.
- TriMet, C-TRAN, SMART, Cherriots, Columbia County Rider, Yamhill County
  Transit, Skamania-area or other small service-source leads.

### Methodology Candidates

- Treat `CBSA = 38900` as a raw exact-boundary lead pending independent
  extraction and archive.
- Require OMB statistical-use caveat in any future boundary note.
- Require county-coarseness review before using a county-based CBSA for
  transport-access work.
- Require cross-state service-source and governance-complexity flags.
- Decide whether direct ACS CBSA population or county aggregation is preferred
  before denominator work.

### Open Questions

- Can CBSA `38900` become an MTR denominator after county-coarseness review, or
  should it remain only an official statistical-metro test case?
- Which boundary artifact should be archived for analysis: detailed TIGER/Line,
  cartographic boundary, or both?
- Should central/outlying county status be required metadata?
- Which outlying counties require built-up-area or gridded-population overlays?
- What threshold makes a small agency material for service-source completeness?
- How should cross-state governance and 2016-2020 commuting vintage be
  recorded?

### Rejected Or Quarantined Material

- `CBSA = 38900` and county membership remain raw leads until source-row
  extraction is repeated and archived.
- Transit service geography, GTFS, NTD reporter data, and routes are rejected
  as denominators.
- Operator lists are quarantined until current source snapshots and spatial
  overlay are performed.
- Portland-Vancouver-Hillsboro is not admitted as an MTR by this return.

## Immediate Formation-Stage Use

Portland-Vancouver-Hillsboro moves from
`portland_cbsa_exact_boundary_handoff_ready` to
`raw_return_buffered_cbsa_boundary_reextraction_required`.

Next allowed output:

- OMB/Census CBSA exact-boundary source note;
- boundary artifact acquisition plan;
- county-coarseness readiness screen;
- cross-state service-source inventory.

Prohibited output remains:

- admitted MTR;
- filled boundary record;
- accepted population value;
- score, ranking, metric record, or candidate-universe ledger.
