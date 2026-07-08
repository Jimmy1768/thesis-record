# Sao Paulo GHS-FUA Boundary Classification Review

Date: 2026-07-05

Status: lead-specific modelled-boundary classification review. No MTR admitted.
No filled boundary record, evidence manifest, candidate list,
candidate-universe ledger, metric record, score, ranking, accepted denominator
value, or raw data archive is authorized.

Related lead:

- `mtr_src_008` Sao Paulo GHS-FUA

Related source notes:

- `theses/mobility-conversion/research/source_notes/ghs_functional_urban_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ghs_pop_population_grid_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/ghsl_degree_of_urbanisation_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ghsl_urban_centre_database_2026-06-28.md`

Related methodology:

- `theses/mobility-conversion/research/batch_s1d_modelled_global_boundary_burden_2026-07-01.md`

## Review Decision

Sao Paulo GHS-FUA can proceed only as a high-burden modelled global boundary
lead. It is not ready for readiness review, a filled boundary record, or raw
data acquisition.

Existing Thesis 2 notes verify that GHS-FUA and GHS-POP are plausible global
source systems, but the exact Sao Paulo GHS-FUA row, fallback justification,
population vintage pairing, official/national context search, built-form
overlay, and formal/informal service-source completeness remain unresolved.

## Lead Status

Previous intake status: `needs_boundary_classification_review`

New classification status:

```yaml
sao_paulo_ghs_fua_status:
  lead_id: mtr_src_008
  working_name: Sao Paulo GHS-FUA
  boundary_family: modelled_functional_region
  boundary_authority: European Commission JRC / GHSL
  classification_status: high_burden_modelled_boundary_handoff_ready
  exact_ghs_fua_row_status: unresolved
  fallback_justification_status: unresolved
  readiness_review_allowed: false
  boundary_record_allowed: false
  evidence_manifest_allowed: false
```

## What Is Now Known

```yaml
source_path_review:
  boundary_source_family:
    title: GHS-FUA R2019A
    authority: European Commission JRC / GHSL
    role: candidate fallback or validation modelled functional-region source
    verified_in_existing_notes: true
    raw_artifact_archived: false
  population_source_family:
    title: GHS-POP R2023A
    authority: European Commission JRC / GHSL
    role: candidate gridded resident-population denominator or reconciliation layer
    verified_in_existing_notes: true
    accepted_population_value: false
  overlay_source_families:
    - GHS-SMOD / Degree of Urbanisation
    - GHS-UCDB
    role: built-form and urban-centre overlay only
    accepted_as_boundary: false
  service_source_leads:
    - SPTrans
    - EMTU
    role: service-source leads only
    accepted_as_evidence: false
```

## What Is Not Known

- Exact GHS-FUA identifier, name, and row for Sao Paulo.
- Whether a stronger official, national, observed, hybrid, or statistical
  boundary exists and should outrank GHS-FUA.
- Exact GHS-FUA product/release/epoch fields needed for a future record.
- Whether the 2015 modelled boundary is too stale for a current method test.
- Which GHS-POP target year could pair defensibly with the GHS-FUA epoch.
- Whether GHS-POP should be used as denominator, reconciliation layer, or not at
  all if official denominators are available.
- Which built-form overlay should be used to inspect modelled-boundary fit.
- Whether model inputs overlap too strongly with explanatory axes, especially
  economic capacity.
- Whether SPTrans, EMTU, rail/metro, municipal, intermunicipal, informal,
  private, demand-responsive, and other service sources are traceable,
  reproducible, licensed, and complete enough.
- Whether registration/API constraints make service data non-reproducible.

## Required Next Fields

```yaml
sao_paulo_ghs_fua_required_fields:
  fallback_justification:
  official_or_national_boundary_search:
  exact_ghs_fua_identifier:
  exact_ghs_fua_name:
  product_release:
  boundary_epoch:
  coordinate_system:
  resolution:
  model_input_disclosure:
  economic_capacity_input_overlap_caveat:
  vintage_and_growth_review:
  ghs_pop_release:
  ghs_pop_target_year:
  population_summarization_method:
  accepted_denominator_value: false
  built_form_overlay_source:
  service_overlay_sources:
  formal_service_coverage_against_boundary:
  informal_or_weakly_documented_service_gaps:
  access_registration_or_license_constraints:
```

## Burden Effect

```yaml
burden_effect:
  boundary_source_eligibility: pass_only_as_high_burden_modelled_fallback_or_validation
  source_verification: partial_pass_source_families_only
  boundary_fit: blocked_exact_row_fallback_and_vintage_unresolved
  data_bundle_plausibility: high_risk_service_and_denominator_alignment_unresolved
  evidence_manifest_need: not_created_no_raw_artifact_acquired
  candidate_universe_guardrail: pass_no_admission
```

## Next Recommended Artifact

Create a Sao Paulo GHS-FUA high-burden exact-row/source-bundle workflow and
handoff.

The next artifact should not ask whether Sao Paulo is important, large,
congested, or transport-significant. It should ask for source-led extraction
and burden fields:

- exact GHS-FUA row;
- fallback justification against stronger source families;
- GHS-POP denominator/vintage pairing;
- built-form overlay source;
- official/national context source search;
- SPTrans/EMTU and other formal/informal service-source coverage.

## Prohibited Outputs

This review does not authorize:

- admitted MTR;
- readiness review;
- filled boundary record;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted denominator value;
- raw data archive without manifest.
