# U.S. Census ACS/TIGER Subcounty Overlay Sources

Date inspected: 2026-07-06

Additional verification: 2026-07-07

Verification status: `directly_inspected_official_tiger_paths_acs_api_blocked`

Source:

- Title or dataset:
  - American Community Survey 5-year API source family
  - TIGER/Line tract and block-group geometry source family
- Authority or publisher: U.S. Census Bureau
- URL, DOI, document identifier, archive path, API endpoint, or access path:
  - `https://www.census.gov/data/developers/data-sets/acs-5year.html`
  - `https://api.census.gov/data/2024/acs/acs5`
  - `https://www2.census.gov/geo/tiger/TIGER2024/TRACT/tl_2024_41_tract.zip`
  - `https://www2.census.gov/geo/tiger/TIGER2024/BG/tl_2024_41_bg.zip`
- Release date, source vintage, or version:
  - TIGER/Line 2024 tract and block-group paths inspected by HEAD for
    Minnesota, Wisconsin, Oregon, and Washington.
  - ACS 5-year API source family inspected through official documentation path;
    live API row queries remain blocked locally after curl, Python urllib, and
    HTTP redirect probes.

Status: independently inspected source note. This note does not admit an MTR,
accept an outcome metric, create an evidence manifest, authorize raw data
archiving, calculate scores, rank MTRs, or make final paper claims.

## Source Authority

The U.S. Census Bureau publishes the American Community Survey source family,
the Census API, and TIGER/Line geometry products.

## What The Source Defines

The source family can support the first county-coarseness overlay selected in:

- `theses/mobility-conversion/research/county_coarseness_overlay_plan_2026-07-06.md`

The intended first overlay is:

```yaml
selected_overlay:
  overlay_type: tract_or_block_group_population_sensitivity_layer
  population_source_family: American Community Survey 5-year
  geometry_source_family: TIGER/Line tract_or_block_group_geometry
  role: subcounty_population_visibility
  accepted_population_value: false
```

TIGER/Line 2024 geometry checks:

```yaml
tiger_geometry_checks:
  tract_minnesota_2024:
    url: https://www2.census.gov/geo/tiger/TIGER2024/TRACT/tl_2024_27_tract.zip
    http_status: 200
    content_type: application/zip
    content_length: 7492209
    last_modified: "Fri, 27 Jun 2025 20:05:43 GMT"
    raw_geometry_archived_in_repo: false
  block_group_minnesota_2024:
    url: https://www2.census.gov/geo/tiger/TIGER2024/BG/tl_2024_27_bg.zip
    http_status: 200
    content_type: application/zip
    content_length: 13095867
    last_modified: "Fri, 27 Jun 2025 20:01:19 GMT"
    raw_geometry_archived_in_repo: false
  tract_wisconsin_2024:
    url: https://www2.census.gov/geo/tiger/TIGER2024/TRACT/tl_2024_55_tract.zip
    http_status: 200
    content_type: application/zip
    content_length: 7642880
    last_modified: "Fri, 27 Jun 2025 20:05:44 GMT"
    raw_geometry_archived_in_repo: false
  block_group_wisconsin_2024:
    url: https://www2.census.gov/geo/tiger/TIGER2024/BG/tl_2024_55_bg.zip
    http_status: 200
    content_type: application/zip
    content_length: 13843348
    last_modified: "Fri, 27 Jun 2025 20:01:21 GMT"
    raw_geometry_archived_in_repo: false
  tract_oregon_2024:
    url: https://www2.census.gov/geo/tiger/TIGER2024/TRACT/tl_2024_41_tract.zip
    http_status: 200
    content_type: application/zip
    content_length: 10648349
    last_modified: "Fri, 27 Jun 2025 20:05:44 GMT"
    raw_geometry_archived_in_repo: false
  block_group_oregon_2024:
    url: https://www2.census.gov/geo/tiger/TIGER2024/BG/tl_2024_41_bg.zip
    http_status: 200
    content_type: application/zip
    content_length: 16965287
    last_modified: "Fri, 27 Jun 2025 20:01:20 GMT"
    raw_geometry_archived_in_repo: false
  tract_washington_2024:
    url: https://www2.census.gov/geo/tiger/TIGER2024/TRACT/tl_2024_53_tract.zip
    http_status: 200
    content_type: application/zip
    content_length: 9827813
    last_modified: "Fri, 27 Jun 2025 20:05:44 GMT"
    raw_geometry_archived_in_repo: false
  block_group_washington_2024:
    url: https://www2.census.gov/geo/tiger/TIGER2024/BG/tl_2024_53_bg.zip
    http_status: 200
    content_type: application/zip
    content_length: 16249192
    last_modified: "Fri, 27 Jun 2025 20:01:21 GMT"
    raw_geometry_archived_in_repo: false
```

All needed TIGER 2024 tract and block-group state ZIP paths for the current
Minneapolis and Portland overlay plans responded HTTP 200. No geometry was
downloaded or archived.

## Source Function For Mobility Conversion

- `population_denominator_source`, only after a denominator method note and
  manifest decision
- `candidate_validation_overlay`
- `methodology_reference`

## Boundary / Denominator Role

- MTR boundary source: no.
- Resident-population denominator source: possible later denominator or
  sensitivity source; no value is accepted in this note.
- Overlay or input only: yes, as subcounty population visibility layer inside
  independently verified county-based boundaries.
- Service-derived denominator risk: none directly from ACS/TIGER, but service
  overlays must remain separate and cannot clip the ACS/TIGER denominator.

## Outcome / Axis Role

