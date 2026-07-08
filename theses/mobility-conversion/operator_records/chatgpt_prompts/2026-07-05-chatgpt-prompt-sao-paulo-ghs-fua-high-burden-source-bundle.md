# ChatGPT Deep Research Prompt: Sao Paulo GHS-FUA High-Burden Source Bundle

Use ChatGPT Deep Research for the request below.

Important output instruction:

- Return the result as a single raw Markdown file.
- Do not render the Markdown as formatted prose.
- If file attachment output is available, attach a `.md` file.
- If file attachment output is not available, put the entire returned Markdown file inside one fenced code block with info string `markdown`.
- Do not include commentary before or after the raw Markdown file.
- The first line of the returned Markdown file must be `# Raw Return: Sao Paulo GHS-FUA High-Burden Source Bundle`.

The research return is raw material only. Do not present it as evidence, source truth, accepted methodology, accepted MTR selection, score, ranking, or paper prose.

---

# Handoff: Sao Paulo GHS-FUA High-Burden Source Bundle Request

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

The Sao Paulo lead is `mtr_src_008`.

Current reviewed source path:

```yaml
working_name: Sao Paulo GHS-FUA
boundary_source_family: modelled_functional_region
boundary_authority: European Commission JRC / GHSL
classification_status: high_burden_modelled_boundary_handoff_ready
exact_ghs_fua_row_status: unresolved
fallback_justification_status: unresolved
readiness_review_allowed: false
```

Relevant Thesis 2 artifacts:

- `theses/mobility-conversion/research/sao_paulo_ghs_fua_boundary_classification_review_2026-07-05.md`
- `theses/mobility-conversion/research/sao_paulo_ghs_fua_high_burden_extraction_workflow_2026-07-05.md`
- `theses/mobility-conversion/research/batch_s1d_modelled_global_boundary_burden_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/ghs_functional_urban_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ghs_pop_population_grid_2026-07-01.md`
- `theses/mobility-conversion/research/source_notes/ghsl_degree_of_urbanisation_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/ghsl_urban_centre_database_2026-06-28.md`

## Research Purpose

Find traceable GHSL/JRC, official/national context, population-denominator,
built-form overlay, and service-source material needed to evaluate the Sao
Paulo GHS-FUA lead under the high-burden modelled-boundary rule.

This is not a request to prove Sao Paulo has good or bad transport.

This is not a request to compare Sao Paulo to any other region.

This is not a request to calculate access, coverage, scores, or rankings.

## Research Questions

Answer these questions from official or primary sources:

1. What is the exact GHS-FUA identifier/name for Sao Paulo?
2. What official GHSL/JRC source maps that identifier to the modelled FUA row?
3. What product release, epoch, coordinate system, resolution, source path, and
   license/reuse terms apply?
4. What model inputs and caveats must be recorded, including GDP per capita or
   economic-capacity input overlap?
5. What stronger source families are available or unavailable for Sao Paulo:
   observed FUA, national commuting/labour-market area, official statistical
   metro, hybrid statistical region, official population geography, or planning
   region?
6. If stronger sources exist, why would GHS-FUA remain useful as a fallback or
   validation layer rather than a primary boundary?
7. What GHS-POP release and target year could pair with the GHS-FUA boundary,
   and what vintage mismatch caveat applies?
8. Are official population denominators available that should outrank GHS-POP?
9. Which built-form overlay should be used for context: GHS-SMOD, GHS-UCDB, or
   a stronger official built-up extent source?
10. What SPTrans sources exist, and what access, registration, license,
    reproducibility, format, and vintage constraints apply?
11. What EMTU sources exist, and what access, registration, license,
    reproducibility, format, and vintage constraints apply?
12. What metro, rail, municipal, intermunicipal, ferry, private, informal,
    demand-responsive, paratransit, or weakly documented services are material?
13. Could formal service feeds hide major service or population gaps inside the
    modelled FUA?

## Required Source Families To Check

At minimum, check source paths in these families:

