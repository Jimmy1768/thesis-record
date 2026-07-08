# Sao Paulo GHS-FUA Raw Return Intake

Date: 2026-07-05

Raw return:

- `theses/mobility-conversion/operator_records/external_query_tests/2026-07-05-sao-paulo-ghs-fua-high-burden-source-bundle-raw-return.md`
- SHA-256:
  `fe44cde13083c23040a8aad15806dea30e7f60449b20b7d4bbc1a78cc4f87fdb`

Status: intake only. No MTR is admitted. No evidence is accepted. No boundary
record, evidence manifest, candidate-universe ledger, outcome metric record,
score, ranking, accepted GHS-FUA row, or accepted denominator value is
authorized.

## Scope Compliance

The return treats Sao Paulo GHS-FUA as a high-burden modelled-boundary lead. It
does not inspect the raw official GeoPackage row, calculate population, calculate
service coverage, or decide that GHS-FUA is acceptable as an MTR boundary.

It correctly flags GHS-FUA as modelled, not observed commuting-flow geography.

## Intake Classification

### Source Leads

- JRC/GHSL GHS-FUA R2019A product, catalogue, FTP tree, ZIP path,
  documentation, DOI, and copyright/license path.
- GHS-POP R2023A population grid source path.
- GHS-SMOD and GHS-UCDB built-form/context source paths.
- IBGE 2022 Population Arrangements and Urban Concentrations source family.
- IBGE municipal boundary and official population source paths.
- Sao Paulo Metro OD survey/planning context.
- SPTrans developer static GTFS / Olho Vivo API source path.
- EMTU open-data/API-GTFS lead.
- CPTM, Metro, ARTESP, intermunicipal bus, charter, paratransit, ferry, and
  informal/weakly documented service-source leads.

### Methodology Candidates

- Keep GHS-FUA as a modelled global fallback only unless no stronger official
  national/observed source family is usable.
- Require exact official GeoPackage row extraction before any GHS-FUA boundary
  decision.
- Inspect IBGE population arrangements / urban concentrations before relying on
  GHS-FUA as primary denominator.
- Record GHS-FUA model inputs, GDP-per-capita input risk, 2015 boundary epoch,
  travel-time/friction model, and GHS-POP vintage mismatch as mandatory caveats.
- Use GHS-SMOD/GHS-UCDB only as overlays, not as full MTR boundaries.

### Open Questions

- What is the exact official Sao Paulo GHS-FUA identifier/name in the JRC
  GeoPackage?
- Does IBGE provide a stronger official boundary or composition for the Sao
  Paulo transport-region question?
- Can GHS-FUA be paired defensibly with GHS-POP R2023A, or does the boundary
  epoch mismatch block formation-stage use?
- Which service-source bundle could cover the full modelled region rather than
  only the city or formal metropolitan services?
- How should informal, charter, paratransit, and weakly documented services be
  treated?

### Rejected Or Quarantined Material

- Exact Sao Paulo GHS-FUA row/name is unresolved and not accepted.
- GHS-FUA is rejected as an observed commuting-flow boundary.
- GHS-SMOD, GHS-UCDB, official planning regions, and service geographies are
  rejected as substitute MTR boundaries at this stage.
- Reputation or megacity status is rejected as selection justification.
- Sao Paulo is not admitted as an MTR by this return.

## Immediate Formation-Stage Use

Sao Paulo moves from `sao_paulo_ghs_fua_high_burden_handoff_ready` to
`raw_return_buffered_modelled_boundary_high_burden_review_required`.

Next allowed output:

- JRC/GHSL exact-row acquisition plan;
- IBGE fallback/stronger-boundary source review;
- modelled-boundary caveat decision record;
- formal/informal service-source inventory plan.

Prohibited output remains:

- admitted MTR;
- filled boundary record;
- accepted population value;
- score, ranking, metric record, or candidate-universe ledger.
