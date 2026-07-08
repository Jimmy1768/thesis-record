# Bristol TTWA Exact Row Raw Return Intake

Date: 2026-07-05

Raw return:

- `theses/mobility-conversion/operator_records/external_query_tests/2026-07-05-bristol-ttwa-exact-row-source-bundle-raw-return.md`
- SHA-256:
  `0aa1537b5b980150bc7b45a20952c5b3a51bf96a0d1f51d7d32ae03e50c8de16`

Status: intake only. No MTR is admitted. No evidence is accepted. No boundary
record, evidence manifest, candidate-universe ledger, outcome metric record,
score, ranking, accepted denominator value, or raw TTWA row is authorized.

## Scope Compliance

The return keeps Bristol TTWA as a source-led lead and does not calculate
population, stop coverage, accessibility, service coverage, scores, or
rankings.

It does not use BODS, NaPTAN, operators, service areas, or route coverage as
the TTWA denominator.

## Intake Classification

### Source Leads

- ONS / data.gov.uk Travel to Work Areas December 2011 names and codes table
  with `TTWA11CD` and `TTWA11NM`.
- Raw exact-code lead: Bristol / `E30000180`.
- ONS / data.gov.uk TTWA December 2011 boundary products, including full
  clipped boundary formats and web services.
- ONS LSOA population estimate and LSOA-to-TTWA exact-fit lookup path for
  population denominator construction.
- ONS TTWA methodology and commuting-vintage caveat sources.
- BODS, NaPTAN, National Rail, ferry, airport, park-and-ride, demand-responsive,
  and community-transport source leads.

### Methodology Candidates

- Require canonical TTWA names-and-codes raw extraction before accepting
  `E30000180`.
- Treat TTWA 2011 as an observed labour-market geography with strong vintage
  caveats.
- Use LSOA-to-TTWA lookup plus official population estimates if no direct TTWA
  population table is available.
- Require fixed-route and non-fixed-route service materiality review before any
  coverage test.

### Open Questions

- Can Codex independently extract the canonical Bristol row from the official
  names-and-codes table?
- Which TTWA boundary product should be archived for analysis versus display?
- Which population vintage should pair with a 2011 TTWA boundary during
  formation-stage testing?
- How should post-2020 commuting change affect TTWA boundary-fit review?
- Which Bristol-area rail, ferry, park-and-ride, airport, DRT, or community
  services are material to the first source bundle?

### Rejected Or Quarantined Material

- `E30000180` remains a raw lead until canonical row extraction is repeated by
  Codex.
- BODS/NaPTAN/service geography is rejected as a denominator.
- Population aggregation is quarantined until official lookup and population
  inputs are archived.
- Bristol is not admitted as an MTR by this return.

## Immediate Formation-Stage Use

Bristol moves from `bristol_ttwa_exact_row_handoff_ready` to
`raw_return_buffered_ttwa_exact_row_reextraction_required`.

Next allowed output:

- ONS exact-row/source note;
- TTWA boundary artifact acquisition plan;
- population aggregation method note;
- Bristol service-source materiality review.

Prohibited output remains:

- admitted MTR;
- filled boundary record;
- accepted population value;
- score, ranking, metric record, or candidate-universe ledger.
