# Calgary CMA Boundary / Population Source-Path Review

Date: 2026-07-03

Status: lead-specific source-path review. No MTR admitted. No filled boundary
record, evidence manifest, candidate list, candidate-universe ledger, metric
record, score, ranking, accepted denominator value, or raw data archive is
authorized.

Related lead:

- `mtr_src_005` Calgary CMA

Related source notes:

- `theses/mobility-conversion/research/source_notes/statistics_canada_cma_ca_2021_current_glossary_followup_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/statistics_canada_2021_boundary_profile_source_paths_2026-07-03.md`

## Review Decision

Calgary CMA can proceed as a Canadian hybrid functional-statistical source-led
lead, but it is not ready for a filled boundary record.

Statistics Canada source paths for boundary files and Census Profile data are
identified. Exact Calgary CMA row/code, boundary artifact, population field, and
service-overlay fit remain unresolved.

## Lead Status

Previous intake status: `ready_for_source_note_review`

New source-path status:

```yaml
calgary_cma_status:
  lead_id: mtr_src_005
  working_name: Calgary CMA
  boundary_family: hybrid_functional_statistical_region
  boundary_authority: Statistics Canada
  source_path_status: boundary_and_profile_paths_identified
  exact_cma_row_status: unresolved
  boundary_record_allowed: false
  evidence_manifest_allowed: false
```

## What Is Now Known

```yaml
source_path_review:
  boundary_source_path:
    title: 2021 Census Boundary files
    authority: Statistics Canada
    catalogue_path: https://www150.statcan.gc.ca/n1/en/catalogue/92-160-X
    role: candidate boundary source path
    raw_artifact_archived: false
  population_source_path:
    title: 2021 Census Profile
    authority: Statistics Canada
    access_path: https://www12.statcan.gc.ca/census-recensement/2021/dp-pd/prof/index.cfm?Lang=E
    role: candidate population denominator source path
    accepted_population_value: false
  methodology_source:
    title: Illustrated Glossary - Census metropolitan area and census agglomeration
    authority: Statistics Canada
    path: https://www150.statcan.gc.ca/n1/pub/92-195-x/2021001/geo/cma-rmr/cma-rmr-eng.htm
```

## What Is Not Known

- Exact Calgary CMA code, DGUID, or row identifier.
- Exact Calgary CMA boundary artifact and version.
- Census subdivision membership and building blocks.
- Whether historical comparability, manual adjustment, or merge/secondary-core
  rules materially affect the Calgary CMA boundary.
- Population denominator table field and selected year.
- Calgary Transit service-source vintage and license.
- Whether Calgary Transit covers all material public-transport service inside
  the CMA.
- Whether regional/intermunicipal service, commuter service, airport service,
  paratransit, or demand-responsive services matter inside the CMA.

## Required Next Fields

```yaml
calgary_cma_required_fields:
  exact_code:
  exact_name:
  DGUID_or_equivalent:
  boundary_vintage:
  boundary_file_source:
  boundary_geometry_status: not_archived
  building_blocks:
  functional_basis: CMA/CA commuting-flow and population-core rules
  commuting_or_labour_market_vintage:
  historical_comparability_rule_impact:
  manual_adjustment_rule_impact:
  merge_or_secondary_core_rule_impact:
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
  source_verification: partial_pass_source_paths_only
  boundary_fit: blocked_exact_row_and_boundary_membership_unresolved
  data_bundle_plausibility: plausible_but_blocked_service_coverage_unknown
  evidence_manifest_need: not_created_no_raw_artifact_acquired
  candidate_universe_guardrail: pass_no_admission
```

## Next Recommended Artifact

Create an exact Calgary CMA row/code extraction workflow, or outsource a
Calgary CMA exact-row/source-bundle handoff.

The next artifact should not ask whether Calgary is a good transport region. It
should ask for source-led extraction fields:

- exact CMA code/DGUID;
- boundary file/product path;
- population denominator field/table;
- census subdivision membership;
- Calgary Transit and regional service-source coverage against the CMA.

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
