# Handoff: Minneapolis-St. Paul ERS CZ Exact Membership / Source Bundle Request

Date: 2026-07-05

From: Thesis 2 working thread

To: Deep Research / external research thread

Status: research request. This is not evidence, not source truth, not an
accepted MTR, not a candidate-universe record, not a boundary record, not a
metric record, not a score, and not a ranking.

## Thesis Context

Thesis: Mobility Conversion

Full title: Mobility Conversion: How Metropolitan Transport Regions Convert
Capacity, Pressure, Shape, Governance, and Growth into Usable Access

Use term:

- Metropolitan Transport Region
- MTR

Do not use:

- Metropolitan Transit Region

## Current Thesis 2 Gate

The Minneapolis-St. Paul lead is `mtr_src_004`.

Current reviewed source path:

```yaml
working_name: Minneapolis-St. Paul ERS CZ
boundary_source_family: national_commuting_zone
boundary_authority: USDA ERS
source_path_status: source_families_verified_exact_membership_unresolved
exact_cz_membership_status: unresolved
service_overlay_status: unresolved
```

Relevant Thesis 2 artifacts:

- `theses/mobility-conversion/research/minneapolis_ers_cz_boundary_population_source_path_review_2026-07-05.md`
- `theses/mobility-conversion/research/minneapolis_ers_cz_exact_membership_extraction_workflow_2026-07-05.md`
- `theses/mobility-conversion/research/batch_s1b_us_county_based_boundary_mechanics_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/usda_ers_commuting_zones_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/us_census_acs_population_denominator_access_input_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/fta_ntd_gtfs_weblinks_2026-06-28.md`

## Research Purpose

Find traceable USDA ERS, U.S. Census/ACS, county-boundary, and FTA/NTD sources
needed to evaluate the Minneapolis-St. Paul ERS CZ lead.

This is not a request to prove Minneapolis-St. Paul has good transport.

This is not a request to compare Minneapolis-St. Paul to any other region.

This is not a request to calculate access, coverage, scores, or rankings.

## Research Questions

Answer these questions from official or primary sources:

1. What is the exact USDA ERS 2020 Commuting Zone identifier for the
   Minneapolis-St. Paul labour-market region?
2. What official ERS source directly maps the name or counties to that CZ code?
3. Which counties and county equivalents are included in that ERS CZ?
4. What source provides the county identifiers, membership vintage, and release
   date?
5. What official county boundary source should later pair with that ERS county
   set?
6. What ACS source and estimate period should provide resident population for
   the same county set?
7. What aggregation method and margin-of-error handling are required for county
   ACS population?
8. What containment, fit, or quality measures are available for the ERS CZ?
9. Which member counties create county-coarseness, rural/exurban overreach,
   weak-integration, cross-state, or multi-agency transport-access risks?
10. Which FTA/NTD reporters and GTFS Weblinks are material inside the ERS CZ?
11. Are regional GTFS feeds present, and do they cover all relevant fixed-route
    reporters?
12. What demand-responsive, paratransit, vanpool, intercity, airport, private,
    or other non-fixed-route services are material but outside static GTFS
    coverage?

## Required Source Families To Check

At minimum, check source paths in these families:

- USDA ERS Commuting Zones and Labor Market Areas;
- ERS 2020 CZ documentation and membership files;
- U.S. Census county boundary files or TIGER/Line county products;
- U.S. Census ACS population tables/API/profile paths;
- FTA / NTD GTFS Weblinks;
- NTD reporter metadata if needed;
- local or regional transit agency source pages only to verify service/source
  coverage, not to define the MTR denominator.

Do not rely on Wikipedia, travel guides, blogs, city reputation, livability
rankings, "best transit city" articles, congestion fame, or walkability
reputation.

## Required Return Fields

Return a raw source bundle using this shape:

```yaml
minneapolis_ers_cz_exact_membership_return:
  return_status: raw_research_material_only
  reviewed_boundary:
    working_name: Minneapolis-St. Paul ERS CZ
    source_authority: USDA ERS
    exact_name:
    exact_code:
    geography_type:
    source_url_or_access_path:
    verification_status:
  county_membership:
    source_title:
    source_url_or_access_path:
    county_list:
    county_identifier_fields:
    membership_vintage:
    release_or_update_date:
    verification_status:
  county_boundary_artifact:
    product_title:
    catalogue_or_download_path:
    file_or_layer:
    vintage:
    identifier_field:
    license_or_reuse_terms:
    raw_download_required_later:
  population_denominator:
    source_title:
    source_url_or_access_path:
    geography_identifiers:
    population_field:
    acs_estimate_period:
    aggregation_method:
    margin_of_error_or_uncertainty_handling:
    value_returned: do_not_return_value_unless_needed_for_source_identification
    verification_status:
  county_coarseness_and_caveats:
    commuting_flow_vintage:
    pandemic_or_remote_work_caveat:
    containment_or_fit_measures:
    rural_or_exurban_overreach_risk:
    cross_state_or_multi_agency_complexity:
    weakly_integrated_counties:
    source_url_or_access_path:
  service_source_bundle:
    fta_ntd_gtfs_weblinks_source:
      source_authority:
      source_url_or_access_path:
      format:
      vintage_or_update_date:
      license_or_access_terms:
      coverage_against_CZ:
    ntd_reporters_or_gtfs_feeds:
    regional_feed_notes:
    missing_operators_or_modes:
  rejected_or_quarantined_material:
    - item:
      reason:
```

## Evidence Limits

The return must not:

- admit Minneapolis-St. Paul as an MTR;
- create a candidate list;
- score or rank Minneapolis-St. Paul;
- claim Minneapolis-St. Paul has good or bad transport;
- use FTA/NTD, GTFS, agency, route, stop, or service geography as the MTR
  boundary;
- use service geography as the denominator;
- calculate population coverage;
- download raw datasets;
- archive raw feeds;
- write polished paper prose.

## Output Format

Return in this order:

1. Short method summary.
2. Source table.
3. YAML-style raw source bundle.
4. Exact CZ code and county membership findings.
5. Boundary/population artifact findings.
6. County-coarseness and caveat findings.
7. Service/operator coverage findings.
8. Rejected/quarantined material.
9. Open questions for Thesis 2.
10. Source URL list.

## Intake Reminder

The Thesis 2 working thread will process the return through:

- raw-return buffer protocol;
- Deep Research return protocol;
- source-note verification;
- coverage reconciliation worksheet;
- evidence manifest process, only if raw artifacts are later acquired.

Do not present the return as final evidence.
