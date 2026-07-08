# ABS Greater Melbourne GCCSA Exact Row Source Note

Date inspected: 2026-07-05

Verification status: `directly_inspected_official_source`

Source:

- Title or dataset: GCCSA 2021 Australia allocation workbook and GCCSA 2021
  Australia digital boundary file path
- Authority or publisher: Australian Bureau of Statistics
- URL, DOI, document identifier, archive path, API endpoint, or access path:
  - `https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/allocation-files/GCCSA_2021_AUST.xlsx`
  - `https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/digital-boundary-files/GCCSA_2021_AUST_SHP_GDA2020.zip`
- Release date, source vintage, or version:
  - ASGS Edition 3, July 2021 to June 2026.
  - Allocation workbook response last-modified: 2021-06-24.
  - Digital boundary ZIP response last-modified: 2021-06-24.

Status: independently inspected source note. This note does not admit an MTR,
accept an outcome metric, create an evidence manifest, authorize raw data
archiving, calculate scores, rank MTRs, or make final paper claims.

## Source Authority

The Australian Bureau of Statistics publishes ASGS Edition 3 geography
standards, allocation files, and digital boundary files.

## What The Source Defines

The official ABS allocation workbook was inspected transiently outside the
repo. Its shared string table includes the relevant field names:

```yaml
identifier_fields:
  - GCCSA_CODE_2021
  - GCCSA_NAME_2021
  - STATE_CODE_2021
  - STATE_NAME_2021
  - AUS_CODE_2021
  - AUS_NAME_2021
  - AREA_ALBERS_SQKM
  - ASGS_LOCI_URI_2021
```

The same workbook identifies the Greater Melbourne row:

```yaml
greater_melbourne_gccsa:
  GCCSA_CODE_2021: 2GMEL
  GCCSA_NAME_2021: Greater Melbourne
  STATE_CODE_2021: "2"
  STATE_NAME_2021: Victoria
  AUS_CODE_2021: AUS
  AUS_NAME_2021: Australia
  ASGS_LOCI_URI_2021: "http://linked.data.gov.au/dataset/asgsed3/GCCSA/2GMEL"
  raw_workbook_archived_in_repo: false
```

The official ABS digital boundary ZIP path responded with HTTP 200 and content
type `application/zip`. The boundary geometry was not downloaded to or archived
in the repo.

## Source Function For Mobility Conversion

- `boundary_source_family`
- `population_denominator_source`
- `methodology_reference`

## Boundary / Denominator Role

- MTR boundary source: candidate primary boundary source family for the Greater
  Melbourne GCCSA lead, pending boundary-fit review.
- Resident-population denominator source: candidate denominator source family
  only; this note does not verify any population value.
- Overlay or input only: Victoria transport feeds, service areas, routes, and
  modes remain overlays only and are not inspected in this note.
- Service-derived denominator risk: downstream only if PTV/DTP feed coverage is
  used instead of the independent GCCSA boundary.

## Outcome / Axis Role

- Outcome dimensions supported: none directly.
- Explanatory axes supported: possible future urban-form or demand-intensity
  context only after separate methodology gates.
- Risk of confusing outcome with explanatory axis: low in this source note.

## Data Availability

- Geography: Greater Capital City Statistical Area.
- Spatial unit: GCCSA.
- Time period or release vintage: ASGS Edition 3, 2021.
- Update frequency: ASGS edition cycle, not reviewed further here.
- Access method: public ABS allocation workbook and digital boundary file URL.
- License or usage constraint: not fully reviewed in this note; later raw
  boundary acquisition must archive or cite the applicable ABS terms.

## Relevance To Mobility Conversion

This note independently verifies the exact Greater Melbourne GCCSA identifier
from an official ABS source. It allows the lead to move beyond raw-return-only
status for exact code/name verification.

It does not decide whether GCCSA is a good MTR boundary. GCCSA remains a broad
functional/statistical geography and still requires boundary-fit, population,
and service-source review.

## Limitations

- The allocation workbook was inspected transiently and not archived in the
  repo.
- Boundary ZIP availability was checked by HTTP response only; geometry,
  shapefile fields, polygons, and area values were not archived or inspected.
- Population denominator source and exact population field were not verified.
- SA4 membership was not extracted.
- ASGS Edition 4 migration timing was not reviewed.
- Victoria DTP/PTV GTFS, Timetable API, ferries, FlexiRide, school services,
  SkyBus, regional rail/coach, and paratransit coverage were not verified.

## Suitability Judgment

Suitability: `candidate_primary_boundary`

Rationale:

ABS is the official authority for the GCCSA source family, and the inspected
allocation workbook directly verifies `2GMEL` as Greater Melbourne. Suitability
remains conditional on raw boundary acquisition under a manifest, population
denominator verification, SA4 membership review, and a boundary-fit screen.

## Extraction Decision

```yaml
melbourne_gccsa_exact_row_extraction:
  lead_id: mtr_src_006
  working_name: Greater Melbourne GCCSA
  source_authority: Australian Bureau of Statistics
  exact_name: Greater Melbourne
  exact_code: 2GMEL
  geography_type: GCCSA
  geography_vintage: "ASGS Edition 3, July 2021 to June 2026"
  boundary_product: "GCCSA_2021_AUST_SHP_GDA2020.zip"
  boundary_product_url_or_catalogue_path: "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/digital-boundary-files/GCCSA_2021_AUST_SHP_GDA2020.zip"
  boundary_geometry_status: not_archived
  population_product: unresolved
  population_field: unresolved
  accepted_denominator_value: false
  building_blocks: SA4_membership_not_extracted
  service_overlay_source: unresolved
  service_coverage_against_boundary: unresolved
  evidence_manifest_status: not_created
  extraction_decision: exact_row_verified_boundary_population_and_fit_blocked
  blockers:
    - raw_boundary_geometry_not_archived
    - population_denominator_not_verified
    - SA4_membership_not_extracted
    - GCCSA_boundary_fit_not_reviewed
    - Victoria_service_overlay_unresolved
```

## Methodology Implication

Greater Melbourne should not return to ChatGPT for the same exact-code
question. The next work should decide whether to run a GCCSA boundary-fit
screen before or after raw ABS boundary and SA4 allocation artifacts are
manifested.

## Next Allowed Output

Choose one:

- source-note follow-up.

Specific next follow-up:

- verify ABS population denominator source and exact field for `2GMEL`;
- verify SA4 membership from official ABS allocation or boundary artifacts;
- prepare a draft evidence manifest if raw ABS boundary/population artifacts
  are about to be acquired;
- review Victoria service-source coverage against the independent GCCSA
  boundary.

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
