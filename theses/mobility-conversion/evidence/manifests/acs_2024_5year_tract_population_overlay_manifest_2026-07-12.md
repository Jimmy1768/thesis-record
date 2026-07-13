# ACS 2024 5-Year Tract Population Overlay Manifest

Status: reviewed provisional evidence manifest. Do not treat this file as an
accepted population or denominator record.

```yaml
manifest_id: acs_2024_5year_tract_population_overlay_manifest_2026_07_12
manifest_status: quality_review_complete_provisional_not_admitted
created: 2026-07-12
updated: 2026-07-13
operator_thread: Thesis 2

artifact_identity:
  source_family: American Community Survey 2024 5-year detailed table B01003
  source_name: ACS 2024 5-year tract population capture for subcounty overlay work
  source_authority: U.S. Census Bureau
  source_url_or_access_path:
    api_base: https://api.census.gov/data/2024/acs/acs5
    api_row_pattern: https://api.census.gov/data/2024/acs/acs5?get=NAME,B01003_001E,B01003_001M&for=tract:*&in=state:XX&in=county:YYY
    live_authentication: environment_only_CENSUS_API_KEY_appended_in_memory_only
  acquisition_mode: api_row_capture_per_exact_county
  retrieval_date: 2026-07-12T09:35:22.327850Z
  source_vintage: ACS 2024 5-year
  latest_known_release: official Census API row capture completed and locally reproduced as provisional Phase 4 input only
  geography:
    - tract
  source_note_path: theses/mobility-conversion/research/source_notes/us_census_acs_tiger_subcounty_overlay_sources_2026-07-06.md

intended_use:
  use_class: provisional_population_visibility_input_only
  related_boundary_record: none
  related_metric_record: none
  related_method_test: acs_tract_population_acquisition_join_plan_2026_07_12
  mtr_dependency:
    - Minneapolis-St. Paul ERS CZ lead
    - Portland-Vancouver-Hillsboro CBSA lead
  outcome_dimension: none
  source_role: subcounty_population_visibility_layer_for_tract_join_only

storage:
  raw_archive_path: theses/mobility-conversion/evidence/raw/us_census/acs_2024_5year_tract_population/
  processed_path: theses/mobility-conversion/evidence/processed/us_census/acs_2024_5year_tract_population/
  checksum:
    method: sha256
    county_json: exact_census_api_response_bytes_per_county
    index_json: stable_capture_index_order_with_run_timestamp
  file_format:
    county_payload: exact_api_list_of_lists_json_bytes
    index_payload: json
  secret_handling:
    census_api_key_storage: environment_only
    census_api_key_persisted: false
    census_api_key_logged: false
    query_url_in_index_is_public_and_key_free: true
  repository_storage_allowed: true
  raw_archive_created: true
  processed_overlay_created: true
  placeholder_directories_not_created_by_this_handoff: true
  nonempty_output_refusal_required: true
  partial_capture_allowed: false

artifact_review:
  raw_capture:
    county_json_files_present: 20
    capture_index_present: true
    capture_index_sha256: f03527a73b1c976efe79d9f9f450926d9c7d7f40584c81712228911d92594699
    total_data_rows: 1413
  processed_outputs:
    joined_csv_present: true
    joined_csv_sha256: 6fa719485f31276bf688afe7b8d0b5ccc539b9917dbca8952de789cfd410d6d3
    summary_json_present: true
    summary_json_sha256: 06a2fc9f55cf47ed138d9437eb25cc511185e6394d791df72e8050eca5e6909f
  coverage_review:
    minneapolis_ers_cz_tracts:
      geometry_rows: 845
      raw_rows: 845
      joined_rows: 845
      one_to_one_coverage: true
    portland_cbsa_tracts:
      geometry_rows: 568
      raw_rows: 568
      joined_rows: 568
      one_to_one_coverage: true
    total_rows: 1413
    total_one_to_one_coverage: true
  reproducibility_review:
    county_checksums_verified_against_index: true
    processed_outputs_reproduced_from_repository_raw_bytes: true
    reproduced_joined_csv_sha256: 6fa719485f31276bf688afe7b8d0b5ccc539b9917dbca8952de789cfd410d6d3
    reproduced_summary_json_sha256: 06a2fc9f55cf47ed138d9437eb25cc511185e6394d791df72e8050eca5e6909f
  secret_exposure_review:
    census_api_key_in_persisted_artifacts: false
    authenticated_query_url_in_persisted_artifacts: false
    machine_specific_absolute_paths_in_processed_summary: false

join_key_and_fields:
  join_key: STATEFP_plus_COUNTYFP_plus_TRACTCE
  requested_fields:
    - NAME
    - B01003_001E
    - B01003_001M
  preserve_estimate_and_moe: true
  reject_sentinel_values: true
  reject_negative_values: true
  reject_noninteger_estimate_or_moe: true
  reject_missing_or_mismatched_geography: true
  reject_aggregation: true
  reject_scoring: true
  reject_ranking: true

coverage_scope:
  minneapolis_counties:
    - "27003"
    - "27019"
    - "27025"
    - "27037"
    - "27053"
    - "27059"
    - "27065"
    - "27115"
    - "27123"
    - "27139"
    - "27163"
    - "55093"
    - "55109"
  portland_counties:
    - "41005"
    - "41009"
    - "41051"
    - "41067"
    - "41071"
    - "53011"
    - "53059"
  total_counties: 20
  first_pass_geography: tract
  fallback_geography_if_tract_too_coarse: block_group
  accepted_population_value: false
  accepted_denominator_value: false

quality_review:
  verification_status: capture_and_join_review_complete_provisional
  completeness_notes:
    - exact ACS API row capture completed for all 20 exact counties at 2026-07-12T09:35:22.327850Z
    - raw county payload checksums were independently reverified against index.json
    - raw capture index sha256 is f03527a73b1c976efe79d9f9f450926d9c7d7f40584c81712228911d92594699
    - processed joined CSV sha256 is 6fa719485f31276bf688afe7b8d0b5ccc539b9917dbca8952de789cfd410d6d3
    - processed summary JSON sha256 is 06a2fc9f55cf47ed138d9437eb25cc511185e6394d791df72e8050eca5e6909f
    - Minneapolis tract coverage is 845/845 and Portland tract coverage is 568/568
    - total tract coverage is 1413/1413 with one_to_one_coverage=true
    - local reproduction from repository raw bytes matched both processed artifacts byte-for-byte
    - persisted index and processed artifacts remain public-key-safe and machine-path-free
  known_limitations:
    - tract overlay remains provisional_population_visibility_input_only
    - no accepted population values
    - no accepted denominator values
    - no metric record, candidate admission, score, comparison, or rank
    - no MTR boundary admission or publication claim
    - tract coarseness and block-group escalation remain open for later review if needed

admissibility:
  allowed_for_source_note: true
  allowed_for_method_test: true
  allowed_for_boundary_record: false
  allowed_for_metric_record: false
  allowed_for_final_evidence: false
  decision: provisional_capture_and_join_review_complete_not_admitted
  decision_date: 2026-07-13
  rationale: >
    The ACS 2024 5-year detailed table B01003 tract capture has now been
    acquired, checksummed, joined read-only to the committed TIGER 2024 tract
    layers, and reproduced locally from repository raw bytes. That technical
    integrity is sufficient for a bounded Phase 4 pre-admission evidence review,
    but it still does not authorize any accepted population value, accepted
    denominator value, metric record, candidate admission, ranking, scoring, or
    publication claim.
  required_follow_up:
    - preserve the tract overlay as provisional input only
    - keep any future metric retest blocked until boundary, service, and travel-time authority conditions are explicitly resolved
    - later block-group escalation only if tract visibility proves too coarse
```

## Manifest Limits

This manifest records source identity, exact tract query shape, county scope,
actual raw and processed artifact presence, exact-byte checksum posture,
reproducibility review, and read-only join guardrails. It does not accept a
population value, accept a denominator, create a boundary record, create an
outcome metric record, calculate scores, rank places, or support final paper
claims.
