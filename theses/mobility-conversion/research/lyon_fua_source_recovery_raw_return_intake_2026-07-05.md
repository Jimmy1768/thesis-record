# Lyon FUA Source Recovery Raw Return Intake

Date: 2026-07-05

Raw return:

- `theses/mobility-conversion/operator_records/external_query_tests/2026-07-05-lyon-fua-source-recovery-raw-return.md`
- SHA-256:
  `9fe25160f88edb738ed68b19264e54881025f83f8e4b3e9f8e58d85ba80f66dd`

Status: intake only. No MTR is admitted. No evidence is accepted. No boundary
record, evidence manifest, candidate-universe ledger, outcome metric record,
score, ranking, or accepted service method is authorized.

## Scope Compliance

The return preserves the prior blocker rather than bypassing it:

- France NAP / TCL static GTFS and NeTEx remain unavailable through
  unauthenticated metadata;
- authenticated Grand Lyon / producer access and license review remain
  unresolved;
- SIRI Lite is not accepted as a GTFS/NeTEx substitute;
- TCL service, fare, and governance geography are not used as the `FR002F`
  denominator.

No prohibited selection, scoring, ranking, or service-derived denominator was
introduced.

## Intake Classification

### Source Leads

- France NAP / `transport.data.gouv.fr` TCL dataset metadata.
- Grand Lyon account, producer authentication, and `Licence Mobilite` access
  paths.
- French SIRI / SIRI Lite documentation and TCL SIRI Lite resources.
- SNCF national static/realtime source paths for TER, Intercites, TGV, and
  rail services that may intersect `FR002F`.
- Rhonexpress official service source lead.
- Auvergne-Rhone-Alpes regional/interurban coach and bus source leads.
- TCL demand-responsive, paratransit, school, and river-shuttle source leads.
- Transitland or third-party recovery paths as quarantine-only leads.

### Methodology Candidates

- Keep SIRI Lite in `available_but_method_unresolved` status until a controlled
  authenticated response, schema fields, snapshot semantics, license terms, and
  archive method are verified.
- Treat NAP covered-area metadata as a source-discovery aid, not as FUA
  coverage proof.
- Require boundary overlay against `FR002F` before deciding whether SNCF,
  Rhonexpress, regional coaches, DRT, or special services are material.
- Prefer authenticated GTFS/NeTEx recovery if available; use SIRI Lite only
  after a separate method decision.

### Open Questions

- Can authenticated Grand Lyon / producer access retrieve current static GTFS
  or NeTEx for TCL?
- What exact license terms and redistribution constraints apply to authenticated
  TCL static data?
- Can a SIRI Lite EstimatedTimetable response produce a reproducible scheduled
  service snapshot, or is it unsuitable for static coverage work?
- Which non-TCL operators or modes materially intersect `FR002F`?
- Should Lyon source recovery proceed from boundary overlay first or from NAP
  covered-area metadata first?

### Rejected Or Quarantined Material

- TCL service geography, covered-area metadata, fare zones, and governance
  boundaries are rejected as MTR denominators.
- Unauthenticated NAP metadata is rejected as proof that current static feed
  data are available for evidence use.
- Transitland or other third-party cached feeds are quarantined as recovery
  leads only.
- SIRI Lite substitution is rejected for immediate use.

## Immediate Formation-Stage Use

Lyon moves from `source_recovery_handoff_ready` to
`raw_return_buffered_static_feed_and_siri_method_blocked`.

Next allowed output:

- authenticated-source acquisition plan;
- verified source note for TCL/France NAP access and license status;
- SIRI Lite method decision record;
- `FR002F` service-operator overlay plan.

Prohibited output remains:

- admitted MTR;
- accepted SIRI Lite method;
- filled boundary record;
- evidence manifest without raw acquisition decision;
- score, ranking, metric record, or candidate-universe ledger.
