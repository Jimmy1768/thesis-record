# Batch S1A: Eurostat/OECD FUA Exact-Row Feasibility

Date: 2026-07-01

Status: formation-stage source-system feasibility decision. No MTR is selected.
No boundary record, evidence manifest, candidate-universe ledger, outcome
metric record, score, ranking, or MTR comparison is authorized.

Related intake:

- `theses/mobility-conversion/research/source_led_mtr_proposal_intake_2026-07-01.md`

Related source note:

- `theses/mobility-conversion/research/source_notes/eurostat_gisco_urban_audit_fua_download_api_2026-07-01.md`

Related existing source notes:

- `theses/mobility-conversion/research/source_notes/eurostat_functional_urban_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/oecd_functional_urban_areas_2026-06-28.md`
- `theses/mobility-conversion/research/source_notes/eurostat_metropolitan_regions_2026-06-28.md`

## Question

Can Thesis 2 trace exact FUA rows/codes, vintages, polygons, and population
denominator options from Eurostat/OECD sources without relying on city
reputation?

## Short Decision

Source-system feasibility: yes.

Readiness promotion for Helsinki or Lyon: no.

Reason:

- Eurostat GISCO exposes an official Urban Audit/FUA geodata distribution with
  current and prior vintages, multiple formats, region/label geometries,
  coordinate reference systems, and an API.
- OECD confirms that its FUA definition expands city boundaries using
  population density and travel-to-work flows and links to FUA data and
  boundaries.
- However, exact Helsinki and Lyon FUA rows/codes, geometry files, population
  denominator sources, and service-source overlays have not yet been extracted
  into ThesisRecord artifacts.

## What Is Strong

- `observed_functional_region` remains the strongest current boundary family
  for European MTR proposals where official FUA rows exist.
- The GISCO source system supports exact-row extraction rather than vague
  region naming.
- The source system allows vintage-aware selection because multiple Urban Audit
  releases are listed.
- The FUA boundary source is independent of transit operator service geography,
  protecting unserved populations from disappearing from the denominator.

## What Is Weak Or Still Open

- GISCO geometry vintage is not automatically the same as commuting-flow vintage.
- The FUA polygon alone does not provide a resident-population denominator.
- The FUA polygon alone does not prove that local service feeds cover the whole
  MTR denominator.
- Unit codes must be tied to official names/attributes, not guessed from city
  familiarity.
- Download provisions and license terms must be recorded before raw geometry is
  archived.
- European source maturity may bias early testing toward source-rich regions.

## S1A Rule

For Eurostat/OECD FUA proposal leads, exact FUA row/code extraction is required
before readiness checklist review.

A lead may not move from `ready_for_source_note_review` or `needs_source_trace`
to readiness review until it has:

- exact FUA unit code;
- unit name or official label from source attributes;
- source system and vintage;
- geometry file path or API path;
- geometry type;
- CRS and scale;
- source/license/download-provisions note;
- resident-population denominator source path;
- known or explicitly unknown commuting-data vintage;
- service-source overlay plan that does not redefine the denominator.

## Lead Implications

### `mtr_src_001` Helsinki FUA

Current status after S1A: remains `ready_for_source_note_review`.

Allowed next output:

- exact FUA row/code extraction plan;
- source-note review for HSL/Digitransit only after boundary-source extraction
  fields are defined;
- draft evidence manifest if raw GISCO geometry will be archived.

Not allowed:

- Helsinki boundary record;
- candidate admission;
- score or ranking.

### `mtr_src_002` Lyon FUA

Current status after S1A: remains `needs_source_trace`.

Allowed next output:

- exact FUA row/code extraction plan;
- source trace for France National Access Point local feed records;
- draft evidence manifest if raw GISCO geometry or feed records will be
  archived.

Not allowed:

- Lyon readiness checklist review before local feed-source trace;
- Lyon boundary record;
- candidate admission;
- score or ranking.

## Required Vintage Fields

Minimum fields for any future Eurostat/OECD FUA boundary record:

```yaml
primary_boundary:
  source_system: Eurostat GISCO Urban Audit
  source_authority: Eurostat GISCO / European Commission
  dataset_vintage:
  unit_code:
  unit_name:
  unit_type: FUA
  geometry_file_or_api_path:
  geometry_type:
  scale:
  crs:
  retrieval_or_inspection_date:
  download_provisions_or_license_note:
  commuting_data_vintage:
  lau_or_input_geography_vintage:
  known_boundary_limitations:

population_denominator:
  source_name:
  source_authority:
  source_vintage:
  alignment_method:
  mismatch_notes:

service_overlay:
  source_name:
  source_authority:
  source_vintage:
  coverage_against_fua:
  denominator_prohibited: true
```

## Evidence Manifest Decision

No evidence manifest is created in S1A.

Reason:

- S1A verifies the source-system path and rule, not the raw GISCO geometry
  artifact.
- A manifest becomes required only when Thesis 2 acquires, archives, transforms,
  or version-pins raw boundary files.

## Next Recommended Work

Prepare an exact-row extraction plan for Eurostat GISCO FUA leads. The plan
should specify how to identify the unit code and official name from the source
attributes before downloading or archiving raw geometry.

## Closing Guardrail

This batch does not select, admit, score, rank, or compare MTRs. It only
decides that Eurostat/OECD FUA exact-row extraction is feasible and required
before readiness review.
