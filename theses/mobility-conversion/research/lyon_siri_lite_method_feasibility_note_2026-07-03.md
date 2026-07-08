# Lyon SIRI Lite Method Feasibility Note

Date: 2026-07-03

Status: formation-stage method feasibility note. No MTR admitted. No filled
boundary record, evidence manifest, candidate list, candidate-universe ledger,
metric record, score, ranking, accepted denominator value, raw feed archive, or
raw data archive is authorized.

Related lead:

- `mtr_src_002` Lyon FUA / `FR002F`

Related records:

- `theses/mobility-conversion/research/lyon_tcl_static_feed_availability_followup_2026-07-03.md`
- `theses/mobility-conversion/research/source_notes/france_nap_lyon_tcl_service_sources_2026-07-01.md`
- `theses/mobility-conversion/research/lyon_fua_service_source_trace_note_2026-07-01.md`

## Purpose

Evaluate whether available SIRI Lite resources for Lyon TCL can substitute for
unavailable static GTFS/NeTEx resources in Thesis 2 formation-stage method
work.

This note does not inspect or archive SIRI Lite feed contents. It only defines
the feasibility gates.

## Current Source Posture

The refreshed France NAP catalog metadata identifies:

```yaml
available_resources:
  - SIRI Lite estimated timetables
  - SIRI Lite situation exchange
  - SIRI Lite vehicle monitoring
unavailable_static_resources:
  - GTFS
  - NeTEx
  - PDF documentation
dataset_tags:
  - licence-mobilités
  - authentification_requise
dataset_license: mobility-licence
```

The static-feed blocker remains:

```yaml
static_feed_status: blocked_static_feed_unavailable
siri_lite_status: available_but_method_unresolved
```

## Feasibility Decision

SIRI Lite is not currently eligible to replace GTFS/NeTEx for a scheduled public
transport access method.

Formation-stage decision:

```yaml
siri_lite_method_feasibility:
  current_decision: not_eligible_without_schema_archive_and_completeness_review
  can_support_current_coverage_reconciliation: false
  can_support_historical_or_method_stress_test: possible_after_method_note
  can_support_metric_record: false
  raw_feed_archive_allowed_by_this_note: false
```

## Required Feasibility Gates

SIRI Lite can be reconsidered only if a later source/method note resolves all
of these gates:

```yaml
required_siri_lite_gates:
  schema_gate:
    question: >
      Does the SIRI Lite estimated-timetables response contain enough structured
      stop, route, trip, calendar, operator, mode, and accessibility information
      for the intended access method?
    current_status: unresolved
  snapshot_gate:
    question: >
      Can the SIRI Lite source produce a reproducible scheduled-service snapshot
      rather than only a volatile operational view?
    current_status: unresolved
  archive_gate:
    question: >
      Can the response be archived under an evidence manifest with timestamp,
      query path, checksum, license, and replay notes?
    current_status: unresolved
  completeness_gate:
    question: >
      Does SIRI Lite cover the same operator/mode scope as the missing GTFS or
      NeTEx feed, and is that scope sufficient for FR002F?
    current_status: unresolved
  vintage_gate:
    question: >
      What service day, validity window, or observation window would the SIRI
      Lite source represent?
    current_status: unresolved
  license_access_gate:
    question: >
      Do mobility-license and authentication requirements permit reproducible
      research use and later manifest archival?
    current_status: unresolved
  denominator_gate:
    question: >
      Can residents outside SIRI Lite coverage remain visible through an
      independent FR002F boundary and denominator?
    current_status: unresolved
```

If any gate remains unresolved, SIRI Lite must stay `available_but_method_unresolved`.

## Static Feed Preference Rule

GTFS or NeTEx remains the preferred static schedule source for scheduled access
testing.

SIRI Lite should be treated as a fallback path only if:

- current GTFS/NeTEx cannot be recovered from official sources;
- SIRI Lite schema and snapshot behavior are independently documented;
- the feed can be archived reproducibly;
- the method remains labelled as a fallback/stress-test method;
- no comparison or score is created from the result.

## Realtime / Dynamic Source Rule

The `situation-exchange` and `vehicle-monitoring` resources should be treated
as dynamic or operational inputs until proven otherwise.

They cannot support scheduled-service access testing unless a method note
defines:

- observation window;
- sampling interval;
- missingness and outage handling;
- retention/archive plan;
- reproducibility limits.

## FR002F Coverage Rule

Even if SIRI Lite becomes method-feasible, it cannot define the MTR.

The independent denominator remains `FR002F`. SIRI Lite coverage must be
reconciled against `FR002F`, and missing service or unserved population must
remain visible.

```yaml
service_geography_not_used_as_boundary: true
coverage_against_FR002F_required: true
unserved_population_visibility_required: true
```

## Lead Effect

```yaml
lead_effect:
  lead_id: mtr_src_002
  fua_code: FR002F
  static_feed_status: blocked_static_feed_unavailable
  siri_lite_status: available_but_method_unresolved
  current_access_method_allowed: false
  current_coverage_reconciliation_allowed: false
  next_required_work:
    - static_feed_recovery_handoff
    - SIRI_Lite_schema_and_license_source_note
    - non_TCL_operator_inventory_handoff
```

## Next Recommended Artifact

Create a Lyon source-recovery handoff asking research to find:

- current official GTFS or NeTEx recovery paths, if any;
- official SIRI Lite schema/documentation for the listed TCL resources;
- mobility-license and authentication terms;
- non-TCL operators and modes material inside `FR002F`.

## Prohibited Outputs

This note does not authorize:

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
