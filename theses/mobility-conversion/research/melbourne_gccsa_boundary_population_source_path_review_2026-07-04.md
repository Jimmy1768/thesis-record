# Greater Melbourne GCCSA Boundary / Population Source-Path Review

Date: 2026-07-04

Status: lead-specific source-path review. No MTR admitted. No exact GCCSA row
accepted. No filled boundary record, evidence manifest, candidate list,
candidate-universe ledger, metric record, score, ranking, accepted denominator
value, or raw data archive is authorized.

Related lead:

- `mtr_src_006` Greater Melbourne GCCSA

Related source note:

- `theses/mobility-conversion/research/source_notes/abs_asgs_sa4_gccsa_2026-06-28.md`

## Review Decision

Greater Melbourne GCCSA can proceed as an Australian hybrid
functional-statistical source-led lead, but it is not ready for a filled
boundary record.

ABS ASGS Edition 3 source paths and methodology are identified. Exact Greater
Melbourne GCCSA code, boundary artifact, population denominator field, ASGS
edition-transition posture, and Victoria service-source coverage remain
unresolved.

## Lead Status

Previous intake status: `ready_for_source_note_review`

New source-path status:

```yaml
melbourne_gccsa_status:
  lead_id: mtr_src_006
  working_name: Greater Melbourne GCCSA
  boundary_family: hybrid_functional_statistical_region
  boundary_authority: Australian Bureau of Statistics
  source_path_status: asgs_gccsa_source_family_identified
  exact_gccsa_row_status: unresolved
  boundary_record_allowed: false
  evidence_manifest_allowed: false
```

## What Is Now Known

```yaml
source_path_review:
  boundary_source_family:
    title: Australian Statistical Geography Standard ASGS Edition 3
    authority: Australian Bureau of Statistics
    source_path: https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026
    role: candidate boundary source family
    raw_artifact_archived: false
  methodology_source:
    title: Main Structure and Greater Capital City Statistical Areas
    authority: Australian Bureau of Statistics
    source_path: https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/main-structure-and-greater-capital-city-statistical-areas
  gccsa_source:
    title: Greater Capital City Statistical Areas
    authority: Australian Bureau of Statistics
    source_path: https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/main-structure-and-greater-capital-city-statistical-areas/greater-capital-city-statistical-areas
```

## What Is Not Known

- Exact Greater Melbourne GCCSA code or row identifier.
- Exact boundary file/product path and layer.
- Whether Edition 3 or an Edition 4 transition source should govern the first
  extraction attempt.
- SA4 building blocks included in Greater Melbourne GCCSA.
- Population denominator table/source and field.
- Victoria DTP GTFS source vintage, license, and archive posture.
- Whether statewide GTFS coverage fully represents public transport inside the
  GCCSA.
- Whether regional rail, coach, ferry, demand-responsive, school, paratransit,
  airport, or privately operated services matter inside the GCCSA.

## Required Next Fields

```yaml
melbourne_gccsa_required_fields:
  exact_code:
  exact_name:
  ASGS_edition:
  boundary_vintage:
  boundary_file_source:
  boundary_geometry_status: not_archived
  building_blocks:
    - SA4_membership
  functional_basis: capital_city_functional_area_built_from_SA4s
  labour_market_or_service_access_basis:
  statistical_stability_rules:
  population_denominator_source:
  population_vintage:
  accepted_denominator_value: false
  service_overlay_source:
  service_coverage_against_boundary:
  source_rich_region_bias_risk:
```

## Readiness Effect

```yaml
readiness_effect:
  boundary_source_eligibility: pass_at_source_family_level
  source_verification: partial_pass_source_family_only
  boundary_fit: blocked_exact_row_boundary_artifact_and_SA4_membership_unresolved
  data_bundle_plausibility: plausible_but_blocked_service_coverage_unknown
  evidence_manifest_need: not_created_no_raw_artifact_acquired
  candidate_universe_guardrail: pass_no_admission
```

## Next Recommended Artifact

Create an exact Greater Melbourne GCCSA row/code extraction workflow and
external research handoff.

The next artifact should not ask whether Melbourne is a good transport region.
It should ask for source-led extraction fields:

- exact GCCSA code/name;
- ASGS edition and boundary product path;
- SA4 building blocks;
- population denominator field/table;
- Victoria DTP GTFS and other service-source coverage against the GCCSA.

## Prohibited Outputs

This review does not authorize:

- admitted MTR;
- filled boundary record;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted denominator value;
- raw data archive without manifest.
