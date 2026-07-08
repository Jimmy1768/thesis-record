# Greater Melbourne GCCSA Exact Row Raw Return Intake

Date: 2026-07-05

Raw return:

- `theses/mobility-conversion/operator_records/external_query_tests/2026-07-05-melbourne-gccsa-exact-row-source-bundle-raw-return.md`
- SHA-256:
  `3abe004d551df5ea53e4d13a9bd8c166c8439da4f13b7defbf39d20ff1acd012`

Status: intake only. No MTR is admitted. No evidence is accepted. No boundary
record, evidence manifest, candidate-universe ledger, outcome metric record,
score, ranking, accepted denominator value, or raw geometry is authorized.

## Scope Compliance

The return keeps Greater Melbourne GCCSA as a source-led lead. It does not
treat statewide GTFS, PTV service geography, ferry services, FlexiRide zones,
or Victorian transport coverage as an MTR denominator.

No raw ABS files, DTP feeds, API responses, or population workbooks were
archived.

## Intake Classification

### Source Leads

- ABS ASGS Edition 3 GCCSA documentation and access/download pages.
- ABS exact name/code lead: Greater Melbourne / `2GMEL`.
- ABS GCCSA boundary file path, including
  `GCCSA_2021_AUST_SHP_GDA2020.zip`.
- ABS GCCSA allocation workbook path for SA4 membership.
- ABS Regional Population and Census profile/QuickStats population paths.
- Victoria DTP / Transport Victoria / PTV GTFS Schedule, Timetable API, and
  GTFS Realtime paths.
- Ferry, FlexiRide/on-demand, school-bus, SkyBus/airport, regional train,
  regional coach, and demand-responsive/paratransit service-source leads.

### Methodology Candidates

- Treat `2GMEL` as an official raw identifier lead pending Codex raw boundary
  acquisition and row inspection.
- Require explicit GCCSA boundary-fit review because ABS GCCSA is broad,
  functional/statistical, SA4-built, and has no population criterion.
- Require operator/mode manifest after GTFS acquisition before coverage
  conclusions.
- Record ASGS Edition 4 migration timing as a future compatibility issue.

### Open Questions

- Should `2GMEL` be accepted after raw ABS geometry is archived, or must a
  separate boundary-fit screen occur first?
- Should the boundary record use shapefile, GeoPackage, or both?
- What exact ABS Regional Population field should become the denominator after
  acquisition?
- Should SA4 membership come from the allocation workbook or from spatial
  extraction?
- How should ferries, FlexiRide, school buses, SkyBus, regional services, and
  paratransit be scoped for V1 coverage?

### Rejected Or Quarantined Material

- Greater Melbourne GCCSA is rejected as an admitted MTR at this stage.
- PTV/statewide transport-service geography is rejected as a denominator.
- ABS population values are rejected as comparison inputs until raw
  denominator extraction and manifesting occur.
- Service completeness claims are quarantined until raw feed and operator
  manifest review.

## Immediate Formation-Stage Use

Greater Melbourne moves from `melbourne_gccsa_exact_row_handoff_ready` to
`raw_return_buffered_exact_row_and_boundary_fit_review_required`.

Next allowed output:

- ABS exact-row/source note;
- ABS boundary and allocation acquisition plan;
- GCCSA boundary-fit review;
- Victoria service-source coverage inventory.

Prohibited output remains:

- admitted MTR;
- filled boundary record;
- accepted population value;
- score, ranking, metric record, or candidate-universe ledger.
