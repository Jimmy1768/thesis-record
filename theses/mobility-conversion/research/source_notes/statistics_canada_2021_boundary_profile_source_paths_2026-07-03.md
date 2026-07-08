# Source Note: Statistics Canada 2021 Boundary And Profile Source Paths

Date inspected: 2026-07-03

Verification status: `source_catalog_paths_inspected`

Source:

- Title or dataset:
  - 2021 Census Boundary files
  - 2021 Census Profile
- Authority or publisher: Statistics Canada
- URL, DOI, document identifier, archive path, API endpoint, or access path:
  - `https://www150.statcan.gc.ca/n1/en/catalogue/92-160-X`
  - `https://www12.statcan.gc.ca/census-recensement/2021/dp-pd/prof/index.cfm?Lang=E`
- Release date, source vintage, or version:
  - 2021 Census geography/profile source paths inspected 2026-07-03

Status: independently inspected source-path note. This note does not admit an
MTR, accept a boundary, accept a denominator value, create an evidence manifest,
authorize raw data archiving, calculate scores, rank MTRs, or make final paper
claims.

## Source Authority

Statistics Canada.

## What The Source Paths Provide

The Statistics Canada catalogue path for `92-160-X` is the official source path
for Census boundary files. The Census Profile path is the official source path
for Census Profile tables.

For Mobility Conversion, these source paths are relevant to Canadian
Census Metropolitan Area (CMA) and Census Agglomeration (CA) leads because they
can potentially provide:

- boundary geometry;
- geography identifiers;
- population denominator tables;
- census-release vintage fields;
- source-authority and reuse metadata.

## Source Function For Mobility Conversion

- `boundary_source_family`
- `population_denominator_source`
- `methodology_reference`

## Boundary / Denominator Role

- MTR boundary source: candidate source path for Canadian CMA/CA leads after
  exact geography row/code and boundary vintage are verified.
- Resident-population denominator source: candidate source path through Census
  Profile or related Statistics Canada population tables after exact geography
  row/code and table fields are verified.
- Overlay or input only: service/operator geography remains overlay only.
- Service-derived denominator risk: medium if Calgary Transit or any local
  service area is substituted for the CMA denominator.

## Outcome / Axis Role

- Outcome dimensions supported: none directly.
- Explanatory axes supported: none directly at this source-path level.
- Risk of confusing outcome with explanatory axis: medium. Official statistical
  geography and data richness must not be mistaken for transport quality.

## Data Availability

- Geography: Canada.
- Spatial unit: Census geography, including CMA/CA geography where selected.
- Time period or release vintage: 2021 Census source family inspected.
- Update frequency: census-release based; no fixed generic cadence accepted
  here.
- Access method: Statistics Canada catalogue and Census Profile interface.
- License or usage constraint: Statistics Canada terms must be recorded before
  raw boundary/profile artifacts are archived.

## Inspection Limits

This note verifies source paths only. It does not verify an exact Calgary CMA
row, code, DGUID, boundary file, or population value.

A direct Census Profile page probe for a likely Calgary CMA DGUID did not
successfully complete during this pass, so no exact row is accepted from that
probe.

No raw boundary file, profile table, or Census artifact was downloaded or
archived in the repository.

## Suitability Judgment

Suitability: `candidate_denominator_source`

Rationale:

Statistics Canada boundary/profile source paths are suitable for source-note
follow-up on Canadian CMA/CA leads. They are not enough to create a boundary
record until exact geography and population fields are independently extracted.

## Methodology Implication

Canadian CMA source work should use a two-step gate:

1. Verify source-system and product paths.
2. Verify lead-specific geography row/code, boundary vintage, population
   denominator field, and service-overlay limits.

Passing step 1 does not pass step 2.

## Next Allowed Output

Allowed:

- Calgary CMA boundary/population source-path review;
- exact Calgary CMA row/code extraction workflow;
- Calgary service-source trace plan;
- later evidence manifest draft if raw Statistics Canada artifacts are
  intentionally acquired.

## Prohibited Outputs

This source note does not authorize:

- admitted MTR;
- filled boundary record;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- accepted denominator value;
- raw data archive without manifest.
