# Eurostat/OECD FUA Exact-Row Extraction Workflow

Date: 2026-07-01

Status: formation-stage extraction workflow. No FUA row is accepted here. No
MTR is selected. No boundary record, evidence manifest, candidate-universe
ledger, outcome metric record, score, ranking, or MTR comparison is authorized.

Related decision:

- `theses/mobility-conversion/research/batch_s1a_eurostat_oecd_fua_exact_row_feasibility_2026-07-01.md`

Related source note:

- `theses/mobility-conversion/research/source_notes/eurostat_gisco_urban_audit_fua_download_api_2026-07-01.md`

Related returned leads:

- `mtr_src_001` Helsinki FUA
- `mtr_src_002` Lyon FUA

## Purpose

Define how Thesis 2 should identify an exact Eurostat/OECD FUA row before any
European FUA lead can proceed to readiness review or a `not_admitted` boundary
record.

The workflow is source-system oriented. It does not choose Helsinki, Lyon, or
any other MTR.

## Core Rule

No European FUA proposal may move to readiness-checklist review until the exact
source row is identified from source attributes, not guessed from city name or
local reputation.

## Workflow Steps

### Step 1. Confirm Source System

Record:

```yaml
source_system:
  source_name: Eurostat GISCO Urban Audit / Cities and Functional Urban Areas
  source_authority: Eurostat GISCO / European Commission
  method_context: Eurostat/OECD Functional Urban Area
  source_note_path: theses/mobility-conversion/research/source_notes/eurostat_gisco_urban_audit_fua_download_api_2026-07-01.md
```

### Step 2. Choose Vintage Before Geography

Choose and justify the FUA vintage before extracting a named row.

Required fields:

```yaml
vintage_selection:
  selected_dataset_vintage:
  available_vintages_considered:
  reason_for_selected_vintage:
  known_commuting_data_vintage:
  known_lau_or_input_geography_vintage:
  unknown_vintage_fields:
```

If commuting-data vintage or input-geography vintage is unknown, record it as
unknown. Do not silently equate GISCO geometry release year with commuting-flow
year.

### Step 3. Identify Candidate Unit From Source Attributes

Use official source attributes to identify:

```yaml
unit_identification:
  unit_code:
  unit_name:
  unit_type: FUA
  country_or_countries:
  source_attribute_table_or_api_path:
  source_attribute_fields_used:
  ambiguity_notes:
```

Do not accept a row if:

- the name match is ambiguous;
- only a city-core (`C`) unit is identified;
- the FUA (`F`) unit is not separately identified;
- the source attributes cannot be traced.

### Step 4. Identify Geometry Artifact

Record:

```yaml
geometry_artifact:
  geometry_file_or_api_path:
  geometry_type:
  scale:
  crs:
  format:
  download_provisions_or_license_note:
  retrieval_or_inspection_date:
```

Do not archive the geometry file at this step unless an evidence manifest is
created first.

### Step 5. Identify Population Denominator Path

Record:

```yaml
population_denominator_path:
  source_name:
  source_authority:
  source_url_or_access_path:
  geography_alignment:
  source_vintage:
  aggregation_or_reconciliation_method:
  mismatch_notes:
```

The FUA boundary source alone does not satisfy the population-denominator
requirement.

### Step 6. Identify Service Overlay Need

Record only the service-source need, not accepted service evidence:

```yaml
service_overlay_need:
  expected_source_families:
  likely_operators_or_access_points:
  source_trace_status:
  coverage_against_fua_unknown: true
  denominator_prohibited: true
```

Service feeds cannot define or modify the FUA denominator.

### Step 7. Manifest Trigger Check

Create an evidence manifest before any of the following:

- downloading a FUA geometry file into the repo;
- archiving a raw attribute table;
- clipping, transforming, dissolving, or simplifying geometry;
- deriving a population denominator from raw files;
- storing checksums for acquired raw artifacts;
- creating processed geometry.

If the workflow only records source paths and required fields, no manifest is
created.

### Step 8. Allowed Decision

After exact-row extraction, allowed decisions are:

- `ready_for_lead_review`;
- `needs_source_trace`;
- `ready_for_draft_manifest`;
- `quarantined_ambiguous_row`;
- `rejected_not_fua`;
- `rejected_service_derived_denominator`.

No decision admits an MTR.

## Extraction Note Shape

Use this shape if an exact-row extraction note is created:

```markdown
# Eurostat/OECD FUA Exact-Row Extraction Note

Date:

Status: extraction note only. No MTR selected.

Related lead:

## Source System

## Vintage Selection

## Unit Identification

## Geometry Artifact

## Population Denominator Path

## Service Overlay Need

## Manifest Trigger Check

## Decision

## Prohibited Outputs
```

## Current Lead Effects

### `mtr_src_001` Helsinki FUA

Current status: remains `ready_for_source_note_review`.

Next allowed output:

- exact-row extraction note using this workflow.

### `mtr_src_002` Lyon FUA

Current status: remains `needs_source_trace`.

Next allowed output:

- exact-row extraction note using this workflow;
- separate France National Access Point source trace.

## Closing Guardrail

This workflow does not select or admit an MTR. It only defines how an exact FUA
row may be identified before any readiness review, boundary record, manifest, or
metric work.
