# ONS Bristol TTWA Exact Row Source Note

Date inspected: 2026-07-05

Verification status: `directly_inspected_official_source`

Source:

- Title or dataset: Travel to Work Areas December 2011 names/codes and
  boundaries
- Authority or publisher: Office for National Statistics / data.gov.uk
- URL, DOI, document identifier, archive path, API endpoint, or access path:
  - `https://www.data.gov.uk/dataset/f6da11df-4e4d-4beb-92fc-3b4939f1b4d9/travel-to-work-areas-december-2011-names-and-codes-in-the-uk`
  - `https://www.data.gov.uk/dataset/abff04be-da8f-4439-8833-e5fe64d28d28/travel-to-work-areas-december-2011-boundaries-uk-bfc-v21`
  - `https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/Travel_to_Work_Areas_Dec_2011_FCB_in_United_Kingdom_2022/FeatureServer/0/query?where=TTWA11CD%3D%27E30000180%27&outFields=TTWA11CD,TTWA11NM&returnGeometry=false&f=pjson`
- Release date, source vintage, or version:
  - Travel to Work Areas as at December 2011.
  - data.gov.uk catalogue pages responded HTTP 200 on 2026-07-05.

Status: independently inspected source note. This note does not admit an MTR,
accept an outcome metric, create an evidence manifest, authorize raw data
archiving, calculate scores, rank MTRs, or make final paper claims.

## Source Authority

The Office for National Statistics is the source authority for the TTWA
geography products inspected here. data.gov.uk provides official catalogue
pages for the names/codes table and full-resolution clipped boundary product.

## What The Source Defines

The official ONS boundary FeatureServer was queried without geometry. It
returned the Bristol TTWA feature row:

```yaml
bristol_ttwa:
  TTWA11CD: E30000180
  TTWA11NM: Bristol
  source_layer: Travel_to_Work_Areas_Dec_2011_FCB_in_United_Kingdom_2022
  returnGeometry: false
  raw_geometry_archived_in_repo: false
```

The raw return's separate names/codes FeatureServer path,
`TTWA_2011_UK_NC_V4`, returned an ArcGIS `Invalid URL` response for the tested
service and layer URLs. This note therefore verifies the exact code/name row
through the official ONS boundary layer, while leaving canonical names/codes
raw-file extraction unresolved.

## Source Function For Mobility Conversion

- `boundary_source_family`
- `population_denominator_source`
- `methodology_reference`

## Boundary / Denominator Role

- MTR boundary source: candidate primary boundary source family for the Bristol
  TTWA lead, pending raw boundary acquisition and boundary-fit review.
- Resident-population denominator source: candidate aggregation geography only;
  this note does not verify or accept any population value.
- Overlay or input only: NaPTAN, BODS, National Rail, Travelwest, ferry,
  community transport, and operator materials remain overlays only.
- Service-derived denominator risk: downstream only if service coverage or
  authority geography replaces the independent TTWA boundary.

## Outcome / Axis Role

- Outcome dimensions supported: none directly.
- Explanatory axes supported: possible future demand-intensity or governance-fit
  context only after separate gates.
- Risk of confusing outcome with explanatory axis: low in this source note.

## Data Availability

- Geography: Travel to Work Area.
- Spatial unit: TTWA polygon feature; exact lower-level building blocks not
  extracted in this note.
- Time period or release vintage: December 2011 TTWA geography.
- Update frequency: not reviewed beyond the inspected catalogue pages.
- Access method: data.gov.uk catalogue pages and official ONS ArcGIS
  FeatureServer query. The query was run with `returnGeometry=false`.
- License or usage constraint: not fully reviewed in this note. Raw geometry
  and reuse metadata require manifest review before repository archiving.

## Relevance To Mobility Conversion

This note independently verifies the raw return's Bristol code/name lead,
`E30000180 = Bristol`, from an official ONS boundary layer. It supports later
TTWA boundary acquisition, population aggregation design, and service-overlay
review.

It does not decide whether the 2011 TTWA is acceptable as an MTR denominator.

## Limitations

- The official names/codes raw table was not downloaded or archived.
- The raw return's names/codes FeatureServer path was not recoverable in this
  pass.
- The ONS boundary FeatureServer row was queried without geometry; raw geometry
  was not downloaded, hashed, inspected, or archived.
- Population denominator construction remains unresolved. Any population path
  would need an official small-area population source and an official
  small-area-to-TTWA lookup or bridge.
- TTWA 2011 commuting-flow vintage requires a post-2020 commuting and
  remote-work caveat.
- TTWA boundaries are labour-market geographies, not transport service
  geographies; rural or weakly served hinterland inclusion needs boundary-fit
  review.
- Bristol-area BODS, NaPTAN, rail, ferry, demand-responsive, community
  transport, and coach source materiality was not verified here.

## Suitability Judgment

Suitability: `candidate_primary_boundary`

Rationale:

The inspected official ONS boundary layer directly verifies `TTWA11CD =
E30000180` and `TTWA11NM = Bristol`. Suitability remains conditional on raw
boundary manifesting, population aggregation, commute-vintage caveats,
boundary-fit review, and service-overlay review.

## Extraction Decision

```yaml
bristol_ttwa_exact_row_extraction:
  lead_id: mtr_src_003
  working_name: Bristol TTWA
  source_authority: Office for National Statistics
  exact_name: Bristol
  exact_code: E30000180
  geography_type: 2011_travel_to_work_area
  boundary_product: Travel to Work Areas December 2011 Boundaries UK BFC
  boundary_feature_status: verified_without_geometry
  names_codes_raw_file_status: unresolved
  boundary_geometry_status: not_archived
  population_product: unresolved
  population_field: unresolved
  accepted_denominator_value: false
  service_overlay_source: unresolved
  service_coverage_against_boundary: unresolved
  evidence_manifest_status: not_created
  extraction_decision: exact_row_verified_boundary_population_and_service_blocked
  blockers:
    - canonical_names_codes_raw_file_not_archived
    - raw_boundary_geometry_not_archived
    - population_denominator_not_verified
    - commute_vintage_caveat_not_resolved
    - service_overlay_materiality_not_verified
```

## Methodology Implication

Bristol should not return to ChatGPT for the exact TTWA code/name question. The
next work should decide whether 2011 TTWA vintage and labour-market boundary
fit are acceptable for a not-admitted boundary record, and should separately
verify population aggregation and multimodal service-source materiality.

## Next Allowed Output

Choose one:

- source-note follow-up.

Specific next follow-up:

- acquire raw TTWA boundary geometry only under a draft evidence manifest;
- extract the canonical names/codes raw file if a stable official file URL is
  needed;
- verify an official population aggregation path;
- run a TTWA boundary-fit and service-overlay materiality review.

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