- Outcome dimensions supported: none directly in this note.
- Explanatory axes supported: possible demand-intensity context only after
  separate method decisions.
- Risk of confusing outcome with explanatory axis: moderate if population
  distribution is used as a performance proxy. It must remain denominator or
  sensitivity context.

## Data Availability

- Geography:
  - ACS 5-year tract and block-group estimates through Census API source
    family.
  - TIGER/Line tract and block-group geometry by state ZIP.
- Spatial unit:
  - tract;
  - block group.
- Time period or release vintage:
  - TIGER/Line 2024 paths inspected for Minnesota, Wisconsin, Oregon, and
    Washington.
  - ACS API target path tested for 2024 ACS 5-year, but row response was not
    obtained locally.
- Update frequency: not reviewed in this note.
- Access method:
  - Census API;
  - public TIGER ZIP paths.
- License or usage constraint: not fully reviewed in this note.

## ACS API Probe

Attempted tract API probe:

```text
https://api.census.gov/data/2024/acs/acs5?get=NAME,B01003_001E,B01003_001M&for=tract:*&in=state:41&in=county:051
```

Local result:

```yaml
acs_api_probe:
  purpose: verify tract-level NAME_total_population_estimate_and_MOE_fields
  result: blocked_by_local_tls_error
  curl_exit_code: 35
  raw_response_archived_in_repo: false
```

The probe was retried with HTTP/1.1 and returned the same local TLS failure.
Two minimal API probes also failed locally with TLS code 35:

```text
https://api.census.gov/data/2024/acs/acs5?get=NAME&for=us:*
https://api.census.gov/data/2023/acs/acs5?get=NAME&for=us:*
```

This note therefore does not verify a live ACS API row response. It only
records the intended endpoint pattern and source-family role.

Additional 2026-07-07 verification:

```yaml
additional_acs_api_verification_2026_07_07:
  python_urllib_probe:
    url: https://api.census.gov/data/2024/acs/acs5?get=NAME&for=us:*
    result: blocked_by_ssl_wrong_version_number
    raw_response_archived_in_repo: false
  http_redirect_probe:
    url: http://api.census.gov/data/2024/acs/acs5?get=NAME&for=us:*
    result: blocked_by_empty_reply_or_redirect_failure
    curl_exit_code: 52
    raw_response_archived_in_repo: false
  verification_decision: api_access_blocked_in_current_environment
```

## Relevance To Mobility Conversion

ACS tract or block-group population is the selected first subcounty overlay
because it can make resident population visible inside large county-based
boundaries without changing the denominator to a service area or urban core.

For the current county-coarseness leads, this source family should help answer:

- whether peripheral county population is concentrated or dispersed;
- whether county-scale geography hides weakly served population;
- whether block-group detail is required after a tract-level first pass;
- where later service-footprint overlays must preserve unserved-population
  visibility.

## Limitations

- No ACS API response was obtained because of local TLS failure.
- No ACS tables, TIGER shapefiles, crosswalks, or geometry were downloaded or
  archived.
- All current Minnesota, Wisconsin, Oregon, and Washington TIGER 2024 tract and
  block-group paths were checked by HEAD only; no geometry was downloaded.
- ACS estimates require margin-of-error handling and vintage recording.
- Block-group estimates may require more careful uncertainty handling than
  tract estimates.
- TIGER geometry and ACS geography vintages must be aligned or explicitly
  caveated.
- This source family does not identify service availability, travel time,
  accessibility, affordability, safety, or governance.

## Suitability Judgment

Suitability: `candidate_validation_overlay`

Rationale:

The Census ACS/TIGER source family is suitable as the first subcounty
population visibility overlay for county-coarseness review. Suitability is
conditional on a later manifest/source-note step that verifies state-specific
TIGER paths, ACS API availability, estimate vintage, variables, geography
join keys, and margin-of-error handling.

## Extraction Decision

```yaml
us_census_acs_tiger_subcounty_overlay_sources:
  overlay_role: tract_or_block_group_population_sensitivity_layer
  source_authority: U.S. Census Bureau
  first_pass_geography: tract
  fallback_geography_if_tract_too_coarse: block_group
  representative_tiger_paths_verified: true
  all_required_state_tiger_paths_verified: true
  acs_api_live_row_verified: false
  acs_api_blocker: local_TLS_or_SSL_failure_across_curl_and_python_clients
  raw_geometry_status: not_archived
  raw_population_table_status: not_archived
  accepted_population_value: false
  evidence_manifest_status: not_created
  extraction_decision: source_family_suitable_manifest_or_source_note_followup_required
  blockers:
    - ACS_API_row_query_not_verified
    - ACS_MOE_handling_not_defined
    - no_evidence_manifest_for_raw_acquisition
```

## Methodology Implication

The county-coarseness overlay plan can proceed, but raw acquisition should not.
Because ACS API access failed through multiple clients in the current
environment, the next step should be a draft evidence-manifest decision rather
than more local API probing.

The next step is:

- a draft evidence manifest decision for TIGER geometry acquisition and later
  ACS table acquisition, explicitly marking ACS API access as externally
  blocked in this environment.

## Next Allowed Output

Choose one:

- source-note follow-up;
- draft evidence manifest.

Specific next follow-up:

- decide whether a draft manifest can cover TIGER geometry first while ACS API
  access remains blocked;
- verify ACS 5-year API access and the fields for total population estimate
  and margin of error from another environment before any ACS table archive;
- define tract-first versus block-group escalation rules;
- decide whether raw acquisition requires a draft evidence manifest before
  any files are stored.

## Prohibited Outputs

This source note does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted population value;
- filled boundary record;
- raw data archive without manifest.
