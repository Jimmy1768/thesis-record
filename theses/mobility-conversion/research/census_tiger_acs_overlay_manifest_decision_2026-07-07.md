# Census TIGER/ACS Overlay Manifest Decision

Date: 2026-07-07

Status: manifest decision note. No evidence manifest is created by this note.
No raw data is acquired, archived, processed, or accepted.

Related source note:

- `theses/mobility-conversion/research/source_notes/us_census_acs_tiger_subcounty_overlay_sources_2026-07-06.md`

Related method artifacts:

- `theses/mobility-conversion/research/county_coarseness_method_note_2026-07-06.md`
- `theses/mobility-conversion/research/county_coarseness_overlay_plan_2026-07-06.md`

## Decision

The TIGER geometry and ACS population-table work must be split into separate
manifest tracks.

TIGER/Line 2024 tract and block-group geometry for Minnesota, Wisconsin,
Oregon, and Washington may proceed to a draft evidence-manifest file because
all required state ZIP paths have been directly checked by HEAD against official
U.S. Census Bureau paths.

ACS 5-year tract or block-group population tables may not proceed to raw
archive or accepted overlay input in the current environment. Live ACS API row
verification remains blocked after curl, Python urllib, and HTTP redirect
probes. ACS acquisition must wait for successful row verification from another
environment or a later local environment fix.

This decision does not admit an MTR, create a candidate list, create a
candidate-universe ledger, fill a boundary record, create an outcome metric
record, calculate scores, rank MTRs, accept population values, or accept a
denominator.

## Manifest Tracks

```yaml
manifest_decision:
  decision_status: split_manifest_tracks_required
  intended_method_role: county_coarseness_subcounty_population_visibility
  boundary_record_dependency: blocked
  metric_record_dependency: blocked
  accepted_population_value: false
  accepted_denominator_value: false
  raw_archive_created: false
  processed_overlay_created: false
```

### Track 1: TIGER Geometry

```yaml
tiger_geometry_manifest_track:
  proposed_manifest_id: tiger_2024_subcounty_geometry_overlay_manifest_draft
  proposed_manifest_status: draft
  source_family: TIGER/Line tract_and_block_group_geometry
  source_authority: U.S. Census Bureau
  geography:
    - Minnesota tract
    - Minnesota block group
    - Wisconsin tract
    - Wisconsin block group
    - Oregon tract
    - Oregon block group
    - Washington tract
    - Washington block group
  verification_basis: official_state_zip_paths_head_verified
  acquisition_allowed_by_this_note: false
  next_allowed_output: draft_evidence_manifest_for_tiger_geometry_only
  future_raw_archive_path_placeholder: theses/mobility-conversion/evidence/raw/us_census/tiger_2024_subcounty_geometry/
  future_processed_path_placeholder: theses/mobility-conversion/evidence/processed/us_census/tiger_2024_subcounty_geometry/
  required_before_archive:
    - draft_manifest_file_created
    - license_or_reuse_notes_recorded
    - exact_urls_repeated_in_manifest
    - checksum_method_declared
    - repository_storage_decision_recorded
```

The draft TIGER manifest may reference all verified ZIP paths from the source
note. The manifest must not claim that the geometry has been downloaded until
the files are actually acquired and checksummed under the manifest rules.

### Track 2: ACS Population Tables

```yaml
acs_population_table_manifest_track:
  proposed_manifest_id: acs_5year_subcounty_population_overlay_manifest_deferred
  proposed_manifest_status: needs_source_verification
  source_family: American Community Survey 5-year API
  source_authority: U.S. Census Bureau
  geography:
    - tract
    - block group
  target_variables:
    - B01003_001E
    - B01003_001M
  verification_basis: source_family_identified_live_row_blocked
  acquisition_allowed_by_this_note: false
  next_allowed_output: external_environment_api_verification_or_source_note_followup
  future_raw_archive_path_placeholder: theses/mobility-conversion/evidence/raw/us_census/acs_5year_subcounty_population/
  future_processed_path_placeholder: theses/mobility-conversion/evidence/processed/us_census/acs_5year_subcounty_population/
  required_before_archive:
    - live_api_row_verified
    - state_county_query_pattern_verified
    - tract_join_keys_verified
    - block_group_join_keys_verified_if_used
    - margin_of_error_handling_defined
    - vintage_alignment_with_tiger_recorded
```

The ACS track remains deferred because the current environment cannot verify a
live API row response. A future ACS source-note follow-up must record a
successful response with fields, geography, vintage, and margin-of-error fields
before an ACS manifest can be used for raw acquisition.

## Use Constraints

The split tracks may support only the county-coarseness overlay plan. The
allowed role is subcounty population visibility for the Minneapolis ERS CZ and
Portland CBSA leads.

The tracks may not be used to:

- replace an official boundary source;
- create or fill a boundary record;
- create a resident denominator;
- infer service coverage;
- infer usable access performance;
- calculate an outcome metric;
- compare or rank places.

## Rationale

The TIGER source path risk and the ACS table access risk are different enough
that bundling them into one acquisition step would obscure evidence status.
TIGER geometry paths are currently verifiable. ACS API rows are not. A split
decision preserves progress on geometry planning while preventing population
tables from entering the evidence workflow before their fields, rows, vintage,
join keys, and uncertainty handling are verified.

## Next Allowed Output

Next local output:

- draft an evidence manifest for TIGER 2024 tract and block-group geometry
  only, using `manifest_status: draft`.

Alternative next output:

- create an ACS API source-note follow-up only after successful row access from
  another environment or after local TLS/API access is fixed.

## Prohibited Outputs

This note does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted population value;
- accepted denominator value;
- filled boundary record;
- raw data archive;
- final paper claim.
