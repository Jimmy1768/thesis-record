# Eurostat/OECD FUA Exact-Row Extraction Note

Date: 2026-07-01

Status: extraction note only. No MTR selected. No boundary record, evidence
manifest, candidate-universe ledger, outcome metric record, score, ranking, or
MTR comparison is authorized.

Workflow:

- `theses/mobility-conversion/research/eurostat_oecd_fua_exact_row_extraction_workflow_2026-07-01.md`

Related source note:

- `theses/mobility-conversion/research/source_notes/eurostat_gisco_urban_audit_fua_download_api_2026-07-01.md`

Related intake:

- `theses/mobility-conversion/research/source_led_mtr_proposal_intake_2026-07-01.md`

## Source System

```yaml
source_system:
  source_name: Eurostat GISCO Urban Audit / Cities and Functional Urban Areas
  source_authority: Eurostat GISCO / European Commission
  method_context: Eurostat/OECD Functional Urban Area
  distribution_api:
    units_json: https://gisco-services.ec.europa.eu/distribution/v2/urau/urau-2024-units.json
    distribution_base: https://gisco-services.ec.europa.eu/distribution/v2/urau/distribution/
```

Temporary inspection was performed against official GISCO metadata and label
files. No raw GISCO geometry or label files were archived in ThesisRecord.

## Vintage Selection

```yaml
vintage_selection:
  selected_dataset_vintage: 2024 Urban Audit / URAU distribution
  available_vintages_considered:
    - 2024
    - 2021
    - 2020
    - 2018
    - 2014
    - 2004
    - 2001
  reason_for_selected_vintage: >
    The 2024 distribution is the current inspected GISCO Urban Audit/FUA
    distribution and exposes unit-level region and label files.
  known_commuting_data_vintage: unknown_from_this_extraction
  known_lau_or_input_geography_vintage: unknown_from_this_extraction
  unknown_vintage_fields:
    - commuting_data_vintage
    - LAU_or_input_geography_vintage
```

Do not equate the 2024 GISCO geometry release with the commuting-flow vintage.

## Unit Identification

### `mtr_src_001` Helsinki FUA

```yaml
unit_identification:
  related_lead: mtr_src_001
  unit_code: FI001F
  unit_name: Helsinki
  unit_type: FUA
  country_or_countries:
    - Finland
  source_attribute_table_or_api_path:
    - https://gisco-services.ec.europa.eu/distribution/v2/urau/urau-2024-units.json
    - https://gisco-services.ec.europa.eu/distribution/v2/urau/distribution/FI001F-label-4326-2024.geojson
  source_attribute_fields_used:
    URAU_CODE: FI001F
    URAU_CATG: F
    URAU_NAME: Helsinki
    CNTR_CODE: FI
    NUTS3_2024: FI1B1
  ambiguity_notes: none at label-file inspection level
```

Inspection result:

- `FI001F` is present in the 2024 units metadata.
- The official label file identifies `URAU_CODE: FI001F`,
  `URAU_CATG: F`, and `URAU_NAME: Helsinki`.

### `mtr_src_002` Lyon FUA

```yaml
unit_identification:
  related_lead: mtr_src_002
  unit_code: FR002F
  unit_name: Lyon
  unit_type: FUA
  country_or_countries:
    - France
  source_attribute_table_or_api_path:
    - https://gisco-services.ec.europa.eu/distribution/v2/urau/urau-2024-units.json
    - https://gisco-services.ec.europa.eu/distribution/v2/urau/distribution/FR002F-label-4326-2024.geojson
  source_attribute_fields_used:
    URAU_CODE: FR002F
    URAU_CATG: F
    URAU_NAME: Lyon
    CNTR_CODE: FR
    NUTS3_2024: FRK26
  ambiguity_notes: none at label-file inspection level
```

Inspection result:

- `FR002F` is present in the 2024 units metadata.
- The official label file identifies `URAU_CODE: FR002F`,
  `URAU_CATG: F`, and `URAU_NAME: Lyon`.

## Raw Return Correction

The raw return implied a Lyon FUA lead but listed `FR003F` in the extracted
source-support path logic. Official GISCO label inspection shows:

```yaml
FR002F:
  URAU_NAME: Lyon
  URAU_CATG: F
  CNTR_CODE: FR
  NUTS3_2024: FRK26

FR003F:
  URAU_NAME: Lille
  URAU_CATG: F
  CNTR_CODE: FR
  NUTS3_2024: FRE11
```

Decision:

