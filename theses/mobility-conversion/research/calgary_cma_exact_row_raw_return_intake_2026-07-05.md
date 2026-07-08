# Calgary CMA Exact Row Raw Return Intake

Date: 2026-07-05

Raw return:

- `theses/mobility-conversion/operator_records/external_query_tests/2026-07-05-calgary-cma-exact-row-source-bundle-raw-return.md`
- SHA-256:
  `db2106ae48c74d74462a0ef404e8c1dfd43a02b64621c9f26badf67c0901a0ca`

Status: intake only. No MTR is admitted. No evidence is accepted. No boundary
record, evidence manifest, candidate-universe ledger, outcome metric record,
score, ranking, accepted denominator value, or raw source row is authorized.

## Scope Compliance

The return identifies official Statistics Canada and local service-source leads
without downloading raw datasets or accepting Calgary as an MTR.

It does not use Calgary Transit geography as the denominator and does not
calculate service coverage, population coverage, scores, or rankings.

## Intake Classification

### Source Leads

- Statistics Canada 2021 Census reference map lead mapping Calgary to CMA code
  `825`.
- Statistics Canada 2021 Census Profile and Focus on Geography DGUID paths
  using `2021S0503825`.
- Statistics Canada / Geo.ca 2021 Census Boundary Files and ArcGIS REST
  `CMA - lcma000b21s_e` layer path.
- Statistics Canada GeoSuite / population and dwelling count paths for
  population denominator and building-block extraction.
- Statistics Canada CMA/CA glossary and methodology rules.
- Calgary Transit GTFS/static and realtime/open-data paths.
- Airdrie, Chestermere, Cochrane, On-It, airport, shuttle, private/intercity,
  and paratransit service-source leads.

### Methodology Candidates

- Treat `825` and `2021S0503825` as raw exact-row leads until Codex
  independently re-extracts and archives the boundary feature or official row.
- Require GeoSuite or equivalent official relationship data before accepting
  CSD membership.
- Require service-overlay review for regional municipalities inside the CMA
  before any readiness promotion.
- Keep On-It / Cochrane service status timestamped because the raw return notes
  possible 2026 discontinuation.

### Open Questions

- Should exact row acceptance require archiving the `CMAUID = 825` /
  `DGUID = 2021S0503825` feature from `lcma000b21s_e`?
- Should GeoSuite be mandatory for CSD membership and population denominator
  extraction?
- Which Calgary CMA municipalities are materially outside Calgary Transit
  coverage?
- How should regional commuter, airport, private/intercity, and paratransit
  services be handled in a first service-source bundle?
- What timestamp governs any 2026 On-It / Cochrane service-status claim?

### Rejected Or Quarantined Material

- The raw code/DGUID values are not accepted source truth yet.
- Calgary Transit service geography is rejected as a boundary or denominator.
- Regional-service snippets are quarantined until timestamped official source
  inspection.
- The raw return's suggested source-note path is not adopted automatically.

## Immediate Formation-Stage Use

Calgary moves from `calgary_cma_exact_row_handoff_ready` to
`raw_return_buffered_exact_row_reextraction_required`.

Next allowed output:

- verified Statistics Canada exact-row/source note;
- boundary feature acquisition plan with manifest trigger;
- CSD membership extraction plan;
- Calgary CMA service-overlay completeness review.

Prohibited output remains:

- admitted MTR;
- filled boundary record;
- accepted population value;
- score, ranking, metric record, or candidate-universe ledger.
