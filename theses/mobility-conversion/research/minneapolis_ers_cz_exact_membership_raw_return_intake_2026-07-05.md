# Minneapolis-St. Paul ERS CZ Exact Membership Raw Return Intake

Date: 2026-07-05

Raw return:

- `theses/mobility-conversion/operator_records/external_query_tests/2026-07-05-minneapolis-ers-cz-exact-membership-source-bundle-raw-return.md`
- SHA-256:
  `012257650933b324265f4bac06568e7862a1285f50cdf6fefa8a51bcc2b30111`

Status: intake only. No MTR is admitted. No evidence is accepted. No boundary
record, evidence manifest, candidate-universe ledger, outcome metric record,
score, ranking, accepted county membership, or accepted denominator value is
authorized.

## Scope Compliance

The return keeps the ERS CZ as a source-led labour-market boundary lead. It
does not use transit agencies, GTFS, NTD reporters, route coverage, or service
areas as the denominator.

No raw ERS CSV, TIGER/Line county geometry, ACS API response, or GTFS feed is
archived by this return.

## Intake Classification

### Source Leads

- USDA ERS 2020 Commuting Zones and Labor Market Areas page.
- USDA ERS 2020 Commuting Zones CSV lead with raw code/name:
  `CZ2020 = 258`, `CZName = Minneapolis city, MN`.
- County membership rows, containment fields, and average containment values
  from the raw return, pending Codex re-extraction.
- U.S. Census TIGER/Line county geometry and ACS population denominator paths.
- ACS margin-of-error guidance.
- FTA/NTD GTFS Weblinks, NTD agency metadata, and local agency source leads:
  Metro Transit, Minnesota Valley Transit Authority, Southwest Transit, Maple
  Grove Transit, Northstar, Metro Micro, Heartland Express, Arrowhead, and
  other possible rural/county services.

### Methodology Candidates

- Require Codex re-acquisition and archive of the ERS CSV before accepting
  `CZ2020 = 258` or the county membership.
- Use TIGER/Line county geometry for analytic construction if exact county
  geometry matters.
- Treat county coarseness, lower-containment counties, cross-state complexity,
  and remote-work/post-2020 caveats as required readiness fields.
- Separate NTD/GTFS source discovery from service coverage against the CZ.

### Open Questions

- Which counties are in `CZ2020 = 258` after independent ERS CSV extraction?
- Which lower-containment or rural counties create boundary-fit risks for
  transport-access work?
- How should county-level ACS population and MOE be aggregated?
- Which fixed-route agencies are material inside the CZ, and which are merely
  adjacent or minor?
- How should Metro Micro, paratransit, rural county services, and commuter rail
  be handled in V1?

### Rejected Or Quarantined Material

- `CZ2020 = 258`, county membership, and containment values remain raw leads
  until re-extracted and archived.
- GTFS, NTD reporter areas, and agency service geographies are rejected as
  denominators.
- Service completeness claims are quarantined until operator/feed inventory and
  spatial overlay are performed.
- Minneapolis-St. Paul is not admitted as an MTR by this return.

## Immediate Formation-Stage Use

Minneapolis-St. Paul moves from
`minneapolis_ers_cz_exact_membership_handoff_ready` to
`raw_return_buffered_ers_membership_reextraction_required`.

Next allowed output:

- ERS CZ exact-membership source note;
- county geometry and population aggregation plan;
- county-coarseness readiness screen;
- NTD/GTFS service-source inventory.

Prohibited output remains:

- admitted MTR;
- filled boundary record;
- accepted population value;
- score, ranking, metric record, or candidate-universe ledger.
