# JRC GHSL Sao Paulo GHS-FUA Source System Source Note

Date inspected: 2026-07-05

Verification status: `directly_inspected_official_source_high_burden_blocked`

Source:

- Title or dataset: GHS-FUA R2019A, GHS functional urban areas
- Authority or publisher: European Commission Joint Research Centre / Global
  Human Settlement Layer
- URL, DOI, document identifier, archive path, API endpoint, or access path:
  - `https://human-settlement.emergency.copernicus.eu/ghs_fua.php`
  - `https://data.jrc.ec.europa.eu/dataset/347f0337-f2da-4592-87b3-e25975ec2c95`
  - `https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_FUA_UCDB2015_GLOBE_R2019A/V1-0/`
  - `https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_FUA_UCDB2015_GLOBE_R2019A/V1-0/GHS_FUA_UCDB2015_GLOBE_R2019A_54009_1K_V1_0.zip`
  - `https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_FUA_UCDB2015_GLOBE_R2019A/V1-0/copyright.txt`
- Release date, source vintage, or version:
  - Product: `GHS_FUA_UCDB2015_GLOBE_R2019A_54009_1K_V1_0`.
  - Official directory lists the ZIP as last modified 2020-03-03.
  - HEAD response for the ZIP reported `content-type: application/zip`,
    `content-length: 3059037`, and `last-modified: Tue, 03 Mar 2020
    13:48:42 GMT`.

Status: independently inspected source note. This note does not admit an MTR,
accept an outcome metric, create an evidence manifest, authorize raw data
archiving, calculate scores, rank MTRs, or make final paper claims.

## Source Authority

The European Commission Joint Research Centre publishes the Global Human
Settlement Layer source system. The inspected official directory exposes the
GHS-FUA R2019A V1-0 ZIP and copyright text.

## What The Source Defines

Existing ThesisRecord notes already classify GHS-FUA R2019A as a modelled
functional urban area source for epoch 2015. The 2026-07-05 inspection verifies
that the official download path and source-system files are live:

```yaml
ghs_fua_source_system:
  product: GHS_FUA_UCDB2015_GLOBE_R2019A_54009_1K_V1_0
  directory_url: https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/GHSL/GHS_FUA_UCDB2015_GLOBE_R2019A/V1-0/
  listed_files:
    - file: GHS_FUA_UCDB2015_GLOBE_R2019A_54009_1K_V1_0.zip
      listed_modified: "2020-03-03 13:48"
      listed_size: 2.9M
      head_content_length: 3059037
      head_content_type: application/zip
    - file: copyright.txt
      listed_modified: "2026-03-05 12:26"
      listed_size: 540
  raw_zip_archived_in_repo: false
  raw_geopackage_extracted: false
```

The official copyright text states Creative Commons Attribution 4.0
International reuse terms with credit and change-indication requirements.

## Source Function For Mobility Conversion

- `boundary_source_family`
- `population_denominator_source`, only if paired with separate population
  source design
- `candidate_validation_overlay`
- `methodology_reference`

## Boundary / Denominator Role

- MTR boundary source: possible high-burden fallback or validation boundary
  source only; not accepted as observed commuting geography.
- Resident-population denominator source: no accepted denominator value here.
  GHS-POP or IBGE population sources require separate vintage and aggregation
  decisions.
- Overlay or input only: GHS-SMOD, GHS-UCDB, IBGE arrangements, SPTrans, EMTU,
  ARTESP, rail, metro, charter, paratransit, and informal-service materials
  remain overlays or source leads.
- Service-derived denominator risk: high if SPTrans, EMTU, rail, metro, API,
  route, stop, planning, or service coverage replaces the independent boundary.

## Outcome / Axis Role

- Outcome dimensions supported: none directly.
- Explanatory axes supported: possible urban-form context only after separate
  overlay method notes.
- Risk of confusing outcome with explanatory axis: high. GHS-FUA model inputs
  include country GDP per capita and travel-time/friction inputs, which can
  overlap with explanatory-axis concepts.

## Data Availability

