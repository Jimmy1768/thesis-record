# Batch S1E: Local Service-Source Verification Queue

Date: 2026-07-01

Status: formation-stage service-source queue and rule set. No MTR is selected.
No service source is accepted as evidence. No boundary record, evidence
manifest, candidate-universe ledger, outcome metric record, score, ranking, or
MTR comparison is authorized.

Related intake:

- `theses/mobility-conversion/research/source_led_mtr_proposal_intake_2026-07-01.md`

Related source notes:

- `theses/mobility-conversion/research/source_notes/gtfs_schedule_outcome_input_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/gtfs_realtime_outcome_input_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/gtfs_fares_outcome_input_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/mobilitydata_gtfs_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/fta_ntd_gtfs_weblinks_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/transitland_feed_registry_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/bts_national_transit_map_2026-06-28.md`

## Question

Which named service/network sources are traceable, current, licensed,
reproducible, and complete enough to become indicator inputs after a separate
MTR denominator is verified?

## Short Decision

The local service sources in the 2026-07-01 raw return remain source leads, not
evidence.

They may enter source-note review as service or network inputs only. No local
service source may define, shrink, expand, or validate the MTR denominator by
itself.

## Service-Source Status Table

| Related lead | Source lead | Current status | Next allowed output |
| --- | --- | --- | --- |
| `mtr_src_001` Helsinki FUA | HSL open data / Digitransit GTFS, GTFS-RT, OSM routing stack | `source_lead_only` | Source-note review after FUA extraction fields are defined |
| `mtr_src_002` Lyon FUA | France National Access Point local transport datasets | `needs_source_trace` | Source trace for Lyon/FUA-relevant feed records |
| `mtr_src_003` Bristol TTWA | NaPTAN, Bus Open Data Service, rail/ferry overlays | `source_lead_only` | Source-note review for modal coverage and non-bus gaps |
| `mtr_src_005` Calgary CMA | Calgary Transit Scheduling Data and regional operators | `source_lead_only` | Source-note review for CMA coverage, regional gaps, and GTFS license/vintage |
| `mtr_src_006` Greater Melbourne GCCSA | Victoria DTP GTFS schedule data and possible realtime feeds | `source_lead_only` | Source-note review for GCCSA clipping/alignment and statewide coverage |
| `mtr_src_008` Sao Paulo GHS-FUA | SPTrans / EMTU developer or API/GTFS leads | `source_lead_only_high_access_risk` | Source trace for access, registration, license, reproducibility, and informal-service gaps |

## Required Service-Source Fields

Before a service source can support an indicator method test, record:

```yaml
service_source_review:
  source_name:
  source_authority:
  source_url_or_access_path:
  format:
  static_or_realtime:
  publication_or_feed_date:
  feed_validity_window:
  retrieval_or_inspection_date:
  license_or_reuse_terms:
  registration_required:
  authentication_required:
  archive_required:
  evidence_manifest_required:
  modes_covered:
  operators_covered:
  operators_missing_or_unknown:
  geography_covered:
  coverage_against_independent_mtr_boundary:
  unserved_population_visibility:
  non_fixed_route_or_informal_service_gaps:
  accessibility_fields_available:
  fare_fields_available:
  realtime_fields_available:
  validation_status:
  source_limitations:
  denominator_prohibited: true
```

## Operator Completeness Checklist

For every proposed MTR-specific feed bundle, answer:

- Does the source represent one operator, several operators, or a national /
  regional access point?
- Are all material public-transport operators inside the independent MTR
  boundary identified?
- Are any modes excluded by source design, regulation, format, or publication
  practice?
- Are informal, demand-responsive, paratransit, privately operated, ferry,
  regional rail, commuter rail, or school-service modes relevant?
- Is the service source current, historical, or continuously updated?
- Is the feed valid for the same period as the proposed method test?
- Does the source require registration, API keys, terms acceptance, or
  non-public credentials?
- Can the feed be reproduced later from public artifacts?
- Would missing service sources hide unserved or weakly served populations?
- Is any service geography being used, even implicitly, as the MTR boundary?

## Registration/API-Access Rule

Registration-limited service sources are not automatically rejected, but they
carry an access caveat.

They may be used only if:

- public documentation identifies the source authority and data function;
- access terms are recordable;
- a later evidence manifest records how access was obtained;
- reproducibility limits are stated;
- the source is not the sole basis for a denominator or candidate selection.

If access cannot be reproduced or license terms cannot be recorded, the source
remains `source_lead_only` or `quarantined_insufficient_source`.

## Service-Derived Denominator Rule

The following are prohibited as MTR denominators:

- GTFS feed extents;
- route or stop buffers;
- agency service areas;
- fare zones;
- national access point catalog geography;
- realtime vehicle observation extents;
- crowdsourced feed-registry coverage.

These may become overlays or indicator inputs only after an independent MTR
boundary is defined.

## Lead Implications

### `mtr_src_001` Helsinki FUA

Status after S1E: HSL/Digitransit remains `source_lead_only`.

Next allowed output:

- service-source note after exact FUA boundary extraction plan exists.

### `mtr_src_002` Lyon FUA

Status after S1E: France NAP remains `needs_source_trace`.

Next allowed output:

- source trace identifying the specific Lyon/FUA-relevant dataset records,
  formats, operators, licenses, and vintages.

### `mtr_src_003` Bristol TTWA

Status after S1E: NaPTAN/BODS/non-bus sources remain `source_lead_only`.

Next allowed output:

- modal completeness source-note review.

### `mtr_src_005` Calgary CMA

Status after S1E: Calgary Transit and regional operator sources remain
`source_lead_only`.

Next allowed output:

- source-note review after exact CMA boundary/population source path is defined.

### `mtr_src_006` Greater Melbourne GCCSA

Status after S1E: Victoria DTP GTFS remains `source_lead_only`.

Next allowed output:

- source-note review after exact GCCSA boundary/population source path is
  defined.

### `mtr_src_008` Sao Paulo GHS-FUA

Status after S1E: SPTrans/EMTU remains `source_lead_only_high_access_risk`.

Next allowed output:

- access and license source trace, not readiness review.

## Evidence Manifest Decision

No evidence manifest is created in S1E.

Reason:

- S1E creates a service-source review queue and required fields.
- A manifest becomes required only if raw feeds, API responses, feed-link
  tables, validation reports, or archived service artifacts are acquired,
  transformed, or version-pinned.

## Methodology Implication

Thesis 2 should not begin data collection with service feeds. It should first
verify the independent MTR denominator, then use service feeds as indicator
inputs against that denominator.

This protects unserved populations from disappearing from the measurement
frame.

## Next Recommended Work

Create a source-system extraction workflow for the highest-priority boundary
family before creating any filled boundary record:

- first choice: Eurostat/OECD FUA exact-row extraction workflow;
- second choice: U.S. county-based readiness-review template run;
- hold modelled-boundary lead until burden-specific source trace is complete.

## Closing Guardrail

This batch does not select, admit, score, rank, or compare MTRs. It only defines
how local service sources can become reviewed indicator inputs after an
independent MTR boundary exists.
