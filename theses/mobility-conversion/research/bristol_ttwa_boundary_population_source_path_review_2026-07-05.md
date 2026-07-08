# Bristol TTWA Boundary / Population Source-Path Review

Date: 2026-07-05

Status: lead-specific source-path review. No MTR admitted. No filled boundary
record, evidence manifest, candidate list, candidate-universe ledger, metric
record, score, ranking, accepted denominator value, or raw data archive is
authorized.

Related lead:

- `mtr_src_003` Bristol TTWA

Related source notes:

- `theses/mobility-conversion/research/source_notes/ons_travel_to_work_areas_national_method_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ons_travel_to_work_caveats_2026-06-28.md`

## Review Decision

Bristol TTWA can proceed as a United Kingdom national commuting-zone source-led
lead, but it is not ready for a filled boundary record.

Existing Thesis 2 TTWA notes verify the broad source-family relevance and the
need for commute-vintage caveats. They do not yet verify the exact Bristol TTWA
row/code, official boundary product, population aggregation path, or service
coverage bundle.

## Lead Status

Previous intake status: `ready_for_source_note_review`

New source-path status:

```yaml
bristol_ttwa_status:
  lead_id: mtr_src_003
  working_name: Bristol TTWA
  boundary_family: national_commuting_zone
  boundary_authority: ONS
  source_path_status: source_family_relevance_verified_exact_paths_unresolved
  exact_ttwa_row_status: unresolved
  boundary_record_allowed: false
  evidence_manifest_allowed: false
```

## What Is Now Known

```yaml
source_path_review:
  method_source_family:
    authority: Office for National Statistics
    role: candidate national commuting-zone source family
    verified_in_existing_notes: true
  caveat_source_family:
    authority: Office for National Statistics / ONS Data Science Campus
    role: commute-vintage and pandemic/remote-work caveat source
    verified_in_existing_notes: true
  service_source_leads:
    - NaPTAN
    - Bus Open Data Service
    - rail source overlay if material
    - ferry or other non-bus overlays if material
    role: service-source leads only
    accepted_as_evidence: false
```

## What Is Not Known

- Exact Bristol TTWA official name, code, or row identifier.
- Exact TTWA boundary product, layer, version, and download path.
- Exact commuting-flow vintage and boundary delineation vintage for the Bristol
  row.
- Official population denominator path for the same geography.
- Whether the population denominator should be direct, lookup-based, or
  small-area aggregation.
- Whether the Bristol TTWA materially over-includes rural labour-market
  hinterland for an MTR denominator.
- Whether NaPTAN and Bus Open Data Service cover all material public-transport
  service inside the TTWA.
- Whether rail, ferry, coach, demand-responsive, paratransit, or privately
  operated services are material inside the TTWA.
- Whether post-2020 work-from-home disruption makes the TTWA unsuitable for a
  current-comparison method test or only requires a caveat.

## Required Next Fields

```yaml
bristol_ttwa_required_fields:
  exact_code:
  exact_name:
  boundary_vintage:
  commuting_or_labour_market_vintage:
  boundary_file_source:
  boundary_geometry_status: not_archived
  building_blocks:
  delineation_method_source:
  self_containment_threshold_or_algorithm:
  pandemic_or_remote_work_caveat:
  population_denominator_source:
  population_vintage:
  population_aggregation_method:
  accepted_denominator_value: false
  service_overlay_sources:
  service_coverage_against_boundary:
  missing_modes_or_operators:
  source_rich_region_bias_risk:
```

## Readiness Effect

```yaml
readiness_effect:
  boundary_source_eligibility: pass_at_source_family_level
  source_verification: partial_pass_source_family_and_caveats_only
  boundary_fit: blocked_exact_row_boundary_and_population_paths_unresolved
  data_bundle_plausibility: plausible_but_blocked_service_coverage_unknown
  evidence_manifest_need: not_created_no_raw_artifact_acquired
  candidate_universe_guardrail: pass_no_admission
```

## Next Recommended Artifact

Create an exact Bristol TTWA row/code extraction workflow and handoff an exact
row/source-bundle request to external research.

The next artifact should not ask whether Bristol is a good transport region. It
should ask for source-led extraction fields:

- exact TTWA code/name;
- boundary product and layer path;
- TTWA delineation-method source;
- population denominator path and aggregation method;
- NaPTAN, Bus Open Data Service, rail, ferry, coach, and other material
  service-source coverage against the TTWA.

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
