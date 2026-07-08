# Helsinki FUA Operator Inventory Raw Return Intake

Date: 2026-07-05

Raw return:

- `theses/mobility-conversion/operator_records/external_query_tests/2026-07-05-helsinki-fua-operator-inventory-raw-return.md`
- SHA-256:
  `964cfd9d6c733a7aa8962271a7e4ed97f7b5ef3c4c6c4134804cf92af92be92f`

Status: intake only. No MTR is admitted. No evidence is accepted. No boundary
record, evidence manifest, candidate-universe ledger, outcome metric record,
score, ranking, or accepted denominator value is authorized.

## Scope Compliance

The return follows the requested raw-return posture:

- labels itself raw research material;
- uses Metropolitan Transport Region / MTR terminology;
- does not calculate scores, rankings, population coverage, or service
  coverage;
- does not use HSL service geography as the `FI001F` denominator;
- separates official source paths from secondary municipality-crosswalk leads.

The return includes a negative mention of the prohibited terminology only as a
guardrail statement.

## Intake Classification

### Source Leads

- Eurostat GISCO Urban Audit FUA geodata and metadata for `FI001F` boundary
  context.
- OECD FUA municipality-list path for exact official municipality extraction.
- HSL area/zones, HSL open data, HSL GTFS, HSL GTFS-RT, Digitransit APIs, and
  Digitransit terms as primary HSL/Digitransit source paths.
- Fintraffic / FINAP scheduled public-transport and DRT publication paths as
  non-HSL recovery paths.
- Järvenpää public and service-transportation pages as a concrete
  missing-service risk lead if official `FI001F` membership includes
  Järvenpää.
- Matkahuolto and national/Fintraffic routing paths as possible non-HSL
  service-source recovery leads.

### Methodology Candidates

- Require official `FI001F` LAU/municipality membership before testing HSL
  completeness.
- Treat HSL static GTFS as a core source family, not as proof of full FUA
  coverage.
- Compare service-source footprints to the independent FUA boundary so
  residents outside feed coverage remain visible.
- Record non-fixed-route, DRT, ferry, rail, and interurban services as explicit
  materiality questions rather than silently excluding them.

### Open Questions

- What is the exact official `FI001F` municipality/LAU membership from
  OECD/GISCO source artifacts?
- Which `FI001F` municipalities are outside HSL member-area coverage?
- Does the Digitransit Finland endpoint contain complete local/regional bus,
  rail, ferry, and DRT sources for the FUA, or only a partial source bundle?
- Which non-HSL services are material enough for the first coverage method
  test?
- How should HSL-router coverage be distinguished from broader national
  Digitransit / FINAP coverage?

### Rejected Or Quarantined Material

- Secondary tbed/DadaBIK municipality snippets are quarantined as
  verification leads only.
- HSL fare/service geography is rejected as an MTR denominator.
- HSL GTFS alone is rejected as a complete FUA service-coverage proof.
- Any claim that Helsinki is ready for a boundary record or coverage metric is
  rejected at this intake stage.

## Immediate Formation-Stage Use

Helsinki moves from `operator_inventory_handoff_ready` to
`raw_return_buffered_operator_inventory_review_required`.

Next allowed output:

- source-note plan or verified source notes for official `FI001F`
  municipality membership;
- HSL/Digitransit service-source completeness review;
- non-HSL operator/source inventory review;
- coverage-reconciliation blocker update.

Prohibited output remains:

- admitted MTR;
- filled boundary record;
- evidence manifest without raw acquisition decision;
- score, ranking, metric record, or candidate-universe ledger.