- Correct the Lyon FUA extraction lead to `FR002F`.
- Do not use `FR003F` for Lyon.
- Keep this correction visible rather than hiding the raw-return mismatch.

## Geometry Artifact

No geometry was archived.

Inspectable geometry paths:

```yaml
helsinki_fua:
  region_4326: https://gisco-services.ec.europa.eu/distribution/v2/urau/distribution/FI001F-region-100k-4326-2024.geojson
  label_4326: https://gisco-services.ec.europa.eu/distribution/v2/urau/distribution/FI001F-label-4326-2024.geojson
  geometry_type: region polygon and label point
  scale: 1:100,000
  crs: EPSG:4326
  region_http_status_inspected: 200
  label_http_status_inspected: 200

lyon_fua:
  region_4326: https://gisco-services.ec.europa.eu/distribution/v2/urau/distribution/FR002F-region-100k-4326-2024.geojson
  label_4326: https://gisco-services.ec.europa.eu/distribution/v2/urau/distribution/FR002F-label-4326-2024.geojson
  geometry_type: region polygon and label point
  scale: 1:100,000
  crs: EPSG:4326
  region_http_status_inspected: 200
  label_http_status_inspected: 200
```

Download provisions, license, and reuse terms still require a manifest-stage
source note before any raw geometry is archived.

## Population Denominator Path

Partially resolved at source-family level by:

- `theses/mobility-conversion/research/source_notes/eurostat_urb_lpop1_fua_population_2026-07-01.md`
- `theses/mobility-conversion/research/eurostat_fua_population_denominator_path_note_2026-07-01.md`

Eurostat `URB_LPOP1` is a candidate denominator source family for European FUA
leads, using the `cities` dimension and the `DE1001V` total-population
indicator. This does not accept any denominator value.

Required lead-specific fields:

```yaml
population_denominator_path:
  source_name: Eurostat URB_LPOP1
  source_authority: Eurostat / European Commission
  source_url_or_access_path: https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/urb_lpop1
  geography_alignment: FUA code through `cities` dimension after GISCO code verification
  selected_source_vintage: unresolved
  observation_status_flag: unresolved
  aggregation_or_reconciliation_method: none unless separately justified
  mismatch_notes: lead-specific year availability and vintage alignment unresolved
```

The FUA geometry source does not itself satisfy resident-population denominator
requirements. The population source path is now identified, but each lead still
requires year selection, missingness/status review, and vintage alignment before
readiness promotion.

## Service Overlay Need

```yaml
service_overlay_need:
  helsinki:
    expected_source_families:
      - HSL open data
      - Digitransit GTFS / GTFS-RT
      - OSM routing stack if routing is tested
    source_trace_status: source_lead_only
    coverage_against_fua_unknown: true
    denominator_prohibited: true
  lyon:
    expected_source_families:
      - France National Access Point local transport datasets
      - GTFS / NeTEx / SIRI records if found
      - OSM routing stack if routing is tested
    source_trace_status: needs_source_trace
    coverage_against_fua_unknown: true
    denominator_prohibited: true
```

Service feeds cannot define or modify the FUA denominator.

## Manifest Trigger Check

No evidence manifest is created by this extraction note.

Reason:

- only source paths, label attributes, HTTP status, and required fields were
  inspected;
- no raw GISCO geometry was archived in the repo;
- no geometry was transformed, clipped, dissolved, simplified, or processed;
- no population denominator was derived.

Manifest required before:

- downloading FUA geometry into the repo;
- archiving raw label or attribute files;
- creating checksums for raw source artifacts;
- deriving population denominators;
- creating processed geometry.

## Decision

```yaml
decision:
  helsinki_fua:
    related_lead: mtr_src_001
    extraction_status: ready_for_lead_review
    exact_row_confirmed: true
    unit_code: FI001F
    unit_name: Helsinki
    remaining_blockers:
      - population_denominator_path
      - service_overlay_source_trace
      - license_or_download_provisions_for_archiving
      - commuting_data_vintage_unknown
  lyon_fua:
    related_lead: mtr_src_002
    extraction_status: needs_source_trace
    exact_row_confirmed: true
    unit_code: FR002F
    unit_name: Lyon
    corrected_from_raw_return_mismatch: true
    remaining_blockers:
      - France_NAP_local_feed_trace
      - population_denominator_path
      - license_or_download_provisions_for_archiving
      - commuting_data_vintage_unknown
```

## Prohibited Outputs

This extraction note does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- boundary record;
- evidence manifest;
- outcome metric record;
- score;
- ranking;
- raw data archive without manifest.
