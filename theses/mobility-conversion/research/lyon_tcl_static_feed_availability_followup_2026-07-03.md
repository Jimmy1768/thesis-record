# Lyon TCL Static Feed Availability Follow-Up

Date: 2026-07-03

Status: source-availability follow-up. No MTR admitted. No filled boundary
record, evidence manifest, candidate list, candidate-universe ledger, metric
record, score, ranking, accepted denominator value, or raw data archive is
authorized.

Related lead:

- `mtr_src_002` Lyon FUA / `FR002F`

Related source note:

- `theses/mobility-conversion/research/source_notes/france_nap_lyon_tcl_service_sources_2026-07-01.md`

Related trace note:

- `theses/mobility-conversion/research/lyon_fua_service_source_trace_note_2026-07-01.md`

## Inspection Scope

The France National Access Point catalog metadata was refreshed on 2026-07-03.

Only catalog/API metadata was inspected. No GTFS, NeTEx, SIRI Lite, PDF, or
other raw service artifact was downloaded into the repository.

Temporary local files used only for inspection:

- `/tmp/thesis2-fr-nap-tcl-20260703.json`
- `/tmp/thesis2-fr-nap-api-doc-20260703.md`

These temporary files are not evidence archives.

## Catalog API Access

The refreshed PAN API documentation states that the transport.data.gouv.fr API
for reusing data is available:

```yaml
catalog_api:
  authentication: none_for_catalog_api
  quota: none_for_catalog_api
  format: JSON
  includes:
    - datasets
    - resources
    - AOMs
    - history
    - validations
  endpoints:
    - https://transport.data.gouv.fr/api/datasets
    - https://transport.data.gouv.fr/api/datasets/:id
```

This openness applies to the catalog/API metadata. It does not remove resource
access or license constraints on individual datasets.

## Refreshed Dataset Metadata

```yaml
dataset:
  id: 5de42c4d8b4c417a10e62ec9
  title: Réseau urbain TCL
  publisher: SYTRAL Mobilités
  legal_owner: SYTRAL Mobilités
  updated: 2026-05-12T22:15:44.378000Z
  licence: mobility-licence
  tags:
    - licence-mobilités
    - authentification_requise
```

The dataset remains an official traced service-source lead, but it is not yet a
usable static schedule archive for Thesis 2.

## Refreshed Resource Availability

```yaml
resources:
  available:
    - resource_id: 84026
      format: SIRI Lite
      title: Horaires théoriques du réseau Transports en Commun Lyonnais
      updated: 2026-05-12T07:07:46.116000Z
      original_url: https://data.grandlyon.com/siri-lite/2.0/estimated-timetables.json
    - resource_id: 84027
      format: SIRI Lite
      title: Horaires théoriques du réseau Transports en Commun Lyonnais
      updated: 2026-05-12T07:07:46.117000Z
      original_url: https://data.grandlyon.com/siri-lite/2.0/situation-exchange.json
    - resource_id: 84028
      format: SIRI Lite
      title: Horaires théoriques du réseau Transports en Commun Lyonnais
      updated: 2026-05-12T22:15:44.378000Z
      original_url: https://data.grandlyon.com/siri-lite/2.0/vehicle-monitoring.json
  unavailable_in_catalog_response:
    - resource_id: 80087
      format: pdf
      updated: 2025-01-22T23:07:31.266000Z
      original_url: https://download.data.grandlyon.com/files/rdata/tcl_sytral.tcltheorique/OFFREDETRANSPORT_TCL.PDF
    - resource_id: 65813
      format: NeTEx
      updated: 2025-01-22T23:07:31.266000Z
      original_url: https://download.data.grandlyon.com/files/rdata/tcl_sytral.tcltheorique/NETEX_TCL.ZIP
    - resource_id: 65812
      format: GTFS
      updated: 2025-01-22T23:07:31.267000Z
      original_url: https://download.data.grandlyon.com/files/rdata/tcl_sytral.tcltheorique/GTFS_TCL.ZIP
```

## Static Feed Decision

Current decision:

```yaml
lyon_static_feed_status:
  current_static_gtfs_available: false
  current_static_netex_available: false
  catalog_lists_static_resources: true
  catalog_marks_static_resources_available: false
  available_current_resources_are_siri_lite: true
  readiness_effect: blocked_static_feed_unavailable
```

The old GTFS metadata embedded in the catalog remains historical and
unavailable. It must not be treated as current service evidence.

## SIRI Lite Substitution Risk

SIRI Lite resources are currently available in the catalog, but they are not an
automatic substitute for a static GTFS or NeTEx archive.

Before SIRI Lite can support any method test, Thesis 2 needs a method note that
answers:

- whether the SIRI Lite `estimated-timetables` endpoint can provide a complete
  scheduled-service snapshot;
- whether the response can be archived reproducibly under a manifest;
- whether the format includes enough stop, route, calendar, accessibility, and
  operator fields for the intended access method;
- whether `situation-exchange` and `vehicle-monitoring` are realtime/dynamic
  inputs that require observation-window design;
- whether authentication and the `mobility-licence` terms allow reproducible
  research use.

## Lead Effect

Lyon FUA remains blocked for current-performance coverage reconciliation.

```yaml
lead_effect:
  lead_id: mtr_src_002
  fua_code: FR002F
  service_status: source_trace_found_static_feed_unresolved
  static_feed_status: blocked_static_feed_unavailable
  siri_lite_status: available_but_method_unresolved
  current_coverage_reconciliation_allowed: false
  historical_or_method_stress_test_allowed: only_after_method_note
```

## Next Allowed Output

Allowed:

- SIRI Lite method feasibility note;
- France NAP / mobility-license source-note follow-up;
- Lyon non-TCL operator inventory handoff;
- raw-return handoff for current GTFS/NeTEx recovery paths.

## Prohibited Outputs

This follow-up does not authorize:

- admitted MTR;
- filled boundary record;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted denominator value;
- raw feed archive;
- raw data archive without manifest.
