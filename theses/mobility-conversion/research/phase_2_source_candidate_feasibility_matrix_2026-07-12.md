# Phase 2 Source-Candidate Feasibility Matrix

Date: 2026-07-12

Status: bounded source-led feasibility matrix. These are source-led research
leads, not admitted MTRs, not a candidate list, not a candidate universe, not a
comparison, and not a ranking.

## Scope

This matrix records the auditable Phase 2 disposition for the bounded eight-lead
intake. Every lead has:

- a verified source-family posture;
- an explicit blocker or Phase 3 route;
- a next allowed output.

## Matrix

| lead_id | working_name | source_family | authority | verified_source_note_path | current_blocker_posture | Phase 2 disposition | next_allowed_output |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `mtr_src_001` | Helsinki FUA | `observed_functional_region` | OECD / Eurostat GISCO | `theses/mobility-conversion/research/source_notes/oecd_helsinki_fua_municipality_membership_2026-07-05.md` | `municipality_membership_verified_service_completeness_blocked` | `source_feasible_but_blocked` | `reconcile_non_hsl_service_source_coverage_against_FI001F_membership` |
| `mtr_src_002` | Lyon FUA | `observed_functional_region` | Eurostat GISCO / OECD / France NAP | `theses/mobility-conversion/research/source_notes/france_nap_lyon_tcl_static_feed_recovery_2026-07-05.md` | `static_feed_and_siri_method_blocked` | `source_feasible_but_blocked` | `resolve_authenticated_tcl_static_feed_access_licence_and_siri_lite_method` |
| `mtr_src_003` | Bristol TTWA | `national_commuting_zone` | ONS | `theses/mobility-conversion/research/source_notes/ons_bristol_ttwa_exact_row_2026-07-05.md` | `exact_row_verified_boundary_population_and_service_blocked` | `source_feasible_but_blocked` | `verify_raw_boundary_geometry_population_path_and_service_materiality` |
| `mtr_src_004` | Minneapolis-St. Paul ERS CZ | `national_commuting_zone` | USDA ERS | `theses/mobility-conversion/research/source_notes/usda_ers_minneapolis_cz_exact_membership_2026-07-05.md` | `processed_tiger_geometry_created_quality_review_next` | `advance_to_phase_3_boundary_geometry_validation` | `advance_to_phase_3_boundary_geometry_validation` |
| `mtr_src_005` | Calgary CMA | `hybrid_functional_statistical_region` | Statistics Canada | `theses/mobility-conversion/research/source_notes/statistics_canada_calgary_cma_exact_row_2026-07-05.md` | `boundary_feature_verified_population_dguid_conflict` | `source_feasible_but_blocked` | `resolve_statistics_canada_dguid_profile_relation_population_path_and_service_overlay_caveats` |
| `mtr_src_006` | Greater Melbourne GCCSA | `hybrid_functional_statistical_region` | Australian Bureau of Statistics | `theses/mobility-conversion/research/source_notes/abs_greater_melbourne_gccsa_exact_row_2026-07-05.md` | `exact_row_verified_boundary_population_and_fit_blocked` | `source_feasible_but_blocked` | `verify_abs_population_path_sa4_membership_and_service_overlay_caveats` |
| `mtr_src_007` | Portland-Vancouver-Hillsboro CBSA | `official_statistical_metro` | U.S. Census Bureau / OMB | `theses/mobility-conversion/research/source_notes/us_census_portland_cbsa_exact_boundary_2026-07-05.md` | `processed_tiger_geometry_created_quality_review_next` | `advance_to_phase_3_boundary_geometry_validation` | `advance_to_phase_3_boundary_geometry_validation` |
| `mtr_src_008` | Sao Paulo GHS-FUA | `modelled_functional_region` | European Commission JRC / GHSL | `theses/mobility-conversion/research/source_notes/jrc_ghsl_sao_paulo_ghs_fua_source_system_2026-07-05.md` | `source_system_verified_exact_row_and_fallback_blocked` | `quarantined_high_burden_fallback` | `review_ibge_alternatives_or_prepare_manifest_before_ghs_fua_geopackage_extraction` |

## Disposition Counts

- `advance_to_phase_3_boundary_geometry_validation`: 2
- `source_feasible_but_blocked`: 5
- `quarantined_high_burden_fallback`: 1

## Closure Basis

Phase 2 can close for this bounded intake because the work objective was source
and candidate feasibility, not admission. Every lead now has an auditable
source-family posture and a next allowed output.

The downstream blockers remain real, but they no longer prevent Phase 2 from
closing:

- Helsinki and Lyon remain source-feasible but blocked on service/source
  completeness work.
- Bristol, Calgary, and Melbourne remain source-feasible but blocked on
  boundary, population, or fit work.
- Minneapolis and Portland are routed forward to Phase 3 boundary geometry
  validation.
- Sao Paulo remains a quarantined high-burden fallback.

## Source Truth References

- `theses/mobility-conversion/thesis.yml`
- `theses/mobility-conversion/README.md`
- `theses/mobility-conversion/research/source_led_mtr_proposal_intake_2026-07-01.md`
- `theses/mobility-conversion/research/source_led_mtr_followup_batch_plan_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/oecd_helsinki_fua_municipality_membership_2026-07-05.md`
- `theses/mobility-conversion/research/source_notes/france_nap_lyon_tcl_static_feed_recovery_2026-07-05.md`
- `theses/mobility-conversion/research/source_notes/ons_bristol_ttwa_exact_row_2026-07-05.md`
- `theses/mobility-conversion/research/source_notes/usda_ers_minneapolis_cz_exact_membership_2026-07-05.md`
- `theses/mobility-conversion/research/source_notes/statistics_canada_calgary_cma_exact_row_2026-07-05.md`
- `theses/mobility-conversion/research/source_notes/abs_greater_melbourne_gccsa_exact_row_2026-07-05.md`
- `theses/mobility-conversion/research/source_notes/us_census_portland_cbsa_exact_boundary_2026-07-05.md`
- `theses/mobility-conversion/research/source_notes/jrc_ghsl_sao_paulo_ghs_fua_source_system_2026-07-05.md`