- Geography: global modelled functional urban areas.
- Spatial unit: GeoPackage in World Mollweide, 1 km product naming.
- Time period or release vintage: 2015 urban-centre/model epoch, R2019A V1-0
  product.
- Update frequency: not reviewed beyond this release.
- Access method: official public JRC catalogue and directory. The catalogue
  page returned HTTP 405 to HEAD but downloaded via GET; the directory and ZIP
  HEAD were reachable.
- License or usage constraint: copyright text indicates CC BY 4.0 reuse with
  credit and change indication.

## Relevance To Mobility Conversion

This source system is useful as a global modelled fallback where no stronger
observed or official national functional boundary is available. It is also a
useful stress test for the higher evidence burden required for modelled
boundaries.

For Sao Paulo, this note verifies the official source system only. It does not
verify the exact Sao Paulo GHS-FUA row, identifier, name, polygon, or
population denominator.

## Limitations

- The official ZIP was not downloaded or archived in the repository.
- The GeoPackage schema and Sao Paulo row were not inspected.
- Exact GHS-FUA identifier, exact name, and matching rule remain unresolved.
- IBGE population arrangements and urban concentrations remain a possible
  stronger official Brazil source family, but this pass did not extract their
  exact Sao Paulo composition. The IBGE page returned a command-line Cloudflare
  challenge during the live check.
- GHS-FUA is modelled, not observed commuting-flow geography.
- The boundary epoch is 2015 and may not align with current service feeds or
  2020/2025 population products.
- Model inputs may overlap with economic-capacity and accessibility concepts.
- Formal and informal service-source coverage across a modelled Sao Paulo
  region remains unresolved.

## Suitability Judgment

Suitability: `candidate_validation_overlay`

Rationale:

The official JRC/GHSL source system is verified and reusable under CC BY 4.0,
but the Sao Paulo exact row has not been extracted. Until a stronger official
Brazil source review and exact GeoPackage extraction are completed, the lead
should stay in high-burden fallback status rather than readiness review.

## Extraction Decision

```yaml
sao_paulo_ghs_fua_source_system_review:
  lead_id: mtr_src_008
  working_name: Sao Paulo GHS-FUA
  source_authority: European Commission JRC / GHSL
  boundary_family: modelled_functional_region
  product: GHS_FUA_UCDB2015_GLOBE_R2019A_54009_1K_V1_0
  product_release: R2019A_V1_0
  boundary_epoch: 2015
  zip_path_status: official_path_verified_by_directory_and_head
  license_status: CC_BY_4_0_verified_from_official_copyright_text
  exact_ghs_fua_identifier: unresolved
  exact_ghs_fua_name: unresolved
  exact_row_status: not_extracted
  raw_zip_status: not_archived
  raw_geopackage_status: not_extracted
  population_product: unresolved
  population_field: unresolved
  accepted_denominator_value: false
  service_overlay_source: unresolved
  service_coverage_against_boundary: unresolved
  evidence_manifest_status: not_created
  extraction_decision: source_system_verified_exact_row_and_fallback_blocked
  blockers:
    - exact_GHS_FUA_row_not_extracted
    - raw_GeoPackage_not_archived
    - IBGE_stronger_boundary_review_unresolved
    - GHS_POP_or_IBGE_population_pairing_unresolved
    - modelled_boundary_caveats_unresolved
    - formal_informal_service_source_coverage_unresolved
```

## Methodology Implication

Sao Paulo should not return to ChatGPT for source-system discovery. The next
work should either review official IBGE alternatives first or intentionally
open a draft evidence manifest before acquiring and inspecting the official
GHS-FUA GeoPackage.

## Next Allowed Output

Choose one:

- source-note follow-up.

Specific next follow-up:

- review IBGE population arrangements / urban concentrations as a potentially
  stronger official Brazil source family;
- if GHS-FUA remains needed, prepare a draft evidence manifest before
  downloading and extracting the GeoPackage;
- document GHS-POP or IBGE population vintage pairing;
- plan formal and informal service-source coverage review.

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
