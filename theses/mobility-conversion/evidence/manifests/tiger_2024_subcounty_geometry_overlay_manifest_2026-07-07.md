# TIGER 2024 Subcounty Geometry Overlay Manifest

Status: draft evidence manifest. Do not treat this file as accepted evidence.

```yaml
manifest_id: tiger_2024_subcounty_geometry_overlay_manifest_2026_07_07
manifest_status: feature_level_validation_passed_population_join_pending
created: 2026-07-07
updated: 2026-07-12
operator_thread: Thesis 2

artifact_identity:
  source_family: TIGER/Line tract_and_block_group_geometry
  source_name: TIGER/Line 2024 tract and block group state ZIP files
  source_authority: U.S. Census Bureau
  source_url_or_access_path:
    tract_minnesota_2024: https://www2.census.gov/geo/tiger/TIGER2024/TRACT/tl_2024_27_tract.zip
    block_group_minnesota_2024: https://www2.census.gov/geo/tiger/TIGER2024/BG/tl_2024_27_bg.zip
    tract_wisconsin_2024: https://www2.census.gov/geo/tiger/TIGER2024/TRACT/tl_2024_55_tract.zip
    block_group_wisconsin_2024: https://www2.census.gov/geo/tiger/TIGER2024/BG/tl_2024_55_bg.zip
    tract_oregon_2024: https://www2.census.gov/geo/tiger/TIGER2024/TRACT/tl_2024_41_tract.zip
    block_group_oregon_2024: https://www2.census.gov/geo/tiger/TIGER2024/BG/tl_2024_41_bg.zip
    tract_washington_2024: https://www2.census.gov/geo/tiger/TIGER2024/TRACT/tl_2024_53_tract.zip
    block_group_washington_2024: https://www2.census.gov/geo/tiger/TIGER2024/BG/tl_2024_53_bg.zip
  acquisition_mode: bulk_file_download_under_existing_manifest
  retrieval_date: 2026-07-07
  source_vintage: TIGER/Line 2024
  latest_known_release: official TIGER2024 state ZIP paths checked by HEAD on 2026-07-07
  geography:
    - Minnesota tract
    - Minnesota block group
    - Wisconsin tract
    - Wisconsin block group
    - Oregon tract
    - Oregon block group
    - Washington tract
    - Washington block group
  source_note_path: theses/mobility-conversion/research/source_notes/us_census_acs_tiger_subcounty_overlay_sources_2026-07-06.md

intended_use:
  use_class: county_coarseness_subcounty_population_visibility_geometry
  related_boundary_record: none
  related_metric_record: none
  related_method_test: county_coarseness_overlay_plan_2026_07_06
  mtr_dependency:
    - Minneapolis-St. Paul ERS CZ lead
    - Portland-Vancouver-Hillsboro CBSA lead
  outcome_dimension: none
  source_role: geometry_layer_for_future_tract_or_block_group_population_overlay

storage:
  raw_archive_path: theses/mobility-conversion/evidence/raw/us_census/tiger_2024_subcounty_geometry/
  processed_path:
    minneapolis_ers_cz_tracts: theses/mobility-conversion/evidence/processed/us_census/tiger_2024_subcounty_geometry/minneapolis_ers_cz_tracts/
    minneapolis_ers_cz_block_groups: theses/mobility-conversion/evidence/processed/us_census/tiger_2024_subcounty_geometry/minneapolis_ers_cz_block_groups/
    portland_cbsa_tracts: theses/mobility-conversion/evidence/processed/us_census/tiger_2024_subcounty_geometry/portland_cbsa_tracts/
    portland_cbsa_block_groups: theses/mobility-conversion/evidence/processed/us_census/tiger_2024_subcounty_geometry/portland_cbsa_block_groups/
  checksum:
    tl_2024_27_bg.zip: 608a2cf783eb473f0e0d1d96085cd9b36f5d0581e25556f95686b2a1af71ed5f
    tl_2024_27_tract.zip: ff85e970af09db62e28f1010cbf51c0241373da4e75b168aee76ca224473f3ce
    tl_2024_41_bg.zip: 3c6ab8255d8300f25c9605c3550abd6fe3b39c768d5827b327cf180d1e4d2525
    tl_2024_41_tract.zip: 5c429b7577273441ee7f045718cb9989a6fb03f6bf72167410efebbc144cba5c
    tl_2024_53_bg.zip: 6a650e5db7510922815eba5e40623e6985803987469198408dc1e9a0d7fcefe4
    tl_2024_53_tract.zip: 60af16a9d108a55e8a9642dc38c77d10e77b143c2303758fc5bd626229e3a89f
    tl_2024_55_bg.zip: 3832c7b938ae357e88f162d6d97f141cdab9efced9684d60de62ab3708ff57e0
    tl_2024_55_tract.zip: 313c378d7fa173bf653381d644d8ded7b4f6241b2065d2b890e1fccccaab5de5
  checksum_method: sha256
  file_format: remote_zip_shapefile_bundle
  file_size:
    tract_minnesota_2024_content_length: 7492209
    block_group_minnesota_2024_content_length: 13095867
    tract_wisconsin_2024_content_length: 7642880
    block_group_wisconsin_2024_content_length: 13843348
    tract_oregon_2024_content_length: 10648349
    block_group_oregon_2024_content_length: 16965287
    tract_washington_2024_content_length: 9827813
    block_group_washington_2024_content_length: 16249192
    total_byte_size: 95764945
  license_or_reuse_notes: reviewed_us_government_work_reproduction_allowed_cite_census_trademark_notice_required
  redistribution_allowed: true
  repo_storage_allowed: true

boundary_and_geography:
  geographic_unit:
    - tract
    - block group
  mtr_boundary_compatibility: overlay_only_not_boundary_source
  requires_crosswalk: true
  crosswalk_method: future_spatial_overlay_or_geoid_join_after_raw_geometry_and_population_tables_are_verified
  known_boundary_mismatch: county_based_boundary_coarseness_requires_subcounty_visibility_review
  denominator_risk: no_denominator_value_accepted_geometry_only

vintage_and_refresh:
  source_release_cadence: annual_tiger_line_release_expected_not_reviewed
  intended_refresh_cadence: per_method_test_or_boundary_vintage_update
  vintage_alignment_class: geometry_vintage_verified_acs_table_vintage_deferred
  volatility_flag: low_for_geometry_high_for_method_alignment_if_acs_vintage_differs
  refresh_trigger: newer_tiger_release_or_acs_population_table_vintage_decision

quality_review:
  verification_status: raw_and_processed_geometry_created_checksummed_readback_passed_feature_level_validation_passed_population_join_pending
  completeness_notes:
    - all_required_state_tract_paths_for_current_minneapolis_and_portland_overlay_scope_head_verified
    - all_required_state_block_group_paths_for_current_minneapolis_and_portland_overlay_scope_head_verified
    - all_required_raw_zip_files_downloaded
    - all_required_raw_zip_files_sha256_checksummed
    - all_required_raw_zip_files_passed_unzip_integrity_tests
    - each_zip_contains_expected_shapefile_sidecar_set
    - shapefile_schema_and_feature_counts_reviewed
    - coordinate_reference_system_reviewed_as_GCS_North_American_1983
    - geometry_boundary_alignment_plan_created
    - pyshp_extraction_tooling_validated
    - processed_county_filtered_geometry_created
    - processed_geometry_readback_counts_and_bounding_boxes_recorded
    - processed_geometry_checksums_recorded
    - feature_level_processed_geometry_validation_passed_for_minneapolis_and_portland_tracts_and_block_groups
    - processed_sidecar_sha256_hashes_match_the_extraction_log
    - block_group_parent_tract_membership_confirmed
    - ACS population tables not verified or archived
  missingness_class: no_missing_sidecars_detected_schema_level_only
  comparability_class: likely_comparable_within_tiger_2024_pending_raw_inspection
  source_rich_region_bias_risk: low_for_geometry_source_availability
  informal_or_unreported_activity_bias_risk: not_applicable_to_geometry
  known_limitations:
    - geometry_only_no_population_values
    - ACS API access_blocked_in_current_environment
    - no_planar_coverage_topology_validation_done
    - no_visual_review_of_processed_outputs
    - source_metadata_xml_not_copied_to_combined_derived_outputs
    - no boundary_record_or_metric_record_dependency_allowed

admissibility:
  allowed_for_source_note: true
  allowed_for_method_test: false
  allowed_for_boundary_record: false
  allowed_for_metric_record: false
  allowed_for_final_evidence: false
  decision: feature_level_geometry_validation_passed_population_join_pending
  decision_date: 2026-07-12
  rationale: >
    Official U.S. Census Bureau TIGER/Line 2024 tract and block-group state ZIP
    paths for Minnesota, Wisconsin, Oregon, and Washington have been verified by
    HEAD requests and downloaded under a reviewed license/storage posture. Raw
    ZIP checksums, ZIP integrity checks, shapefile schema review, feature-count
    capture, coordinate-reference metadata review, boundary-alignment planning,
    county-filtered processed geometry extraction, and feature-level processed
    geometry validation are complete. ACS population-table acquisition and
    downstream overlay method gates remain unresolved, and empirical tract
    sufficiency is still pending.
  required_follow_up:
    - design bounded Phase 4 ACS tract population acquisition and join work
    - test tract-level sufficiency empirically in Phase 4
    - keep block-group escalation available for peripheral or edge sensitivity
    - keep ACS population-table acquisition deferred until API row verification succeeds
```

License and repository-storage review:

- `theses/mobility-conversion/research/tiger_2024_license_storage_review_2026-07-07.md`

Raw acquisition log:

- `theses/mobility-conversion/research/tiger_2024_raw_geometry_acquisition_log_2026-07-07.md`

Raw geometry quality review:

- `theses/mobility-conversion/research/tiger_2024_raw_geometry_quality_review_2026-07-07.md`

Geometry boundary-alignment plan:

- `theses/mobility-conversion/research/tiger_2024_geometry_boundary_alignment_plan_2026-07-07.md`

Processed geometry extraction log:

- `theses/mobility-conversion/research/tiger_2024_processed_geometry_extraction_log_2026-07-08.md`

## Manifest Limits

This manifest records source identity, intended use, verified remote path
metadata, raw ZIP archive location, checksums, ZIP integrity status, and
county-filtered processed geometry locations. It does not accept a population
value, accept a denominator, fill a boundary record, create an outcome metric
record, calculate scores, rank places, or support final paper claims.
