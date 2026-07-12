# ACS 2024 5-Year Tract Population Overlay Manifest

Status: draft evidence manifest. Do not treat this file as accepted evidence.

```yaml
manifest_id: acs_2024_5year_tract_population_overlay_manifest_2026_07_12
manifest_status: needs_source_verification
created: 2026-07-12
updated: 2026-07-12
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
  retrieval_date: null
  source_vintage: ACS 2024 5-year
  latest_known_release: official Census API path identified; live row capture remains externally deferred
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
  raw_archive_created: false
  processed_overlay_created: false
  placeholder_directories_not_created_by_this_handoff: true
  nonempty_output_refusal_required: true
  partial_capture_allowed: false

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
  verification_status: draft_needs_api_row_verification
  completeness_notes:
    - exact ACS API row query pattern identified
    - live capture requires environment-only CENSUS_API_KEY authentication
    - exact tract county scope identified for Minneapolis and Portland
    - geometry vintage alignment required with TIGER 2024 tract layers
    - raw county files must preserve exact Census API response bytes
    - capture index records byte checksums and retrieval metadata
    - capture index query_url values must remain public and key-free
    - join tool will remain read-only and checksum-verified
    - live ACS row capture remains blocked in the current environment
  known_limitations:
    - no ACS raw county JSON archived yet
    - no ACS processed join output archived yet
    - no accepted population values
    - no accepted denominator values
    - no aggregation, score, or rank

admissibility:
  allowed_for_source_note: true
  allowed_for_method_test: false
  allowed_for_boundary_record: false
  allowed_for_metric_record: false
  allowed_for_final_evidence: false
  decision: needs_source_verification
  decision_date: 2026-07-12
  rationale: >
    The ACS 2024 5-year detailed table B01003 tract capture is the intended
    subcounty population visibility source for Phase 4, but the current
    environment still cannot verify live API rows. This manifest therefore
    records the exact query family, county scope, storage layout, exact-byte
    checksum posture, and join guardrails without authorizing any raw acquisition,
    processed output, accepted population value, accepted denominator value,
    ranking, scoring, or publication claim.
  required_follow_up:
    - external-environment ACS row capture for each exact county
    - checksum-verified raw county JSON capture
    - checksum-verified read-only tract join
    - later block-group escalation only if tract visibility proves too coarse
```

## Manifest Limits

This manifest records source identity, exact tract query shape, county scope,
storage layout, exact-byte checksum posture, and read-only join guardrails. It does not
accept a population value, accept a denominator, create raw or processed ACS
data, create a boundary record, create an outcome metric record, calculate
scores, rank places, or support final paper claims.
