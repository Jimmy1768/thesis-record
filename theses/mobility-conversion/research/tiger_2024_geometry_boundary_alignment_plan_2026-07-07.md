# TIGER 2024 Geometry Boundary Alignment Plan

Date: 2026-07-07

Status: geometry-only boundary-alignment plan. This plan does not create
processed geometry, accept population values, accept a denominator, fill a
boundary record, create an outcome metric record, calculate scores, rank
places, or support final paper claims.

Related manifest:

- `theses/mobility-conversion/evidence/manifests/tiger_2024_subcounty_geometry_overlay_manifest_2026-07-07.md`

Related raw geometry quality review:

- `theses/mobility-conversion/research/tiger_2024_raw_geometry_quality_review_2026-07-07.md`

Boundary source notes:

- `theses/mobility-conversion/research/source_notes/usda_ers_minneapolis_cz_exact_membership_2026-07-05.md`
- `theses/mobility-conversion/research/source_notes/us_census_portland_cbsa_exact_boundary_2026-07-05.md`

## Purpose

Define how the archived TIGER 2024 tract and block-group geometry may later be
filtered for the Minneapolis ERS CZ and Portland CBSA county-coarseness overlay.

This plan is geometry-only. It does not join ACS population, calculate
population totals, create an accepted denominator, or admit either lead as an
MTR.

## Alignment Inputs

```yaml
alignment_inputs:
  raw_geometry_archive: theses/mobility-conversion/evidence/raw/us_census/tiger_2024_subcounty_geometry/
  geometry_vintage: TIGER/Line 2024
  geometry_units:
    - tract
    - block_group
  filter_fields:
    state_fips: STATEFP
    county_fips: COUNTYFP
    tract_code: TRACTCE
    block_group_code: BLKGRPCE
    tract_geoid: GEOID
    block_group_geoid: GEOID
  coordinate_reference_system: GCS_North_American_1983
  processed_geometry_authorized_by_this_plan: false
  population_join_authorized_by_this_plan: false
```

## Minneapolis ERS CZ FIPS Filter

Source boundary: USDA ERS 2020 commuting zone `CZ2020 = 258`, `CZName =
Minneapolis city, MN`.

```yaml
minneapolis_ers_cz_geometry_filter:
  lead_id: mtr_src_004
  working_name: Minneapolis-St. Paul ERS CZ
  boundary_source_family: USDA_ERS_2020_commuting_zone
  county_filter_method: STATEFP_plus_COUNTYFP
  tract_first_files:
    - tl_2024_27_tract.zip
    - tl_2024_55_tract.zip
  block_group_escalation_files:
    - tl_2024_27_bg.zip
    - tl_2024_55_bg.zip
  included_county_fips:
    - "27003" # Anoka County, MN
    - "27019" # Carver County, MN
    - "27025" # Chisago County, MN
    - "27037" # Dakota County, MN
    - "27053" # Hennepin County, MN
    - "27059" # Isanti County, MN
    - "27065" # Kanabec County, MN
    - "27115" # Pine County, MN
    - "27123" # Ramsey County, MN
    - "27139" # Scott County, MN
    - "27163" # Washington County, MN
    - "55093" # Pierce County, WI
    - "55109" # St. Croix County, WI
  peripheral_focus_county_fips:
    - "27025" # Chisago County, MN
    - "27059" # Isanti County, MN
    - "27065" # Kanabec County, MN
    - "27115" # Pine County, MN
    - "55093" # Pierce County, WI
  initial_subcounty_geography: tract
  block_group_escalation_rule: >
    Escalate to block groups only for peripheral-focus counties or edge areas
    where tract geometry is too coarse to show whether resident population is
    concentrated near the metropolitan core, a commuting corridor, or a
    weakly-served rural/exurban edge.
```

## Portland CBSA FIPS Filter

Source boundary: U.S. Census/OMB 2023 CBSA `38900`,
`Portland-Vancouver-Hillsboro, OR-WA`.

```yaml
portland_cbsa_geometry_filter:
  lead_id: mtr_src_007
  working_name: Portland-Vancouver-Hillsboro CBSA
  boundary_source_family: OMB_Census_2023_CBSA
  county_filter_method: STATEFP_plus_COUNTYFP
  tract_first_files:
    - tl_2024_41_tract.zip
    - tl_2024_53_tract.zip
  block_group_escalation_files:
    - tl_2024_41_bg.zip
    - tl_2024_53_bg.zip
  included_county_fips:
    - "41005" # Clackamas County, OR
    - "41009" # Columbia County, OR
    - "41051" # Multnomah County, OR
    - "41067" # Washington County, OR
    - "41071" # Yamhill County, OR
    - "53011" # Clark County, WA
    - "53059" # Skamania County, WA
  peripheral_focus_county_fips:
    - "41009" # Columbia County, OR
    - "41071" # Yamhill County, OR
    - "53059" # Skamania County, WA
  initial_subcounty_geography: tract
  block_group_escalation_rule: >
    Escalate to block groups only for outlying counties or edge areas where
    tract geometry is too coarse to show whether resident population is
    concentrated near the Portland-Vancouver core, along a service corridor, or
    outside plausible service-source coverage.
```

## Extraction Rules

```yaml
geometry_extraction_rules:
  allowed_first_pass: tract_filter_by_county_fips
  allowed_second_pass: block_group_filter_by_county_fips_for_escalation_counties
  processed_output_status: not_authorized_by_this_plan
  future_processed_output_placeholder:
    minneapolis_tract: theses/mobility-conversion/evidence/processed/us_census/tiger_2024_subcounty_geometry/minneapolis_ers_cz_tracts/
    minneapolis_block_group: theses/mobility-conversion/evidence/processed/us_census/tiger_2024_subcounty_geometry/minneapolis_ers_cz_block_groups/
    portland_tract: theses/mobility-conversion/evidence/processed/us_census/tiger_2024_subcounty_geometry/portland_cbsa_tracts/
    portland_block_group: theses/mobility-conversion/evidence/processed/us_census/tiger_2024_subcounty_geometry/portland_cbsa_block_groups/
  required_before_processed_output:
    - confirm extraction tooling
    - record exact command_or_script
    - preserve source ZIP checksums
    - write processed artifact manifest_update
    - keep ACS population tables separate
```

Filtering must use `STATEFP` and `COUNTYFP`, not name matching. `GEOID` may be
used as the stable join key after filtering:

- tract `GEOID`: `STATEFP` + `COUNTYFP` + `TRACTCE`
- block-group `GEOID`: `STATEFP` + `COUNTYFP` + `TRACTCE` + `BLKGRPCE`

## Boundary Caveats

- Minneapolis ERS CZ membership is 2020 commuting-zone geography while TIGER
  geometry is 2024 tract/block-group geography.
- Portland CBSA membership is 2023 OMB/Census delineation while TIGER geometry
  is 2024 tract/block-group geography.
- This plan assumes county FIPS membership is stable for the named counties
  across the reviewed source vintages; any county boundary change note must be
  reviewed before processed extraction.
- County-filtered tract or block-group geometry is an overlay input only. It
  does not become the MTR boundary.

## Next Allowed Output

Choose one:

- processed-geometry extraction manifest update and extraction log;
- county-boundary change note review;
- ACS API source-note follow-up if live row access succeeds.

## Prohibited Outputs

This plan does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- accepted population value;
- accepted denominator value;
- filled boundary record;
- outcome metric record;
- score;
- ranking;
- final paper claim.
