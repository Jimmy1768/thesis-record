# Source Note: Eurostat GISCO Urban Audit FUA Download API

Date inspected: 2026-07-01

Verification status: `directly_inspected_data_catalog`

Source:

- Title or dataset: Eurostat GISCO Cities and Functional Urban Areas geodata /
  Urban Audit distribution API
- Authority or publisher: Eurostat GISCO / European Commission
- URL, DOI, document identifier, archive path, API endpoint, or access path:
  - `https://ec.europa.eu/eurostat/web/gisco/geodata/statistical-units/cities-functional-urban-areas`
  - `https://gisco-services.ec.europa.eu/distribution/v2/`
  - `https://gisco-services.ec.europa.eu/distribution/v2/urau/`
  - `https://gisco-services.ec.europa.eu/distribution/v2/urau/urau-2024-files.html`
  - `https://gisco-services.ec.europa.eu/distribution/v2/urau/urau-2024-units.html`
- Release date, source vintage, or version: Urban Audit 2024 distribution,
  with prior listed distributions for 2021, 2020, 2018, 2014, 2004, and 2001.

Status: independently inspected source note. This note does not admit an MTR,
accept an outcome metric, create an evidence manifest, authorize raw data
archiving, calculate scores, rank MTRs, or make final paper claims.

## Source Authority

Eurostat GISCO, the European Commission geographical information and map
service attached to Eurostat.

## What The Source Defines

The source provides downloadable Urban Audit geodata, including cities and
functional urban areas.

The inspected Eurostat GISCO page identifies available download dimensions:

- years: 2024, 2021, 2020, 2018, 2014, 2004, 2001;
- file formats: GeoPackage, SHP, TopoJSON, GeoJSON, PBF, SVG;
- geometry types: region polygons and label points;
- scale: 1:100,000 for 2024 Urban Audit data;
- coordinate reference systems: EPSG:3035, EPSG:4326, EPSG:3857;
- an official GISCO distribution API.

The inspected GISCO distribution API exposes:

- `themes.json`;
- an Urban Audit theme;
- per-vintage files, zipped files, units, release notes, and metadata;
- 2024 FUA polygon files such as `URAU_RG_100K_2024_4326_FUA.geojson`;
- unit-level API entries with unique Urban Audit unit codes and individual
  GeoJSON files.

## Source Function For Mobility Conversion

- `boundary_source_family`
- `population_denominator_source`, only if paired with compatible Eurostat or
  other population source
- `methodology_reference`

## Boundary / Denominator Role

- MTR boundary source: yes, for European source-led proposals where an exact FUA
  unit code, polygon, vintage, and limitations are verified.
- Resident-population denominator source: not by itself. Population denominator
  must be verified separately from compatible Eurostat FUA population data,
  official local-area aggregation, or another documented denominator source.
- Overlay or input only: can also support city-core/FUA overlay comparison.
- Service-derived denominator risk: none in the GISCO source itself, but high
  risk if later service feeds are used to redefine the FUA denominator.

## Outcome / Axis Role

- Outcome dimensions supported: none directly.
- Explanatory axes supported: urban form only as boundary/context input, not as
  an outcome or score component.
- Risk of confusing outcome with explanatory axis: low for the boundary source
  itself, but high if FUA availability is treated as evidence of transport
  quality.

## Data Availability

- Geography: European Urban Audit city and functional urban area units.
- Spatial unit: Urban Audit city (`C`) and FUA (`F`) unit codes, regions, and
  labels.
- Time period or release vintage: 2024 current inspected distribution, plus
  earlier listed distributions.
- Update frequency: not accepted here as a stable rule; listed vintages show
  discrete releases, not necessarily a fixed cadence.
- Access method: Eurostat GISCO page and distribution API.
- License or usage constraint: subject to Eurostat/GISCO download provisions;
  any raw geometry archive requires an evidence manifest and license note.

## Relevance To Mobility Conversion

This source can resolve the first S1A question: exact FUA row extraction is
source-system feasible. The system exposes both bundled FUA files and unit-level
entries, so a later worker can trace a proposed European MTR lead to a specific
FUA code, geometry file, projection, scale, and vintage.

This supports source-led testing for `mtr_src_001` Helsinki FUA and
`mtr_src_002` Lyon FUA without selecting either MTR by reputation.

## Limitations

- The API proves source-system feasibility, not that a named proposal is ready
  for a boundary record.
- Exact Helsinki and Lyon FUA unit rows/codes were not accepted in this note.
  They still require extraction and inspection.
- A 2024 GISCO geometry vintage does not by itself identify the vintage of the
  commuting data or LAU inputs behind the FUA delineation.
- FUA geometry does not solve resident-population denominator selection.
- FUA geometry does not verify local public-transport feed completeness.
- Download provisions must be recorded before raw geometry is archived.
- Built-in availability for European FUAs creates a source-rich-region bias
  risk if treated as candidate importance.

## Suitability Judgment

Suitability: `candidate_primary_boundary`

Rationale:

Eurostat GISCO Urban Audit FUA geodata is suitable as a candidate primary
boundary source family for European MTR proposals where the exact FUA row/code,
geometry vintage, source limitations, and denominator path are verified.

This note does not make Helsinki or Lyon admitted candidates.

## Methodology Implication

Exact FUA row/code extraction should be a hard prerequisite before a European
FUA proposal can move from intake/source-note review to readiness checklist
review.

The minimum extraction fields should be:

- `source_system: Eurostat GISCO Urban Audit`;
- `dataset_vintage`;
- `unit_code`;
- `unit_type`;
- `unit_name`, if available from source attributes;
- `geometry_file`;
- `geometry_type`;
- `scale`;
- `crs`;
- `source_url_or_api_path`;
- `download_provisions_or_license_note`;
- `retrieval_or_inspection_date`;
- `population_denominator_source`;
- `commuting_data_vintage_or_unknown`;
- `lau_or_input_geography_vintage_or_unknown`;
- `known_boundary_limitations`.

## Next Allowed Output

Allowed:

- S1A feasibility decision record;
- exact-row extraction plan;
- later draft evidence manifest if raw GISCO files are acquired;
- later source-led lead review for `mtr_src_001` or `mtr_src_002`.

## Prohibited Outputs

This source note does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- raw data archive without manifest.
