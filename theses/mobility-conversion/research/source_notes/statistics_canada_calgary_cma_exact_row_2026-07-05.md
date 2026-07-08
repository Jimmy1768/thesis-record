# Statistics Canada Calgary CMA Exact Row Source Note

Date inspected: 2026-07-05

Verification status: `directly_inspected_official_source`

Source:

- Title or dataset: 2021 Standard Geographical Classification reference map,
  2021 Census Cartographic Boundary Files CMA layer, Boundary Files catalogue,
  and 2021 Census CMA/CA glossary
- Authority or publisher: Statistics Canada / Government of Canada
- URL, DOI, document identifier, archive path, API endpoint, or access path:
  - `https://www12.statcan.gc.ca/census-recensement/2021/geo/maps-cartes/referencemaps-cartesdereference/sgc-cgt/map-eng.cfm?SGC=02_16`
  - `https://geo.statcan.gc.ca/geo_wa/rest/services/2021/Cartographic_boundary_files/MapServer/6`
  - `https://geo.statcan.gc.ca/geo_wa/rest/services/2021/Cartographic_boundary_files/MapServer/6/query?where=CMANAME%3D%27Calgary%27&outFields=CMAUID,DGUID,CMANAME,CMATYPE,PRUID,LANDAREA&returnGeometry=false&f=pjson`
  - `https://www150.statcan.gc.ca/n1/en/catalogue/92-160-X`
  - `https://www150.statcan.gc.ca/n1/pub/92-195-x/2021001/geo/cma-rmr/cma-rmr-eng.htm`
- Release date, source vintage, or version:
  - SGC reference map source modified: 2022-02-01.
  - Boundary Files, Census year 2021 release: 2021-11-17.
  - CMA/CA glossary release: 2022-02-09.
  - Boundary feature layer: 2021 Cartographic Boundary Files, layer
    `CMA - lcma000b21s_e` / MapServer layer ID `6`.

Status: independently inspected source note. This note does not admit an MTR,
accept an outcome metric, create an evidence manifest, authorize raw data
archiving, calculate scores, rank MTRs, or make final paper claims.

## Source Authority

Statistics Canada publishes the 2021 Census geography reference maps, boundary
files, cartographic boundary services, and glossary definitions used here.

## What The Source Defines

The inspected SGC reference map for Alberta - South part identifies Calgary as:

```yaml
reference_map_row:
  uid: "825"
  name: Calgary
  type: CMA
```

The inspected ArcGIS REST layer identifies the official cartographic boundary
feature layer:

```yaml
boundary_layer:
  layer_name: "CMA - lcma000b21s_e"
  layer_id: 6
  type: Feature Layer
  geometry_type: esriGeometryPolygon
  spatial_reference_wkid: 3347
  supported_query_formats:
    - JSON
    - geoJSON
    - PBF
  identifier_fields:
    - CMAUID
    - CMAPUID
    - DGUID
    - CMANAME
    - CMATYPE
    - PRUID
    - LANDAREA
```

The inspected no-geometry query against `CMANAME = 'Calgary'` returned:

```yaml
calgary_boundary_feature_attributes:
  CMAUID: "825"
  DGUID: "2021S050548825"
  CMANAME: Calgary
  CMATYPE: "B"
  PRUID: "48"
  LANDAREA: 5098.6806999999999
  geometry_downloaded_or_archived: false
```

The inspected Boundary Files catalogue confirms that the 2021 Boundary Files
are geographic files representing Census of Population dissemination
boundaries, with a 2021 census-year release listed.

The inspected CMA/CA glossary defines CMAs and CAs as adjacent municipalities
centred on a population centre, with adjacent municipalities included when they
have a high degree of integration with the core as measured by place-of-work
commuting flows. It also states that census subdivisions are the building
blocks and lists the delineation rules.

## Source Function For Mobility Conversion

- `boundary_source_family`
- `population_denominator_source`
- `methodology_reference`

## Boundary / Denominator Role

- MTR boundary source: candidate primary boundary source family for the Calgary
  CMA lead, pending later boundary-fit and readiness review.
- Resident-population denominator source: candidate denominator source family
  only. This note does not verify or accept a population value.
- Overlay or input only: Calgary Transit, regional services, and other service
  sources remain overlays only and are not inspected in this note.
- Service-derived denominator risk: none in this source family; the risk remains
  downstream if Calgary Transit or regional service geography is substituted for
  the independent CMA boundary.

## Outcome / Axis Role

- Outcome dimensions supported: none directly.
- Explanatory axes supported: possible future demand-intensity or urban-form
  denominator context only after separate methodology gates.
- Risk of confusing outcome with explanatory axis: low in this source note
  because it verifies boundary geography, not transport performance.

## Data Availability

- Geography: Calgary, census metropolitan area / census agglomeration source
  family.
- Spatial unit: CMA polygon feature in the 2021 Cartographic Boundary Files
  layer, plus SGC reference map code.
