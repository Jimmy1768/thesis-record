# Source Note: GHS-POP Population Grid

Date inspected: 2026-07-01

Verification status: `directly_inspected_data_catalog`

Source:

- Title or dataset: GHS-POP R2023A - GHS population grid multitemporal
  (1975-2030)
- Authority or publisher: European Commission, Joint Research Centre
- URL, DOI, document identifier, archive path, API endpoint, or access path:
  - `https://data.jrc.ec.europa.eu/dataset/2ff68a52-5b5b-4a22-8f40-c41da8332cfe`
  - DOI: `10.2905/2FF68A52-5B5B-4A22-8F40-C41DA8332CFE`
  - DOI: `10.2905/JRC.CXKEDRR`
- Release date, source vintage, or version: R2023A, issued 2023-05-08;
  modified 2025-08-07 in the inspected JRC catalogue entry.

Status: independently inspected source note. This note does not admit an MTR,
accept an outcome metric, create an evidence manifest, authorize raw data
archiving, calculate scores, rank MTRs, or make final paper claims.

## Source Authority

European Commission, Joint Research Centre, Global Human Settlement Layer.

## What The Source Defines

GHS-POP R2023A is a global gridded population dataset. The inspected catalogue
entry describes residential population estimates from 1975 to 2020 in five-year
intervals and projections to 2025 and 2030.

The dataset disaggregates census or administrative-unit population to grid
cells using GHSL built-up layers and other population inputs.

## Source Function For Mobility Conversion

- `population_denominator_source`
- `urban_form_source`
- `methodology_reference`

## Boundary / Denominator Role

- MTR boundary source: no.
- Resident-population denominator source: candidate fallback or reconciliation
  source where official population denominators do not align with a proposed
  boundary.
- Overlay or input only: yes, as gridded resident-population surface.
- Service-derived denominator risk: none directly, but there is modelled
  denominator risk if gridded population is treated as more precise than source
  inputs allow.

## Outcome / Axis Role

- Outcome dimensions supported: access-to-opportunities denominator, network
  coverage denominator, service-availability denominator, and distributional
  population exposure when aligned to a verified MTR boundary.
- Explanatory axes supported: urban form and growth/maturity context only, not
  as direct outcome performance.
- Risk of confusing outcome with explanatory axis: medium. Population grids can
  make source-rich or high-growth areas look more measurable; that is not the
  same as transport quality.

## Data Availability

- Geography: global.
- Spatial unit: raster grids.
- Time period or release vintage: estimates 1975-2020 and projections 2025,
  2030.
- Resolution: 100m and 1km in World Mollweide, with WGS84 grids at 3 arc-second
  and 30 arc-second resolution.
- Update frequency: irregular.
- Access method: JRC data catalogue download.
- License or usage constraint: European Commission reuse notice; access
  conditions inspected as no limitations. Any raw raster archive still requires
  an evidence manifest.

## Relevance To Mobility Conversion

GHS-POP can support global denominator work where official population data do
not align cleanly with modelled or functional boundaries.

For `mtr_src_008` Sao Paulo GHS-FUA, it is relevant only as a population
denominator or reconciliation layer after the GHS-FUA boundary row is verified.

## Limitations

- It is a modelled/disaggregated population grid, not a direct census count at
  the final grid-cell level.
- Population estimates and projections have different evidentiary weight.
- Alignment with GHS-FUA requires explicit target-year selection.
- A GHS-FUA 2015 boundary paired with a later GHS-POP population grid creates a
  vintage mismatch that must be documented.
- Gridded resident population does not capture daytime population, visitors,
  informal residents missed by source statistics, commuter inflows, or transient
  users.
- Raster acquisition, clipping, reprojection, and summarization require an
  evidence manifest before any raw data archive or derived denominator is
  created.

## Suitability Judgment

Suitability: `candidate_denominator_source`

Rationale:

GHS-POP is suitable as a candidate gridded resident-population denominator or
reconciliation layer for modelled global boundary tests, but it is not a
boundary source and not a complete access metric.

## Methodology Implication

Any modelled-boundary proposal using GHS-FUA and GHS-POP must record a
boundary/denominator vintage pair:

- GHS-FUA product and epoch;
- GHS-POP release and target year;
- mismatch rationale;
- population summarization method;
- uncertainty and source-limitations note.

## Next Allowed Output

Allowed:

- S1D modelled-boundary burden decision;
- later draft evidence manifest if raw raster files are acquired;
- later denominator-source review for a specific modelled-boundary lead.

## Prohibited Outputs

This source note does not authorize:

- admitted MTR;
- candidate list;
- candidate-universe ledger;
- outcome metric record;
- score;
- ranking;
- raw data archive without manifest.