- GHSL/JRC GHS-FUA R2019A;
- GHSL/JRC GHS-POP R2023A;
- GHSL/JRC GHS-SMOD and GHS-UCDB;
- official Brazil national/statistical/metropolitan/planning geography sources;
- official or primary population-denominator sources;
- SPTrans data/API/feed/source pages;
- EMTU data/API/feed/source pages;
- metro/rail/operator sources if material;
- informal, private, intermunicipal, demand-responsive, or weakly documented
  service sources where official coverage is incomplete.

Do not rely on Wikipedia, travel guides, blogs, city reputation, livability
rankings, "best transit city" articles, megacity fame, congestion fame, or
walkability reputation.

## Required Return Fields

Return a raw source bundle using this shape:

```yaml
sao_paulo_ghs_fua_high_burden_return:
  return_status: raw_research_material_only
  reviewed_boundary:
    working_name: Sao Paulo GHS-FUA
    source_authority: European Commission JRC / GHSL
    exact_ghs_fua_identifier:
    exact_ghs_fua_name:
    geography_type:
    source_url_or_access_path:
    verification_status:
  ghs_fua_artifact:
    product_title:
    catalogue_or_download_path:
    release:
    epoch:
    coordinate_system:
    resolution:
    identifier_field:
    license_or_reuse_terms:
    raw_download_required_later:
  fallback_and_context:
    stronger_boundary_sources_checked:
      observed_functional_region:
      national_commuting_zone:
      hybrid_functional_statistical_region:
      official_statistical_metro:
      planning_or_governance_region_overlay:
    fallback_justification:
    official_or_national_context_sources:
  model_caveats:
    model_input_disclosure:
    economic_capacity_input_overlap_caveat:
    travel_time_or_friction_input_caveat:
    urban_centre_inheritance_risk:
    boundary_epoch:
    growth_or_staleness_risk:
    source_url_or_access_path:
  population_denominator:
    ghs_pop_source_title:
    ghs_pop_source_url_or_access_path:
    ghs_pop_release:
    ghs_pop_target_year:
    estimate_or_projection_status:
    summarization_method:
    official_population_alternative:
    value_returned: do_not_return_value_unless_needed_for_source_identification
    verification_status:
  built_form_overlay:
    selected_overlay_source:
    source_url_or_access_path:
    release_or_epoch:
    role: validation_or_context_only
  service_source_bundle:
    sptrans_source:
      source_authority:
      source_url_or_access_path:
      format:
      vintage_or_update_date:
      license_or_access_terms:
      access_or_registration_constraints:
      coverage_against_GHS_FUA:
    emtu_source:
      source_authority:
      source_url_or_access_path:
      format:
      vintage_or_update_date:
      license_or_access_terms:
      access_or_registration_constraints:
      coverage_against_GHS_FUA:
    rail_metro_or_other_formal_sources:
    informal_or_weakly_documented_service_gaps:
    reproducibility_limits:
  rejected_or_quarantined_material:
    - item:
      reason:
```

## Evidence Limits

The return must not:

- admit Sao Paulo as an MTR;
- create a candidate list;
- score or rank Sao Paulo;
- claim Sao Paulo has good or bad transport;
- treat GHS-FUA as observed commuting geography;
- use SPTrans, EMTU, rail, route, stop, fare-zone, agency, or service geography
  as the MTR boundary;
- use service geography as the denominator;
- calculate population coverage;
- download raw datasets;
- archive raw feeds or rasters;
- write polished paper prose.

## Output Format

Return in this order:

1. Short method summary.
2. Source table.
3. YAML-style raw source bundle.
4. Exact GHS-FUA row findings.
5. Fallback/official-context source findings.
6. GHS-POP and built-form overlay findings.
7. Model-input/vintage/growth caveat findings.
8. Service/operator/formal-informal coverage findings.
9. Rejected/quarantined material.
10. Open questions for Thesis 2.
11. Source URL list.

## Intake Reminder

The Thesis 2 working thread will process the return through:

- raw-return buffer protocol;
- Deep Research return protocol;
- source-note verification;
- modelled-boundary burden review;
- evidence manifest process, only if raw artifacts are later acquired.

Do not present the return as final evidence.