- Time period or release vintage: 2021 Census geography.
- Update frequency: Boundary files catalogue indicates five-year frequency.
- Access method: public Statistics Canada reference map, catalogue page, and
  ArcGIS REST service query. Geometry was not downloaded or archived.
- License or usage constraint: not fully reviewed in this note. Later raw
  boundary acquisition must archive or cite the applicable Statistics Canada
  terms and metadata.

## Relevance To Mobility Conversion

This note independently verifies that Calgary has an official Statistics Canada
CMA code and a queryable 2021 cartographic boundary feature row. This is enough
to move the Calgary lead beyond raw-return-only status for the boundary source
family.

It is not enough to fill a boundary record or accept a denominator because the
population/profile identifier path is still unresolved.

## Limitations

- The no-geometry ArcGIS REST query verified attributes only; raw geometry was
  not downloaded, archived, hashed, or inspected.
- The inspected boundary-layer DGUID is `2021S050548825`.
- The raw return and Focus on Geography lead used `2021S0503825`. That Focus
  path rendered an official Calgary (CMA) page, but the relation between
  `2021S0503825` and the boundary-layer DGUID was not resolved in this pass.
- A Census Profile URL using `DGUIDlist=2021S0503825` returned a Statistics
  Canada 404 page in this pass.
- A Census Profile request using `DGUIDlist=2021S050548825` did not return a
  usable body within the local check window.
- Population denominator source, exact population field, and acceptable profile
  or table path remain blocked.
- Census subdivision membership and CSDUID/DGUID rows were not extracted.
- Calgary-specific application of historical comparability, manual adjustment,
  merging, or secondary-core rules was not determined.
- Service-overlay fit against the CMA boundary remains unresolved.

## Suitability Judgment

Suitability: `candidate_primary_boundary`

Rationale:

Statistics Canada is the official authority for the CMA boundary source family.
The independent inspection verifies the exact Calgary CMA code `825` and a
queryable boundary feature row for the 2021 cartographic boundary layer. The
source is suitable for later boundary-record work only after a manifest-backed
raw geometry acquisition, population-denominator reconciliation, CSD membership
extraction, and service-overlay review.

## Extraction Decision

```yaml
calgary_cma_exact_row_extraction:
  lead_id: mtr_src_005
  working_name: Calgary CMA
  source_authority: Statistics Canada
  exact_name: Calgary
  exact_code: "825"
  DGUID_or_equivalent:
    boundary_layer_DGUID: "2021S050548825"
    raw_return_profile_or_focus_DGUID: "2021S0503825"
    relation_status: unresolved_source_conflict
  geography_type: CMA
  census_release_or_geography_vintage: "2021 Census geography"
  boundary_product: "2021 Cartographic Boundary Files"
  boundary_product_url_or_catalogue_path: "https://www150.statcan.gc.ca/n1/en/catalogue/92-160-X"
  boundary_file_name_or_layer: "CMA - lcma000b21s_e / MapServer layer 6"
  boundary_geometry_status: not_archived
  population_product: unresolved
  population_product_url_or_table_path: unresolved
  population_field: unresolved
  population_vintage: unresolved
  accepted_denominator_value: false
  building_blocks: census_subdivisions_not_extracted
  commuting_or_labour_market_vintage: previous Census Program place-of-work flows per CMA/CA glossary
  historical_comparability_rule_impact: unknown_for_Calgary
  manual_adjustment_rule_impact: unknown_for_Calgary
  merge_or_secondary_core_rule_impact: unknown_for_Calgary
  service_overlay_source: unresolved
  service_coverage_against_boundary: unresolved
  license_or_reuse_terms: unresolved_for_raw_boundary_acquisition
  evidence_manifest_status: not_created
  extraction_decision: quarantined_source_conflict
  blockers:
    - boundary_geometry_not_archived
    - population_profile_or_table_path_unresolved
    - boundary_DGUID_and_profile_DGUID_relation_unresolved
    - CSD_membership_not_extracted
    - Calgary_specific_method_caveats_unknown
    - service_overlay_unresolved
```

## Methodology Implication

Calgary should not return to ChatGPT for the same exact-row question. The next
work should resolve the Statistics Canada identifier split and population path
directly from official Statistics Canada tables, APIs, or downloadable
geography relationship files.

If the DGUID split is expected Statistics Canada behavior, record the join rule
explicitly before any boundary record is filled. If it is not expected, treat
the raw return's DGUID claim as quarantined.

## Next Allowed Output

Choose one:

- source-note follow-up.

Specific next follow-up:

- verify the official Census Profile or table path that joins Calgary CMA
  population data to `CMAUID = 825` and/or `DGUID = 2021S050548825`;
- verify whether `2021S0503825` is a valid alternate profile identifier and how
  it relates to `2021S050548825`;
- extract CSD membership from an official Statistics Canada relationship file
  or GeoSuite path;
- prepare a draft evidence manifest only if raw boundary/profile artifacts are
  about to be acquired.

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
