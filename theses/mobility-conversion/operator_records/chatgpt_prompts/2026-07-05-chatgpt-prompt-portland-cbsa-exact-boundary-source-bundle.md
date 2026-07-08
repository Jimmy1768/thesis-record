# ChatGPT Deep Research Prompt: Portland-Vancouver-Hillsboro CBSA Exact Boundary / Source Bundle

Use ChatGPT Deep Research for the request below.

Important output instruction:

- Return the result as a single raw Markdown file.
- Do not render the Markdown as formatted prose.
- If file attachment output is available, attach a `.md` file.
- If file attachment output is not available, put the entire returned Markdown file inside one fenced code block with info string `markdown`.
- Do not include commentary before or after the raw Markdown file.
- The first line of the returned Markdown file must be `# Raw Return: Portland-Vancouver-Hillsboro CBSA Exact Boundary / Source Bundle`.

The research return is raw material only. Do not present it as evidence, source truth, accepted methodology, accepted MTR selection, score, ranking, or paper prose.

---

# Handoff: Portland-Vancouver-Hillsboro CBSA Exact Boundary / Source Bundle Request

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

The Portland-Vancouver-Hillsboro lead is `mtr_src_007`.

Current reviewed source path:

```yaml
working_name: Portland-Vancouver-Hillsboro MSA
boundary_source_family: official_statistical_metro
boundary_authority: OMB / U.S. Census Bureau
source_path_status: source_families_verified_exact_boundary_unresolved
exact_cbsa_boundary_status: unresolved
service_overlay_status: unresolved
```

Relevant Thesis 2 artifacts:

- `theses/mobility-conversion/research/portland_cbsa_boundary_population_source_path_review_2026-07-05.md`
- `theses/mobility-conversion/research/portland_cbsa_exact_boundary_extraction_workflow_2026-07-05.md`
- `theses/mobility-conversion/research/batch_s1b_us_county_based_boundary_mechanics_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/us_omb_core_based_statistical_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/us_census_acs_population_denominator_access_input_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/fta_ntd_gtfs_weblinks_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/bts_national_transit_map_2026-06-28.md`

## Research Purpose

Find traceable OMB/Census, ACS, county-boundary, FTA/NTD, and BTS sources needed
to evaluate the Portland-Vancouver-Hillsboro CBSA lead.

This is not a request to prove Portland has good transport.

This is not a request to compare Portland to any other region.

This is not a request to calculate access, coverage, scores, or rankings.

## Research Questions

Answer these questions from official or primary sources:

1. What is the exact OMB/Census CBSA/MSA identifier for the
   Portland-Vancouver-Hillsboro metropolitan statistical area?
2. What official source directly maps that name to the CBSA code?
3. What standard vintage and delineation vintage apply?
4. Which counties and county equivalents are included in the CBSA?
5. What official Census boundary product/layer contains the CBSA geometry?
6. What official ACS source and estimate period should provide resident
   population for the same geography?
7. Is direct ACS CBSA geography available, or should county aggregation be used?
8. What margin-of-error or uncertainty handling is required?
9. Which member counties create county-coarseness, rural/exurban overreach,
   cross-state, weak-integration, or multi-agency transport-access risks?
10. What OMB statistical-use caveat must be recorded?
11. Which FTA/NTD reporters and GTFS Weblinks are material inside the CBSA?
12. Is BTS National Transit Map useful as an overlay or validation source for
    fixed-route coverage inside the CBSA?
13. What ferry, demand-responsive, paratransit, vanpool, intercity, airport,
    private, or other non-fixed-route services are material but outside static
    GTFS coverage?

## Required Source Families To Check

At minimum, check source paths in these families:

- OMB CBSA/MSA delineation sources;
- U.S. Census CBSA boundary products or TIGER/Line/cartographic boundary files;
- U.S. Census ACS population tables/API/profile paths;
- U.S. Census county boundary files if county aggregation is needed;
- FTA / NTD GTFS Weblinks;
- BTS National Transit Map;
- NTD reporter metadata if needed;
- local or regional transit agency source pages only to verify service/source
  coverage, not to define the MTR denominator.

Do not rely on Wikipedia, travel guides, blogs, city reputation, livability
rankings, "best transit city" articles, congestion fame, or walkability
reputation.

## Required Return Fields

Return a raw source bundle using this shape:

```yaml
portland_cbsa_exact_boundary_return:
  return_status: raw_research_material_only
  reviewed_boundary:
    working_name: Portland-Vancouver-Hillsboro MSA
    source_authority: OMB / U.S. Census Bureau
    exact_name:
    exact_code:
    geography_type:
    source_url_or_access_path:
    verification_status:
  delineation_and_membership:
    source_title:
    source_url_or_access_path:
    standard_vintage:
    delineation_vintage:
    county_list:
    county_identifier_fields:
    release_or_update_date:
    verification_status:
  boundary_artifact:
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
    geography_identifier:
    population_field:
    acs_estimate_period:
    direct_cbsa_or_county_aggregation_method:
    margin_of_error_or_uncertainty_handling:
    value_returned: do_not_return_value_unless_needed_for_source_identification
    verification_status:
  cbsa_caveats:
    source_authority_caveat:
    commuting_data_vintage:
    pandemic_or_remote_work_caveat:
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
      coverage_against_CBSA:
    bts_national_transit_map_source:
      source_authority:
      source_url_or_access_path:
      format:
      vintage_or_update_date:
      coverage_against_CBSA:
    ntd_reporters_or_gtfs_feeds:
    regional_feed_notes:
    missing_operators_or_modes:
  rejected_or_quarantined_material:
    - item:
      reason:
```

## Evidence Limits

The return must not:

- admit Portland-Vancouver-Hillsboro as an MTR;
- create a candidate list;
- score or rank Portland-Vancouver-Hillsboro;
- claim Portland has good or bad transport;
- use FTA/NTD, GTFS, BTS National Transit Map, agency, route, stop, or service
  geography as the MTR boundary;
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
4. Exact CBSA code, delineation, and county membership findings.
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

